% ορίζουμε σχέση component
component(computer, [power_supply, monitor, motherboard, cpu, ram]).
component(power_supply, [cable, fan, wire, core]).
component(monitor, [screen, power_cable, buttons]).
component(motherboard, [cpu_slot, ram_slots, power_connector]).


% ορίζουμε σχέση material
material(cable, metal).
material(fan, plastic).
material(screen, plastic).
material(buttons, plastic).
material(wire, metal).
material(core, metal).

% δημιουργούμε την find_components 
find_components(Component, [Component]) :-
    \+ component(Component, _).  

find_components(Component, [Component | Subcomponents]) :-
    component(Component, DirectSubcomponents),
    find_all_subcomponents(DirectSubcomponents, Subcomponents).

find_all_subcomponents([], []).
find_all_subcomponents([H|T], Components) :-
    find_components(H, Subs),
    find_all_subcomponents(T, More),
    append(Subs, More, Components).

% για να βρούμε τα συστατικά με συγκεκριμένο υλικό.
components_with_material(Material, Components) :-
    findall(Component, (material(Component, Material)), Components).


% Επιστρέφει το σύνολο των συστατικών.
count_all_components(Object, Count) :-
    find_components(Object, Components),
    length(Components, Count).