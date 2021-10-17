Webpage Parser
==============

The webpage parser is a ruby exercise. It is a script that reads a log file and organize it into ordered list,
from the most viewed page to the last viewed page.
It returns two lists:
  - general ordered list
  - unique ordered list

Examples
--------

input:

/help_page/1 646.865.545.408
/index 444.701.448.104
/help_page/1 646.865.545.408
/about 061.945.150.735
/help_page/1 646.865.545.408

output:
- general return list:
-> /help_page/1 3 views
-> /index 1 views
-> /about 1 views

- unique return list:
-> /index 1 unique views
-> /about 1 unique views
-> /help_page/1 1 unique views

Usage
-----

To run the tests you need to do the following:

1. Ensure you are using a compatible ruby version (3.0.2)
2. `bundle install`
3. `rspec`

To run the script you need to do the following:

1. Ensure you are using a compatible ruby version (3.0.2)
2. `bundle install`
3. `ruby lib/webpage_visit.rb path-to-your-log`
