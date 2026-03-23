# Main Game Loop

## Rock Paper Scissors flow

1. Click either Rock, Paper, or Scissors
2. Displays choice
3. Computer picks their choice randomly
4. Countdown begins (3... 2... 1...). Speed of countdown is variable with upgrades
  - should disable selections while waiting for timer
  - after timer finishes, re-enable the selections
5. Computer choice displays
6. Decide if win
7. If you win, gain 1 point
8. If you tie, nothing happens
9. If you lose, add "rage" reducing cooldown by some % compounding. Delay is variable with upgrades

## Clicking one of RPS
1. Click one
2. Display choice
3. Disable button until after decision is made
4. On loss, add "rage" reducing cooldown by some % compounding
5. Wait cooldown period until you can click again

# Upgrades

## Things to upgrade
1. Cash payout
2. Countdown length
3. Odds of winning (with each of R,P,S)
4. Combo value?
5. Number of background players
6. Frequency of background players playing
7. Rage multiplier
8. Rage duration

## Upgrade schools

Rock, Paper, and Scissors get XP for each of their own schools

1. Different types of upgrades for each school
2. Rock:
3. Paper:
4. Scissors:

### Upgrade logic

```
{
  "skills": {
    "001": {
      "description": "Upgrade Cash Prize Lv. 1",
      "cost": 10,
      "cash+": 1,
      "dependencies": []
    },
    "002": {
      "description": "Upgrade Cash Prize Lv. 2",
      "cost": 200,
      "cash+": 2,
      "dependencies": ["001"]
    }
  }
}
```

1. Have full list of upgrades, including progressive upgrades
2. Have full list of taken upgrades (or is "taken" just an attribute on above list?)
2. On skill taken:
  - Append skill ID to list of taken skills
  - Emit a signal with which upgrade was taken (and list of all upgrades, and list of taken upgrades?)
  - Subsystems (like CashManager) catch signal and record the change (such as increased value))
  - Identify any skills whose dependencies are now satisfied, and add them to the list of "available upgrades".
  - Update list of available upgrades, including cost