module Views.Services exposing (..)

import Components.QuoteBubble exposing (quoteBubble)
import Components.Utils exposing (emptyDiv)
import Data.Services exposing (..)
import Data.UserInfo exposing (isValidEmail)
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.Email exposing (..)
import Views.Widget exposing (..)


services : Model -> Html Msg
services model =
    div []
        [ div [ class "mw6 center mv3" ] [ quoteBubble "Here it is, your personalised list of Parkinson's services" Blue ]
        , h3 [] [ text "Based on what you've told us, here's the information and support that we think's right for you." ]
        , renderResultsLink model
        , div [ class "pb6" ] (List.indexedMap renderService model.top3things)
        , div [ class "mw7 center mv4" ]
            [ renderEmailForm model
            , emailSubmitted model
            ]
        , div [ class "mw6 center mv3" ] [ quoteBubble "Psst...one more thing.." Green ]
        , div [ class "mw7 center mv4" ]
            [ h3 [] [ text "Thank you for testing [product name]. You’ve caught it hot off the press – it’s not quite live yet and we’re still making improvements. We’d love to know what you thought and if you have any suggestions on how we could make it better. " ]
            , h3 [] [ text "Can you spare ten minutes to share your feedback?" ]
            , div [ class "flex justify-between mw6 center" ]
                [ button [ class Styles.buttonClear ] [ text "Fill out this quick survey" ]
                , button [ class Styles.buttonClear ] [ text "Drop us an email" ]
                ]
            ]
        ]


renderService : Int -> ServiceData -> Html Msg
renderService i s =
    div [ class "mw7 pa4 center" ]
        [ div [ class "mw5 center" ] [ quoteBubble s.title (handleBackground i) ]
        , p [] [ text s.body ]
        , renderWidget <| shortcodeToWidget s
        , button [ class Styles.buttonClear ] [ text s.cta ]
        ]


handleBackground : Int -> QuoteBubbleBackground
handleBackground i =
    case i of
        0 ->
            Orange

        1 ->
            Green

        _ ->
            Blue


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
            { new = "Want a copy? Let us know your email address"
            , returning = "If you'd like to have these resent to your email, click Submit"
            }
    in
        case model.email of
            Valid email ->
                emailForm model prompts.new email

            NotEntered ->
                emailForm model prompts.new ""

            Invalid email ->
                emailForm model prompts.new email

            Retrieved email ->
                emailForm model prompts.returning email

            _ ->
                span [] []


emailForm : Model -> String -> String -> Html Msg
emailForm model prompt email =
    div [ class "flex flex-column items-center" ]
        [ h3 [ class "blue" ] [ text prompt ]
        , input [ onInput SetEmail, class <| classes [ Styles.inputField, "mw5" ], value email ] []
        , div [] [ handleSubmitEmail model ]
        ]


handleSubmitEmail : Model -> Html Msg
handleSubmitEmail model =
    if isValidEmail model.email then
        button
            [ onClick SubmitEmail
            , autocomplete False
            , class <| classes [ Styles.buttonClear, "mt3" ]
            ]
            [ text "Submit" ]
    else
        button [ class <| classes [ Styles.buttonDisabled, "mt3" ] ] [ text "Submit" ]


emailSubmitted : Model -> Html Msg
emailSubmitted model =
    case model.email of
        Submitted email ->
            h3 [ class "blue" ] [ text <| "Your results have been sent to " ++ email ]

        _ ->
            emptyDiv
