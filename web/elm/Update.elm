module Update exposing (..)

import Model exposing (..)
import Data.Quotes exposing (..)


init : ( Model, Cmd Msg )
init =
    initialModel ! []


initialModel : Model
initialModel =
    { view = Quotes
    , currentQuote = ( 0, firstQuote )
    , quotes = quoteList
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetView view ->
            { model | view = view } ! []

        UpdateAnswer answer (( i, _ ) as currentQuote) ->
            { model
                | quotes = updateAnswer answer currentQuote model.quotes
                , currentQuote = getQuote (i + 1) model.quotes
            }
                ! []
