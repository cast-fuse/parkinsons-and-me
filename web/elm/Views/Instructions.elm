module Views.Instructions exposing (instructions)

import Helpers.Styles exposing (buttonClear)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


instructions : Model -> Html Msg
instructions model =
    div [ class "mw6 center" ]
        [ h2 [] [ text "We're now going to share some quotes from real people - they've all been recently diagnosed too. If the quote sounds like you, there's an option to let us know." ]
        , h2 [] [ text "This will help us get a better picture of what information and support is right for you." ]
        , h2 [] [ text "Ready?" ]
        , button [ class buttonClear, onClick <| SetView Quotes ] [ text "Let's go" ]
        ]
