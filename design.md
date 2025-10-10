# Design

## Rock Paper Scissors flow

1. Click either Rock, Paper, or Scissors
2. Displays choice
3. Computer picks their choice randomly
4. Countdown begins (3... 2... 1...). Speed of countdown is variable with upgrades
5. Computer choice displays
6. Decide if win
7. If you win, gain 1 point
8. If you tie, nothing happens
9. If you lose, 1 second delay before you can play again. Delay is variable with upgrades

## Clicking one of RPS
1. Click one
2. Display choice
3. Disable button until after decision is made
4. On loss, cooldown += 1 second
5. Wait cooldown period until you can click again