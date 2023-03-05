#  Big Picture

## Custom loading screen while movies update

## Actor views?

## ViewModels

Refactor recent view viewmodel (and maybe search view as well) to get remaining movie details more parsimoniously

## All Expanded views

Modify links to open respective apps, if possible

# Specific Rating Sources

## Metacritic

See if there is a more specific url to scrape (like letterboxd) that just has the rating

Must-see designation (and associated graphic) could be added to detail view, maybe to condensed.

Fix alignment in expanded view. Looks odd.

## Rotten Tomatoes

Fix: consensus scraping fails when audience consensus isn't present. Critic consensus just gets repeated.

Certified fresh designation (and associated graphic) could be added to detail view, maybe to condensed.

Add review counts under critic/audience % in expanded view

## Letterboxd

Add average rating to the right of histogram on expanded view

## Cinemascore

Consider adding descriptions to fill out blank space in expanded view

Fix search. For e.g., "Star Wars" gets multiple results, but none for the original film, so the score returned is actually for Rogue One.

Fix letters <--> numbers mapping that's happening now. Seems badly written.

Add D rating range. Apparently there's a D rating range

## IMDb

Fix ForEach views in expanded view. Right now they use id: \.self, but the same rating can occur multiple times, which can screw things up.
