# Outdoor.sy Customer List Tool

## Quickly view and sort customer data using a file list of customers.
---
## Use
Place the file to parse somewhere within the app and make note of the relative path.

For example,
if you have a file named `customer-list.txt`, you could place it in the `tmp` folder, and the relative path would be `tmp/customer-list.txt`.

---
To use the list tool from a Ruby console:

```ruby
require_relative 'lib/customer_importer'

# Provide the path of the file you want to parse
list = CustomerImporter.new(file_path: 'tmp/commas.txt')

# If the file uses a different separator:
# list = CustomerImporter.new(file_path: 'tmp/pipes.txt', col_sep: '|')

customers = list.parse

customers.show
```

This will print to stdout a table like this:

```ruby
Name | Email | Vehicle Type | Vehicle Name | Vehicle Length in Inches
Greta Thunberg | greta@future.com | sailboat | Fridays For Future | 384
Xiuhtezcatl Martinez | martinez@earthguardian.org | campervan | Earth Guardian | 336
Mandip Singh Soin | mandip@ecotourism.net | motorboat | Frozen Trekker | 384
Jimmy Buffet | jb@sailor.com | sailboat | Margaritaville | 480=> nil
```

The list can be sorted on the following columns:

```ruby
- :none (default, no sort applied)
- :name
- :first_name
- :last_name
- :email
- :vehicle_type
- :vehicle_name
- :vehicle_length_in_inches
```

For example:

```ruby
customers.show(sort: :vehicle_length_in_inches, dir: :desc)

Name | Email | Vehicle Type | Vehicle Name | Vehicle Length in Inches
Jimmy Buffet | jb@sailor.com | sailboat | Margaritaville | 480
Mandip Singh Soin | mandip@ecotourism.net | motorboat | Frozen Trekker | 384
Greta Thunberg | greta@future.com | sailboat | Fridays For Future | 384
Xiuhtezcatl Martinez | martinez@earthguardian.org | campervan | Earth Guardian | 336=> nil

---

customers.show(sort: :vehicle_name, dir: :asc)

Name | Email | Vehicle Type | Vehicle Name | Vehicle Length in Inches
Xiuhtezcatl Martinez | martinez@earthguardian.org | campervan | Earth Guardian | 336
Greta Thunberg | greta@future.com | sailboat | Fridays For Future | 384
Mandip Singh Soin | mandip@ecotourism.net | motorboat | Frozen Trekker | 384
Jimmy Buffet | jb@sailor.com | sailboat | Margaritaville | 480=> nil
```
