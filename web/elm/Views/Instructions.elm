module Views.Instructions exposing (instructions)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


instructions : Model -> Html Msg
instructions model =
    div []
        [ p [] [ text "We're now going to share some quotes from real people with you - they've all been recently diagnosed too. If the quote sounds like you, there's an option to let us know." ]
        , p [] [ text "This will help us get a better picture of what information and support is right for you." ]
        , p [] [ text "Ready?" ]
        , button [ onClick <| SetView Quotes ] [ text "Let's go" ]
        ]
