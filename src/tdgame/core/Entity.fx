package tdgame.core;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.geometry.Point2D;
import javafx.scene.shape.Path;
import tdgame.util.PathUtil;

/**
 * @author Maxim Kolchin
 */
public abstract class Entity extends CustomNode {

    public var name: String;
    public var node: Node;
    public var field: Field;
    def DURATION = 80ms;

    override function create() {
	Group {
	    content: node
	}
    }

    public abstract function reset(): Void;

    public abstract function destroy(): Void;

    public function translate(point: Point2D) {
	this.translateX = point.x;
	this.translateY = point.y;
    }

    protected function duration(velocity: Number, path: Path): Duration {
	DURATION.mul(PathUtil.distance(path) / velocity)
    }

}
