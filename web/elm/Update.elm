module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Web.QuoteServiceWeightings exposing (getQuoteServiceWeightings)
import Data.Web.Answers exposing (handlePostAnswers)
import Data.Web.User exposing (..)
import Data.Web.UserEmail exposing (..)
import Data.Quotes exposing (..)
import Data.Weightings exposing (..)
import Data.Services exposing (..)
import Data.Shuffle exposing (..)
import Dict
import Navigation


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    { initialModel | currentHash = location.hash }
        ! [ getQuoteServiceWeightings ]


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = NotEntered
    , ageRange = Nothing
    , email = Nothing
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
    , currentHash = ""
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
            { model | email = Just email } ! []

        ReceiveQuoteServiceWeightings (Err _) ->
            { model | fetchErrorMessage = "Something went wrong fetching the data." } ! []

        ReceiveQuoteServiceWeightings (Ok data) ->
            { model
                | quotes = data.quotes
                , services = data.services
                , weightings = data.weightings
                , userWeightings = makeEmptyWeightingsDict data.services
                , earlyOnsetWeightings = handleEarlyOnsetWeightings data
            }
                ! [ shuffleQuoteIds <| getQuoteIds data.quotes ]

        ShuffleQuoteIds qIds randomList ->
            (model |> handleShuffleQuotes qIds randomList) ! []

        SubmitAnswer answer ->
            let
                newModel =
                    model
                        |> handleAnswer answer
                        |> updateWeightings answer
                        |> handleNextQuote
                        |> handleGoToServices
                        |> handleTop3Things
            in
                newModel ! [ handlePostAnswers newModel ]

        HandleGoToQuotes ->
            (handleGoToQuotes model) ! [ postUserDetails model ]

        ReceiveUserId (Err _) ->
            model ! []

        ReceiveUserId (Ok uId) ->
            { model | userId = Just uId } ! []

        PutUserEmail (Ok _) ->
            { model | email = Nothing } ! []

        PutUserEmail (Err _) ->
            model ! []

        SubmitEmail ->
            model ! [ sendUserEmail model ]

        PostUserAnswers _ ->
            model ! []

        UrlChange location ->
            { model | currentHash = location.hash } ! []
