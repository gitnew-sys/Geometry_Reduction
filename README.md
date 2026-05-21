# Geometry_Reduction
Audio-visual experiences of modeled spaces play a key role when study
ing the human perception of the built environment, and the results
should give us an intuitive sense of the real situation. Acoustic models
need a low number of polygons in order to be simulated efficiently. It
is at the same time important to retain acoustic properties while sim
plification. But the reconstruction of existing architecture is usually
achieved by photogrammetry, which results in noisy and geometrically
complex 3D meshes. They must be post-processed to become suitable
for simulation.

Therefore, a mesh-filtering algorithm is analyzed that follows a
feature-preserving approach. This is expected to be an important step
before the mesh’s number of polygons can be reduced. The algorithm
has been implemented in Matlab. Two models serve as test scenarios, i.e.
a photogrammetry mesh of the Eurogress hall in Aachen, Germany and a generic
simple room. To evaluate the algorithm’s performance, first, the change
of geometrical shapes is inspected by means of the number of iterations
and selected filter weights. Secondly, geometrical acoustic simulation
is performed to analyze the filter’s impact on the acoustic simulation
result

The source of this implementation:
https://doi.org/10.1016/j.isprsjprs.2021.01.006

Models used:
https://drive.google.com/drive/folders/1wAxTnf281rQv_-BkdelPXRSXhPaC4wf6?usp=drive_link
