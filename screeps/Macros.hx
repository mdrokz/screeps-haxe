package screeps;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
#end

class MacroUtils {
	public static macro function getValues(typePath:Expr):Expr {
		// Get the type from a given expression converted to string.
		// This will work for identifiers and field access which is what we need,
		// it will also consider local imports. If expression is not a valid type path or type is not found,
		// compiler will give a error here.
		var type = Context.getType(typePath.toString());

		// Switch on the type and check if it's an abstract with @:enum metadata
		switch (type.follow()) {
			case TAbstract(_.get() => ab, _) if (ab.meta.has(":enum")):
				// @:enum abstract values are actually static fields of the abstract implementation class,
				// marked with @:enum and @:impl metadata. We generate an array of expressions that access those fields.
				// Note that this is a bit of implementation detail, so it can change in future Haxe versions, but it's been
				// stable so far.
				var valueExprs = [];
				for (field in ab.impl.get().statics.get()) {
					if (field.meta.has(":enum") && field.meta.has(":impl")) {
						var fieldName = field.name;
						valueExprs.push(macro $typePath.$fieldName);
					}
				}
				// Return collected expressions as an array declaration.
				return macro $a{valueExprs};
			default:
				// The given type is not an abstract, or doesn't have @:enum metadata, show a nice error message.
				throw new Error(type.toString() + " should be @:enum abstract", typePath.pos);
		}
	}

	macro public static function buildEnum(typePath:Expr):Array<Field> {
		var type = Context.getType(typePath.toString());

		var fields = Context.getBuildFields();

		switch (type.follow()) {
			case TAbstract(_.get() => ab, _) if (ab.meta.has(":enum")):
				for (field in ab.impl.get().statics.get()) {
					if (field.meta.has(":enum") && field.meta.has(":impl")) {
						var fieldName = field.name;

						var expr = field.expr().expr;

						// trace(expr);

						switch (field.expr().expr) {
							case TCast(e, m): {
									switch (e.expr) {
										case TConst(TString(s)): {
												fields.push({
													name: fieldName,
													kind: FVar(macro:String, macro $v{s}),
													pos: Context.currentPos()
												});
											}

										default:
									}
								}

							default:
						}
					}
				}
			// Return collected expressions as an array declaration.
			default:
				// The given type is not an abstract, or doesn't have @:enum metadata, show a nice error message.
				throw new Error(type.toString() + " should be @:enum abstract", typePath.pos);
		}
		return fields;
	}

	macro public static function buildNestedFields(types:Array<String>):ComplexType {
		var types = types.map((x) -> x.toComplex());

		var ct = types.pop();
		while (types.length > 0) {
			var t = types.pop();
			ct = macro:EitherType<$t, $ct>;
		}

		return ct;
	}
}
