module Views.Quotes exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Data.Quotes exposing (..)
import Dict


quotes model =
    div []
        [ p [] [ text <| getQuote model ]
        , button [ onClick <| SubmitAnswer Yes ] [ text "Yes" ]
        , button [ onClick <| SubmitAnswer No ] [ text "No" ]
        ]


getQuote : Model -> String
getQuote model =
    case model.currentQuote of
        Just qId ->
            Dict.get qId model.quotes
                |> Maybe.withDefault ""

        Nothing ->
            ""
