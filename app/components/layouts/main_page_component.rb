class Layouts::MainPageComponent < ViewComponent::Base
  renders_one :body

  def initialize(title:, class_name: 'text-left')
    @title = title
    @class_name = class_name
  end
end
