module Model.Postcode exposing (..)


type Postcode
    = NotEntered
    | Valid String
    | Invalid String
