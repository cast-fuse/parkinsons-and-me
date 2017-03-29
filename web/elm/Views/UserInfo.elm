module Views.UserInfo exposing (userInfo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Components.Logo exposing (logo)
import Data.UserInfo
    exposing
        ( ageRanges
        , ageRangeToString
        , postCodeToString
        , isValidAgeRange
        , isValidName
        , isValidPostcode
        )


userInfo : Model -> Html Msg
userInfo model =
    div []
        [ logo
        , h2 [ class "blue" ] [ text <| String.toUpper <| "A bit about you" ]
        , div [ class "flex flex-column justify-center items-center" ]
            [ div []
                [ nameField model
                , postcodeField model
                , ageField model
                ]
            ]
        , errorMessage model
        , button [ class "bg-dark-blue bn white ph6 pv3 f5 mt4", onClick SubmitForm ] [ text "Next" ]
        ]


nameField : Model -> Html Msg
nameField model =
    div [ class "flex items-center" ]
        [ p
            [ class "tl w6"
            , classList [ ( "red", model.formErrors && not (isValidName model) ) ]
            ]
            [ text "What's your name?" ]
        , input
            [ class "w7 h2 ttu"
            , onInput SetName
            , value <| Maybe.withDefault "" model.name
            ]
            []
        ]


postcodeField : Model -> Html Msg
postcodeField model =
    div [ class "flex items-center" ]
        [ p
            [ class "tl w6"
            , classList [ ( "red", model.formErrors && not (isValidPostcode model) ) ]
            ]
            [ text "What's your postcode?" ]
        , input
            [ class "w7 h2 ttu"
            , onInput SetPostcode
            , value <| postCodeToString model.postcode
            ]
            []
        ]


ageField : Model -> Html Msg
ageField model =
    div [ class "flex mt4" ]
        [ p
            [ class "tl w6 ma0 mt2"
            , classList [ ( "red", model.formErrors && not (isValidAgeRange model) ) ]
            ]
            [ text "What's your age range?" ]
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


errorMessage : Model -> Html Msg
errorMessage model =
    if model.formErrors then
        p [ class "red" ] [ text "Please verify the fields in red" ]
    else
        span [] []
