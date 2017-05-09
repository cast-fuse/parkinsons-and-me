module Views.Quotes exposing (..)

import Components.QuoteBubble exposing (cycleQuoteBackground, quoteBubble)
import Dict
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


quotes : Model -> Html Msg
quotes model =
    div [ class "center mw6 mt4" ]
        [ p [ class "grey" ] [ text <| renderQuoteNumber model ]
        , renderQuoteBubble model
        , answerButtons
        ]


answerButtons : Html Msg
answerButtons =
    let
        buttonClasses =
            classes [ "f4 ma1", Styles.buttonClear ]
    in
        div [ class "flex justify-center flex-row-ns flex-column ma3" ]
            [ button
                [ class <| buttonClasses
                , onClick <| SubmitAnswer Yes
                ]
                [ text "Yes, this sounds like me" ]
            , button
                [ class <| buttonClasses
                , onClick <| SubmitAnswer No
                ]
                [ text "No, this doesn't sound like me" ]
            ]


renderQuoteBubble : Model -> Html Msg
renderQuoteBubble model =
    quoteBubble
        (getQuoteBody model)
        "pa5-ns"
        (model |> quoteNumber |> cycleQuoteBackground)


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


getQuoteBody : Model -> String
getQuoteBody model =
    model.currentQuote
        |> Maybe.andThen (\x -> Dict.get x model.quotes)
        |> Maybe.withDefault ""
