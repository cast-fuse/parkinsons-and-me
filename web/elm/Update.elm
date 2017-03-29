module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode, validateForm)


init : ( Model, Cmd Msg )
init =
    initialModel ! []


initialModel : Model
initialModel =
    { view = UserInfo
    , name = Nothing
    , postcode = NotEntered
    , ageRange = Nothing
    , formErrors = False
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
