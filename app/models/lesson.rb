class Lesson < ActiveRecord::Base
	belongs_to :section


	include RankedModel
	ranks :row_order, :with_same => :section_id
end
