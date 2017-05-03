module Views.Services exposing (..)

import Components.QuoteBubble exposing (quoteBubble)
import Components.Utils exposing (emptyDiv)
import Data.Services exposing (..)
import Data.UserInfo exposing (isValidEmail)
import Helpers.Styles as Styles
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.Email exposing (..)
import Views.Widget exposing (..)


services : Model -> Html Msg
services model =
    div []
        [ div [ class "mw6 center mv3" ] [ quoteBubble "Here you are, your tailored list of Parkinson's services" ]
        , p [] [ text "Based on what you've told us, here's the information and support that we think's right for you." ]
        , renderResultsLink model
        , div [ class "bg-blue pb6" ] (List.map renderService model.top3things)
        , div [ class "mw7 center mv4" ]
            [ renderEmailForm model
            , emailSubmitted model
            ]
        ]


renderService : ServiceData -> Html Msg
renderService s =
    div [ class "mw7 pa4 bg-light-gray center" ]
        [ h3 [ class "blue ma0" ] [ text s.title ]
        , p [] [ text s.body ]
        , renderWidget <| shortcodeToWidget s
        , button [ class Styles.buttonClear ] [ text s.cta ]
        ]


renderResultsLink : Model -> Html Msg
renderResultsLink model =
    case model.uuid of
        Just uuid ->
            div [ class "pb4" ]
                [ p [] [ text "Come back and visit your page any time:" ]
                , a [ class "blue no-underline", href <| resultsUrl uuid ] [ text <| resultsUrl uuid ]
                ]

        Nothing ->
            emptyDiv


resultsUrl : String -> String
resultsUrl uuid =
    "https://what3things-staging.herokuapp.com/#my-results/" ++ uuid


renderEmailForm : Model -> Html Msg
renderEmailForm model =
    let
        prompts =
            { x = "Want a copy? Let us know your email address"
            , y = "If you'd like to have these resent to your email, click Submit"
            }
    in
        case model.email of
            Valid email ->
                emailForm model prompts.x email

            NotEntered ->
                emailForm model prompts.x ""

            Invalid email ->
                emailForm model prompts.x email

            Retrieved email ->
                emailForm model prompts.y email

            _ ->
                span [] []


emailForm : Model -> String -> String -> Html Msg
emailForm model prompt email =
    div [ class "flex flex-column items-center" ]
        [ h3 [ class "blue" ] [ text prompt ]
        , input [ onInput SetEmail, class (Styles.inputField ++ " mw5"), value email ] []
        , div [] [ handleSubmitEmail model ]
        ]


handleSubmitEmail : Model -> Html Msg
handleSubmitEmail model =
    if isValidEmail model.email then
        button
            [ onClick SubmitEmail
            , autocomplete False
            , class <| Styles.buttonClear ++ " mt3"
            ]
            [ text "Submit" ]
    else
        button [ class <| Styles.buttonDisabled ++ " mt3" ] [ text "Submit" ]


emailSubmitted : Model -> Html Msg
emailSubmitted model =
    case model.email of
        Submitted email ->
            h3 [ class "blue" ] [ text <| "Your results have been sent to " ++ email ]

        _ ->
            emptyDiv
