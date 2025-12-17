extends Label

func change_text(offset: int) -> void:
	self.text = "%.2f" % (float(offset) / 100)
