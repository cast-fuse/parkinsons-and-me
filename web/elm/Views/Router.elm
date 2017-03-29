module Views.Router exposing (router)

import Views.Home exposing (home)
import Views.UserInfo exposing (userInfo)
import Views.Quotes exposing (quotes)
import Model exposing (..)
import Html exposing (..)


router : Model -> Html Msg
router model =
    case model.view of
        Home ->
            home model

        UserInfo ->
            userInfo model

        Quotes ->
            quotes model

        _ ->
            p [] [ text "woot results " ]
