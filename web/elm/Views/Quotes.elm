module Views.Quotes exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Helpers.Styles as Styles
import Model exposing (..)
import Dict


quotes : Model -> Html Msg
quotes model =
    div [ class "center mw6 mt4" ]
        [ p [ class "grey" ] [ text <| renderQuoteNumber model ]
        , div [ class "relative pa5" ]
            [ h2 [ class "black relative z-3 handwriting f2" ] [ em [] [ text <| getQuote model ] ]
            , img [ class "absolute top-0 left-0 z-1 h-100 w-100", src "/images/speech-bubble-1.png" ] []
            ]
        , button [ class (Styles.buttonBlue ++ " ma3 relative z-3"), onClick <| SubmitAnswer Yes ] [ text "Yes, I feel like this" ]
        , button [ class (Styles.buttonClear ++ " relative z-3"), onClick <| SubmitAnswer No ] [ text "No, not how I feel" ]
        ]


renderQuoteNumber : Model -> String
renderQuoteNumber model =
    let
        current =
            quoteNumber model

        total =
            Dict.size model.quotes
    in
        (toString current) ++ " of " ++ (toString total)


quoteNumber : Model -> Int
quoteNumber model =
    let
        total =
            Dict.size model.quotes
    in
        total - (model.remainingQuotes |> Maybe.withDefault [] |> List.length)


getQuote : Model -> String
getQuote model =
    model.currentQuote
        |> Maybe.andThen (\x -> Dict.get x model.quotes)
        |> Maybe.withDefault ""
