module Update exposing (..)

import Model exposing (..)
import Data.UserInfo exposing (validatePostcode)
import Data.Web.QuoteServiceWeighting exposing (getQuoteServiceWeighting)
import Data.Web.Answers exposing (handlePostAnswers)
import Data.Web.User exposing (..)
import Data.Web.UserEmail exposing (..)
import Data.Quotes exposing (..)
import Data.Weightings exposing (..)
import Data.Services exposing (..)
import Dict


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getQuoteServiceWeighting ]


initialModel : Model
initialModel =
    { view = Home
    , name = Nothing
    , postcode = NotEntered
    , ageRange = Nothing
    , email = Nothing
    , userId = Nothing
    , quotes = Dict.empty
    , services = Dict.empty
    , top3things = []
    , weightings = Dict.empty
    , fetchErrorMessage = ""
    , currentQuote = Nothing
    , remainingQuotes = Nothing
    , userWeightings = Dict.empty
    , userAnswers = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetView view ->
            { model | view = view } ! []

        SetName name ->
            { model | name = Just name } ! []

        SetPostcode postcode ->
            { model | postcode = validatePostcode postcode } ! []

        SetAgeRange ageRange ->
            { model | ageRange = Just ageRange } ! []

        SetEmail email ->
            { model | email = Just email } ! []

        ReceiveQuoteServiceWeighting (Err _) ->
            { model | fetchErrorMessage = "Something went wrong fetching the data." } ! []

        ReceiveQuoteServiceWeighting (Ok data) ->
            let
                qIds =
                    getQuoteIds data.quotes
            in
                { model
                    | quotes = data.quotes
                    , services = data.services
                    , weightings = data.weightings
                    , remainingQuotes = List.tail qIds
                    , currentQuote = List.head qIds
                    , userWeightings = makeEmptyWeightingsDict data.services
                }
                    ! []

        SubmitAnswer answer ->
            let
                newModel =
                    model
                        |> handleAnswer answer
                        |> updateWeightings answer
                        |> handleNextQuote
                        |> handleGoToServices
                        |> handleTop3Things
            in
                newModel ! [ handlePostAnswers newModel ]

        HandleGoToQuotes ->
            (handleGoToQuotes model) ! [ postUserDetails model ]

        ReceiveUserId (Err _) ->
            model ! []

        ReceiveUserId (Ok uId) ->
            { model | userId = Just uId } ! []

        PutUserEmail (Ok _) ->
            model ! []

        PutUserEmail (Err _) ->
            model ! []

        SubmitEmail ->
            model ! [ sendUserEmail model ]

        PostUserAnswers _ ->
            model ! []
