// Copyright  2014 Michael V. Franklin
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

module main;

import std.regex;
import std.array;
import std.stdio;
import std.string;
import std.conv;
import std.typecons;
import std.algorithm;

import arsd.dom;

class Peripheral
{
	string name;
    string description;
	string Prepender;
	string baseAddress;
}


class Register
{
    string name;
    string description;
    string resetValue;
	string resetMask;
	string size;
    string access;
    string addressOffset;
	string dim;
	string dimIncrement;
	string dimIndex;

}

class Field{
	string name;
	string description;
	string bitOffset;
	string bitWidth;
	string access;
}

class EnumeratedValue{
	string name;
	string description;
	string value;
}

string tab = "  ";
string newline = "\n";

string xmlToD(string inputstring)
{
	Document document = new Document(inputstring, true, true);
	
	Peripheral Peri       = new Peripheral();
    auto code = appender!string;

	foreach(Perf; document.getElementsByTagName("peripheral"))
	{
		foreach(child; Perf.childNodes){
			if(child.tagName=="description"   ){Peri.description       = child.innerText();}
			if(child.tagName=="name"          ){Peri.name              = child.innerText();}		
			if(child.tagName=="baseAddress"   ){Peri.baseAddress       = child.innerText();}
		}  
	
		code.put("/****************************************************************************************" ~ newline);
		foreach(string line; splitter(Peri.description, regex("[\r\n]+") )){
			code.put(tab~"* "~line~newline);				
		}
		code.put("*/" ~ newline);
		code.put("final abstract class " ~Peri.name);
		code.put(": Peripheral!(");
		code.put(Peri.baseAddress~ ")" ~ newline);
		code.put("{" ~ newline);
		
		code.put(HandleRegisters(Perf));

		code.put("}" ~ newline);
	}
	
    return(code.data);
}


string HandleRegisters(Element Perf){

		
		auto code = appender!string;

		foreach(Regs; Perf.getElementsByTagName("register"))
		{       
				Register Reg          = new Register();
				
				foreach(child; Regs.childNodes){
					if(child.tagName=="description"   ){Reg.description       = child.innerText();}
					if(child.tagName=="name"          ){Reg.name              = child.innerText();}		
					if(child.tagName=="size"          ){Reg.size              = child.innerText();}	
					if(child.tagName=="resetValue"    ){Reg.resetValue        = child.innerText();}
					if(child.tagName=="resetMask"     ){Reg.resetMask         = child.innerText();}
					if(child.tagName=="access"        ){Reg.access            = child.innerText().replaceAll(regex("-"),"_");}
					if(child.tagName=="addressOffset" ){Reg.addressOffset     = child.innerText();}
					if(child.tagName=="dim"           ){Reg.dim               = child.innerText();}
					if(child.tagName=="dimIncrement"  ){Reg.dimIncrement      = child.innerText();}
					if(child.tagName=="dimIndex"      ){Reg.dimIndex          = child.innerText();}
				}                                         
				
				Reg.access~=Reg.size;
				
				
				if(Reg.name.canFind("%s")){
					string mybase   = Reg.addressOffset;
					uint mybaseval  = parseValue(mybase);
					string basename = Reg.name;
					uint incvalue=0;
					foreach(string sreg ; splitter(Reg.dimIndex, regex(",") )){
						Reg.name = replaceAll(basename,regex("%s"),sreg);
						Reg.addressOffset = printhex(mybaseval + incvalue);
						code.put(Register_Subhandle(Regs,Reg));
						incvalue += parseValue(Reg.dimIncrement);
					}
				
				}else{
					code.put( Register_Subhandle(Regs,Reg));
				}

		}
		return(code.data);
		
		
}

string Register_Subhandle(Element Regs, Register Reg){
	auto code = appender!string;
	
	code.put(tab~"/**************************************************************************************" ~ newline);
	foreach(string line; splitter(Reg.description, regex("[\r\n]+") )){
		code.put(tab~"* "~line~newline);				
	}
	code.put(tab~"*/" ~ newline);
	code.put(tab~"final abstract class " ~Reg.name);
	code.put(tab~": Register!(" ~Reg.addressOffset);
	code.put(tab~", Access." ~Reg.access~ ")" ~ newline);
	code.put(tab~"{" ~ newline);
	
	code.put( HandleFields(Regs));

	code.put(tab~"}" ~ newline);
	
	return(code.data);
}

string HandleFields(Element Regs){

	auto code = appender!string;
	Field Fld = new Field();


	foreach(Flds; Regs.getElementsByTagName("field")){
		foreach(child; Flds.childNodes){
			if(child.tagName=="description"){Fld.description  = child.innerText();}
			if(child.tagName=="name"       ){Fld.name         = child.innerText();}		
			if(child.tagName=="bitOffset"  ){Fld.bitOffset    = child.innerText();}
			if(child.tagName=="bitWidth"   ){Fld.bitWidth     = child.innerText();}
			if(child.tagName=="access"     ){Fld.access       = child.innerText().replaceAll(regex("-"),"_");}
		}                                                   

		code.put(tab~tab ~ "/************************************************************************************" ~ newline);
		code.put(tab~tab ~ Fld.description.replace(newline, newline ~ tab) ~ newline);
//
		code.put(HandleEnums(Flds));
		
		code.put(tab~tab ~ "*/" ~ newline);
		code.put(tab~tab ~ "alias " ~ Fld.name ~ " = ");
		if (Fld.bitWidth=="1")
		{
			code.put(tab~"Bit!(" ~ (Fld.bitOffset.to!int + Fld.bitWidth.to!int).to!string ~ ", Mutability." ~ Fld.access ~ ");");
		}
		else
		{
			//code.put("OFFSET:"~Fld.bitOffset~newline);
			code.put(tab~"BitField!(" ~ (Fld.bitOffset.to!int + Fld.bitWidth.to!int).to!string~ ", " ~ Fld.bitOffset ~ ", Mutability." ~ Fld.access ~ ");");
		}
		code.put(newline);
		code.put(newline);	
	}
	return(code.data);
}

string HandleEnums(Element Flds){

	auto code = appender!string;
	EnumeratedValue EnumV = new EnumeratedValue();

	foreach(EnumsTop; Flds.getElementsByTagName("enumeratedValues")){
		foreach(Enums; EnumsTop.getElementsByTagName("enumeratedValue")){
			foreach(child; Enums.childNodes){
				if(child.tagName=="description"){EnumV.description  = child.innerText();}
				if(child.tagName=="name"       ){EnumV.name         = child.innerText();}		
				if(child.tagName=="value"      ){EnumV.value        = child.innerText();}
			}
			code.put(tab~tab~tab~EnumV.name~tab~EnumV.value~tab~EnumV.description~newline);
		}  
	}
	return(code.data);
}

uint parseValue(string number){
	assert(number.length > 0,"Invalid Empty number");
	auto hex = matchFirst(number, regex(`0x([0-9A-Fa-f]+)`));
	if(!hex.empty){return hex[1].to!uint(16);}
	auto dec = matchFirst(number, regex(`([0-9]+)`));
	if(!dec.empty){return dec[1].to!uint(10);}
	auto bin = matchFirst(number, regex(`#([0-1]+)`));
	if(!bin.empty){return bin[1].to!uint(10);}
	assert(0,"Unexpected string when parsing for value: "~number);
}

string printhex(uint number){
	import std.format;
	return format("%#x", number).toUpper();
}



void main(string[] args){
	import std.file;
	std.stdio.write(xmlToD(readText(args[1])));
}
