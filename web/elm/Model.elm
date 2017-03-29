module Model exposing (..)


type alias Model =
    { view : View
    , name : Maybe String
    , postcode : Postcode
    , ageRange : Maybe AgeRange
    , formErrors : Bool
    }


type View
    = Home
    | UserInfo
    | Quotes


type AgeRange
    = UnderForty
    | Forties
    | Fifties
    | Sixties
    | Seventies
    | OverEighty


type Postcode
    = NotEntered
    | Valid String
    | Invalid String


type Msg
    = SetView View
    | SetName String
    | SetPostcode String
    | SetAgeRange AgeRange
    | SubmitForm
