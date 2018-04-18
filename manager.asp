<%

' File: manager.asp
'
' Evolved Classic ASP Plugins Framework manager definition.
'
' License:
'
' This file is part of Evolved Classic ASP Plugins Framework.
' Copyright (C) 2013 Fabio Zendhi Nagao
'
' Evolved Classic ASP Plugins Framework is free software: you can redistribute it and/or modify
' it under the terms of the GNU Lesser General Public License as published by
' the Free Software Foundation, either version 3 of the License, or
' (at your option) any later version.
'
' Evolved Classic ASP Plugins Framework is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU Lesser General Public License for more details.
'
' You should have received a copy of the GNU Lesser General Public License
' along with Evolved Classic ASP Plugins Framework. If not, see <http://www.gnu.org/licenses/>.



' Class: PluginManager
'
' The central piece of Evolved Classic ASP Plugins Framework. This class loads
' and configure plugins from a json file which manifests the desires of the
' plugin to extend the functionality of a process.
'
' About:
'
' 	- Written by Fabio Zendhi Nagao <http://zend.lojcomm.com.br> @ Jun 2013
'
class PluginManager

' --[ Public section ]----------------------------------------------------------

	public default function [new](byVal name, byVal path)
		Me.name = name

		if isEmpty( Application(Me.name) ) then
			Application(Me.name) = loadTextFile(path)
		end if

		set [new] = Me
	end function

	public name

	public Listeners

	' Property: classType
	'
	' Class type.
	'
	' Contains:
	'
	' 	(string) - type
	'
	public property get classType
		classType = typename(Me)
	end property

	' Property: classVersion
	'
	' Class version.
	'
	' Contains:
	'
	' 	(string) - version
	'
	public property get classVersion
		classVersion = "1.0.0"
	end property

	public sub [set](byVal controller, byVal method)
		dim Plugins, Plugin, i

		[Ξ].unshift( []( "{0}_{1}", array(controller, method) ) )

		set Plugins = JSON.parse( Application(Me.name) )
		for each i in Plugins.enumerate()
			set Plugin = Plugins.get(i)
			if not isEmpty( Plugin.extends.get( controller ) ) then
				if isEmpty( Application( []( "Plugins.{0}", Plugin.id ) ) ) then _
					Application( []( "Plugins.{0}", Plugin.id ) ) = mid( loadTextFile( Server.mapPath( []( "{0}/plugin.asp", Plugin.path ) ) ), 3 )
				executeGlobal Application( []( "Plugins.{0}", Plugin.id ) )
				execute []( "Listeners.set ""{0}"", new {0}", Plugin.id )
			end if
			set Plugin = nothing
		next
		set Plugins = nothing
	end sub

	public sub unset(byVal controller, byVal method)
		[Ξ].shift( []( "{0}_{1}", array(controller, method) ) )
	end sub

	public sub define(byRef Actors)
		dim context_id, key
		context_id = [Ξ].get(0)
		for each key in Listeners.enumerate()
			Listeners.get(key).define context_id, Actors
		next
	end sub

	public sub bind(byRef Actors)
		dim context_id, key
		context_id = [Ξ].get(0)
		for each key in Listeners.enumerate()
			Listeners.get(key).bind context_id, Actors
		next
	end sub

	public sub beforeAction(byRef Context)
		dim context_id, key
		context_id = [Ξ].get(0)
		for each key in Listeners.enumerate()
			Listeners.get(key).beforeAction context_id, Context
		next
	end sub

	public sub afterAction(byRef Context)
		dim context_id, key
		context_id = [Ξ].get(0)
		for each key in Listeners.enumerate()
			Listeners.get(key).afterAction context_id, Context
		next
	end sub

' --[ Private section ]---------------------------------------------------------

	private [Ξ]

	private sub Class_initialize()
		set Listeners = [!]("{}")
		set [Ξ]       = [!]("[]")
	end sub

	private sub Class_terminate()
		set [Ξ]       = nothing
		set Listeners = nothing
	end sub

end class

%>