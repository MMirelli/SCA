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
save('data.mat')
save('best_DWT_param.mat', 'best'); 
```
---

To get the best DWT parameters to de-noise the initial signal run 

```
get_the_best_dwt_params()
``` 
This will be the output

```
output = [WNAME, lev, THR_i, THR_METH_i, RESC_i]
```

To interpret it run:

```
load('data.mat')
fprint('The best params are: \nWavelet: %s;\nlevel: %i\nthreshold: %s\n...'
	'threshold method: %s\nrescaling: %s',...
	output(1), output(2), TPTR_TYPES(output(3)),...
	SORH(output(4)),SCAL(output(5));
```
In order to plot the de-noised signal using ```wden``` with the computed parameters:

TODO: check
```
plot_denoised_signal(output); 
plot_denoised_signal(output(1:end));
plot_denoised_signal(output(1), ..., output(5)); 
```

To plot the 3d plot use

```
plot_by_level_and_threshold(output(1), output(4), output(5));
```
