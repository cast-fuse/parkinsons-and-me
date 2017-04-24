module Update exposing (..)

import Model exposing (..)
import Model.Postcode as Postcode
import Model.Email as Email
import Data.UserInfo exposing (validatePostcode, validateEmail, emailToString)
import Data.Answers exposing (handleAnswer)
import Data.QuoteServiceWeightings exposing (setQuoteServiceWeightings)
import Web.Answers exposing (handlePostAnswers)
import Web.Results.UrlParser exposing (..)
import Web.Results.EntryPoint exposing (..)
import Web.User exposing (..)
import Web.UserEmail exposing (..)
import Data.Quotes exposing (..)
import Data.Services exposing (..)
import Data.Shuffle exposing (..)
import Dict
import Navigation


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            { initialModel | entryPoint = setEntryPoint location }
    in
        model ! handleGetUserData model


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = Postcode.NotEntered
    , ageRange = Nothing
    , email = Email.NotEntered
    , userId = Nothing
    , quotes = Dict.empty
    , services = Dict.empty
    , top3things = []
    , weightings = Dict.empty
    , earlyOnsetWeightings = Dict.empty
    , fetchErrorMessage = ""
    , currentQuote = Nothing
    , remainingQuotes = Nothing
    , userWeightings = Dict.empty
    , userAnswers = []
    , entryPoint = Start
    , uuid = Nothing
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetView view ->
            { model | view = view } ! []

        SetName name ->
            { model | name = Just name } ! []

        SetPostcode postcode ->
            { model | postcode = validatePostcode postcode } ! []

        SetAgeRange ageRange ->
            { model | ageRange = Just ageRange } ! []

        SetEmail email ->
            { model | email = validateEmail email } ! []

        ReceiveQuoteServiceWeightings (Err _) ->
            { model | fetchErrorMessage = "Something went wrong fetching the data." } ! []

        ReceiveQuoteServiceWeightings (Ok data) ->
            (model |> setQuoteServiceWeightings data) ! [ shuffleQuoteIds <| getQuoteIds data.quotes ]

        ShuffleQuoteIds qIds randomList ->
            (model |> handleShuffleQuotes qIds randomList) ! []

        SubmitAnswer answer ->
            let
                newModel =
                    model
                        |> handleAnswer answer
            in
                newModel ! [ handlePostAnswers newModel ]

        HandleGoToQuotes ->
            (handleGoToQuotes model) ! [ postUserDetails model ]

        ReceiveUser (Err _) ->
            model ! []

        ReceiveUser (Ok rawUser) ->
            (model |> handleRetrievedUserData rawUser) ! []

        PutUserEmail (Ok _) ->
            { model | email = Email.Submitted <| emailToString model.email } ! []

        PutUserEmail (Err _) ->
            model ! []

        SubmitEmail ->
            model ! [ sendUserEmail model ]

        PostUserAnswers (Err _) ->
            model ! []

        PostUserAnswers (Ok uuid) ->
            let
                newModel =
                    { model | uuid = Just uuid }
                        |> handleGoToServices
                        |> handleTop3Things
            in
                newModel ! []

        UrlChange location ->
            { model | entryPoint = setEntryPoint location } ! []

        ReceiveResults (Err err) ->
            model ! []

        ReceiveResults (Ok res) ->
            (model |> loadResults res) ! []
