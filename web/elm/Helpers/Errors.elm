module Helpers.Errors exposing (..)

import Model exposing (..)


removeFetchError : Model -> Model
removeFetchError model =
    { model | fetchErrorMessage = "" }


removeSubmitError : Model -> Model
removeSubmitError model =
    { model | submitErrorMessage = "" }


putUserEmailError : Model -> Model
putUserEmailError model =
    model |> submitError "Something went wrong when submitting email"


putUserEmailConsentError : Model -> Model
putUserEmailConsentError model =
    model |> submitError "Something went wrong when submitting email consent"


postUserAnswersError : Model -> Model
postUserAnswersError model =
    model |> submitError "Something went wrong when sending answers"


receiveUserError : Model -> Model
receiveUserError model =
    model |> fetchError "Something went wrong fetching user data"


receiveResultsError : Model -> Model
receiveResultsError model =
    model |> fetchError "Something went wrong fetching results data"


quotesServiceWeightingsError : Model -> Model
quotesServiceWeightingsError model =
    model |> fetchError "Something went wrong fetching quote-service-weighting data"


fetchError : String -> Model -> Model
fetchError message model =
    { model | fetchErrorMessage = message } |> fetchErrorView


submitError : String -> Model -> Model
submitError message model =
    { model | submitErrorMessage = message } |> submitErrorView


fetchErrorView : Model -> Model
fetchErrorView model =
    { model | view = Error FetchError }


submitErrorView : Model -> Model
submitErrorView model =
    { model | view = Error SubmitError }
