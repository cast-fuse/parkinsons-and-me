module Views.Router exposing (router)

import Views.Home exposing (home)
import Views.UserInfo exposing (userInfo)
import Model exposing (..)
import Html exposing (..)


router : Model -> Html Msg
router model =
    case model.view of
        Home ->
            home model

        UserInfo ->
            userInfo model
