module Views.Services exposing (..)

import Components.QuoteBubble exposing (cycleQuoteBackground, quoteBubble)
import Components.Utils exposing (emptyDiv)
import Data.UserInfo exposing (isValidEmail)
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Model.Email exposing (..)


services : Model -> Html Msg
services model =
    let
        emailAnchor =
            resultsLink model
    in
        div []
            [ div [ class "mw6 center mv3" ] [ quoteBubble "Here it is, your personalised list of Parkinson's services" "pa5-ns" Blue ]
            , h3 [] [ text "Based on what you've told us, here's the information and support that we think's right for you." ]
            , h3 [] [ text "Shall we email you a copy?" ]
            , a [ href <| "#" ++ emailAnchor ] [ button [ class Styles.buttonClear ] [ text "Yes Please" ] ]
            , div [ class "pb3" ] (List.indexedMap renderService model.top3Services)
            , div [ class "mw7 center mv4", id emailAnchor ]
                [ renderEmailForm model
                , emailSubmitted model
                ]
            , renderResultsLink model
            , div [ class "mw6 center mv3" ] [ quoteBubble "Psst...one more thing.." "" Green ]
            , div [ class "mw7 center mv4" ]
                [ h3 [] [ text "Thank you for testing ", i [ class "dark-blue" ] [ text "Parkinson's and Me" ], text ". You’ve caught it hot off the press – it’s not quite live yet and we’re still making improvements. We’d love to know what you thought and if you have any suggestions on how we could make it better." ]
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
        [ div [ class "mw5 center" ] [ quoteBubble s.title "ph5-ns" (cycleQuoteBackground i) ]
        , p [] [ text s.body ]
        , button [ class Styles.buttonClear ] [ text s.cta ]
        ]


renderResultsLink : Model -> Html Msg
renderResultsLink model =
    case model.uuid of
        Just _ ->
            div [ class "pb4" ]
                [ h3 [] [ text "Come back and visit your page any time:" ]
                , a [ class "no-underline dark-blue f3", href <| resultsUrl model, target "_blank" ] [ text <| resultsUrl model ]
                ]

        Nothing ->
            emptyDiv


resultsUrl : Model -> String
resultsUrl model =
    String.concat
        [ "https://wwww.parkinsons-and-me.herokuapp.com/"
        , "#"
        , resultsLink model
        ]


resultsLink : Model -> String
resultsLink model =
    model.uuid
        |> Maybe.map ((++) "my-results/")
        |> Maybe.withDefault ""


renderEmailForm : Model -> Html Msg
renderEmailForm model =
    let
        prompts =
            { new = "Want a copy? we can send it to you via email"
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
        [ h3 [] [ text prompt ]
        , input [ onInput SetEmail, class <| classes [ Styles.inputField, "mw5" ], value email ] []
        , div [] [ handleSubmitEmail model ]
        , privacyStatement model
        ]


privacyStatement : Model -> Html Msg
privacyStatement model =
    case model.emailConsent of
        False ->
            h3 []
                [ input
                    [ type_ "checkbox"
                    , onCheck SetEmailConsent
                    , checked model.emailConsent
                    ]
                    []
                , text "We’d love to hear your feedback! If you’re happy to be contacted by Parkinson’s UK about"
                , i [ class "dark-blue" ] [ text " Parkinson's and Me" ]
                , text " please tick this box. Don’t worry, your details won’t be used for anything else. To find out more, read our "
                , a [ href "https://www.parkinsons.org.uk/content/parkinsons-uk-website-terms-and-conditions", class "no-underline dark-blue" ] [ text "privacy statement" ]
                ]

        True ->
            h3 [] [ text "Thanks for taking part, we'll get in touch later to ask you what you think of the app" ]


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
            h3 [] [ text <| "Your results have been sent to " ++ email ]

        _ ->
            emptyDiv
