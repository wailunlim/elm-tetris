module Main exposing (Model)

import Array exposing (..)
import Browser
import Grid exposing (..)
import Html exposing (Html, div, h1, span, td)
import Html.Attributes exposing (style)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (color, height, width)



-- Main


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- Model


type alias Model =
    { board : Board
    }


initUnit : Int -> Int -> Maybe Unit
initUnit i j =
    Nothing


init : Model
init =
    { board = Grid.initialize 10 20 initUnit
    }


type alias Board =
    Grid (Maybe Unit)


type alias Unit =
    Svg Msg


type Tetromino
    = I
    | O
    | T
    | S
    | Z
    | J
    | L



-- Update


type Msg
    = Tick


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick ->
            model



-- View


renderLine : Array (Html Msg) -> Html Msg
renderLine arr =
    div [ style "display" "flex" ] (toList arr)


renderUnit : Maybe Unit -> Html Msg
renderUnit piece =
    case piece of
        Nothing ->
            svg [ width "20", height "20" ] [ rect [ height "20", width "20", color "black" ] [] ]

        Just x ->
            svg [] [ x ]


collateLines : Array (Html Msg) -> Html Msg
collateLines arr =
    div [] (toList arr)


renderBoard : Board -> Html Msg
renderBoard board =
    board
        |> Grid.rows
        |> Array.map (Array.map renderUnit)
        |> Array.map renderLine
        |> collateLines


view : Model -> Html Msg
view model =
    div [] [ renderBoard model.board ]
