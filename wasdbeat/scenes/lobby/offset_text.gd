extends Label

func change_text(offset: float) -> void:
	self.text = "%.2f" % offset
