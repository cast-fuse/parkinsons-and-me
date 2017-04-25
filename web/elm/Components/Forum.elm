module Components.Forum exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


forum : Html msg
forum =
    div []
        [ iframe [ class "w-100", height 400, src "https://www.youtube.com/embed/zSsh0_Z7Ipk" ] [] ]
