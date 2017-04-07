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
        [ p [ class "grey" ] [ text <| quoteNumber model ]
        , div [ class "bg-light-gray pa4 br2" ] [ h2 [ class "blue" ] [ em [] [ text <| getQuote model ] ] ]
        , button [ class (Styles.buttonBlue ++ " ma3"), onClick <| SubmitAnswer Yes ] [ text "Yes, I feel like this" ]
        , button [ class Styles.buttonClear, onClick <| SubmitAnswer No ] [ text "No, not how I feel" ]
        ]


quoteNumber : Model -> String
quoteNumber model =
    let
        total =
            Dict.size model.quotes

        current =
            total - (model.remainingQuotes |> Maybe.withDefault [] |> List.length)
    in
        (toString current) ++ " of " ++ (toString total)


getQuote : Model -> String
getQuote model =
    case model.currentQuote of
        Just qId ->
            Dict.get qId model.quotes
                |> Maybe.withDefault ""

        Nothing ->
            ""
