module View exposing (..)

import Components.LogoFooter exposing (logoFooter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Views.Router exposing (router)


view : Model -> Html Msg
view model =
    div [ class "tc" ]
        [ router model
        , logoFooter
        ]
