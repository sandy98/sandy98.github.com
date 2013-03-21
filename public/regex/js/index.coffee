#\s*\[\s*(.+?)\s+"(.+?)"\s*\]\s*$ PGN tagline
#[White "Savoretti, Ernesto"]
#(?:(^0-0-0|^O-O-O)|(^0-0|^O-O)|(?:^([a-h])(?:([1-8])|(?:x([a-h][1-8])))(?:=?([NBRQ]))?)|(?:^([NBRQK])([a-h])?([1-8])?(x)?([a-h][1-8])))(?:(\+)|(#)|(\+\+))?$

$ ->
  #document.write "Hello!"

  nullify = ->
    $('#result').css('background', 'pink')
    $('#result').html '<span class= "label label-important">NO MATCH</span>'

  show = (match) ->
#    $('#result').css('background', '#f5deb3')
    $('#result').css('background', '#eeeeee')
    len = match.length - 1
    html = "<span class=\"label label-info\">#{match[0]}</span>&nbsp;"
    if len > 0
      if $("#chk-global").attr("checked")
        postclass = 'label-info'
      else
        postclass = 'label-success'
      for n in [1..len]
        html += "<span class=\"label #{postclass}\">#{match[n]}</span>&nbsp;"
    $('#result').html html

  chkMatch = ->
    try
      return nullify() if $('#regex-text').val() is ''
      modifiers = ""
      if $("#chk-global").attr("checked")
        modifiers += "g"
      if $("#chk-insensitive").attr("checked")
        modifiers += "i"
      if $("#chk-multiline").attr("checked")
        modifiers += "m"
      regex = new RegExp $('#regex-text').val().replace(/\\/g, '\\'), modifiers
      stri = $('#string-text').val()
      m = stri.match regex
      return nullify() if not m
      show m

    catch e
      nullify()

  $('#regex-text').on 'keyup', chkMatch
  $('#string-text').on 'keypress', chkMatch
  $('.modifiers').on 'click', chkMatch
  $('#cboExamples').on 'change click', (ev) ->
    $('#regex-text').val $('#cboExamples').val()

  $('#cboExamples')[0].selectedIndex = -1
  i = setInterval chkMatch, 200