# Welcome!

This is companion code to the proposed JuliaCon 2024 talk **Inequality-Sensitive Treatment Effect Estimation in Julia.**

The purpose of the proposed talk is to present a novel statistical framework for analyzing the distributional impacts of social science experiments and policy interventions. I investigate how to bring notions of inequality aversion into the analysis of randomized controlled trials and show, using experimental data from [Meager 2022's Bayesian meta study] (https://www.aeaweb.org/articles?id=10.1257/aer.20181811) on the effect of microcredit interventions on consumption from five countries, how my methods compare to the standard comparisons based on differences in means.

The `simulating_and_analyzing_using_Turing.jl` file tests the methodology I develop on simulated data using Julia 1.9 and Turing 0.29.

The `analyzing_imported_MCMC_draws.jl` file takes [Meager 2022's   MCMC output] (https://github.com/rmeager/aggregating-dist-TEs/blob/main/output/microcredit_consumption_lognormal_tailored_hierarchical_pdf_output_5000_iters.RData) and uses it to provide `egalitarian equivalent treatment effect` estimates for the microcredit interventions in the five countries.

The notion of `egalitarian equivalent treatment effect` is the main conceptual innovation of the talk. In practice, one obtains the egalitarian equivalent of an income distribution by multiplying the mean income in the distribution by (1-**A**), where **A** is a suitably defined [Atkinson inequality index](https://en.wikipedia.org/wiki/Atkinson_index). Any such index is equal to zero when there is no inequality and is equal to 1 in a perfectly unequal society. When evaluating treatments from this point of view one can therefore decompose the changes in welfare given a certain treatment or policy into the changes that are due to the effects of the treatment on mean income, and the changes that are due to the effect of the treatment on inequality.


