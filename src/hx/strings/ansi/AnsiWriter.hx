/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: Apache-2.0
 */
package hx.strings.ansi;

import hx.strings.AnyAsString;

class AnsiWriter<T> {

   final _out:StringBuf_StringBuilder_or_Output<T>;
   public var out(get, never):T;
   inline function get_out():T return _out.out;


   inline
   public function new(out:StringBuf_StringBuilder_or_Output<T>)
      this._out = out;


   /**
    * sets the given text attribute
    */
   inline
   public function attr(attr:AnsiTextAttribute)
      return write(Ansi.attr(attr));


   /**
    * set the text background color
    */
   inline
   public function bg(color:AnsiColor):AnsiWriter<T>
      return write(Ansi.bg(color));


   /**
    * Clears the screen and moves the cursor to the home position
    */
   inline
   public function clearScreen():AnsiWriter<T>
      return write(Ansi.clearScreen());


   /**
    * Clear all characters from current position to the end of the line including the character at the current position
    */
   inline
   public function clearLine():AnsiWriter<T>
       return write(Ansi.clearLine());


   inline
   public function cursor(cmd:AnsiCursor):AnsiWriter<T>
      return write(Ansi.cursor(cmd));


   /**
    * set the text foreground color
    */
   inline
   public function fg(color:AnsiColor):AnsiWriter<T>
      return write(Ansi.fg(color));


   /**
    * flushes any buffered data
    */
   inline
   public function flush():AnsiWriter<T> {
      _out.flush();
      return this;
   }


   inline
   public function write(str:AnyAsString):AnsiWriter<T> {
      _out.write(str);
      return this;
   }
}


@:noCompletion
@:noDoc @:dox(hide)
@:forward
abstract StringBuf_StringBuilder_or_Output<T>(StringWriter<T>) {

   inline
   function new(writer:StringWriter<T>)
      this = writer;

   @:from inline static function fromStringBuilder<T:StringBuilder>  (out:T) return new StringBuf_StringBuilder_or_Output(new StringBuilderStringWriter(out));
   @:from inline static function fromStringBuf    <T:StringBuf>      (out:T) return new StringBuf_StringBuilder_or_Output(new StringBufStringWriter(out));
   @:from inline static function fromOutput       <T:haxe.io.Output> (out:T) return new StringBuf_StringBuilder_or_Output(new OutputStringWriter(out));
}


@:noDoc @:dox(hide)
private interface StringWriter<T> {
   public var out(default, null):T;
   public function flush():Void;
   public function write(str:String):Void;
}


@:noDoc @:dox(hide)
private class OutputStringWriter<T:haxe.io.Output> implements StringWriter<T> {

   public var out(default, null):T;

   inline
   public function new(out:T)
      this.out = out;

   public function flush()
      out.flush();

   public function write(str:String)
      out.writeString(str);
}


@:noDoc @:dox(hide)
private class StringBufStringWriter<T:StringBuf> implements StringWriter<T> {

   public var out(default, null):T;

   inline
   public function new(out:T)
      this.out = out;

   public function flush() {};

   public function write(str:String)
      out.add(str);
}


@:noDoc @:dox(hide)
private class StringBuilderStringWriter<T:StringBuilder> implements StringWriter<T> {

   public var out(default, null):T;

   inline
   public function new(out:T)
      this.out = out;

   public function flush() {};

   public function write(str:String) {
      #if (cs||java)
         cast(out, StringBuilder).add(str);
      #else
         out.add(str);
      #end
   }
}
