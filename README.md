# TinyShop
<img src="https://github.com/callumboddy/TinyShop/blob/master/Assets/icon.png" width="200" />


## Screenshot
<img src="https://github.com/callumboddy/TinyShop/blob/master/Assets/screenshot.png" width="400" />

## Tests

![Alt Text](https://github.com/callumboddy/TinyShop/blob/master/Assets/coverage.png)

Code coverage is @ ~80% with 26 unit tests in total, I focuesed on the unit testing the model. I would have liked to added more tests especially with mocked responses for the currency converter. 

If you would like me to add UI Tests I would be happy to do so.

## User Experience & Interface

### Hiding Basket

![Alt Text](http://g.recordit.co/jiyUC4wz0x.gif)

The basket is hidden until at least 1 item is added to it, it then automatically resigns when empty.

- animates in when needed.
- displays the total number of items in the basket.
- displays the total price of the basket in the currently selected currency.
- It will live update as you change the currency.
- It supports pluarlisation between 1 item & multiple items.

### Quantity Toggles

if no items of that product are in the basket, the "add to basket" button is visible, once at least one quanitiy of that product has been added to the basket, the cell updates to display a quantity toggle.

- There is no upper limit on this value.


### Currency Selector

![Alt Text](http://g.recordit.co/FqSKLv08Ej.gif)

- currency can be changed by selecting button.
- displays as action sheet (could possibley change if more currencies were supported).
- if API is unreachable for any reason then an alert will be displayed.


## Architecure & Code Style

I would be happy to go into more detail on this
