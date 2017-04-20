module Views.Services exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Helpers.Styles as Styles
import Components.Logo exposing (..)
import Model exposing (..)
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
                , a [ class "blue", href <| "http://localhost:4000/#my-results/" ++ uuid ] [ text <| (++) "http://localhost:4000/#my-results/" <| Maybe.withDefault "" model.uuid ]
                ]

        Nothing ->
            div [] []


renderEmailForm : Model -> Html Msg
renderEmailForm model =
    case model.email of
        RetrievedEmail email ->
            div [] []

        ValidEmail email ->
            emailForm model email

        NotEnteredEmail ->
            emailForm model ""

        InvalidEmail email ->
            emailForm model email

        SubmittedEmail ->
            div [] []


emailForm : Model -> String -> Html Msg
emailForm model email =
    div []
        [ h3 [ class "blue" ] [ text "If you'd like a copy of them for futute reference, please enter your email" ]
        , input [ onInput SetEmail, class (Styles.inputField ++ " mw5 center"), placeholder "put your email", value email ] []
        , (handleSubmitEmail model)
        ]


handleSubmitEmail : Model -> Html Msg
handleSubmitEmail model =
    if isValidEmail model then
        button
            [ onClick SubmitEmail
            , autocomplete False
            , class (Styles.buttonBlue ++ " mt3")
            ]
            [ text "Submit" ]
    else
        button [ class Styles.buttonDisabled ] [ text "Submit" ]
