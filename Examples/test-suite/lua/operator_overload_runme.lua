-- demo of lua swig capacilities (operator overloading)
require("import")	-- the import fn
import("operator_overload")	-- import lib

for k,v in pairs(operator_overload) do _G[k]=v end -- move to global

-- first check all the operators are implemented correctly from pure C++ code
Op_sanity_check()

-- catching undefined variables
setmetatable(getfenv(),{__index=function (t,i) error("undefined global variable `"..i.."'",2) end})

-- test routine:
a=Op()
b=Op(5)
c=Op(b) -- copy construct
d=Op(2)
dd=d; -- assignment operator

-- test equality
assert(a~=b)
assert(b==c)
assert(a~=d)
assert(d==dd)

-- test <
assert(a<b)
assert(a<=b)
assert(b<=c)
assert(b>=c)
assert(b>d)
assert(b>=d)

-- lua does not support += operators: skiping

-- test +
f=Op(1)
g=Op(1)
assert(f+g==Op(2))
assert(f-g==Op(0))
assert(f*g==Op(1))
assert(f/g==Op(1))
--assert(f%g==Op(0))	-- lua does not support %

-- test unary operators
--assert((not a)==true) -- lua does not allow overloading for not operator
--assert((not b)==false) -- lua does not allow overloading for not operator
assert(-a==a)
assert(-b==Op(-5))

-- test []
h=Op(3)
assert(h[0]==3)
assert(h[1]==0)
h[0]=2	-- set
assert(h[0]==2)
h[1]=2	-- ignored
assert(h[0]==2)
assert(h[1]==0)

-- test ()
i=Op(3)
assert(i()==3)
assert(i(1)==4)
assert(i(1,2)==6)

-- plus add some code to check the __str__ fn
assert(tostring(Op(1))=="Op(1)")
assert(tostring(Op(-3))=="Op(-3)")

--[[
/* Sample test code in C++

#include <assert.h>
#include <stdio.h>

int main(int argc,char** argv)
{
	// test routine:
	Op a;
	Op b=5;
	Op c=b;	// copy construct
	Op d=2;

	// test equality
	assert(a!=b);
	assert(b==c);
	assert(a!=d);

	// test <
	assert(a<b);
	assert(a<=b);
	assert(b<=c);
	assert(b>=c);
	assert(b>d);
	assert(b>=d);

	// test +=
	Op e=3;
	e+=d;
	assert(e==b);
	e-=c;
	assert(e==a);
	e=Op(1);
	e*=b;
	assert(e==c);
	e/=d;
	assert(e==d);
	e%=c;
	assert(e==d);

	// test +
	Op f(1),g(1);
	assert(f+g==Op(2));
	assert(f-g==Op(0));
	assert(f*g==Op(1));
	assert(f/g==Op(1));
	assert(f%g==Op(0));

	// test unary operators
	assert(!a==true);
	assert(!b==false);
	assert(-a==a);
	assert(-b==Op(-5));

	// test []
	Op h=3;
	assert(h[0]==3);
	assert(h[1]==0);
	h[0]=2;	// set
	assert(h[0]==2);
	h[1]=2;	// ignored
	assert(h[0]==2);
	assert(h[1]==0);

	// test ()
	Op i=3;
	assert(i()==3);
	assert(i(1)==4);
	assert(i(1,2)==6);

	// plus add some code to check the __str__ fn
	//assert(str(Op(1))=="Op(1)");
	//assert(str(Op(-3))=="Op(-3)");

	printf("ok\n");
}
*/
]]
