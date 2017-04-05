module Model exposing (..)

import Dict exposing (..)


type alias Model =
    { view : View
    , name : Maybe String
    , postcode : Postcode
    , ageRange : Maybe AgeRange
    , email : Maybe String
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


type alias Quotes =
    Dict QuoteId String


type alias Services =
    Dict ServiceId ServiceData


type alias ServiceData =
    { title : String
    , body : String
    , cta : String
    , url : String
    }


type alias Weightings =
    Dict QuoteId (Dict ServiceId Float)


type alias RawWeighting =
    { quote_id : Int
    , service_id : Int
    , weight : Float
    }


type alias QuoteId =
    Int


type alias ServiceId =
    Int


type Msg
    = SetView View
    | SetName String
    | SetPostcode String
    | SetAgeRange AgeRange
    | SetEmail String
