module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Api exposing (getQuoteServiceWeighting)
import Data.Quotes exposing (..)
import Data.Weightings exposing (..)
import Data.Services exposing (..)
import Dict


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getQuoteServiceWeighting ]


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = NotEntered
    , ageRange = Nothing
    , email = Nothing
    , quotes = Dict.empty
    , services = Dict.empty
    , top3things = []
    , weightings = Dict.empty
    , fetchErrorMessage = ""
    , currentQuote = Nothing
    , remainingQuotes = Nothing
    , userWeightings = Dict.empty
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

        ReceiveQuoteServiceWeighting (Err _) ->
            { model | fetchErrorMessage = "Something went wrong fetching the data." } ! []

        ReceiveQuoteServiceWeighting (Ok data) ->
            { model
                | quotes = data.quotes
                , services = data.services
                , weightings = data.weightings
                , remainingQuotes = data.quotes |> getQuoteIds |> Just
                , userWeightings = makeEmptyWeightingsDict data.services
            }
                ! []

        SubmitAnswer answer ->
            (model
                |> handleAnswer answer
                |> handleNextQuote
                |> handleGoToServices
                |> handleTop3Things
            )
                ! []

        HandleGoToQuotes ->
            (handleGoToQuotes model) ! []
