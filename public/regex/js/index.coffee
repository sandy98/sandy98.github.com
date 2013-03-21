#\s*\[\s*(.+?)\s+"(.+?)"\s*\]\s*$ PGN tagline
#[White "Savoretti, Ernesto"]
#(?:(^0-0-0|^O-O-O)|(^0-0|^O-O)|(?:^([a-h])(?:([1-8])|(?:x([a-h][1-8])))(?:=?([NBRQ]))?)|(?:^([NBRQK])([a-h])?([1-8])?(x)?([a-h][1-8])))(?:(\+)|(#)|(\+\+))?$

$ ->
  #document.write "Hello!"

  nullify = ->
    $('#result').css('background', 'pink')
    $('#result').html '<span class= "label label-important">NO MATCH</span>'

  show = (match) ->
    $('#result').css('background', '#eeeeee')
    len = match.length - 1
    html = "<span class=\"label label-info\">#{match[0]}</span>&nbsp;"
    if len > 0
      for n in [1..len]
        #console.log "match[#{n}] type = #{typeof match[n]}"
        if (typeof match[n]) isnt "string"
          postclass = 'label-important'
          groupvalue = 'Null'
        else
    	    if $("#chk-global").attr("checked")
            postclass = 'label-info'
          else
            postclass = 'label-success'
          groupvalue = match[n]
        html += "<span class=\"label #{postclass}\">#{groupvalue}</span>&nbsp;"
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

  $('#regex-text, #string-text').on 'keyup keypress change blur focus', chkMatch
  $('.modifiers').on 'click', chkMatch
  $('#cboExamples').on 'change click', (ev) ->
    $('#regex-text').val $('#cboExamples').val()
    chkMatch()

  $('.modifiers').css('vertical-align', 'top')

  $('#cboExamples')[0].selectedIndex = -1

  # i = setInterval chkMatch, 200
  chkMatch()