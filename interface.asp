<%

' File: interface.asp
'
' Evolved Classic ASP Plugins Framework interface definition.
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



' Class: IPlugin
'
' Defines the common specifications required to implement a working plugin for
' Evolved Classic ASP Plugins Framework.
'
' About:
'
' 	- Written by Fabio Zendhi Nagao <http://zend.lojcomm.com.br> @ Jun 2013
'
class IPlugin' extends Interface

' --[ Interface definition ]----------------------------------------------------

	' Subroutine: activate
	'
	' Creates plugin infrastructure and populate with possible existing data.
	'
	public sub activate()
	end sub

	' Subroutine: deactivate
	'
	' Removes plugin infrastructure.
	'
	public sub deactivate()
	end sub

	' Subroutine: define
	'
	' Includes new Actors to the action.
	'
	public sub define(byVal method, byRef Actors)
	end sub

	' Subroutine: bind
	'
	' Assign new events between action Actors.
	'
	public sub bind(byVal method, byRef Actors)
	end sub

	' Subroutine: beforeAction
	'
	' Extends action, changes output, etc.
	'
	public sub beforeAction(byVal method, byRef Context)
	end sub

	' Subroutine: afterAction
	'
	' Extends action, changes output, etc.
	'
	public sub afterAction(byVal method, byRef Context)
	end sub

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

' --[ Delegation ]--------------------------------------------------------------

	public property get requireds
		requireds = Parent.requireds
	end property

	public default function check(byRef I)
		Parent.check Me, I
		set check = Me
	end function

' --[ Private section ]---------------------------------------------------------

	private Parent

	private sub Class_initialize()
		set Parent = new Interface
		Parent.requireds = array("activate","deactivate","define","bind","beforeAction","afterAction")
	end sub

	private sub Class_terminate()
		set Parent = nothing
	end sub

end class

%>