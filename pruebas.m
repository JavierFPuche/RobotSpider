%% Paso 1: Crear el modelo
modelName = 'SpiderLegModel';
new_system(modelName);       % Crea un nuevo modelo
open_system(modelName);      % Lo abre
set_param(modelName, 'Solver', 'ode15s', 'StopTime', '5');  % Configura el solver

%% Paso 2: Añadir bloques base
% Mundo y primer segmento
add_block('sm_lib/Frames and Transforms/World Frame', [modelName '/World'], 'Position', [20, 100, 50, 130]);

% Segmento 1
add_block('sm_lib/Body Elements/Brick Solid', [modelName '/Segment1'], 'Position', [100, 100, 180, 180]);
set_param([modelName '/Segment1'], ...
    'BrickDimensions', '[0.03 0.005 0.005]', ...
    'Density', '2700');  % Aluminio
set_param([modelName '/Segment1'], 'DoExposeReferenceFrame', 'on');

% Joint1 y Segmento2
add_block('sm_lib/Joints/Revolute Joint', [modelName '/Joint1'], 'Position', [200, 100, 250, 150]);
add_block('sm_lib/Body Elements/Brick Solid', [modelName '/Segment2'], 'Position', [300, 100, 380, 180]);
set_param([modelName '/Segment2'], ...
    'BrickDimensions', '[0.03 0.005 0.005]', ...
    'Density', '2700');
set_param([modelName '/Segment2'], 'DoExposeReferenceFrame', 'on');


% Joint2 y Segmento3
add_block('sm_lib/Joints/Revolute Joint', [modelName '/Joint2'], 'Position', [400, 100, 450, 150]);
add_block('sm_lib/Body Elements/Brick Solid', [modelName '/Segment3'], 'Position', [500, 100, 580, 180]);
set_param([modelName '/Segment3'], ...
    'BrickDimensions', '[0.03 0.005 0.005]', ...
    'Density', '2700');
set_param([modelName '/Segment3'], 'DoExposeReferenceFrame', 'on');



% Joint3 y Segmento4
add_block('sm_lib/Joints/Revolute Joint', [modelName '/Joint3'], 'Position', [600, 100, 650, 150]);
add_block('sm_lib/Body Elements/Brick Solid', [modelName '/Segment4'], 'Position', [700, 100, 780, 180]);
set_param([modelName '/Segment4'], ...
    'BrickDimensions', '[0.03 0.005 0.005]', ...
    'Density', '2700');
set_param([modelName '/Segment4'], 'DoExposeReferenceFrame', 'on');


%% Paso 3: Conexiones
add_line(modelName, 'World/R','Segment1/R','autorouting','on');

add_line(modelName, 'Segment1/LConn','Joint1/B');
add_line(modelName, 'Joint1/F','Segment2/LConn');
add_line(modelName, 'Segment2/RConn','Joint2/B');
add_line(modelName, 'Joint2/F','Segment3/LConn');
add_line(modelName, 'Segment3/RConn','Joint3/B');
add_line(modelName, 'Joint3/F','Segment4/LConn');

%% Paso 4: Añadir muelles a cada articulación
for i = 1:3
    springName = sprintf('Spring%d', i);
    jointName = sprintf('Joint%d', i);
    posX = 200 + (i-1)*200;
    
    add_block('simscape/Foundation/Mechanical/Rotational Elements/Rotational Spring', ...
              [modelName '/' springName], ...
              'Position', [posX, 200, posX+50, 250]);
    set_param([modelName '/' springName], 'SpringRate', '0.05');  % Nm/rad
end
