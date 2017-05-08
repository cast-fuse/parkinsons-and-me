module Views.Loading exposing (..)

import Components.QuoteBubble exposing (quoteBubble)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


loading : Html Msg
loading =
    div [ class "relative z-9999 top--1" ]
        [ div [ class "mw5 center" ] [ quoteBubble "Just a Moment" "ph5-ns pv4-ns" Green ]
        , div [ class "mt3" ]
            [ h3 [] [ text "We’re just pulling together your own personalised page of recommended information and support services." ]
            , h3 [] [ text "We won’t be long…" ]
            ]
        ]


loadingBackground : Model -> Html Msg -> Html Msg
loadingBackground model view =
    case model.view of
        Loading ->
            div []
                [ div [ class "z-999 fixed top-0 all ease t3 w-100 vh-100 bg-white o-100 black flex justify-center items-center" ] [ loading ]
                ]

        _ ->
            div []
                [ div [ class "t3 all ease top-0 delay-2 z-999 fixed w-100 vh-100 bg-white o-0 touch-disabled flex justify-center items-center" ] [ loading ]
                , view
                ]
