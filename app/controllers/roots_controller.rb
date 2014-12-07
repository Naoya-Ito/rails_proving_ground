# encoding: utf-8
class RootsController < ApplicationController
  before_filter :authenticate, only: [:study, :work]
   
  def index
  end

  # 成分分析プログラム
  def bunseki
    @name = params[:name]
    if @name.present?
      @name = "文字列長すぎマン" if @name.length > 30
      per_list = []
      @seibun_list = []
      file = open(Rails.root.join("public/seibun_list.txt"))
      seibun_key = file.readlines
      nokori = 100
      number = Digest::MD5.new.update(@name).to_s.to_i(16)
      while true
        per = (nokori < 10) ? nokori : number % (nokori + 1)
        per = 1 if per == 0
        per_list.push per
        @seibun_list.push seibun_key[number%(seibun_key.length)].chomp
        seibun_key.delete_at(number%(seibun_key.length))
        nokori -= per
        break if nokori <= 0
        number = number < 100 ? number * number * 3759 : (number*2/3).to_i
      end
      @per_list = per_list.sort {|a, b| (-1) * (a <=> b)}

      # グラフ描画
      graph_list = []
      @per_list.each_with_index do |per, i|
        graph_list.push [@seibun_list[i], per]
      end
      @chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({defaultSeriesType: 'pie', margin: [50, 200, 60, 170]})
        f.series({
          type: 'pie',
          name: @name,
          data: graph_list
        })
      end
    end
  end

  # 勉強会資料
  def study
    render 'study', layout: 'impress'
  end

  # グループインタビュー資料
  def work
    render 'work', layout: 'impress'
  end

  protected
    def authenticate
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == 'ike' && password == 'menmen'
      end
    end

end
