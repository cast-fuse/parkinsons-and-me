module Views.UserInfo.Postcode exposing (postcode)

import Components.SpeechHeader exposing (speechHeader)
import Data.UserInfo exposing (isValidPostcode, postCodeToString)
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


postcode : Model -> Html Msg
postcode model =
    div []
        [ speechHeader "What's your postcode?"
        , h3 [] [ text "Don't worry, we'll only use your postcode for finding helpful local support." ]
        , div [ class "w-100 mw4 center" ] [ postcodeField model ]
        , handleNext model
        ]


postcodeField : Model -> Html Msg
postcodeField model =
    div [ class "flex items-center pa4" ]
        [ input
            [ class <| classes [ Styles.inputField, "ttu tc" ]
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
