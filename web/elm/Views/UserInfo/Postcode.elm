module Views.UserInfo.Postcode exposing (postcode)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.UserInfo exposing (isValidPostcode, postCodeToString)
import Helpers.Styles as Styles
import Components.Logo exposing (logo)


postcode : Model -> Html Msg
postcode model =
    div []
        [ logo
        , h2 [ class "blue" ] [ text <| String.toUpper <| "A bit about you" ]
        , div [ class "flex flex-column justify-center items-center" ]
            [ div [] [ postcodeField model ]
            ]
        , handleNext model
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


handleNext : Model -> Html Msg
handleNext model =
    if isValidPostcode model then
        button [ class Styles.buttonBlue, onClick <| SetView Home ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
