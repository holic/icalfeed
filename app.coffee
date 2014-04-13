express = require "express"
bodyParser = require "body-parser"
swig = require "swig"
crypto = require "crypto"

sha1 = (data) ->
    crypto.createHash("sha1").update(data).digest()

swig.setFilter "iso8601", (input) ->
    date = new Date input
    date.toISOString().replace /([-:]|\.[0-9]{3})/g, ""


@event = (req, res, next) ->
    params = {}
    params[key] = value for key, value of req.body
    params[key] ?= value for key, value of req.query

    {filename, uid, stamp, start, end, description, summary, url} = params

    locals = {uid, stamp, start, end, description, summary, url}
    unless uid?
        hash = sha1 new Buffer JSON.stringify locals
        locals.uid = hash.toString "hex"
    locals.stamp = if stamp? then stamp*1000 else Date.now()
    locals.start = if start? then start*1000 else Date.now()
    locals.end = if end? then end*1000 else locals.start

    filename ?= "event"
    filename = "#{filename}.ics" unless /\.ics$/i.test filename
    res.attachment filename

    res.render "VEVENT", locals


app = express()
app.engine "ics", swig.renderFile
app.set "view engine", "ics"
app.set "views", "#{__dirname}/views"
app.use bodyParser()

app.get "/event", @event
app.post "/event", @event

app.listen process.env.PORT or 5000, ->
    {address, port} = @address()
    console.log "Listening on http://#{address}:#{port}"
