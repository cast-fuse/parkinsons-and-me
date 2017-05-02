module Views.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.SpeechHeader exposing (speechHeader)
import Helpers.Styles as Styles
import Model exposing (..)


home : Model -> Html Msg
home model =
    div []
        [ speechHeader "Wondering what happens next?"
        , div [ class "mw5 center" ]
            [ h2 [ class "ph3" ] [ text "Being diagnosed can be confusing. There’s a lot of information and support out there. We’re here to help and find what’s right for you." ]
            , button [ class Styles.buttonBlue, onClick <| SetView Name ] [ text "Get Started" ]
            ]
        ]
