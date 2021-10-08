# Recipe Search

## Original Brief

We have to give users the ability to search for recipes. We have some text files containing recipe descriptions written in English. We would like to be able to search over the set of these text files to find recipes given at a minimum a single word e.g. `tomato`.

Example text files: [recipes.zip](https://media.riverford.co.uk/downloads/hiring/sse/recipes.zip)

We would like a program that can provide a search function over these files, each search returning a small number (e.g around 1-10) relevant recipes if possible.

The text files are of differing sizes, and are encoded as utf-8. New text files are coming in all the time, so we should not assume a static set of recipes.

The name of each file is considered the id of the recipe.

Our requirements have been listed by a key business stakeholder:

## Essential requirements:

-	Search results should be relevant, e.g. a search for broccoli stilton soup should return at least broccoli stilton soup.
-	Searches should complete quickly so users are not kept waiting – this tool needs to serve many users so lower latency will mean we can serve more concurrent searches - ideally searches will take < 10ms.

Ideally the results will be sorted so that the most relevant result is first in the result list.

### Plan

Use Trie data structure to index the files. Store tree of words with the recipe file name at the end of word and at any partial words. This allows for partial matches on the right side for autocompletion. 

Use simplistic ranking to favour recipes with intersecting search terms when there are multiple terms. Will also rank whole words higher than partial matches.

## What I'd do if I had more time

I would like to have had more time to great a better ranking system for search terms where string is matched multiple times. 

I would also like to rank results higher if the search term is in the title or ingredients sections of the recipe.

Other Considerations:

* Additional error handling 
* Add logging
* Add more unit tests
* Refactor 

## Installation

Run the following commands

```
mix do deps.get, deps.compile
```

## Run

Run manually via mix
```
mix run -e "Searchcli.main" 
```

Run via escript 
```
mix escript.build
./searchcli
```
