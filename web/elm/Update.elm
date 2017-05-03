module Update exposing (..)

import Data.Answers exposing (handleAnswer)
import Data.Ports exposing (trackOutboundLink)
import Data.QuoteServiceWeightings exposing (setQuoteServiceWeightings)
import Data.Quotes exposing (..)
import Data.Services exposing (..)
import Data.Shuffle exposing (..)
import Data.UserInfo exposing (emailToString, handleName, storeSubmittedEmail, validateEmail, validatePostcode)
import Dict
import Helpers.Delay exposing (..)
import Helpers.Errors exposing (..)
import Model exposing (..)
import Model.Email as Email
import Model.Postcode as Postcode
import Navigation
import Web.Answers exposing (handlePostAnswers, handlePostAnswersLoading)
import Web.Results.EntryPoint exposing (..)
import Web.Results.Url exposing (..)
import Web.User exposing (..)
import Web.UserEmail exposing (..)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            setEntryPoint location initialModel
    in
        model ! handleGetUserData model


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = Postcode.NotEntered
    , ageRange = Nothing
    , email = Email.NotEntered
    , emailConsent = False
    , userId = Nothing
    , quotes = Dict.empty
    , services = Dict.empty
    , top3things = []
    , weightings = Dict.empty
    , fetchErrorMessage = ""
    , submitErrorMessage = ""
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
            handleName model name ! []

        SetPostcode postcode ->
            { model | postcode = validatePostcode postcode } ! []

        SetAgeRange ageRange ->
            { model | ageRange = Just ageRange } ! []

        SetEmail email ->
            { model | email = validateEmail email } ! []

        SetEmailConsent bool ->
            { model | emailConsent = bool } ! []

        ReceiveQuoteServiceWeightings (Err _) ->
            { model | fetchErrorMessage = quotesServiceWeightingsError } ! []

        ReceiveQuoteServiceWeightings (Ok data) ->
            (model |> setQuoteServiceWeightings data |> removeFetchError) ! [ shuffleQuoteIds <| getQuoteIds data.quotes ]

        ShuffleQuoteIds qIds randomList ->
            (model |> handleShuffleQuotes qIds randomList) ! []

        SubmitAnswer answer ->
            let
                newModel =
                    model
                        |> handleAnswer answer
                        |> handlePostAnswersLoading
            in
                newModel ! [ handlePostAnswers newModel ]

        HandleGoToInstructions ->
            handleGoToInstructions model ! [ postUserDetails model ]

        ReceiveUser (Err _) ->
            { model | fetchErrorMessage = receiveUserError } ! []

        ReceiveUser (Ok rawUser) ->
            (model |> handleRetrievedUserData rawUser |> removeFetchError) ! []

        PutUserEmail (Err _) ->
            { model | submitErrorMessage = putUserEmailError } ! []

        PutUserEmail (Ok _) ->
            (model |> storeSubmittedEmail |> removeSubmitError) ! []

        SubmitEmail ->
            model ! [ sendUserEmail model ]

        PostUserAnswers (Err _) ->
            { model | submitErrorMessage = postUserAnswersError } ! []

        PostUserAnswers (Ok uuid) ->
            let
                newModel =
                    { model | uuid = Just uuid }
                        |> removeSubmitError
                        |> handleTop3Things
            in
                newModel ! [ setResultsUrl newModel, waitThenShowServices ]

        UrlChange _ ->
            model ! []

        ReceiveResults (Err err) ->
            { model | fetchErrorMessage = receiveResultsError } ! []

        ReceiveResults (Ok res) ->
            (model |> loadResults res |> removeFetchError) ! []

        TrackOutboundLink url ->
            model ! [ trackOutboundLink url ]
