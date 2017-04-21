module Model.Email exposing (..)


type Email
    = NotEntered
    | Valid String
    | Invalid String
    | Retrieved String
    | Submitted String
