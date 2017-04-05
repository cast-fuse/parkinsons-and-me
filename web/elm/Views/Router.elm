module Views.Router exposing (router)

import Views.Home exposing (home)
import Views.UserInfo.Name exposing (name)
import Views.UserInfo.Postcode exposing (postcode)
import Views.UserInfo.Age exposing (age)
import Model exposing (..)
import Html exposing (..)


router : Model -> Html Msg
router model =
    case model.view of
        Home ->
            home model

        Name ->
            name model

        Postcode ->
            postcode model

        Age ->
            age model

        _ ->
            div [] [ text "stuff" ]
