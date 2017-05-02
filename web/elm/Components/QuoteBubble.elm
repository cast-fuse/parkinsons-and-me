module Components.QuoteBubble exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


quoteBubble : String -> Html msg
quoteBubble body =
    div [ class "relative pa3 pa5-ns" ]
        [ h2 [ class "black relative z-3 handwriting f2" ] [ text body ]
        , img [ class "absolute top-0 left-0 z-1 h-100 w-100", src "/images/speech-bubble-1.png" ] []
        ]
