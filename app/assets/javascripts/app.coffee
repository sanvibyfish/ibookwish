#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require twitter/bootstrap
#= require tag-it

Window.APP =
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert'><a class='close' href='#' data-dismiss='alert'>X</a>#{msg}</div>")

  # 成功信息显示, to 显示在那个dom前(可以用 css selector)
  notice : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-success'><a class='close' data-dismiss='alert' href='#'>X</a>#{msg}</div>")
    
  # 开一个新页面
  openUrl : (url) ->
    window.open(url)


  #获取图书信息
  get_book: (el)->
    $.ajax
      url: "/posts/get_book"
      type: "GET"
      data: {isbn: el.val()}

$(document).ready ->
    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()
    $('#tab a:first').tab('show')
    $('.dropdown-toggle').dropdown()
    $("#get_book_button").click () ->
      Window.APP.get_book($("#post_isbn"))

    $("#post_tags").tagit({
        tagSource: (search, showChoices)->
            that = this;
            $.ajax
              url: "/tags/autocomplete.json"
              data: {q: search.term}
              success: (choices)->
                showChoices(that._subtractArray(choices, that.assignedTags()))
    show_tag_url: "/tags/"
    singleField: true
    singleFieldNode: $('#post_tag_names')
    })

       
