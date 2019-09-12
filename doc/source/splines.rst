Kubiske spliner
================

.. note::
    Følgende eksempelkode antar at du har installert pakken *eksternlab* via

    `pip install eksternlab`


For å kunne løse Newtons ligninger for et rullende objekt på en vilkårlig bane,
trenger vi en matematisk beskrivelse av banen. Dvs. vi må kunne vite høyden til 
banen for en vilkårlig horisontal posisjon. Her gjør vi dette ved å spesifisere *x* og
*y*-koordinatene til et sett med punkter som vi vet at banen går gjennom. Videre
tilpasser vi såkalte *kubiske spliner* til disse punktene. La oss lagre de 
kjente punktene i to lister


>>> x = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2]
>>> y = [1.0, 0.6, 0.4, 0.3, 0.4, 0.7, 1.1]

Videre benytter vi funksjonen *height* til å tilbasse splinen

>>> from eksternlab import height
>>> import numpy as np
>>> h = height(x, y)

For å evaluere høyden for et gitt antall *x*-koordinater kan vi 

>>> x_interp = np.linspace(0.0, 1.0, 50)
>>> y_interp = h(x_interp)

Dersom vi ønsker å beregne hellningsvinkelen kan vi bruke funksjonen *slope*

>>> from eksternlab import slope
>>> alpha = slope(h, x_interp)

Videre kan vi finne krumningen til banen, som er lik den inverse
krumingsradiusen, som følger

>>> from eksternlab import curvature
>>> kappa = curvature(h, x_interp)

.. automodule:: eksternlab.splines
    :members:

