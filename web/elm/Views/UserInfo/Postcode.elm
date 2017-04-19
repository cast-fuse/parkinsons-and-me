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
            [ div [ class "w-100 mw6" ] [ postcodeField model ]
            ]
        , handleNext model
        ]


postcodeField : Model -> Html Msg
postcodeField model =
    div [ class "flex items-center pa4" ]
        [ p [ class "tl w-75 mr3" ] [ text "What's your postcode?" ]
        , input
            [ class Styles.inputField
            , onInput SetPostcode
            , autocomplete False
            , value <| postCodeToString model.postcode
            ]
            []
        ]


handleNext : Model -> Html Msg
handleNext model =
    if isValidPostcode model then
        button [ class Styles.buttonBlue, onClick <| SetView Age ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
