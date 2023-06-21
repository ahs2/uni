class Elements::FormFieldsComponent < ViewComponent::Base
  def initialize(field_name:, field_type:, form_object:, item:, item_type:, options: {})
    @field_name = field_name
    @field_type = field_type
    @form_object = form_object
    @item = item
    @item_type = item_type
    @item_class = @item_type.classify.constantize
    @options = options
  end

  def display_field
    send("get_#{@field_type}_field")
  end

  def get_text_field
    @form_object.text_field( @field_name, class: 'input input-dark' )
  end

  def get_text_disabled_field
    @form_object.text_field( @field_name, class: 'input input-dark', disabled: true )
  end

  def get_datetime_field
    @form_object.datetime_field( @field_name, class: 'input input-dark' )
  end

  def get_time_field
    @form_object.time_field( @field_name, class: 'input input-dark' )
  end

  def get_password_field
    @form_object.password_field( @field_name, class: 'input input-dark' )
  end

  def get_email_field
    @form_object.email_field( @field_name, class: 'input input-dark' )
  end

  def get_hidden_field
    @form_object.hidden_field( @field_name, class: 'input input-dark' )
  end

  def get_textarea_field
    @form_object.text_area( @field_name, class: 'textarea input-dark', rows: 4 )
  end

  def get_textarea_disabled_field
    @form_object.text_area( @field_name, class: 'textarea input-dark', rows: 4, disabled: true )
  end

  def get_number_field
    @form_object.number_field( @field_name, class: 'input input-dark' )
  end

  def get_country_field
    content = <<-HTMLTAG
    <div class="country-select">
      #{@form_object.country_select( @field_name, class: '', priority_countries: ["NE"], locale: 'fr' )}
    </div>
    HTMLTAG
    content.html_safe
  end

  def get_image_field
    image_url = @item.send(@field_name).attached? ? rails_blob_path(@item.send(@field_name), only_path: true) : asset_path('default-image.png')
    image_name = @item.send(@field_name).attached? ? @item.send(@field_name).filename : 'Aucune Image'
    content = <<-HTMLTAG
    <div class="form-img-preview" data-controller="file-upload">
      #{image_tag( image_url, data: {'file-upload-target': "preview"} )}
      #{@form_object.file_field( @field_name, direct_upload: true, class: 'hidden', accept: 'image/jpeg, image/png', data: {'file-upload-target': 'fileinput', action: 'change->file-upload#fileChange'} )}
      <div class="is-flex is-align-content-center mt-4">
        #{@form_object.label(@field_name, 'Choisir une photo', class: "button is-info is-light is-small")}
        <span class="has-text-small pl-1" data-placeholder="#{image_name}" data-file-upload-target="fileName">#{image_name}</span>
      </div>
    </div>
    HTMLTAG
    content.html_safe
  end

  def get_file_field
    file_url = @item.send(@field_name).attached? ? rails_blob_path(@item.send(@field_name), only_path: true) : asset_path('default_excel.png')
    file_name = @item.send(@field_name).attached? ? @item.send(@field_name).filename : 'Aucun fichier'
    content = <<-HTMLTAG
    <div class="form-img-preview" data-controller="file-upload">
      #{image_tag( file_url, data: {'file-upload-target': "preview"} )}
      #{@form_object.file_field( @field_name, direct_upload: true, class: 'hidden', accept: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel, application/vnd.pdf', data: {'file-upload-target': 'fileinput', action: 'change->file-upload#fileChange'} )}
      <div class="is-flex is-align-content-center mt-4">
        #{@form_object.label(@field_name, 'Choisir une photo', class: "button is-info is-light is-small")}
        <span class="text-sm pl-1" data-placeholder="#{file_name}" data-file-upload-target="fileName">#{file_name}</span>
      </div>
    </div>
    HTMLTAG
    content.html_safe
  end

