enum PlotState = {EMPTY, FIGY, WIKI, AGUAV, BUSY, POISON};
set of int: BUSY_PLOTS = {0, 4, 20, 24, 6, 13};
set of int: POISON_PLOTS = {-1};

array[0..4, 0..4] of var PlotState: farm;

constraint forall(y in 0..4, x in 0..4)(
    ((y*5 + x) in BUSY_PLOTS <-> farm[y,x] = BUSY) /\
    ((y*5 + x) in POISON_PLOTS <-> farm[y,x] = POISON)
);

array[0..4, 0..4] of var bool: is_mutation;

constraint forall(y in 0..4, x in 0..4)(
  is_mutation[y,x] <-> (
    farm[y, x] = EMPTY /\

    sum(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = FIGY 
    ) = 1 /\

    sum(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = WIKI 
    ) = 1 /\

    sum(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = AGUAV
    ) = 1 /\

    sum(yOffset in -1..1, xOffset in -1..1 
      where not(yOffset = 0 /\ xOffset = 0) /\
            (x + xOffset in 0..4) /\
            (y + yOffset in 0..4)
    )(
      farm[y + yOffset, x + xOffset] = POISON
    ) = 0
  )
);

var int: num_mutations = sum(is_mutation);
solve maximize num_mutations;
output [
  "farm = ", show2d(farm), ";\n",
  "num_mutations = \(num_mutations);\n",
];
