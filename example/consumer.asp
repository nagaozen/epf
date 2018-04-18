<!--#include virtual="/lib/axe/base.asp"-->
<!--#include virtual="/lib/axe/classes/interface.asp"-->
<!--#include virtual="/lib/axe/classes/Parsers/json2.asp"-->
<!--#include virtual="/lib/evolved/asp/opinionated.asp"-->
<!--#include virtual="/lib/evolved/asp/epf/manager.asp"-->
<!--#include virtual="/lib/evolved/asp/epf/interface.asp"-->
<%

Response.charset = "UTF-8"

dim [π]
set [π] = (new PluginManager)( "Example", Server.mapPath("/lib/evolved/asp/epf/plugins.json") )

sub main
[π].set "Global", "main"

	dim Ctx

	set Ctx = [!!]("{ 'Actors': {} }")

	' define actors
	with Ctx.Actors
		' (optional) result initial state
		.set "result", ""

		' beware of unmanaged resources. eg ADODB.Connection
'		.set "Conn", Conn
	end with

	' invoke plugins define
	[π].define Ctx.Actors

	' bind events
	

	' invoke plugins bind
	[π].bind Ctx.Actors

	' invoke plugins before action
	[π].beforeAction Ctx

	' action!
	with Ctx.Actors
		.set "result", .result & "〈Hi, I'm the main action (standard) content〉"
	end with

	' invoke plugins after action
	[π].afterAction Ctx

	' release unmanaged resources, eg ADODB.Connection
	with Ctx.Actors
'		.purge "Conn"
	end with

	Response.write Ctx.Actors.result

	set Ctx = nothing

[π].unset "Global", "main"
end sub : main

set [π] = nothing

%>