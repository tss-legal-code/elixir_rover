# Rovex

Sample application I wrote while reading a book by Emanuele Delbono "ELIXIR SUCCINTLY"
(https://www.syncfusion.com/succinctly-free-ebooks/elixir-succinctly)

Original repository: https://github.com/emadb/rovex

Original working app: http://rovex.herokuapp.com/ (to test gamepay: open URL in two tabs and play for two players, if lost your opponent - in console positions are displayed after each move)

# Test in REPL:

D:\do\rovex>iex -S mix

Compiling 1 file (.ex)
Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)

iex(1)> RoverSupervisor.create_rover("my", 10,20,:W)
{:ok, #PID<0.167.0>}

iex(2)> RoverSupervisor.create_rover("next", 15,20,:S)
{:ok, #PID<0.169.0>}

iex(3)> Rover.go_forward("my")
:ok

iex(4)> Rover.get_state("my")
{:ok, {9, 20, :W}}


## Installation

Installation and GUI were out of scope of the book.