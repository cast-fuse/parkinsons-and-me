module Components.QuoteBubble exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


quoteBubble : String -> QuoteBubbleBackground -> Html msg
quoteBubble body quoteBackground =
    div [ class "relative pa3 pa5-ns" ]
        [ h2 [ class "black relative z-3 handwriting f2" ] [ text body ]
        , img [ class "absolute top-0 left-0 z-1 h-100 w-100", src <| quoteBackgroundImageMap quoteBackground ] []
        ]


cycleQuoteBackground : Int -> QuoteBubbleBackground
cycleQuoteBackground i =
    case i % 3 of
        1 ->
            Blue

        2 ->
            Green

        _ ->
            Orange


quoteBackgroundImageMap : QuoteBubbleBackground -> String
quoteBackgroundImageMap bg =
    let
        url color =
            "/images/speech-bubble-1-" ++ color ++ ".png"
    in
        case bg of
            Blue ->
                url "blue"

            Green ->
                url "green"

            Orange ->
                url "orange"
