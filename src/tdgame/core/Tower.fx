package tdgame.core;

import javafx.geometry.Point2D;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.animation.transition.RotateTransition;
import tdgame.util.PathUtil;
import javafx.util.Math;

/**
 * @author Maxim Kolchin
 */
public abstract class Tower extends Entity {

    public var fireRate: Duration;
    public var firePower: Number;
    public var cost: Number;
    public var fireRadius: Number;
    public var towerRadius: Number;
    public var position: Point2D;
    protected var center: Point2D;
    var startPoint: Point2D;
    var startAngle: Number = 0;

    override function reset() {
	center = Point2D {
		    x: position.x + towerRadius
		    y: position.y + towerRadius
		}
	startPoint = Point2D { x: center.x y: center.y + towerRadius }
	def timeline = Timeline {
		    repeatCount: Timeline.INDEFINITE
		    keyFrames: [
			KeyFrame {
			    time: fireRate
			    action: function() {
				fire();
			    }
			}
		    ]
		}
	field.add(timeline);
    }

    public function fire() {
	for (creature in field.creatures) {
	    def start = center;
	    def end = creature.center();
	    def distance = end.distance(start);
	    //java.lang.System.out.println("Found: {start} {end} {distance}");
	    if (distance < fireRadius) {
		java.lang.System.out.println("Fire: {start} {end} {distance}");
		def endAngle = angleRotate(start, end);
		RotateTransition {
		    duration: Math.abs(startAngle - endAngle) * 0.0005s;
		    fromAngle: startAngle
		    toAngle: endAngle
		    node: this
		}.play();
		java.lang.System.out.println("startAngle: {startAngle} endAngle:{endAngle}");
		startAngle = endAngle;
		fire(start, end);
		break;
	    }
	}
    }

    public abstract function fire(start: Point2D, end: Point2D);

    override function destroy(): Void { }

    function angleRotate(start: Point2D, end: Point2D): Double {
	def endPoint: Point2D = PathUtil.intersectLineAndCircle(
		start, end, center, towerRadius).get(0);
	def k = (center.y - startPoint.y) / (center.x - startPoint.x);
	def b = startPoint.y - k * startPoint.x;
	def angle: Double = PathUtil.angleBetweenRadius(center, startPoint, endPoint);
	var a;
	if (startPoint.x > center.x) {
	    if (endPoint.x * k + b > endPoint.y) {
		a = startAngle - angle;
	    } else {
		a = startAngle + angle;
	    }
	} else {
	    if (endPoint.x * k + b < endPoint.y) {
		a = startAngle - angle;
	    } else {
		a = startAngle + angle;
	    }
	}

	java.lang.System.out.println("angle: {angle}");
	startPoint = endPoint;

	return a;

    }

}
