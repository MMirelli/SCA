### README

If you wish to add new random noise of a given trace run 

```
add_new_rand_noise(path_to_trace_string);
```
This will save the new noised trace *nt* in ```data.mat```, data used for presentation is saved in ```backup.mat```.

---
**NOTE**

If you have run the previous command and want to test, the original case shown in  *w_exp_analysis_presentation-Mirelli*, just run

``` 
clear
load('backup.mat')
save('output.mat', 'output')
clear output
save('data.mat')
clear
```
---

To get the best DWT parameters to de-noise the initial signal run, it will take a long time to process it

```
output = get_the_best_dwt_params();
``` 
This will be the output

```
output = [WNAME, lev, THR_i, THR_METH_i, RESC_i]
```

To interpret it run:

```
load('data.mat')

num_output = arrayfun(@(x) str2num(x), (output(3:end)));

fprintf('\nThe best params are: \nWavelet: %s;\nlevel: %s;\nthreshold: %s;\nthreshold method: %s;\nrescaling: %s.\n\n',...
	output(1:2), TPTR_TYPES(num_output(1)),...
	SORH(num_output(2)),SCAL(num_output(3)));
```
In order to plot the de-noised signal using ```wden``` with the computed parameters:

```
plot_denoised_signal(output);
```

To plot the 3d plot use

```
output2 = [output(1), output(4:5)];
plot_by_level_and_threshold(output2);
```
