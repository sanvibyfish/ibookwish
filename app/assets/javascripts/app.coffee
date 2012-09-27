#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require twitter/bootstrap
#= require tag-it
#= require gmap3.min
#= require masonry/jquery.masonry
#= require masonry/jquery.imagesloaded.min
#= require masonry/jquery.infinitescroll.min
#= require modernizr

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
    
    $("#post_submit").click ->
      $(this).val("分享中...")
      $(this).attr("disabled","disabled")
      $("#new_post").submit()

    $("#post_isbn").keyup ->  
        if $(this).val().length > 0
          $("#get_book_button").removeAttr("disabled")
        else
          $("#get_book_button").attr("disabled","true")
      
    $("#post_isbn").change ->  
        if $(this).val().length > 0
          $("#get_book_button").removeAttr("disabled")
        else
          $("#get_book_button").attr("disabled","true")

    $("#back-top").hide()

    $ ->
      $(window).scroll ->
        if ($(this).scrollTop() > 100) 
          $('#back-top').fadeIn()
        else
          $('#back-top').fadeOut()
      $('#back-top a').click ->
        $('body,html').animate
          scrollTop: 0
          800
        false

    $container = $('#posts-container');
    gutter = 40;
    min_width = 200;
    $container.imagesLoaded ->
        $container.masonry
          itemSelector: '.bookdate-box'
          gutterWidth: gutter
          columnWidth: (containerWidth)->
            num_of_boxes = (containerWidth/min_width | 0);
            box_width = (((containerWidth - (num_of_boxes-1)*gutter)/num_of_boxes) | 0) ;
            if (containerWidth < min_width)
              box_width = containerWidth;
            $('.bookdate-box').width(box_width);
            box_width


    $container.infinitescroll
      navSelector  : '.pagination'    
      nextSelector : '.next a'  
      itemSelector : '.bookdate-box'
      loading: 
        finishedMsg: '没有更多数据'
        img: '/assets/masonry/loader.gif'
      (newElements)->
        $newElems = $( newElements ).css({ opacity: 0 })
        $newElems.imagesLoaded ->
          $newElems.animate({ opacity: 1 })
          $container.append($newElems).masonry('reload')



    $("#get_book_button").click () ->
      $(this).val("获取中...")
      $(this).attr("disabled","disabled")
      Window.APP.get_book($("#post_isbn"))


    $('#myModal').hide()


    $("#post_tags").tagit
        tagSource: (search, showChoices)->
          that = this
          $.ajax
            url: "/tags/autocomplete.json"
            data: {q: search.term},
            success: (choices)->
              showChoices(that._subtractArray(choices, that.assignedTags()))
        show_tag_url: "/tags/"
        singleField: true
        singleFieldNode: $('#post_tag_names')

