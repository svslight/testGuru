# Метод аутентификации общий => Rails предоставляет спец-ый метод который наз-ся: 
# has_secure_password - внутри библиотеки lib/active_model
# данный метод использует библиотеку BCrypt и чтобы все заработало
# нужно библ подключить в: RubyGems (gem "bcrypt", "~> 3.1.7")

# После этого метод: has_secure_password в модели User (app/models/user.rb) будет работать 
# модуль Auth (в app/models/user/auth.rb) можно удалить и 
# убрать подключение  (include Auth) в модели User (app/models/user.rb)

#	Первоначальный этап: 
# Для того чтобы Auth был загружен автомат - нужно создать:
#	каталог с названием (как класс User) и внутри этого каталога создать файл
#	с названием (таким же как название модуля Auth) и этот модуль должен находится
#	в пространстве имен внутри класса User
		
# Расширим наш модуль Auth с помощью модуля (ActiveSupport::Concern)
# вызовем метод  (extend) и это позволит вызвать метод (included) который принимает блок
# и все что  внутри этого блока находится, будет  вызвано на момент подключения
# модуля на уровне класса, куда модуль подключается и здесь можем указать все валидации,
# которые необходимы и все будет работать как и раньше

# Используем аксессоры для полей :password, :password_confirmation
# эти данные д.б. в объекте класса User, нет необходимости хранить эти данные в БД
# Такую технику в Rails называют виртуальными атрибутами,т.к. эти данные нах-ся у объекта, но не сохраняются в БД
# accessor_writer для атрибута password=(password_string) напишем вручную

# Проверку на существование атрибута password нужно проверять только если поле (password_digest.blank?) пустое
# Значение атрибута password_confirmation должно соответствовать значению атрибута password
    
# Воспользуемся проц: nexdigest алгоритма SHA1 из библиотеки Ruby

module User::Auth

  extend ActiveSupport::Concern
		  
  attr_reader :password
  attr_writer :password_confirmation

  included do
    validates :email, presence: true #, uniqueness: true
    validates :password, presence: true, if: Proc.new { |u| u.password_digest.blank? }
    validates :password, confirmation: true
  end

  def password=(password_string)
    if password_string.nil?
      self.password_digest = nil
    elsif password_string.present?
      @password = password_string
      self.password_digest = digest(password_string)
    end
  end

  def authenticate(password_string)
    digest(password_string) == self.password_digest ? self : false
  end

  private

  def digest(string)
      Digest::SHA1.hexdigest(string)
  end  
end
