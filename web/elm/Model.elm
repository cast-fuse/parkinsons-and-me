module Model exposing (..)

import Dict exposing (..)


type alias Model =
    { view : View
    , name : Maybe String
    , postcode : Postcode
    , ageRange : Maybe AgeRange
    , formErrors : Bool
    , currentQuote : ( Int, Quote )
    , quotes : Dict Int Quote
    , services : List Service
    }


type View
    = Home
    | Name
    | Postcode
    | Age
    | Quotes
    | Services


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


type alias Quote =
    { body : String
    , answer : YesNo
    }


type YesNo
    = Yes
    | No


type alias Service =
    { title : String
    , body : String
    , url : String
    , cta : String
    }


type Msg
    = SetView View
    | SetName String
    | SetPostcode String
    | SetAgeRange AgeRange
    | SubmitForm
    | UpdateAnswer YesNo ( Int, Quote )
