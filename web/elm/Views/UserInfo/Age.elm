module Views.UserInfo.Age exposing (age)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Components.SpeechHeader exposing (speechHeader)
import Data.UserInfo exposing (ageRangeToString, ageRanges, isValidAgeRange)
import Helpers.Styles as Styles


age : Model -> Html Msg
age model =
    div []
        [ speechHeader "Can we ask your age?"
        , h3 [] [ text "We know Parkinson's affects people of all ages - so no matter how old you are, we can help." ]
        , div [ class "mw6 center" ] [ ageOptions model ]
        , handleNext model
        ]


ageOptions : Model -> Html Msg
ageOptions model =
    div [ class "flex flex-wrap justify-center" ] (List.map (ageOption model) ageRanges)


ageOption : Model -> AgeRange -> Html Msg
ageOption model ageRange =
    let
        handleSelectedClasses =
            [ ( "bg-green-blue white", model.ageRange == Just ageRange )
            , ( "black", model.ageRange /= Just ageRange )
            ]
    in
        div
            [ class "ba b--green-blue w-40 ph3 pv2 mr3 mb3 b pointer"
            , classList handleSelectedClasses
            , onClick <| SetAgeRange ageRange
            ]
            [ text <| ageRangeToString ageRange ]


handleNext : Model -> Html Msg
handleNext model =
    if isValidAgeRange model then
        button [ class Styles.buttonClear, onClick <| HandleGoToInstructions ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
