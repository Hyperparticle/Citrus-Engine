/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

package Box2D.Common.Math{

	


/**
* A column vector with 2 elements.
*/

public class b2Vec2
{
	/**
	 * Default constructor to set the coordinates of a vector.
	 */
	public function b2Vec2(x_:Number=0, y_:Number=0) : void {x=x_; y=y_;};

	/**
	 * Sets this vector to all zeros
	 */
	public function SetZero() : void { x = 0.0; y = 0.0; }
	
	/**
	 * Set this vector to some specified coordinates.
	 */
	public function Set(x_:Number=0, y_:Number=0) : void {x=x_; y=y_;};
	
	/**
	 * Copies the values of the vector into this one.
	 */
	public function SetV(v:b2Vec2) : void {x=v.x; y=v.y;};

	/**
	 * Returns a negative (antiparallel) vector. Original vector is unchanged.
	 */
	public function GetNegative():b2Vec2 { return new b2Vec2(-x, -y); }
	
	/**
	 *  Transforms to a negative (antiparallel) vector.
	 */
	public function NegativeSelf():void { x = -x; y = -y; }
	
	/**
	 * Same as calling the constructor.
	 */
	static public function Make(x_:Number, y_:Number):b2Vec2
	{
		return new b2Vec2(x_, y_);
	}
	
	/**
	 * Returns a copy of the vector. Useful for encapsulation.
	 */
	public function Copy():b2Vec2{
		return new b2Vec2(x,y);
	}
	
	/**
	 * Adds two vectors together. 
	 * [a, b] + [c, d] = [a+c, b+d]
	 */
	public function Add(v:b2Vec2) : void
	{
		x += v.x; y += v.y;
	}
	
	/**
	 * Subtracts a vector from this vector.
	 * [a, b] - [c, d] = [a-c, b-d]
	 */
	public function Subtract(v:b2Vec2) : void
	{
		x -= v.x; y -= v.y;
	}

	/**
	 * Multiplies the vector by a scalar.
	 * c[a, b] = [ca, cb]
	 */
	public function Multiply(a:Number) : void
	{
		x *= a; y *= a;
	}
	
	/**
	 * Multiplies this vector by a 2x2 matrix.
	 */
	public function MulM(A:b2Mat22) : void
	{
		var tX:Number = x;
		x = A.col1.x * tX + A.col2.x * y;
		y = A.col1.y * tX + A.col2.y * y;
	}
	
	/**
	 * Takes the dot product of the vector with a 2x2 matrix.
	 */
	public function MulTM(A:b2Mat22) : void
	{
		var tX:Number = b2Math.Dot(this, A.col1);
		y = b2Math.Dot(this, A.col2);
		x = tX;
	}
	
	/**
	 * Cross product between a vector and a float (Number)
	 */
	public function CrossVF(s:Number) : void
	{
		var tX:Number = x;
		x = s * y;
		y = -s * tX;
	}
	
	/**
	 * Cross product between a float (Number) and a vector
	 */
	public function CrossFV(s:Number) : void
	{
		var tX:Number = x;
		x = -s * y;
		y = s * tX;
	}
	
	/**
	 * Takes the minimum between the coresponding coordinates.
	 */
	public function MinV(b:b2Vec2) : void
	{
		x = x < b.x ? x : b.x;
		y = y < b.y ? y : b.y;
	}
	
	/**
	 * Takes the maximum of both coordinates.
	 */
	public function MaxV(b:b2Vec2) : void
	{
		x = x > b.x ? x : b.x;
		y = y > b.y ? y : b.y;
	}
	
	/**
	 * Makes both coordinates positive.
	 */
	public function Abs() : void
	{
		if (x < 0) x = -x;
		if (y < 0) y = -y;
	}

	/**
	 * Gets the length (magnitude) of this vector.
	 */
	public function Length():Number
	{
		return Math.sqrt(x * x + y * y);
	}
	
	/**
	 * Gets the length (magnitude) squared of this vector.
	 * For performance, use this instead of squaring Length() (if possible).
	 */
	public function LengthSquared():Number
	{
		return (x * x + y * y);
	}

	/**
	 * Converts this vector to a unit vector.
	 * @return the length of this vector
	 */
	public function Normalize():Number
	{
		var length:Number = Math.sqrt(x * x + y * y);
		if (length < Number.MIN_VALUE)
		{
			return 0.0;
		}
		var invLength:Number = 1.0 / length;
		x *= invLength;
		y *= invLength;
		
		return length;
	}

	/**
	 * Makes sure both coordinates are neither NaN nor infinity.
	 */
	public function IsValid():Boolean
	{
		return b2Math.IsValid(x) && b2Math.IsValid(y);
	}
	
	public var x:Number;
	public var y:Number;
};

}