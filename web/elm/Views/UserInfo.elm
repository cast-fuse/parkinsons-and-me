module Views.UserInfo exposing (userInfo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Data.UserInfo exposing (infoQueries, ageRanges, ageRangeToString)
import Components.Logo exposing (logo)


userInfo : Model -> Html Msg
userInfo model =
    div []
        [ logo
        , h2 [ class "blue" ] [ text <| String.toUpper <| "A bit about you" ]
        , div [ class "flex flex-column justify-center items-center" ]
            [ div [ class "mb3" ] (List.map (inputField model) infoQueries)
            , ageInput model
            ]
        , button [ class "bg-dark-blue bn white ph4 pv3 f5 mt4", onClick <| SetView UserInfo ] [ text "Next" ]
        ]


inputField : Model -> ( String, String -> Msg ) -> Html Msg
inputField model ( query, updateModel ) =
    div [ class "flex items-center" ]
        [ p [ class "tl w6" ] [ text query ]
        , input [ class "w7 h2", onInput updateModel ] []
        ]


ageInput : Model -> Html Msg
ageInput model =
    div [ class "flex" ]
        [ p [ class "tl w6 ma0 mt2" ] [ text "What's your age range?" ]
        , div [ class "w7 flex flex-wrap justify-between" ] (List.map (ageOption model) ageRanges)
        ]


ageOption : Model -> AgeRange -> Html Msg
ageOption model ageRange =
    div
        [ class "ba-l b--blue w-40 ph3 pv2 mb3 b pointer"
        , classList
            [ ( "bg-blue white", model.ageRange == Just ageRange )
            , ( "blue", model.ageRange /= Just ageRange )
            ]
        , onClick <| SetAgeRange ageRange
        ]
        [ text <| ageRangeToString ageRange ]
