# Создание Gist для конкретного вопроса

class GistQuestionService  

  def initialize(question, client: nil)
    @question = question                    # переменая экз question
    @test = @question.test                  # test - чтобы сохранять назв-е теста
    
    # Создаем клиент - если передали клиент при создании сервиса устанавливаем его, 
    # если нет - создаем новый GitHubClient, который определен в lib/clients/git_hub_client.rb 
    @client = client || GitHubClient.new
  end

  # В данной архитектуре наш сервис отвечает только за создание gist для конкретного вопроса, 
  # то делаем один публичный метод call - он делегирует нашему клиенту GITHUB client
  # просит его создать gist с парметрами;  
  # GITHUB client -> @client - не знает откуда эти параметры, 
  # он принимает эти параменты и его задача создать gist
			    
  def call
    @client.create_gist(gist_params)
  end

  private

  # Приватный метод gist_params - который будет возвращать, те параметры 
  # с помощью которых необходимо сохранить gist
 
  def gist_params
    {
      description: "A question about #{@test.title} from TestGuru",
      # description: I18n.t('.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    # Для формирования финальной строки, помещаем все элементы в массив content 
    content = [@question.body]                  # На первой строчке выводим тело запроса
    content += @question.answers.pluck(:body)   # Затем на каждой строчке выводим ответ к этому вопросу
    content.join("\n")
  end

end