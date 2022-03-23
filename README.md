# Interval Compiler
## Usage

To try forward backward generation run the following

    sample/./main.rb

example with expression  (x - 1)² + (y - 2)² 
Several steps are performed : 
> Generating expression tree

    Add VAR : 0
    ├─ Sqr VAR : 0
    │  └─ Sub VAR : 0
    │     ├─ Variable ID : x
    │     └─ Constant VALUE : 1
    └─ Sqr VAR : 0
       └─ Sub VAR : 0
          ├─ Variable ID : y
          └─ Constant VALUE : 2

>Intermediate variables marking

    Add VAR : 4
    ├─ Sqr VAR : 1
    │  └─ Sub VAR : 0
    │     ├─ Variable ID : x
    │     └─ Constant VALUE : 1
    └─ Sqr VAR : 3
       └─ Sub VAR : 2
          ├─ Variable ID : y
          └─ Constant VALUE : 2

>Forward operations

    _v0 = sub(x,1)
    _v1 = sqr(_v0)
    _v2 = sub(y,2)
    _v3 = sqr(_v2)
    _v4 = add(_v1,_v3)



> Backward operations

    _v3 = add_rev(_v1,_v4,_v3)
    _v1 = add_rev(_v3,_v4,_v1)
    _v0 = sqr_rev(_v1,_v0)
    x = sub_rev1(1,_v0,x)
    _v2 = sqr_rev(_v3,_v2)
    y = sub_rev1(2,_v2,y)