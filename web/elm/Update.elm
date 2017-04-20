module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Answers exposing (handleAnswer)
import Data.QuoteServiceWeightings exposing (setQuoteServiceWeightings)
import Data.Web.Answers exposing (handlePostAnswers)
import Data.Web.Results.UrlParser exposing (..)
import Data.Web.Results.EntryPoint exposing (..)
import Data.Web.User exposing (..)
import Data.Web.UserEmail exposing (..)
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
    , postcode = NotEnteredPostcode
    , ageRange = Nothing
    , email = NotEnteredEmail
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
            { model | email = ValidEmail email } ! []

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

        ReceiveUserId (Err _) ->
            model ! []

        ReceiveUserId (Ok uId) ->
            { model | userId = Just uId } ! []

        PutUserEmail (Ok _) ->
            { model | email = SubmittedEmail } ! []

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
