module Model exposing (..)

import Model.Email exposing (Email)
import Model.Postcode exposing (Postcode)
import Dict exposing (..)
import Http
import Navigation


type alias Model =
    { view : View
    , name : Maybe String
    , postcode : Postcode
    , ageRange : Maybe AgeRange
    , email : Email
    , emailConsent : Bool
    , userId : Maybe Int
    , quotes : Quotes
    , services : Services
    , top3Services : List ServiceData
    , weightings : Weightings
    , fetchErrorMessage : String
    , submitErrorMessage : String
    , currentQuote : Maybe QuoteId
    , remainingQuotes : Maybe (List QuoteId)
    , userWeightings : WeightingsDict
    , userAnswers : List ( QuoteId, Answer )
    , entryPoint : EntryPoint
    , answerUuid : Maybe String
    }


type View
    = Home
    | Name
    | Postcode
    | Age
    | Instructions
    | Quotes
    | Services
    | Error ErrorType
    | Loading


type ErrorType
    = SubmitError
    | FetchError


type AgeRange
    = UnderForty
    | Forties
    | Fifties
    | Sixties
    | Seventies
    | OverEighty


type Answer
    = Yes
    | No


type QuoteBackground
    = Blue
    | Green
    | Orange


type alias Quotes =
    Dict QuoteId String


type alias Services =
    Dict ServiceId ServiceData


type alias ServiceData =
    { title : String
    , body : String
    , cta : String
    , url : String
    , earlyOnset : Bool
    , locationBasedUrl : Bool
    }


type alias Weightings =
    Dict QuoteId WeightingsDict


type alias WeightingsDict =
    Dict ServiceId Float


type alias RawWeighting =
    { quote_id : Int
    , service_id : Int
    , weight : Float
    }


type alias RawUser =
    { id : Int
    , name : String
    , ageRange : AgeRange
    , email : String
    , emailConsent : Bool
    , postcode : String
    }


type alias RawAnswer =
    { quoteId : QuoteId
    , answer : Answer
    }


type alias QuoteId =
    Int


type alias ServiceId =
    Int


type alias Results =
    { user : RawUser
    , answers : List ( QuoteId, Answer )
    , quotes : Quotes
    , services : Services
    , weightings : Weightings
    }


type alias QuoteServiceWeightings =
    { quotes : Quotes
    , services : Services
    , weightings : Weightings
    }


type EntryPoint
    = Start
    | Finish AnswerUuid


type alias AnswerUuid =
    String


type Msg
    = SetView View
    | SetName String
    | SetPostcode String
    | SetAgeRange AgeRange
    | SetEmail String
    | SetEmailConsent Bool
    | ReceiveQuoteServiceWeightings (Result Http.Error QuoteServiceWeightings)
    | ShuffleQuoteIds (List QuoteId) (List Int)
    | SubmitAnswer Answer
    | HandleGoToInstructions
    | ReceiveUser (Result Http.Error RawUser)
    | PutUserEmail (Result Http.Error ())
    | PutUserEmailConsent (Result Http.Error ())
    | SubmitEmail
    | PostUserAnswers (Result Http.Error String)
    | UrlChange Navigation.Location
    | ReceiveResults (Result Http.Error Results)
    | TrackOutboundLink String
