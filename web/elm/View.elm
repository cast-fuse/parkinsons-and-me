module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Router exposing (router)


view : Model -> Html Msg
view model =
    div [ class "tc mt2" ]
        [ router model ]
