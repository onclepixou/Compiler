#!/usr/bin/env ruby

require 'p1788'
include P1788

require 'ez_intervals'
include EZ_INTERVALS
include EZ_ALGORITHMS

def c_expr1(box)

        x = box[0]
        y = box[1]

        _v0 = sub(x,1)
        _v1 = sqr(_v0)
        _v2 = sub(y,2)
        _v3 = sqr(_v2)
        _v4 = add(_v1,_v3)

        r2 = Interval.new(4,5)
        incl = _v4.subset_of? r2
        _v4 &= r2

        
        _v3 = add_rev(_v1,_v4,_v3)
        _v1 = add_rev(_v3,_v4,_v1)
        _v0 = sqr_rev(_v1,_v0)
        x = sub_rev1(1,_v0,x)
        _v2 = sqr_rev(_v3,_v2)
        y = sub_rev1(2,_v2,y)

        return IntervalVector[x, y], incl
end

def c_expr2(box)

    x = box[0]
    y = box[1]

    _v0 = sqr(x)
    _v1 = sqr(y)
    _v2 = add(_v0,_v1)
    _v3 = sin(_v2)
    _v4 = exp(x)
    _v5 = sqr(y)
    _v6 = add(_v4,_v5)
    _v7 = div(_v3,_v6)

    r2 = Interval.new(0.325, Float::INFINITY)
    incl = _v7.subset_of? r2
    _v7 &= r2

    
    _v3 = div_rev1(_v6,_v7,_v3)
    _v6 = mul_rev(_v3,_v7,_v6)
    _v2 = sin_rev(_v3,_v2)
    _v1 = add_rev(_v0,_v2,_v1)
    _v0 = add_rev(_v1,_v2,_v0)
    x = sqr_rev(_v0,x)
    y = sqr_rev(_v1,y)
    _v5 = add_rev(_v4,_v6,_v5)
    _v4 = add_rev(_v5,_v6,_v4)
    x = exp_rev(_v4,x)
    y = sqr_rev(_v5,y)

    return IntervalVector[x, y], incl
end

def c_expr3(box)

    x = box[0]
    y = box[1]

    _v0 = sub(y,5)
    _v1 = sub(x,4)
    _v2 = sqr(_v1)
    _v3 = sqr(y)
    _v4 = add(_v2,_v3)
    _v5 = sqrt(_v4)
    _v6 = mul(4,_v5)
    _v7 = cos(_v6)
    _v8 = mul(_v0,_v7)
    _v9 = sqr(x)
    _v10 = sqr(y)
    _v11 = add(_v9,_v10)
    _v12 = sqrt(_v11)
    _v13 = mul(2,_v12)
    _v14 = sin(_v13)
    _v15 = mul(x,_v14)
    _v16 = sub(_v8,_v15)

    r2 = Interval.new(0,Float::INFINITY)
    incl = _v16.subset_of? r2
    _v16 &= r2

    
    _v15 = add_rev(_v16,_v8,_v15)
    _v8 = sub_rev1(_v15,_v16,_v8)
    _v0 = mul_rev(_v7,_v8,_v0)
    _v7 = mul_rev(_v0,_v8,_v7)
    y = sub_rev1(5,_v0,y)
    _v6 = cos_rev(_v7,_v6)
    _v5 = mul_rev(4,_v6,_v5)
    _v4 = sqrt_rev(_v5,_v4)
    _v3 = add_rev(_v2,_v4,_v3)
    _v2 = add_rev(_v3,_v4,_v2)
    _v1 = sqr_rev(_v2,_v1)
    x = sub_rev1(4,_v1,x)
    y = sqr_rev(_v3,y)
    x = mul_rev(_v14,_v15,x)
    _v14 = mul_rev(x,_v15,_v14)
    _v13 = sin_rev(_v14,_v13)
    _v12 = mul_rev(2,_v13,_v12)
    _v11 = sqrt_rev(_v12,_v11)
    _v10 = add_rev(_v9,_v11,_v10)
    _v9 = add_rev(_v10,_v11,_v9)
    x = sqr_rev(_v9,x)
    y = sqr_rev(_v10,y)

    return IntervalVector[x, y], incl
end

def c_expr4(box)

    x = box[0]
    y = box[1]

    _v0 = mul(x,y)
    _v1 = exp(_v0)
    _v2 = sub(x,y)
    _v3 = sin(_v2)
    _v4 = sub(_v1,_v3)

    r2 = Interval.new(-0.2, 0.2)
    incl = _v4.subset_of? r2
    _v4 &= r2
    
    _v3 = add_rev(_v4,_v1,_v3)
    _v1 = sub_rev1(_v3,_v4,_v1)
    _v0 = exp_rev(_v1,_v0)
    x = mul_rev(y,_v0,x)
    y = mul_rev(x,_v0,y)
    _v2 = sin_rev(_v3,_v2)
    y = add_rev(_v2,x,y)
    x = sub_rev1(y,_v2,x)

    return IntervalVector[x, y], incl
end

initial_box = IntervalVector[Interval[-10, 10], Interval[-10, 10]]
bin, bon, ball = sivia(initial_box, 0.025) {|b| c_expr1(b)}
f = Figure.new(width: 1024, xlabel: 'x', ylabel: 'y', title: "Cexpr")
f.set_range initial_box
f.draw_boxes(ball, 'K[C]')
f.draw_boxes(bin,  'K[M]')
f.draw_boxes(bon,  'K[Y]')
f.write "expr1_contractor.png"


initial_box = IntervalVector[[-6, 2], [-3, 3]]
bin, bon, ball = sivia(initial_box, 0.05) {|b| c_expr2(b)}
f = Figure.new(width: 1024, xlabel: 'x', ylabel: 'y', title: "Cexpr")
f.set_range initial_box
f.draw_boxes(ball, 'K[C]')
f.draw_boxes(bin,  'K[M]')
f.draw_boxes(bon,  'K[Y]')
f.write "expr2_contractor.png"

#initial_box = IntervalVector[[-11, 11], [-11, 11]]
#bin, bon, ball = sivia(initial_box, 0.025) {|b| c_expr3(b)}
#f = Figure.new(width: 1024, xlabel: 'x', ylabel: 'y', title: "Cexpr")
#f.set_range initial_box
#f.draw_boxes(ball, 'K[C]')
#f.draw_boxes(bin,  'K[M]')
#f.draw_boxes(bon,  'K[Y]')
#f.write "expr3_contractor.png"

initial_box = IntervalVector[[-0.5, 3], [-3, 0.5]]
bin, bon, ball = sivia(initial_box, 0.02) {|b| c_expr4(b)}
f = Figure.new(width: 1024, xlabel: 'x', ylabel: 'y', title: "Cexpr")
f.set_range initial_box
f.draw_boxes(ball, 'K[C]')
f.draw_boxes(bin,  'K[M]')
f.draw_boxes(bon,  'K[Y]')
f.write "expr4_contractor.png"