package screeps;

import haxe.extern.EitherType;

extern enum abstract Style(String) {
	var dashed = "dashed";
	var dotted = "dotted";
	var solid = "solid";
}

extern enum abstract Align(String) {
	var center = "center";
	var left = "left";
	var right = "right";
}


extern typedef LineStyle = {
	/**
	 * Line width, default is 0.1.
	 */
	var ?width:Int;

	/**
	 * Line color in any web format, default is #ffffff(white).
	 */
	var ?color:Int;

	/**
	 * Opacity value, default is 0.5.
	 */
	var ?opacity:Int;

	/**
	 * Either undefined (solid line), dashed, or dotted.Default is undefined.
	 */
	var ?lineStyle:Style;
}

extern typedef PolyStyle = {
	/**
	 * Fill color in any web format, default is #ffffff(white).
	 */
	var ?fill:Int;

	/**
	 * Opacity value, default is 0.5.
	 */ var ?opacity:Int;

	/**
	 * Stroke color in any web format, default is undefined (no stroke).
	 */ var ?stroke:EitherType<String, Void>;

	/**
	 * Stroke line width, default is 0.1.
	 */ var ?strokeWidth:Int;

	/**
	 * Either undefined (solid line), dashed, or dotted.Default is undefined.
	 */ var ?lineStyle:Style;
}

extern typedef CircleStyle = {
	/**
	 * Circle radius, default is 0.15.
	 */
	var ?radius:Int;
} &
	PolyStyle

extern typedef TextStyle = {
	/**
	 * Font color in any web format, default is #ffffff(white).
	 */
	var ?color:String;

	/**
	 * Either a number or a string in one of the following forms:
	 * 0.7 - relative size in game coordinates
	 * 20px - absolute size in pixels
	 * 0.7 serif
	 * bold italic 1.5 Times New Roman
	 */
	var ?font:EitherType<Int, String>;

	/**
	 * Stroke color in any web format, default is undefined (no stroke).
	 */
	var ?stroke:String;

	/**
	 * Stroke width, default is 0.15.
	 */
	var ?strokeWidth:Int;

	/**
	 * Background color in any web format, default is undefined (no background).When background is enabled, text vertical align is set to middle (default is baseline).
	 */
	var ?backgroundColor:String;

	/**
	 * Background rectangle padding, default is 0.3.
	 */
	var ?backgroundPadding:Int;

	var ?align: Align;

	/**
	 * Opacity value, default is 1.0.
	 */
	var ?opacity:Int;
}
