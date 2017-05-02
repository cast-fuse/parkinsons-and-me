module Views.UserInfo.Postcode exposing (postcode)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Components.SpeechHeader exposing (speechHeader)
import Data.UserInfo exposing (isValidPostcode, postCodeToString)
import Helpers.Styles as Styles


postcode : Model -> Html Msg
postcode model =
    div []
        [ speechHeader "What's your postcode?"
        , p [] [ text "Don't worry, we won't use your information for anything except for finding the right support near you." ]
        , div [ class "w-100 mw6 center" ] [ postcodeField model ]
        , handleNext model
        ]


postcodeField : Model -> Html Msg
postcodeField model =
    div [ class "flex items-center pa4" ]
        [ input
            [ class <| Styles.inputField ++ " ttu"
            , onInput SetPostcode
            , autocomplete False
            , value <| postCodeToString model.postcode
            ]
            []
        ]


handleNext : Model -> Html Msg
handleNext model =
    if isValidPostcode model.postcode then
        button [ class Styles.buttonClear, onClick <| SetView Age ] [ text "Next" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Next" ]
