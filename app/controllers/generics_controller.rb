class GenericsController < AuthController
  before_action :set_resource, only: [:edit, :show, :update, :destroy]

  def index
    authorize resource_class
    plural_resource_name = "@#{resource_name.pluralize}"
    yield if block_given?
    @pagy, resources = pagy(resource_class.search(filter_params))
    instance_variable_set(plural_resource_name, resources.decorate)
  end

  def show
    authorize get_resource
  end

  def new
    authorize resource_class, :create?
    instance_variable_set("@#{resource_name}", resource_class.new(form_additional_params))
    yield get_resource if block_given?
  end

  def create
    authorize resource_class
    set_resource(resource_class.new(resource_params))
    yield if block_given?
    respond_to do |format|
      if get_resource.save
        format.html do
          redirect_to form_redirect_url, notice: "Action exécutée avec succès"
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("#{resource_name}-form",
                                partial: "#{resource_name.pluralize}/form",
                                locals: { "#{resource_name}": get_resource })
        end
      end
    end
  end

  def edit
    authorize get_resource
    yield get_resource if block_given?
  end

  def update
    authorize get_resource
    yield get_resource if block_given?
    respond_to do |format|
      if get_resource.update(resource_params)
        format.html { redirect_to form_redirect_url, notice: "Action exécutée avec succès" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("#{resource_name}-form",
                                                      partial: "#{resource_name.pluralize}/form",
                                                      locals: { "#{resource_name}": get_resource })
        end
      end
    end
  end

  def destroy
    get_resource.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(get_resource, 'admin')) }
      format.html         { redirect_to send("#{resource_name.pluralize}_path")}
    end
  end

  private

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def filter_params
      {}
    end

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    def set_resource(resource = nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource.decorate)
    end

    def form_redirect_url
      send("#{resource_name.pluralize}_path")
    end

    def form_additional_params
      {}
    end
end
