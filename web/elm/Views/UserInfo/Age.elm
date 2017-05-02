module Views.UserInfo.Age exposing (age)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.UserInfo exposing (isValidAgeRange, ageRangeToString, ageRanges)
import Helpers.Styles as Styles
import Components.Logo exposing (logo)


age : Model -> Html Msg
age model =
    div []
        [ logo
        , h2 [ class "blue" ] [ text <| String.toUpper <| "A bit about you" ]
        , div [ class "flex flex-column justify-center items-center" ]
            [ div [] [ ageField model ]
            ]
        , handleNext model
        ]


ageField : Model -> Html Msg
ageField model =
    div [ class "flex ma4" ]
        [ p [ class "tl mw6 ma0 mt2" ] [ text "What's your age?" ]
        , div [ class "flex flex-wrap justify-center" ] (List.map (ageOption model) ageRanges)
        ]


ageOption : Model -> AgeRange -> Html Msg
ageOption model ageRange =
    div
        [ class "ba b--blue w-40 ph3 pv2 mr3 mb3 b pointer"
        , classList
            [ ( "bg-blue white", model.ageRange == Just ageRange )
            , ( "blue", model.ageRange /= Just ageRange )
            ]
        , onClick <| SetAgeRange ageRange
        ]
        [ text <| ageRangeToString ageRange ]


handleNext : Model -> Html Msg
handleNext model =
    if isValidAgeRange model then
        button [ class Styles.buttonClear, onClick <| HandleGoToInstructions ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
