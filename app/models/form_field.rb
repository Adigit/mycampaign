class FormField 
	include Mongoid::Document
	include Mongoid::Timestamps
	has_many :form_field_entries
	field :campaign_model_name, type: String
	field :model_id, type: BigDecimal
	field :campaign_id, type: BigDecimal
	field :field_type, type: String
	field :field_name, type: String
	field :display_order, type: Integer
	field :required_field, type: Boolean
	field :show_on_details_page, type: Boolean
end
