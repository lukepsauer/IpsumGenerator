require 'bundler'
Bundler.require

get '/' do
  $lineArray = []
  f = File.new("./public/files/lorem.txt", "r")
  tempLineArray = f.readlines
  tempLineArray.each_with_index do |line, i|
    if i % 2 == 0
      outputLine = line.split('.')
      outputLine.pop
      outputLine.each do |line|
        $lineArray.push(line.split('\n')[0])
      end
    end
  end
  erb :Selection
end

post '/generate' do
  $sentences = params[:sentences].to_i
  $paragraphs = params[:paragraphs].to_i
  $pages = params[:pages].to_i
  $sentenceText = []
  if $sentences > 500
    redirect("/")
  end
  if $paragraphs > 50
    redirect("/")
  end
  if $pages > 5
    redirect("/")
  end
  $paragraphsT = true
  $pagesT = true
  $pagesText = []
  $dsentencesText = []
  $sentences.times do
    $sentenceText.push($lineArray[0])
    $lineArray.delete_at(0)
  end
  $dsentencesText = $sentenceText.join(". ")
  $paragraphText = []
  $dparagraphText = []
  $dpagesText = []
  $sentenceText = []
  $paragraphs.times do
    10.times do
      $sentenceText.push($lineArray[0])
      $lineArray.delete_at(0)
    end
    $paragraphText.push($sentenceText.join(". "))
  end
  $dparagraphText = $paragraphText.join(". <br> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp")
  $sentenceText = []
  $paragraphText = []
  $pages.times do
    $paragraphText = []

    10.times do
      $sentenceText = []
      10.times do
        $sentenceText.push($lineArray[0])
        $lineArray.delete_at(0)
      end
      $paragraphText.push($sentenceText.join(". "))
    end
    $pagesText.push($paragraphText.join(". <br> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"))
  end
  $dpagesText = $pagesText.join("<br>&nbsp<br>")
  $displayText = [$dsentencesText, $dparagraphText, $dpagesText].join(" ")
  erb :main
end
#20000 lines
#2000 paragraphs
#200 pages