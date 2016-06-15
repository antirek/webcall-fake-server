express = require 'express'
cors = require 'cors'
app = express()

getRandomSymbol = ()->
  string = 'qwertyuiopasdfghjklzxcvbnm1234567890'
  index = Math.floor(Math.random() * (string.length))
  string[index]

getRandomIndex = ()->
  result = ''
  i = 0
  while i < 7
    i++
    result += getRandomSymbol()
  result

requests = {}
app.use cors()

getStatus = (index)->
  statuses = [
    'Начинаем обработку заявки',
    'Начинаем обработку заявки',
    'Дозвонились оператору',
    'Дозвонились оператору',
    'Соединен',
    'Соединен',
    'Соединен'
  ]
  statuses[index]

getRandomStatus = ()->
  statuses = [
    'Оператор отклонил ваш запрос'
    'Оператор занят и перезвонит вам позже'
    'Оператор отложил ваш вызов'
    'Начинаем обработку заявки'
    'Все операторы заняты'
    'Дозвонились оператору'
    'Нерабочие время обратитесь позже'
    'Нерабочие время, оператор свяжется с вами позже'
    'Ваш номер находится в черном списке'
    'Ваше количество попыток исчерпано'
    'Ваш звонок отложен на 5 минут'
  ]
  index = Math.floor(Math.random() * (statuses.length))
  statuses[index]

app.get '/:key/save', (req, res)->
  console.log 'save request for key:', req.params.key 
  number = req.params.number
  numberIndex = req.params.numberindex
  message = req.params.message
  name = req.params.name
  index = getRandomIndex()
  
  requests[index] =
    number: number
    numberIndex: numberIndex
    message: message
    name: name
    status: 'Начинаем обработку заявки'
    times: 0
  
  interval = setInterval ()->
    if requests[index]
      clearInterval interval
  , 20000
  
  res.json
    ok: true
    id: index

app.get ['/status/:schedule_id/', '/api/status/:schedule_id/'], (req, res)->
  schedule_id = req.params.schedule_id
  if requests[schedule_id]
    res.json
      processingStatus: getStatus(requests[schedule_id].times)
    requests[schedule_id].times++
  else
    res.json
      processingStatus: ''

app.listen 3000, ()->
  console.log 'listen 3000'