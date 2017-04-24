module Views.Services exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Helpers.Styles as Styles
import Components.Utils exposing (emptyDiv)
import Components.Logo exposing (..)
import Model exposing (..)
import Model.Email exposing (..)
import Data.UserInfo exposing (isValidEmail)


services : Model -> Html Msg
services model =
    div []
        [ logo
        , h2 [ class "blue mb4" ] [ text "Here you are, your tailored list of Parkinson's services" ]
        , div [ class "bg-blue pb6" ] (List.map renderService model.top3things)
        , div [ class "mw7 center mv4" ]
            [ (renderResultsLink model)
            , (renderEmailForm model)
            , (emailSubmitted model)
            ]
        ]


renderService : ServiceData -> Html Msg
renderService s =
    div [ class "mw7 pa4 bg-light-gray center" ]
        [ h3 [ class "blue ma0" ] [ text s.title ]
        , p [] [ text s.body ]
        , button [ class Styles.buttonBlue ] [ text s.cta ]
        ]


renderResultsLink : Model -> Html Msg
renderResultsLink model =
    case model.uuid of
        Just uuid ->
            div []
                [ h3 [ class "blue" ] [ text "Your results will be accessible at the following URL" ]
                , a [ class "blue", href <| resultsUrl uuid ] [ text <| resultsUrl uuid ]
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
            { x = "If you'd like a copy of them for futute reference, please enter your email"
            , y = "If you'd like to have these resent to your email, click the button"
            }
    in
        case model.email of
            Valid email ->
                emailForm model prompts.x email

            NotEntered ->
                emailForm model "" ""

            Invalid email ->
                emailForm model prompts.x email

            Retrieved email ->
                emailForm model prompts.y email

            _ ->
                span [] []


emailForm : Model -> String -> String -> Html Msg
emailForm model prompt email =
    div []
        [ h3 [ class "blue" ] [ text prompt ]
        , input [ onInput SetEmail, class (Styles.inputField ++ " mw5 center"), placeholder "put your email", value email ] []
        , (handleSubmitEmail model)
        ]


handleSubmitEmail : Model -> Html Msg
handleSubmitEmail model =
    if isValidEmail model.email then
        button
            [ onClick SubmitEmail
            , autocomplete False
            , class (Styles.buttonBlue ++ " mt3")
            ]
            [ text "Submit" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Submit" ]


emailSubmitted : Model -> Html Msg
emailSubmitted model =
    case model.email of
        Submitted email ->
            h3 [ class "blue" ] [ text <| "Your results have been sent to " ++ email ]

        _ ->
            emptyDiv
