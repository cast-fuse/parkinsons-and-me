module Views.Services exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Helpers.Styles as Styles
import Components.Logo exposing (..)
import Model exposing (..)


services : Model -> Html Msg
services model =
    div []
        [ logo
        , h2 [ class "blue mb4" ] [ text <| renderName model ]
        , div [ class "bg-blue pb6" ] (List.map renderService model.top3things)
        ]


renderName : Model -> String
renderName model =
    let
        title name =
            "Here you are" ++ name ++ ", your tailored list of Parkinson's servivces"
    in
        case model.name of
            Just name ->
                title <| " " ++ name

            Nothing ->
                title ""


renderService : ServiceData -> Html Msg
renderService s =
    div [ class "mw7 pa4 bg-light-gray center" ]
        [ h3 [ class "blue ma0" ] [ text s.title ]
        , p [] [ text s.body ]
        , button [ class Styles.buttonBlue ] [ text s.cta ]
        ]
