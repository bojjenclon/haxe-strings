/*
 * Copyright (c) 2016-2021 Vegard IT GmbH (https://vegardit.com) and contributors.
 * SPDX-License-Identifier: Apache-2.0
 */
package hx.strings.spelling.dictionary;

import haxe.Resource;
import haxe.io.BytesInput;
import hx.strings.internal.Macros;

/**
 * A pre-trained German in-memory dictionary.
 *
 * Contains most common 30.000 words determined and weighted by analyzing:
 * 1) free German books (https://www.gutenberg.org/browse/languages/de),
 * 2) German movie subtitles (http://opensubtitles.org),
 * 3) some German newspaper articles,
 * 4) the Top 10000 German word list of the University Leipzig (http://wortschatz.uni-leipzig.de/html/wliste.html), and
 * 5) the Free German Dictionary (https://sourceforge.net/projects/germandict/)
 *
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
class GermanDictionary extends InMemoryDictionary {

   public static final INSTANCE = new GermanDictionary();

   public function new() {
      super();

      Macros.addResource("hx/strings/spelling/dictionary/GermanDictionary.txt", "GermanDictionary");

      // workaround to prevent strange error: AttributeError: type object 'python_Lib' has no attribute 'lineEnd'
      #if python python.Lib; #end

      // not using loadWordsFromResource for full DCE support
      trace('[INFO] Loading words from embedded [GermanDictionary]...');
      loadWordsFromInput(new BytesInput(Resource.getBytes("GermanDictionary")));
   }

   override
   public function toString()
      return 'GermanDictionary[words=$dictSize]';
}
