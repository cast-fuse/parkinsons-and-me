module Helpers.Errors exposing (..)

import Model exposing (..)


removeFetchError : Model -> Model
removeFetchError model =
    { model | fetchErrorMessage = "" }


removeSubmitError : Model -> Model
removeSubmitError model =
    { model | submitErrorMessage = "" }


putUserEmailError : String
putUserEmailError =
    "Something went wrong when submitting email"


postUserAnswersError : String
postUserAnswersError =
    "Something went wrong when sending answers"


receiveUserError : String
receiveUserError =
    "Something went wrong fetching user data"


receiveResultsError : String
receiveResultsError =
    "Something went wrong fetching results data"


quotesServiceWeightingsError : String
quotesServiceWeightingsError =
    "Something went wrong fetching quote-service-weighting data"
