#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require twitter/bootstrap
#= require tag-it
#= require faye
#= require jquery.pnotify
#= require masonry/jquery.masonry
#= require masonry/jquery.imagesloaded.min
#= require masonry/jquery.infinitescroll.min
#= require jquery.atwho
#= require jquery.autogrow-textarea
#= require rails-timeago
#= require fancybox
#= require social-share-button
#= require homeland
#= require user
#= require post
#= require comment
#= require map
window.APP =
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert'><a class='close' href='#' data-dismiss='alert'>X</a>#{msg}</div>")

  # 成功信息显示, to 显示在那个dom前(可以用 css selector)
  notice : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-success'><a class='close' data-dismiss='alert' href='#'>X</a>#{msg}</div>")
  
  error: (el,msg) ->
    error =  '<div class="alert alert-error" >'
    error += ' <button type="button" class="close" data-dismiss="alert">×</button>'
    error += "#{msg}"
    error += '</div>'
    $(el).html(error)  
  # 开一个新页面
  openUrl : (url) ->
    window.open(url)



    # 绑定 @ 回复功能
  atReplyable : (el, names) ->
    return if names.length == 0
    $(el).atWho "@"
      data : names
      tpl : "<li data-value='${name}'>${name}</li>"

  bindCommentReply: ()->
    # CommentAble @ 回复功能
    commenters = []
    commenter_exists = []
    $("#pin_comments .piece .info_bar .name a").each (idx) ->
      val =
        name : $(this).text()
      if $.inArray(val.name,commenter_exists) < 0
         commenters.push(val)
         commenter_exists.push(val.name)
    APP.atReplyable("#comment_body", commenters)


$(document).ready ->
    APP.bindCommentReply()
    $("a[rel=tooltip]").tooltip()
    $("img[rel=twipsy]").tooltip()
    $("span[rel=twipsy]").tooltip()
    $('.dropdown-toggle').dropdown()
    
    
    $("#push_button").fancybox()
    

    $("#post_submit").click ->
      $(this).val("提交中...")
      $(this).attr("disabled","disabled")
      $("#new_post").submit()
              

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

    # $container = $('#posts-container');
    # gutter = 50;
    # min_width = 200;
    # $container.imagesLoaded ->
    #     $container.masonry
    #       itemSelector: '.bookdate-box'
    #       gutterWidth: gutter
    #       columnWidth: (containerWidth)->
    #         num_of_boxes = (containerWidth/min_width | 0);
    #         box_width = (((containerWidth - (num_of_boxes-1)*gutter)/num_of_boxes) | 0) ;
    #         if (containerWidth < min_width)
    #           box_width = containerWidth;
    #         $('.bookdate-box').width(box_width);
    #         box_width

    $container = $('#posts-container');
    $container.imagesLoaded ->
      $container.masonry
        itemSelector: '.bookdate-box'

    $container.infinitescroll
      navSelector  : '.pagination'    
      nextSelector : '.next_page a'  
      itemSelector : '.bookdate-box'
      loading: 
        finishedMsg: '没有更多数据'
        img: '/assets/masonry/loader.gif'
      (newElements)->
        $newElems = $( newElements ).css({ opacity: 0 })
        $newElems.imagesLoaded ->
          $newElems.animate({ opacity: 1 })
          $container.append($newElems).masonry('reload')

    $('#myModal').hide()
    $("textarea").autogrow()

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

    faye = new Faye.Client(FAYE_SERVER)
    faye.subscribe "/notifications_count/#{CURRENT_USER_ID}",(data) ->
      if data.notif.counts > 0
        text = ''
        if data.notif.reply > 0
          text +=  '<a href="/notifications">你有' + data.notif.reply + '条回复</a><br>'
        if data.notif.at > 0
          text +=  '<a href="/notifications/at">你有' + data.notif.at + '条@</a><br>'
        if data.notif.system > 0
          text +=  '<a href="/notifications/system">你有' + data.notif.system + '条系统消息</a><br>'
        if data.notif.pri > 0
          text +=  '<a href="/notifications/private">你有' + data.notif.pri + '条私信</a><br>'
        $("#user_notifications_count").html("<span class='badge badge-important'>" + data.notif.counts + "</span>")
        $.pnotify
          text: text
          icon: 'icon-envelope'

