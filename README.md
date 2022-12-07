Redmine-contacts-to-Placetel converter
======================================

# System requirements

* awk

# Usage

Export contects from Redmine in `VCF` format.

Then convert file to `csv` format:

    gawk -F: -f vcf2csv.awk contacts_redmine.vcf

# Author

(C) 2022, Ondics GmbH