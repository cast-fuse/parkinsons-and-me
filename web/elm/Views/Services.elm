module Views.Services exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Helpers.Styles as Styles
import Components.Logo exposing (..)
import Model exposing (..)


services : Model -> Html Msg
services model =
    div []
        [ logo
        , h2 [ class "blue mb4" ] [ text "Here you are, your tailored list of Parkinson's services" ]
        , div [ class "bg-blue pb6" ] (List.map renderService model.top3things)
        , div [ class "mw7 center mv4" ]
            [ h3 [ class "blue" ] [ text "If you'd like a copy of your results for futute reference, please enter your email" ]
            , input [ onInput SetEmail, class (Styles.inputField ++ " mw5 center"), placeholder "put your email", value <| Maybe.withDefault "" model.email ] []
            , button [ onClick SubmitEmail, class (Styles.buttonBlue ++ " mt3") ] [ text "submit" ]
            ]
        ]


renderService : ServiceData -> Html Msg
renderService s =
    div [ class "mw7 pa4 bg-light-gray center" ]
        [ h3 [ class "blue ma0" ] [ text s.title ]
        , p [] [ text s.body ]
        , button [ class Styles.buttonBlue ] [ text s.cta ]
        ]
