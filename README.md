# PSTea Animated Soda Can

PSTea Animated Soda Can is a port of my [Animated Soda Can Demo](https://gist.github.com/gregoryfmartin/cd8578c167120b90bf3c8550e2b9e42b) that's been ported into Jake Hildreth's [PSTea](https://github.com/jakehildreth/PSTea). The major difference here is the use of PSTea's Components and Timers to govern animations and display within the MVU architecture.

This is a self-contained tech demo that you can download and run in either PowerShell 5.X or 7.X. The soda can images are encoded in both Sixel and Kitty Graphics Protocol. If you see blank or odd characters in the rendering of the cans, your terminal emulator likely doesn't support these encoding formats.

## How It Works

The script defines several classes:

| Class | Purpose |
| --- | --- |
| `TIString` | Encapsulates image encoded Strings for both Sixel and Kitty Graphics Protocol. |
| `AnimatedSodaCan` | A specialization of `TIString` that adds animation sequencing data. Slightly modified from it's original incarnation outside PSTea. |
| `SodaCanLightBlueBubbles` | Specialization of `AnimatedSodaCan` that is used for a specific soda can image set. |
| `SodaCanArrowLightGreen` | Specializaiton of `AnimatedSodaCan` that is used for a specific soda can image set. |
| `SodaCanArrowDarkPink` | Specialization of `AnimatedSodaCan` that is used for a specific soda can image set. |

These classes all define the soda cans and their animation specifics.

PSTea is initialized by defining a model that contains a list of soda cans to animate. Several subscriptions are defined that each update specific soda cans. The Update function checks for each message dispatched from the subscriptions and actually updates each soda can. Finally, the view displays each soda can in an individual `TeaText` view.

There are other methods of expressing this, and future expressions will be in different branches.

## Credits

Jake Hildreth - Author of PSTea

