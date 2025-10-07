% Persim: 90s grow, 90s mutate (180s total)
% Chesto: 40s grow, 40s mutate (80s total)

var int: t_persim;  % When to plant Persim (in seconds)
var int: t_chesto;  % When to plant Chesto (in seconds)

% Persim mutation window: [t_persim + 90, t_persim + 180]
var int: persim_mutate_start = t_persim + 90;
var int: persim_mutate_end = t_persim + 180;

% Chesto mutation window: [t_chesto + 40, t_chesto + 80]
var int: chesto_mutate_start = t_chesto + 40;
var int: chesto_mutate_end = t_chesto + 80;

% Calculate overlap of mutation windows
var int: overlap_start = max(persim_mutate_start, chesto_mutate_start);
var int: overlap_end = min(persim_mutate_end, chesto_mutate_end);
var int: overlap = max(0, overlap_end - overlap_start);

% Reasonable bounds on planting times
constraint t_persim >= 0;
constraint t_chesto >= 0;
constraint t_persim <= 1000;
constraint t_chesto <= 1000;

solve maximize overlap;

output [
  "t_persim = ", show(t_persim), ";\n",
  "t_chesto = ", show(t_chesto), ";\n",
  "Persim mutation window: [", show(persim_mutate_start), ", ", show(persim_mutate_end), "]\n",
  "Chesto mutation window: [", show(chesto_mutate_start), ", ", show(chesto_mutate_end), "]\n",
  "Overlap duration: ", show(overlap), " seconds\n"
];
