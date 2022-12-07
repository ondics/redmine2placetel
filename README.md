Redmine-to-Placetel contacts converter
======================================

Linux commandline batch converter for contacts exported from 
[Redmine](https://www.redmine.org/).

The converted contacts can be imported into [Placetel](https://placetel.de).

## System requirements

* awk

## Usage

First export contacts from Redmine in `VCF` format.

Then convert file to `csv` format:

    $ awk -F: -f vcf2csv.awk contacts_redmine.vcf > contacts_placetel.csv

If Placetel cannot inport all at once, make slices, e.g.:

    $ sed -n -e '1,1000p' contacts_placetel.csv > contacts_placetel.1-1000.csv

## Author

(C) 2022, Ondics GmbH
