%% This is the application resource file (.app file) for the 'base'
%% application.
{application, tellstick_service,
[{description, "Tellstick to control switch and sensord " },
{vsn, "0.0.1" },
{modules, 
	  [tellstick_service_app,tellstick_service_sup,tellstick_service,mod_tellstick_service]},
{registered,[tellstick_service]},
{applications, [kernel,stdlib]},
{mod, {tellstick_service_app,[]}},
{start_phases, []}
]}.
