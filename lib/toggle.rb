module Toggle

	def self.included(receiver)
	  receiver.extend ClassMethods
	end

	module ClassMethods
	  def toggle!(field)
	    send "#{field}=", !self.send("#{field}?")
	    save :validation => false
	  end
	end


end
