% This script takes calcium imaging data as input and returns the underlying neuronal connectome 04/06/2020

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             MAIN SCRIPT                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning ('off','all'); clear; clc; close all; 
path = genpath('subfunctions'); addpath(path); clear path;

%% INPUTS
INPUTS.ops = sp_deconv_inputs(); % Taking imaging rate and fluorescence decay rate as inputs

%% DATA
INPUTS.calcium = import_data(); % NN by NT (NN: number of neurons, NT: number of time frames)

%% Spike Deconvolution  
RESULTS.spikes_raw = sp_deconv(INPUTS.ops,INPUTS.calcium); % Non-negative deconvolution using Suite2P and OASIS packages

%% Spike Denoising
RESULTS.spikes_denoised = sp_denoise(RESULTS.spikes_raw); % Removing the noise present in deconvolved spikes using an optimal threshold

%% Spike Smoothing
RESULTS.spikes_smooth = sp_smooth(RESULTS.spikes_denoised); % Smoothing the spikes to improve the accuracy of connectome inference

%% Partial Correlation
RESULTS.partial_correlation = partial_corr(RESULTS.spikes_smooth); % Computing partial correlation using matrix inversion 

%% Network
[RESULTS.network,RESULTS.edges] = connectome_inf(RESULTS.partial_correlation); % Connectome Inference based on partial correlation coeff.

%% Circular Graph
circular_graph = circ_graph(RESULTS.network); % Circular graph of the inferred neuronal connectome

%% Graph with positions
pos_graph = graph_w_positions(RESULTS.network); % inferred neuronal connectome based on actual spatial arrangement of neurons 
                                                %(if distance/position information is available)
                                                
%% Network Dynamics
net_dyn(RESULTS.spikes_raw,RESULTS.partial_correlation);