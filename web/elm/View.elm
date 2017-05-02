module View exposing (..)

import Components.LogoFooter exposing (logoFooter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Views.Router exposing (router)


view : Model -> Html Msg
view model =
    div [ class "tc flex flex-column mh-v100" ]
        [ div [ class "flex-1" ] [ router model ]
        , logoFooter
        ]
