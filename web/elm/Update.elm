module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode, validateForm)
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
    , formErrors = False
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

        SubmitForm ->
            if validateForm model then
                { model | view = Quotes } ! []
            else
                { model | formErrors = True } ! []

        UpdateAnswer answer currentQuote ->
            handleUpdateAnswers model answer currentQuote ! []
