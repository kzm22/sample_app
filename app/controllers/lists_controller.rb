class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

  def create
　　# 1. データを受け取り新規登録するためのインスタンス作成
    list = List.new(list_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト. 
    flash[:notice] = "投稿が成功しました"
    redirect_to list_path(list.id)

  end

  def index
    @lists = List.all
    
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    #下記のList.findでレコード1件が取得され
    list = List.find(params[:id])
    #list.destroyでレコードが削除されます。
    list.destroy
    #下記の記述でリストの一覧画面へリダイレクトされます。
    redirect_to '/lists'
  end

  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end

end
