enum PlotState = {EMPTY, FIGY, WIKI, AGUAV, BUSY};
set of int: BUSY_PLOTS = {0, 4, 20, 24, 6, 13};

array[0..4, 0..4] of var PlotState: farm;

constraint forall(y in 0..4, x in 0..4)(
    (y*5 + x) in BUSY_PLOTS <-> farm[y,x] = BUSY
);

array[0..4, 0..4] of var bool: is_mutation;

constraint forall(y in 0..4, x in 0..4)(
  is_mutation[y,x] <-> (
    farm[y, x] = EMPTY /\

    exists(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = FIGY 
    ) /\

    exists(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = WIKI 
    ) /\

    exists(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = AGUAV
    )
  )
);

var int: num_mutations = sum(is_mutation);
solve maximize num_mutations;
output [
  "farm = ", show2d(farm), ";\n",
  "num_mutations = \(num_mutations);\n",
];
