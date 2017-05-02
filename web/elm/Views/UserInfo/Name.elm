module Views.UserInfo.Name exposing (name)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.UserInfo exposing (isValidName)
import Helpers.Styles as Styles
import Components.Logo exposing (logo)


name : Model -> Html Msg
name model =
    div []
        [ logo
        , h2 [ class "blue" ] [ text "What shall we call you?" ]
        , div [ class "w-100 mw6 center" ] [ nameField model ]
        , handleNext model
        ]


nameField : Model -> Html Msg
nameField model =
    div [ class "flex items-center pa4" ]
        [ input
            [ class Styles.inputField
            , onInput SetName
            , autocomplete False
            , value <| Maybe.withDefault "" model.name
            ]
            []
        ]


handleNext : Model -> Html Msg
handleNext model =
    if isValidName model then
        button [ class Styles.buttonClear, onClick <| SetView Postcode ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
