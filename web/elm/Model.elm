module Model exposing (..)

import Dict exposing (..)


type alias Model =
    { view : View
    , currentQuote : ( Int, Quote )
    , quotes : Dict Int Quote
    }


type View
    = Home
    | UserInfo
    | Quotes
    | Results


type alias Quote =
    { body : String
    , answer : YesNo
    }


type YesNo
    = Yes
    | No


type Msg
    = SetView View
    | UpdateAnswer YesNo ( Int, Quote )
