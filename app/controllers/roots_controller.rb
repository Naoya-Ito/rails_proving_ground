# encoding: utf-8
class RootsController < ApplicationController

  def index
  end

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
      Rails.logger.info graph_list
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

end
