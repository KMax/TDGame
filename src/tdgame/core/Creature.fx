package tdgame.core;

import javafx.animation.Timeline;
import javafx.scene.shape.Path;
import javafx.animation.transition.PathTransition;
import javafx.animation.transition.AnimationPath;
import tdgame.util.PathUtil;
import javafx.animation.Interpolator;
import javafx.animation.transition.OrientationType;
import javafx.geometry.Point2D;

/**
 * Класс описывающий параметры существ
 * @author Maxim Kolchin
 */
public abstract class Creature extends Entity {

    public var energy: Number;
    public var speed: Number;
    public var wave: Wave;
    public var path: Path;
    public var timeline: Timeline;

    override function reset(): Void {
	timeline = PathTransition {
		    orientation: OrientationType.ORTHOGONAL_TO_TANGENT
		    duration: duration(speed, PathUtil.distance(path))
		    node: this
		    path: AnimationPath.createFromPath(path)
		    action: function() {
			field.killMan();
			destroy();
		    }
		    interpolator: Interpolator.LINEAR
		}

	translate(PathUtil.startPoint(path));
	insert this into field.creatures;
	field.add(timeline);
    //java.lang.System.out.println("побежал");
    }

    public function center():Point2D {
	this.localToParent(Point2D {
	    x: node.boundsInLocal.minX + node.boundsInLocal.width / 2
	    y: node.boundsInLocal.minY + node.boundsInLocal.height / 2
	})
    }

    public function hit(damage: Number) {
	destroy();
    }

    override function destroy() {
	delete this from field.creatures;
	delete this from wave.monsters;
	delete this.timeline from field.timelines;
	java.lang.System.out.println("Уничтожен");
    }

    /*
     * Функция возвращает время, за которое объект пройдет расстояние - distance
     * со скоростью - speed * 0.0125.
     */
    protected function duration(speed: Number, distance: Number): Duration {
	Duration.valueOf(distance / (speed * 0.0125));
    }

}
