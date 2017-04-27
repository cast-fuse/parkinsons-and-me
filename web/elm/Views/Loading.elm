module Views.Loading exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


loading : Html Msg
loading =
    div [ class "relative z-9999" ]
        [ h3 [] [ text "We’re just pulling together your own personalised page of recommended information and support services." ]
        , h3 [] [ text "We won’t be long…" ]
        ]


loadingBackground : Model -> Html Msg -> Html Msg
loadingBackground model view =
    case model.view of
        Loading ->
            div []
                [ div [ class "z-999 fixed all ease t3 w-100 vh-100 bg-blue o-100 white flex items-center justify-center" ] [ loading ]
                ]

        _ ->
            div []
                [ div [ class "t3 all ease delay-2 z-999 fixed w-100 vh-100 bg-blue o-0 disabled flex items-center justify-center" ] [ loading ]
                , view
                ]
