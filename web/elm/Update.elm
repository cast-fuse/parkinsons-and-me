module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Api exposing (getQuoteServiceWeighting)
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
    , weightings = Dict.empty
    , fetchErrorMessage = ""
    , currentQuote = Nothing
    , remainingQuotes = Nothing
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
            }
                ! []
