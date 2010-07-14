package tdgame.tower;

import tdgame.core.Tower;
import javafx.scene.Node;
import tdgame.resource.Resources;
import javafx.geometry.Point2D;

/**
 * @author Maxim Kolchin
 */
public class Gun extends Tower {

    override var fireRadius: Number = 100;
    override var fireRate: Duration = 2s;
    override var firePower: Number = 10;
    override var towerRadius: Number = 20;
    override var cost: Number = 5;
    override var node: Node = Resources.getImage("gun");

    override function fire(start: Point2D, end: Point2D) {
	gunBullet { field: field, damage: firePower start: start, end: end };
    }

}
