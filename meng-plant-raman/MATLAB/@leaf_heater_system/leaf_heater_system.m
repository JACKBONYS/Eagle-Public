classdef leaf_heater_system
    % A leaf heater control system consisting of a leaf-heater temp. sensor PCB and a Keysight B2902A sourcemeter
    
    properties
        sourcemeter_obj
        temp_sensor_obj
        
        % Control loop settings
        temp_setpoint = 40;
        control_loop_period = 0.1;
        timer = timer();
        hysteresis_max = 1;
        hysteresis_min = -1;
        saturation_max = 2;
        saturation_min = 0;
        gain_P
        gain_D
    end
    
    methods
        function obj = leaf_heater_system( sourcemeter_addr, temp_sensor_index )
            %
            temp_sensor_open_serial( obj, temp_sensor_index );
        end
        
        function delete( obj )
            fclose( obj.sourcemeter_obj );
            fclose( obj.temp_sensor_obj );
        end
        
        temp_sensor_open_serial( obj, temp_index )
        sourcemeter_open_gpib( obj, sourcemeter_addr )
        
        start_control_loop( obj )
        stop_control_loop( obj )
        
        temp_sensor_get_temp( obj )
        
        sourcemeter_set_current( obj, current_setpoint )
        sourcemeter_set_voltage( obj, voltage_setpoint )
        current_measurement = sourcemeter_get_current( obj )
        voltage_measurement = sourcemeter_get_voltage( obj )
        
        control_loop_callback( obj )
    end
end

