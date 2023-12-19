using Turing, Random, Distributions, DataFrames, CairoMakie, CSV
Random.seed!(722);

"""Characteristics of the Social Wefare problem"""
g = 0.5 # The 'protected income fraction' in the reference two-person problem'
γ = 1- 1/log(2,g)  # Implied Kolm-Atkinson inequality aversion parameter
# Egalitarian equivalent measure, ee(μ,σ,γ,P), when there are P zeros, the rest of the outcome variable is LogNormally distributed and the Social Welfare Function is Kolm-Atkinson
ee(μ,σ,γ,P) = (1-P)^(1/(1 - γ)) * exp(μ + 0.5 * (1 - γ ) * σ^2)

# Simulate data from the outcome distributions of the control and treatment groups
μ, τ, σ, P = 6, 0.1, 1.25, 0.25 # The DGP
N = 1000; ceros = round(Int, N * P) # The sample size, plus the number of 'zeros'
y₀ = rand(LogNormal(μ,σ), N - ceros); y₁ = rand(LogNormal(μ + τ, σ), N - ceros)
EE₀ = ee(μ,σ,γ,P)
EE₁ = ee(μ + τ,σ,γ,P)


"""Bayesian model"""
@model function outcome(Y₀, Y₁)
    # Assumptions
    scale = 10
    μ ~ Normal(0, scale); τ ~ Normal(0, scale); lσ ~ Normal(0,scale)
    # Observations
    Y₀ .~ filldist(LogNormal(μ, exp(lσ)), length(Y₀))
    Y₁ .~ filldist(LogNormal(μ + τ, exp(lσ)), length(Y₁))
    return Y₀, Y₁
end

# MCMC sampling
chain_outcome = sample(outcome(y₀ ,y₁), NUTS(0.65), 10000);
df = DataFrame(chain_outcome)

# Induced distribution on the egalitarian equivalent treatment effects
df.ee₀ = ee.(df.μ, exp.(df.lσ), γ, P)
df.ee₁ = ee.(df.μ + df.τ, exp.(df.lσ), γ, P)

# Plots
ff = Figure()
Axis(ff[1, 1],title = "Egalitarian Equivalent Posterior Densities")
d₀ = hist!(df.ee₀, label = "Control", bins = 30)
d₁ = hist!(df.ee₁, label = "Treatment", bins = 30)
axislegend()
ff
save("prototype.png", ff)

# Some summary statistics
df.diff = df.ee₁ - df.ee₀
mean(df.diff)
mean(df.ee₀)
mean(df.ee₁)
minimum(df.ee₀)
minimum(df.ee₁)
df.diff
count(>(0), df.diff)

CSV.write("MCMC_results.csv", df);


