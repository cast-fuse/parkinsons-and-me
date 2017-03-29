module Model exposing (..)


type alias Model =
    { view : View
    }


type View
    = Home
    | UserInfo


type Msg
    = SetView View
