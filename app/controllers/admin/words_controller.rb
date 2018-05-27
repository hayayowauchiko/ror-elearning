class Admin::WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def new
    @word = Word.new
    @category = Category.find(params[:category_id])
    @word.word_answers.build
    # @word.word_answers.build ←これで一括保存の準備は完了
  end

  def create
    abort
    word = Word.new(word_params)
    if word.save
      redirect_to word
    else
      render "new"
    end
  end

  private
  def word_params
    params.require(:word).permit(:content, word_answers_attributes: [:content, :correct])
# これは独特な書き方ですが、このように子要素のstrong parameterを書くことで、自動で子要素に親要素のidもふられます。この場合だと、bookテーブルにあるuser_idにもきちんとこの時作成される親要素のidがふられます。
  end
end
