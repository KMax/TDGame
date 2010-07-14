package tdgame.core;

import javafx.animation.Timeline;
import javafx.geometry.Point2D;
import javafx.animation.Interpolator;
import javafx.animation.transition.AnimationPath;
import javafx.animation.transition.OrientationType;
import javafx.scene.paint.Color;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import tdgame.util.PathUtil;
import javafx.scene.Node;
import javafx.animation.transition.PathTransition;

/**
 * @author Maxim Kolchin
 */
public abstract class Bullet extends Entity {

    public-init var start: Point2D;
    public-init var end: Point2D;
    public var velocity: Number;
    public-init var damage: Number;
    public var damageRadius: Number = 15;
    var timeline: Timeline;
    override var node:Node;

    init {
	reset();
    }

    public function hit() {
	for (creature in field.creatures) {
	    def target = creature.center();
	    if (end.distance(target) <= damageRadius) {
		creature.hit(damage);
		break;
	    }
	}
    }

    public function path(): Path {
	Path {
	    stroke: Color.GRAY
	    strokeWidth: 20
	    elements: [
		MoveTo { x: start.x, y: start.y }
		LineTo { x: end.x, y: end.y }
	    ]
	}
    }

    override function reset() {
	def p = path();

	translate(PathUtil.startPoint(p));

	timeline = PathTransition {
		    node: this
		    interpolator: Interpolator.LINEAR
		    path: AnimationPath.createFromPath(p)
		    orientation: OrientationType.ORTHOGONAL_TO_TANGENT
		    duration: duration(velocity, p)
		    action: function() {
			hit();
			destroy();
		    }
		};

	field.add(timeline);
	insert this into field.bullets;

    }

    override function destroy() {
	delete this from field.bullets;
	delete timeline from field.timelines;
    }

}
