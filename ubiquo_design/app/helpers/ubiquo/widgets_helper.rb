module Ubiquo::WidgetsHelper
  def widget_form(page, widget, &block)
    remote_form_for(
      :widget,
      widget,
      :url => ubiquo.page_widget_path(:page_id => page.id,
                                      :id      => widget.id,
                                      :format  => :js),
      :before => 'killeditor()',
      :html   => { :method => :put,
                   :name   => "widget_edit_form",
                   :id     => "widget_form", },
       &block
    )
  end

  def widget_submit
    submit = %{
      <p class="form_buttons">
        <input type="submit" class="button" value="%s" />
      </p>
    } % [t('ubiquo.design.save')]

    raw submit
  end

  def widget_header(widget)
    header =  %{
      <h3>%s</h3>
      <a href="#" class="lightwindow_action close" rel="deactivate">%s</a>
      <div id="error_messages"></div>
    } % [(t('ubiquo.design.editing_widget', :name => widget.name)), t('ubiquo.design.close_widget')]

    raw header
  end

  def li_widget_attributes(widget, page)
    classes = ["widget"]
    classes << "error" unless widget.valid?
    classes << "inherited" unless page.blocks.include?(widget.block)
    attrs = ["id= 'widget_#{widget.id}'", "class= '#{classes.join(' ')}'"]
    unless widget.valid?
      attrs << ["alt='#{t("ubiquo.design.widget_error")}'"]
      attrs << ["title='#{t("ubiquo.design.widget_error")}'"]
    end
    attrs.join(' ')
  end

end
