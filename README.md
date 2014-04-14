# iCalendar feed API

##### Source code for `icalfeed.herokuapp.com`

---

### Single event

Make a `GET` or `POST` request to `https://icalfeed.herokuapp.com/event.ics` with one or more of the following parameters:

- `uid` : unique ID for this event
- `stamp` : Unix timestamp
- `start` : Unix timestamp, start time for this event
- `end` : Unix timestamp, end time for this event
- `description` : event title
- `summary` : event body
- `url` : event URL
- `filename` : filename for `.ics` download

---

### TODO

- feeds for multiple events
- feeds for other iCal object types
- test `.ics` files for compatibility
