
[1mFrom:[0m /home/ec2-user/environment/qiita_api/app/controllers/folders_controller.rb:25 FoldersController#index:

     [1;34m8[0m: [32mdef[0m [1;34mindex[0m
     [1;34m9[0m:   query = [31m[1;31m'[0m[31mcreated:>2015-10-09[1;31m'[0m[31m[0m [1;34m# 参考 検索時に利用できるオプション[0m
    [1;34m10[0m:   status, next_page, @items = [1;34;4mQiitaApiManager[0m.search(query)
    [1;34m11[0m:   [1;34m# @list = @items.each {|item| puts "[#{item['id']}"}[0m
    [1;34m12[0m:   @folder = [1;34;4mFolder[0m.new(folder_params)
    [1;34m13[0m:   user_id = [1;34;4mFolder[0m.where([35muser_id[0m: current_user.id).where([35marticle_id[0m: @folder.article_id)
    [1;34m14[0m:   [1;34m# Folder.where(user_id: @folder.article_id)[0m
    [1;34m15[0m:   [1;34m# article_id = user_id.where(user_id: @folder.article_id)[0m
    [1;34m16[0m:   [1;34m# article_ids = user_id.article_id[0m
    [1;34m17[0m:   [1;34m# article_ids = article_ids.find_by(article_ids: @folder.article_id)[0m
    [1;34m18[0m:   [1;34m# article_id = Folder.find_by(article_id: @folder.article_id)[0m
    [1;34m19[0m:   [32mif[0m @folder.article_id == user_id
    [1;34m20[0m:     redirect_to folders_path
    [1;34m21[0m:     flash[[33m:notice[0m] = [31m[1;31m"[0m[31mすでに保存されています[1;31m"[0m[31m[0m
    [1;34m22[0m:   [32melse[0m
    [1;34m23[0m:     @folder.save
    [1;34m24[0m:   [32mend[0m 
 => [1;34m25[0m:   binding.pry
    [1;34m26[0m:   [1;34m# article_id = Folder.new(article_id: folder_params[:article_id])[0m
    [1;34m27[0m:   [1;34m# @folders = Folder.where.not(article_id: nil)[0m
    [1;34m28[0m:   [1;34m# if @folders == article_id[0m
    [1;34m29[0m:   [1;34m#   render "users/edit"[0m
    [1;34m30[0m:   [1;34m# else[0m
    [1;34m31[0m:   [1;34m#   flash[:notice] = "すでに保存しています"[0m
    [1;34m32[0m:   [1;34m# end [0m
    [1;34m33[0m: [32mend[0m

