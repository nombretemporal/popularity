# popularity
Using web scraping and plotting to visualise popularity of media and characters on the Web.

## Motivation
Inspired by projects such as [this one](https://github.com/alexei-kouprianov/youtube_tracker), the present project exploits the idea that sometimes data is publicly available, but only for a short time; therefore, it makes sense to scrape it dynamically and store into a file which can later be used for analysis. In principle the analysis and visualisation of the data can be automatised and made dynamic, to the effect that new data points are incorporated in real time.

## Folder [`akinator`](akinator)
Here the multilingual web game [Akinator](https://akinator.com) is used to measure the popularity of real and fictional characters in different language segments. English, French, Italian, German, Russian and Spanish are used.

The main script [`akinators.r`](akinator/scripts/akinators.r), once initialised, will run continuously. It activates the ancillary script [`akinators.pl`](akinator/scripts/akinators.pl), which does the scraping and stores the 10 most recently played characters for each of the six language domains together with timestamps in the text file for the given language. (*Warning*: due to a bug, some lines are stored as blank, hence the provisions in the `R` scripts to exclude them from calculations and plotting.) This way, each of the six language domains is *sampled* approximately every 70 seconds, with the hope that the resulting samples will reflect the general polularity rankings. Once scraping is completed, [`akinators.pl`](akinator/scripts/akinators.pl) plots, for each of the six languages, the 25 most popular characters for the present date. Then it waits for 60 seconds and repeats the procedure. Therefore, the plot will reflect the present day but the six datasets will contain entries for all previous days. If the script is stopped and later run again, it will add to the existing datasets.

The script [`akinators.daily.r`](akinator/scripts/akinators.daily.r) should be run with `Rscript akinators.daily.r n`, where `n` is an integer. it will plot for each language, for all days for which there is data in the language dataset, the time series for most popular characters. More precisely, it will disregard all data points in the corresponding dataset which do not exceed `n`.
