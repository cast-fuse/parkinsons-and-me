module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Web.QuoteServiceWeighting exposing (getQuoteServiceWeighting)
import Data.Web.User exposing (..)
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
    , userId = Nothing
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
            let
                newModel =
                    { model | ageRange = Just ageRange }
            in
                { model | ageRange = Just ageRange } ! [ postUserDetails newModel ]

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

        PostUserDetails (Err err) ->
            let
                log =
                    Debug.log "err" err
            in
                model ! []

        PostUserDetails (Ok data) ->
            let
                log =
                    Debug.log "data" data
            in
                model ! []
