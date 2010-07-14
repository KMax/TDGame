package tdgame.tower;

import tdgame.core.Bullet;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;

/**
 * @author Maxim Kolchin
 */
public class gunBullet extends Bullet {

    override var velocity: Number = 20.0;

    override var node: Node  = Circle {
				fill:Color.BLACK
				radius: 5
			};
}
