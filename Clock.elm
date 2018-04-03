-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html

import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Time.DateTime exposing (..)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model = Time
    -- { minutes : Time
    -- , seconds : Time
    -- }


init : (Model, Cmd Msg)
init =
  (0, Cmd.none)
--   (Model (Time 0, Time 0), Cmd.none)



-- UPDATE


type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)
    -- Tock newTime 



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every Time.second Tick
--   Time.every minute Tock



-- VIEW


view : Model -> Html Msg
view model =
  let
    now =
      epoch
      |> addMilliseconds (floor model)

    stringTurns = 
      toString (turns (toFloat (Time.DateTime.minute now)))

    angleMin = 
      degrees (toFloat (Time.DateTime.minute now)) * 6

    handXMin =
      toString (50 + 40 * cos (angleMin - (degrees 90)))

    handYMin =
      toString (50 + 40 * sin (angleMin - (degrees 90)))

    angle =
      turns (Time.inMinutes model)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    div [] [
        Html.text (toString (angleMin))
        ,svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
      , line [ x1 "50", y1 "50", x2 handXMin, y2 handYMin, stroke "#023963" ] []
      ]
    ]
    
