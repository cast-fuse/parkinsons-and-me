module Views.Services exposing (services)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


services : Model -> Html Msg
services model =
    div []
        [ h2 [] [ text <| renderPageTitle model ]
        , div [] (List.map renderService model.services)
        ]


renderService : Service -> Html Msg
renderService service =
    div []
        [ p [] [ text service.title ]
        , p [] [ text service.body ]
        , a [ href service.url ] [ p [] [ text service.cta ] ]
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
