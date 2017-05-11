module Views.Services exposing (..)

import Components.QuoteBubble exposing (cycleQuoteBackground, quoteBubble)
import Components.Utils exposing (emptyDiv, outboundLink)
import Data.UserInfo exposing (isValidEmail, postCodeToString)
import Helpers.Styles as Styles exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlParser
import HtmlParser.Util
import Model exposing (..)
import Model.Email exposing (..)
import Model.Postcode exposing (Postcode)


services : Model -> Html Msg
services model =
    let
        emailAnchor =
            resultsLink model
    in
        div []
            [ div [ class "mw6 center mv3" ] [ quoteBubble "Here's your personalised list of Parkinson's services" "handwriting-title pa5-ns f1" Blue ]
            , h3 [] [ text "Based on what you've told us, here's the information and support that we think's right for you." ]
            , h3 [] [ text "Shall we email you a copy?" ]
            , a [ href <| "#" ++ emailAnchor ] [ button [ class Styles.buttonClearHover ] [ text "Yes Please" ] ]
            , div [ class "pb3" ] (List.indexedMap (renderService model.postcode) model.top3Services)
            , div [ class "mw7 center", id emailAnchor ]
                [ renderEmailForm model
                , emailSubmitted model
                ]
            , renderResultsLink model
            , div [ class "mw6 center mv3" ] [ quoteBubble "Psst...one more thing..." "handwriting f2" Green ]
            , div [ class "mw7 center mv4" ]
                [ h3 [] [ text "Thank you for testing ", span [ class "dark-blue" ] [ text "Parkinson's and Me" ], text ". You’ve caught it hot off the press – it’s not quite live yet and we’re still making improvements. We’d love to know what you thought and if you have any suggestions on how we could make it better." ]
                , h3 [] [ text "Can you spare two minutes to share your feedback?" ]
                , div [ class "flex justify-between mw6 flex-row-ns flex-column ma3 center" ]
                    [ surveyLink
                    , parkinsonsEmailLink
                    ]
                ]
            ]


renderService : Postcode -> Int -> ServiceData -> Html Msg
renderService postcode i service =
    let
        url =
            handleLocationBasedUrl postcode service

        ctaButton =
            button [ class Styles.buttonClearHover ] [ text service.cta ]

        cta =
            outboundLink url ctaButton
    in
        div [ class "mw7 pa4 center" ]
            [ div [ class "mw5 center" ] [ quoteBubble service.title "ph5-ns handwriting f2" (cycleQuoteBackground i) ]
            , div [] <| parseServiceBody service.body
            , cta
            ]


handleLocationBasedUrl : Postcode -> ServiceData -> String
handleLocationBasedUrl postcode serviceData =
    case serviceData.locationBasedUrl of
        True ->
            serviceData.url ++ (postCodeToString postcode)

        False ->
            serviceData.url


parseServiceBody : String -> List (Html Msg)
parseServiceBody body =
    body
        |> HtmlParser.parse
        |> HtmlParser.Util.toVirtualDom


renderResultsLink : Model -> Html Msg
renderResultsLink model =
    case model.answerUuid of
        Just _ ->
            div [ class "pv4" ]
                [ h3 [ class "mv2" ] [ text "Come back and visit your page any time:" ]
                , a [ class "no-underline dark-blue f3", href <| resultsUrl model, target "_blank" ] [ text <| resultsUrl model ]
                ]

        Nothing ->
            emptyDiv


resultsUrl : Model -> String
resultsUrl model =
    String.concat
        [ "https://parkinsons-and-me.herokuapp.com/"
        , "#"
        , resultsLink model
        ]


resultsLink : Model -> String
resultsLink model =
    model.answerUuid
        |> Maybe.map ((++) "my-results/")
        |> Maybe.withDefault ""


renderEmailForm : Model -> Html Msg
renderEmailForm model =
    let
        prompts =
            { new = "Would you like us to email you a copy?"
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
        , input [ onInput SetEmail, class <| classes [ Styles.inputField, "mw5 w-75 w-100-ns tc" ], value email ] []
        , privacyStatement model
        , div [] [ handleSubmitEmail model ]
        ]


privacyStatement : Model -> Html Msg
privacyStatement model =
    p [ class "f6" ]
        [ input
            [ type_ "checkbox"
            , onCheck SetEmailConsent
            , checked model.emailConsent
            , class "mr1"
            ]
            []
        , text "We would love to get in touch with you again and hear what you thought about "
        , i [ class "dark-blue" ] [ text "Parkinson's and Me" ]
        , text ". If you're happy to be contacted by Parkinson's UK in the future, please tick this box. To find out more, read our "
        , a
            [ href "https://www.parkinsons.org.uk/content/parkinsons-uk-website-terms-and-conditions"
            , target "_blank"
            , class "no-underline dark-blue"
            ]
            [ text "privacy statement." ]
        ]


handleSubmitEmail : Model -> Html Msg
handleSubmitEmail model =
    if isValidEmail model.email then
        button
            [ onClick SubmitEmail
            , autocomplete False
            , class <| classes [ Styles.buttonClearHover, "mt3" ]
            ]
            [ text "Email my recommendations" ]
    else
        button [ class <| classes [ Styles.buttonDisabled, "mt3" ] ] [ text "Email my recommendations" ]


emailSubmitted : Model -> Html Msg
emailSubmitted model =
    case model.email of
        Submitted email ->
            h3 [ class "dark-blue f3" ] [ text <| "Your list of services has been sent to " ++ email ]

        _ ->
            emptyDiv


surveyLink : Html Msg
surveyLink =
    a
        [ href "https://goo.gl/forms/Ld8X0fSkdMF5wvlo2"
        , target "_blank"
        ]
        [ button
            [ class <| classes [ "ma1", Styles.buttonClearHover ] ]
            [ text "Fill out this quick survey" ]
        ]


parkinsonsEmailLink : Html Msg
parkinsonsEmailLink =
    a
        [ href "mailto:web@parkinsons.org.uk?subject=Here's some feedback on Parkinson's and Me" ]
        [ button
            [ class <| classes [ "ma1", Styles.buttonClearHover ] ]
            [ text "Drop us an email" ]
        ]
