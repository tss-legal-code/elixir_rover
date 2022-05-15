defmodule RovexTest do
  use ExUnit.Case
  doctest Rovex

  test "get_state should return current state" do
    {:ok, _} = Rover.start_link({9, 9, :N, "rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9, 9, :N}
  end

  test "handle_cast :go_forward should return  updated state" do
    {:noreply, state} = Rover.handle_cast(:go_forward, %Rover{x: 1, y: 3, direction: :N})
    assert state.x == 1
    assert state.y == 4
    assert state.direction == :N
  end

  test "handle_cast :rotate_left should return  updated state (N)" do
    {:noreply, state} = Rover.handle_cast(:rotate_left, %Rover{x: 1, y: 3, direction: :N})
    assert state.x == 1
    assert state.y == 3
    assert state.direction == :W
  end
end
