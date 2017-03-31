module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Services exposing (serviceList)
import Data.Quotes exposing (..)


init : ( Model, Cmd Msg )
init =
    initialModel ! []


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = NotEntered
    , ageRange = Nothing
    , email = Nothing
    , currentQuote = firstQuote quoteDict
    , quotes = quoteDict
    , services = serviceList
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

        UpdateAnswer answer currentQuote ->
            handleUpdateAnswers model answer currentQuote ! []
