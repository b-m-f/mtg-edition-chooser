# MTG Edition chooser

What does this solve?

Imagine you have a list of cards that you would like to add to your collection. But you only want specific editions, for whatever reason.

This tool takes a list of cards (**cards.txt**) and opens a browser window for each one for you to choose the version.
It then saves the versioned Cards back into a new file (**cards-with-edition.txt**).

You can then use this list on sites lie cardmarket.com

![Example video of usage](./example.gif)

## Features

- Choose version on scryfall.com
- Input compatible with deckstats.net output
- Output compatible with cardmarket deck lists

## How to use

- Download this repository and unpack it
- Open a terminal and go to the directory of the unpacked repository
- Install with `npm install` (Node.JS and npm need to be installed -> https://nodejs.org/en/download/)
- Save all you cards in `cards.txt`
- Run `npm run start`
- Choose versions
- Your final list in saved into `cards-with-editions.txt`

## FAQ

to be added

## Thanks

https://scryfall.com -> provides all the good stuff to make this work
