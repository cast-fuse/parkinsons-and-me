module Components.SpeechHeader exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


speechHeader : String -> Html msg
speechHeader body =
    div [ class "touch-disabled" ]
        [ h1 [ class "handwriting-title ph2 black relative z-3 f1 quote-header" ] [ text body ]
        , div
            [ class "z-1 center absolute contain bg-left right-0 quote-header-background"
            , style [ ( "background-image", "url(/images/speech-bubble-2.png)" ) ]
            ]
            []
        ]
