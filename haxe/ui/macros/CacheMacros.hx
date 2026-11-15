package haxe.ui.macros;

#if macro
import haxe.macro.Context;
#end

/**
    Keeps the registries the build macros fill (the component class map and the RTTI table) whole under a
    compilation server. A class the server has cached does not run its build macro again, so:
     - both registries are @:persistent, and keep what earlier compilations registered;
     - their resources are written again after typing, over whatever copy a cached class brought back.
    Run once per compilation from extraParams.hxml.
**/
class CacheMacros {
    #if macro
    public static function init() {
        Context.onAfterTyping(function(_) {
            haxe.ui.core.ComponentClassMap.saveResource();
            if (haxe.ui.util.RTTI.classInfo != null) {
                haxe.ui.util.RTTI.save();
            }
        });
    }
    #end
}
