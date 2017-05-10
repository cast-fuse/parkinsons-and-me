module Components.QuoteBubble exposing (..)

import Helpers.Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


quoteBubble : String -> String -> QuoteBackground -> Html msg
quoteBubble body extraClasses quoteBackground =
    div [ class "relative pa3" ]
        [ h2 [ class <| classes [ "black relative z-3 ma2 normal", extraClasses ] ] [ text body ]
        , img [ class "absolute top-0 left-0 z-1 h-100 w-100", src <| quoteBackgroundImageMap quoteBackground ] []
        ]


cycleQuoteBackground : Int -> QuoteBackground
cycleQuoteBackground i =
    case i % 3 of
        1 ->
            Blue

        2 ->
            Green

        _ ->
            Orange


quoteBackgroundImageMap : QuoteBackground -> String
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
