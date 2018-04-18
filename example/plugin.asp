<%

class ExamplePlugin' implements IPlugin

	public sub activate()
	end sub

	public sub deactivate()
	end sub

	public sub define(byVal context_id, byRef Actors)
	end sub

	public sub bind(byVal context_id, byRef Actors)
	end sub

	public sub beforeAction(byVal context_id, byRef Context)
		select case context_id
			case "Global_main"
				on_Global_main_beforeAction Context
		end select
	end sub

	public sub afterAction(byVal context_id, byRef Context)
		select case context_id
			case "Global_main"
				on_Global_main_afterAction Context
		end select
	end sub

' --[ Event Handlers ]----------------------------------------------------------

	private sub on_Global_main_beforeAction(byRef Context)
		with Context.Actors
			.set "result", .result & " ｢ onBeforeAction content injected by the ExamplePlugin ｣ "
		end with
	end sub

	private sub on_Global_main_afterAction(byRef Context)
		with Context.Actors
			.set "result", .result & " ｢ content injected by the ExamplePlugin ｣ "
		end with
	end sub

' --[ Private Section ]---------------------------------------------------------

	private Interface

	private sub Class_initialize()
		set Interface = (new IPlugin)(Me)
	end sub

	private sub Class_terminate()
		set Interface = nothing
	end sub

end class
