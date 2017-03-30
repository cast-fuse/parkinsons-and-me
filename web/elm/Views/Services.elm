module Views.Services exposing (services)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Components.Logo exposing (logo)


services : Model -> Html Msg
services model =
    div []
        [ logo
        , div [ class "bg-blue" ]
            [ h2 [ class "blue" ] [ text <| renderPageTitle model ]
            , div [] (List.map renderService model.services)
            ]
        ]


renderService : Service -> Html Msg
renderService service =
    div [ class "bg-white ma4 pa3" ]
        [ p [ class "blue f3" ] [ text service.title ]
        , p [] [ text service.body ]
        , a [ href service.url, class "white no-underline dib center" ] [ p [ class "bg-dark-blue ph3 pv2" ] [ text service.cta ] ]
        ]


renderPageTitle : Model -> String
renderPageTitle model =
    let
        showTitle name =
            "Here you are" ++ name ++ ", your tailored list of Parkinsons services"
    in
        case model.name of
            Nothing ->
                showTitle ""

            Just name ->
                showTitle <| " " ++ name
