function Ek = ecc_anom(SortedData, Mk)
e = SortedData(:,33);
En = Mk;
Ens = En - (En-e.*sin(En)-Mk)./(1-e.*cos(En));
while (abs(Ens-En) > 1e-12)
    En = Ens;
    Ens = En - ((En-e.*sin(En)-Mk)./(1-e.*cos(En)));
end
Ek = Ens;
end
