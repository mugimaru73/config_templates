module ConfigTemplates::Models
  class Compilation
    def initialize
      @config = ::ConfigTemplates.config
      @context = ::ConfigTemplates::Contexts::Compilation.new
    end

    def select(expression)
      @context.criteria ::ConfigTemplates::Criteria::Name.new(expression, true)
      self
    end

    def reject(expression)
      @context.criteria ::ConfigTemplates::Criteria::Name.new(expression, false)
      self
    end

    def send_to(output_name)
      @context.renderers.each do |renderer|
        renderer.validate!
        @config.output(output_name).print renderer
      end
    end
  end
end
