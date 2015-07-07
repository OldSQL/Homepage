# Copyright 2015 Unicode4all
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License. 

module ApplicationHelper  
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      if language.nil?
        CodeRay.scan(code, :ruby).div
      else
        CodeRay.scan(code, language).div
      end
    end
  end
  
  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, 
      :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
  
  def habtm_checkboxes(obj, column, assignment_objects, assignment_object_display_column)
    obj_to_s    = obj.class.to_s.split("::").last.underscore
    field_name  = "#{obj_to_s}[#{column}][]"
    
    html = hidden_field_tag(field_name, "")
    assignment_objects.each do |assignment_obj|
      cbx_id = "#{obj_to_s}_#{column}_#{assignment_obj.id}"
      html += check_box_tag field_name, assignment_obj.id, obj.send(column).include?(assignment_obj.id), :id => cbx_id
      html += label_tag cbx_id, h(assignment_obj.send(assignment_object_display_column))
      html += content_tag(:br)
    end
    html
  end
end
