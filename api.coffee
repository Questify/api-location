
# ### Module dependencies

express   = require 'express'
mongoose  = require 'mongoose'
model     = require './model'


app = module.exports = express()



# # Routes

conn   = mongoose.createConnection 'localhost', 'questify'
Locations = conn.model('Location')


# ## GET /location[s]?/
#
# Returns all the locations

app.get '/', (req, res) ->
  Locations.find (err, locations) ->
    throw err if err
    res.json locations


# ## GET /location[s]?/:id
#
# Returns locations that match query

app.get '/:query', (req, res) ->
  query = req.param 'query'

  if query.match /^[a-f0-9]{24}$/
    Locations.findById query, (err, location) ->
      throw err if err?
      res.json location

