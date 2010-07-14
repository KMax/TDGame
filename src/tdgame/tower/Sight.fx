package tdgame.tower;

import javafx.scene.CustomNode;
import javafx.scene.layout.Stack;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.geometry.Bounds;
import tdgame.core.Field;
import javafx.geometry.BoundingBox;
import javafx.scene.Group;
import javafx.scene.shape.Line;

/**
 * @author Maxim Kolchin
 */
public class Sight extends CustomNode {

    public-init var field: Field;
    public-init var smallRadius: Number;
    public-init var bigRadius: Number;
    public var centerX: Number;
    public var centerY: Number;
    var b: Bounds = bind BoundingBox {
		height: smallRadius * 2;
		width: smallRadius * 2;
		minX: centerX - smallRadius;
		minY: centerY - smallRadius;
	    }

    override function create() {
	Stack {
	    translateX: bind centerX - bigRadius;
	    translateY: bind centerY - bigRadius;
	    content: bind [
		Circle {
		    opacity: 0.1
		    stroke: Color.BLACK
		    strokeWidth: 2
		    radius: bigRadius
		    fill: Color.GREEN
		},
		if (canTowerAdd()) {
		    Circle {
			id: "allow"
			opacity: 0.5
			fill: Color.GREEN
			radius: smallRadius
		    }
		} else {
		    def c = smallRadius *0.55;
		    Group {
			id: "notAllow"
			content: [
			    Circle {
				opacity: 0.5
				fill: Color.RED
				radius: smallRadius
			    },
			    Circle {
				opacity: 1
				stroke: Color.RED
				strokeWidth: 2
				radius: smallRadius - 4
				fill: Color.TRANSPARENT
			    },
			    Line {
				opacity: 1
				startX: -c, startY: c
				endX: c, endY: -c
				strokeWidth: 2
				stroke: Color.RED
			    }
			]
		    }
		}
	    ]
	}
    }

    function canTowerAdd(): Boolean {
	return field.canAddHere(field.parentToLocal(b));
    }

    public function isAddingAllowed(): Boolean {
	return canTowerAdd();
    }

}
