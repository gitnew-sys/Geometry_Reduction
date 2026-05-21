clear;

% set iteration times
iteration_times = 15;

% import obj model
import  = readObj_2('Eurogress_0.0001.obj');
[N,FNormal,Fa,Fb,Fc,Fcenter]=patchnormals(import);
vertex = import.v;
face = import.f.v;
nface = size(face,1);
nvert = size(vertex,1);

%% iteration and display
for i = 1:iteration_times
    [export,newFaceCentroid,newFaceNormals,newVertex] = meshFiltering(import);
    import = export;
    if i==1||i==5||i==10||i==15
        % plot vertex displacements(norm_delta)
        figure;
        bar(export.norm_delta);
        axis manual;
        axis([0 nvert 0 export.norm_delta(1,1)]);
        title(sprintf('Changes in vertices as %d. iteration time(s)',i));

        % plot filtered model with face normal
        figure;
        imageplot(import.v,import.f.v);
        hold on
        quiver3(newFaceCentroid(:,1),newFaceCentroid(:,2),newFaceCentroid(:,3), ...
           newFaceNormals(:,1),newFaceNormals(:,2),newFaceNormals(:,3),1,'color','m');
        title(sprintf('Iteration time(b=1)=%d.',i));
    end
    clear export;
end

%% visulaize the filtered model
% vertface2obj(import.v,import.f.v,'Eurogress_0001_a=1.obj');