module Views.UserInfo exposing (userInfo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


userInfo : Model -> Html Msg
userInfo model =
    div [] [ text "user info" ]
