package tdgame.util;

import javafx.geometry.Point2D;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.shape.LineTo;
import javafx.util.Math;

/**
 * @author andromeda, Maxim Kolchin
 */
public function startPoint(path: Path): Point2D {
    def elem = path.elements[0];

    if (elem instanceof MoveTo) {
	def moveTo = elem as MoveTo;
	return Point2D { x: moveTo.x + path.translateX y: moveTo.y + path.translateY }
    }

    return null;

}

public function sqr(x: Number): Number { x * x }

public function sqr(x1: Number, y1: Number, x2: Number, y2: Number): Number {
    sqr(x2 - x1) + sqr(y2 - y1)
}

public function distance(x1: Number, y1: Number, x2: Number, y2: Number): Number {
    Math.sqrt(sqr(x1, y1, x2, y2));
}

public function distance(path: Path) {

    var x = 0.0;
    var y = 0.0;
    var s = 0.0;

    for (elem in path.elements) {
	if (elem instanceof MoveTo) {
	    def moveTo = elem as MoveTo;
	    x = moveTo.x;
	    y = moveTo.y;
	} else if (elem instanceof LineTo) {
	    def lineTo = elem as LineTo;
	    s += distance(lineTo.x, lineTo.y, x, y);
	    x = lineTo.x;
	    y = lineTo.y;
	}
    }

    return s;

}

public function intersect(x1: Number, y1: Number, x2: Number, y2: Number,
	center: Point2D, radius: Number): Boolean {
    def a = sqr(x1, y1, x2, y2);
    def b = (x2 - x1) * (x1 - center.x) + (y2 - y1) * (y1 - center.y);
    def c = sqr(x1, y1, center.x, center.y) - sqr(radius);

    def det = sqr(b) - a * c;

    if (0 <= det) {
	def s = Math.sqrt(det);

	def root1 = (-b + s) / a;
	def root2 = (-b - s) / a;

	if ((0 <= root1 and root1 <= 1) or (0 <= root2 and root2 <= 1)) {
	    return true;
	}
    }

    return false;

}

public function intersect(path: Path, center: Point2D,
	radius: Number): Boolean {
    var x = 0.0;
    var y = 0.0;

    for (elem in path.elements) {
	if (elem instanceof MoveTo) {
	    def moveTo = elem as MoveTo;
	    x = moveTo.x;
	    y = moveTo.y;
	} else if (elem instanceof LineTo) {
	    def lineTo = elem as LineTo;
	    if (intersect(x, y, lineTo.x, lineTo.y, center, radius)) {
		return true;
	    }
	    x = lineTo.x;
	    y = lineTo.y;
	}
    }
    return false;

}

/*
 * Находит точки пересечения отрезка и окружности
 */
public function intersectLineAndCircle(start: Point2D, end: Point2D, center: Point2D,
	radius: Number): Point2D[] {
    var p: Point2D[];
    def a = sqr(start.x, start.y, end.x, end.y);
    def b = (end.x - start.x) * (start.x - center.x) + (end.y - start.y) * (start.y - center.y);
    def c = sqr(start.x, start.y, center.x, center.y) - sqr(radius);

    def det = sqr(b) - a * c;

    if (0 <= det) {
	def s = Math.sqrt(det);

	def root1 = (-b + s) / a;
	def root2 = (-b - s) / a;

	if ((0 <= root1 and root1 <= 1)) {
	    insert Point2D {
		x: start.x * (1 - root1) + end.x * root1
		y: start.y * (1 - root1) + end.y * root1
	    } into p;
	}
	if ((0 <= root2 and root2 <= 1)) {
	    insert Point2D {
		x: start.x * (1 - root2) + end.x * root2
		y: start.y * (1 - root2) + end.y * root2
	    } into p
	}
    }

    return p

}

/*
 * Находит угол а при вершине А в треугольнике ABC
 * Результат в градусах
 */
public function angleBetweenRadius(A: Point2D, B: Point2D, C: Point2D): Double {
    //длины сторон а,b,c
    def a = distance(B.x, B.y, C.x, C.y);
    def b = distance(A.x, A.y, C.x, C.y);
    def c = distance(A.x, A.y, B.x, B.y);
    def cosA:Double = (sqr(b) + sqr(c) - sqr(a)) / (2 * b * c);
    return Math.toDegrees(Math.acos(cosA));
}