# pour uploader les documents pdf
def get_pdf_field
  file_url = @item.send(@field_name).attached? ? rails_blob_path(@item.send(@field_name), only_path: true) : asset_path('default_pdf.png')
  file_name = @item.send(@field_name).attached? ? @item.send(@field_name).filename : 'Aucun fichier'
  content = <<-HTMLTAG
  <div class="form-img-preview" data-controller="file-upload">
    #{image_tag(file_url, data: {'file-upload-target': "preview"})}
    #{@form_object.file_field(@field_name, direct_upload: true, class: 'hidden', accept: 'application/pdf', data: {'file-upload-target': 'fileinput', action: 'change->file-upload#fileChange'})}
    <div class="is-flex is-align-content-center mt-4">
      #{@form_object.label(@field_name, 'Choisir un PDF', class: "button is-info is-light is-small")}
      <span class="text-sm pl-1" data-placeholder="#{file_name}" data-file-upload-target="fileName">#{file_name}</span>
    </div>
  </div>
  HTMLTAG
  content.html_safe
end


  def get_float_field
    @form_object.number_field( @field_name, min: 0, step: 0.01, class: 'input input-dark' )
  end

  def get_date_field
    content_tag :div, class: 'flatpickr', 'data-controller': 'dateTimePicker', 'data-dateTimePicker-type': 'date' do
      @form_object.number_field( @field_name, class: 'input input-dark', 'data-dateTimePicker-target': 'input' )
    end
  end

  def get_enum_field
    enum_options = @item_class.human_enum_collection(@field_name)
    current_field_value = @item.send(@field_name)
    @form_object.select(@field_name, options_for_select(enum_options, current_field_value), {include_blank: "Non défini"}, placeholder: "Non défini",
      class: 'js-choice select input-dark')
  end


  def get_reference_field

    if  @field_name.include?("class_name") 
        @field_class_name = @field_name.split("#")[@field_name.split("#").index("class_name") + 1]
        @field_name = @field_name.split("#")[0]
        @reference_class = @field_class_name.classify.constantize
    else  
      @reference_class = @field_name.classify.constantize
    end
      @form_object.collection_select("#{@field_name}_id", @reference_class.all, :id, :select_title, {prompt: true},
        {class: "js-choice select input-dark",
        data: {action: 'change->extended-select#onSelectChange', selection: @field_name}})
  end

  
  def get_depended_model_field
    depends_on = @options[:depends_on]
    reference_class = @field_name.classify.constantize
    parent_id = @item.send("#{depends_on}_id")
    matched_resources = reference_class.where("#{depends_on}_id = ? ", parent_id)

    content_tag :div, class: 'select input-dark' do
      @form_object.collection_select("#{@field_name}_id", matched_resources, :id, :select_title, {prompt: true}, {class: "js-choice input-dark",
        data: {action: 'change->extended-select#onSelectChange', selection: @field_name, parent: depends_on, url: send("api_filter_#{@field_name}s_url")}})
    end
  end

  def get_select_multiple_field
    reference_class = @field_name.classify.constantize
    content_tag :div, class: '' do
      @form_object.collection_select("#{@field_name}_ids", reference_class.all, :id, :select_title, {prompt: true},
        {class: 'js-choice input-dark', multiple: true})
    end
  end

  def get_array_field
    list = @item_class.send("all_#{@field_name}")
    current_field_value = @item.send(@field_name)
    @form_object.select(@field_name, options_for_select(list, current_field_value), {include_blank: "Non défini"}, placeholder: "Non défini",
      class: 'js-choice select input-dark', multiple: true)
  end

  def get_nested_attributes_field
    render(::Forms::NestedAttributesComponent.new(
            field_name: @field_name,
            field_type: @field_type,
            form_object: @form_object,
            item: @item,
            options: @options,
            item_type: @item_type
    ))
  end

  def get_nested_disabled_field
    render(::Forms::NestedAttributesComponent.new(
            field_name: @field_name,
            field_type: @field_type,
            form_object: @form_object,
            item: @item,
            options: @options,
            item_type: @item_type,
            disabled: true
    ))
  end

  def get_nested_attributes_modal_field
    content_tag :button, class: 'button is-primary block', 'data-action': 'click->modal#toggle' do
      'Ajouter'
    end
  end

  def get_rich_text_field
    helpers.rich_text_area_tag("#{@item_type}[#{@field_name}]", @item.send(@field_name))
  end

  def get_boolean_field
    content = <<-HTMLTAG
    <div>
      #{@form_object.radio_button @field_name, true, class: "radio"}
      #{@form_object.label @field_name, "Oui", value: "true"}
      #{@form_object.radio_button @field_name, false, class: "radio"}
      #{@form_object.label @field_name, "Non", value: "false"}
    </div>
    HTMLTAG
    content.html_safe
  end

end
