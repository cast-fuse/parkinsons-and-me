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
            [ div [ class "bg-white ph4 pv2 br4 ba-thick b--blue relative z-3" ] [ h2 [ class "blue" ] [ em [] [ text <| getQuote model ] ] ]
            , div
                [ style <| quoteBackground model
                , class "bg-center contain absolute z-1 left-0 right-1"
                ]
                []
            ]
        , button [ class (Styles.buttonBlue ++ " ma3 relative z-3"), onClick <| SubmitAnswer Yes ] [ text "Yes, I feel like this" ]
        , button [ class (Styles.buttonClear ++ " relative z-3"), onClick <| SubmitAnswer No ] [ text "No, not how I feel" ]
        ]


quoteBackground : Model -> List ( String, String )
quoteBackground model =
    case quoteNumber model % 3 of
        0 ->
            Styles.spikesBackground

        1 ->
            Styles.fuzzBackground

        _ ->
            Styles.bubblesBackground


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
    case model.currentQuote of
        Just qId ->
            Dict.get qId model.quotes
                |> Maybe.withDefault ""

        Nothing ->
            ""
