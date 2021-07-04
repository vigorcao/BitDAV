root = exports ? this
# !!!! Hotpoor xialiwei root object
root.Hs or= {}
Hs = root.Hs

$ ->
    console.log "Hello, I am xialiwei."

    $("body").on "click",".add_folder",(evt)->
        folder_name = $(".add_folder_name").val()
        add_folder(folder_name)
    $("body").on "click",".add_folder_new",(evt)->
        add_folder()
    $("body").on "input propertychange",".add_folder_name",(evt)->
        folder_name = $(".add_folder_name").val()
        search_folder_local(folder_name)
    root.search_folder_local = (folder_name="")->
        if folder_name == ""
            $(".card_folder_list_item").removeClass("hide")
        items = $(".card_folder_list_item")
        for item in items
            if $(item).text().indexOf(folder_name)==-1
                $(item).addClass("hide")
            else
                $(item).removeClass("hide")
    root.add_folder = (folder_name="")->
        if folder_name == ""
            folder_name = "新建文件夹"
        url = "/*add_folder"
        $.ajax
            url:url
            data:
                folder_name:folder_name
            dataType: 'json'
            type: 'POST'
            success: (data) ->
                console.log data
                load_folder_list()
            error: (data) ->
                console.log data
    $("body").on "click",".card_folder_list_item",(evt)->
        k = $(this).attr("data-k")
        v = $(this).attr("data-v")
        $(".current_folder_name").text k
    load_folder_list = ()->
        $(".card_folder_list").empty()
        url = "/*get_folders"
        $.ajax
            url:url
            data:null
            dataType: 'json'
            type: 'GET'
            success: (data) ->
                console.log data
                for k,v of data.folders
                    $(".card_folder_list").append """
                    <div class="card_folder_list_item" data-k="#{k}" data-v="#{v}">#{k}</div>
                    """
            error: (data) ->
                console.log data
    load_ready_run = ()->
        load_folder_list()

    $(window).on "load",(evt)->
        load_ready_run()