module Views.Error exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


error : ErrorType -> Model -> Html Msg
error errorType model =
    case errorType of
        FetchError ->
            addFriendlyErrorText model.fetchErrorMessage

        SubmitError ->
            addFriendlyErrorText model.submitErrorMessage


addFriendlyErrorText : String -> Html Msg
addFriendlyErrorText error =
    div [ class "red h-50 w-100 absolute flex flex-column justify-end" ]
        [ p [] [ text <| "Whoops, " ++ error ]
        , p [] [ text "Try refreshing the page and if it's still not working let us know:" ]
        , a [ href <| "mailto:" ++ contactEmail ] [ text contactEmail ]
        ]


contactEmail : String
contactEmail =
    "web@parkinsons.org.uk"
