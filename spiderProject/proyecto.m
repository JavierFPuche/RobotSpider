% Modelo básico de una pata con una articulación controlada por presión

open_system(new_system('SpiderLeg'))

% Añadir bloques:
add_block('simscape/Foundation/Mechanical/Rotational Elements/Rotational Spring','SpiderLeg/Spring')
add_block('simscape/Foundation/Mechanical/Rotational Elements/Revolute Joint','SpiderLeg/Joint')
add_block('simscape/Foundation/Physical Signals/Sources/PS Constant','SpiderLeg/Spring_Stiffness')
add_block('simscape/Foundation/Mechanical/Translational Elements/Ideal Hydraulic Force Source','SpiderLeg/HydraulicActuator')
% Puedes seguir añadiendo elementos desde la librería Simscape

% Luego conecta las partes con líneas y parámetros personalizados
