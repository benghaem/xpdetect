-module(xpdetect).

%% API exports
-export([fact/1, semifact/1,p_coeff/2, cheb_poly_coeff_mat/2, f/2]).
-define(DEBUG,true).

-include("debug.hrl").

%%====================================================================
%% API functions
%%====================================================================

studentpdf(X, Mu, Var, Nu) ->
    true.

%%====================================================================
%% Internal functions
%%====================================================================

fact(V) ->
    fact(V,1).
fact(0,Acc) ->
    1 * Acc;
fact(V,Acc) ->
    fact(V-1,Acc * V).

%even numbers
semifact(V) when V >= 0,  V rem 2 =:= 0 ->
    semifact(V,2);
semifact(V) when V >= 1, V rem 2 =/= 0 ->
    semifact(V,1);
semifact(-1) ->
    1.
semifact(0,_) ->
    1;
semifact(1,Acc) ->
    Acc;
semifact(2,Acc) ->
    Acc;
semifact(V,Acc) ->
    semifact(V-2, Acc*V).


p_coeff(K,G) ->
    p_coeff(K,G,0,K).

p_coeff(_K,_G,Acc,-1) ->
    Acc;
p_coeff(K,G,Acc,A) ->
    ?DBG("K,G,Acc,A ~p,~p,~p,~p~n",[K,G,Acc,A]),
    Ret = cheb_poly_coeff_mat(2*K + 1, 2*A+1) * f(G,A),
    p_coeff(K, G, Ret+Acc, A-1).

f(G,N) ->
    Numer = semifact(2*N - 1) * math:exp(N+G+1/2),
    Denom = math:pow(2,N) * math:pow(N+G+1/2, N+1/2),
    math:sqrt(2)/math:pi() * Numer/Denom.

cheb_poly_coeff_mat(1,1) ->
    1;
cheb_poly_coeff_mat(2,2) ->
    1;
cheb_poly_coeff_mat(I,1) ->
    -1*cheb_poly_coeff_mat(I-2,1);
cheb_poly_coeff_mat(I,J) when I =:= J ->
    2*cheb_poly_coeff_mat(I-1,J-1);
cheb_poly_coeff_mat(I,J) when I > J ->
    2*cheb_poly_coeff_mat(I-1,J-1) - cheb_poly_coeff_mat(I-2,J).



