% shi% memory-friendly mesh filtering Code  50s
function [newobj,newFaceCentroid,newFaceNormals,newVertex] = meshFiltering_zip(obj)

% obj = readObj_2('Eurogress_0001.obj');

%%  Face normals

[~,~,Fa,Fb,Fc,~]=patchnormals(obj);
vertex = obj.v;   % set of vertices
face = obj.f.v;   % 3 vertices of 1 face

nface = size(face,1);
nvert = size(vertex,1);


%% find centroid of a triangle face and initial normal of a triangle face
FaceCentroid = zeros(nface,3);
FNormal = zeros(nface,3);
FaceNormals = zeros(nface,3);
onetriangle = zeros(nface,3);
for i = 1:nface
    pointone = vertex(Fa(i,:),:);
    pointtwo = vertex(Fb(i,:),:);
    pointthree = vertex(Fc(i,:),:);
    FaceCentroid(i,:)=(pointone + pointtwo + pointthree) / 3;   % centroid of a triangle face

    e1 = pointone - pointtwo;
    e2 = pointtwo - pointthree;
    e3 = pointthree - pointone;
    FNormal(i,:) = cross(e1,e3);
    FaceNormals(i,:) = FNormal(i,:)/norm(FNormal(i,:),2);   % initial normal of a triangle face

    e1norm = norm(e1);
    e2norm = norm(e2);
    e3norm = norm(e3);
    onetriangle(i,:) = e1norm + e2norm + e3norm;    % peimeter of one triangle, used for calculating Alpha
end
clear pointone pointtwo pointthree e1 e2 e3 e1norm e2norm e3norm;

%% Face normal bilateral filtering - refine the normal orientations
% spatial distance-based weights alpha & normal proximity-based weights belta
% compute the filtered normal of face fi(new surface normal & a weighted average of its neighbors)

EdgesLength = sum(onetriangle,'all')/2;
nEdeges = nvert + nface - 2;   % Euler's polyhedron formula: V-E+F=2
sigma = EdgesLength/nEdeges;   % average edge length

p = zeros(nface,3);
alpha = zeros(nface,1);
belta = zeros(nface,1);
newFaceNormals = zeros(nface,3);
theta = 20;
NeighborFaces = zeros(nface,1);
for i = 1: nface 
    a = FaceCentroid(i,:);
    b = FaceNormals(i,:);
    e = FNormal(i,:);
    for j = 1:nface
        c = FaceCentroid(j,:);
        d = FaceNormals(j,:);
           FaceDistance = norm( a - c) ;
           % check if facei neighbor facej
           if Fa(i) == Fa(j) || Fa(i) == Fb(j) || Fa(i) == Fc(j) || Fb(i) == Fa(j) || Fb(i) == Fb(j) || Fb(i) == Fc(j) || Fc(i) == Fa(j) || Fc(i) == Fb(j) || Fc(i) == Fc(j)  % 要求1
               if dot(b,d) > cos(theta)   
                NeighborFaces(j) = 1;        % face i and face j are neighborfaces
               end
           end

             alpha(j,1) = exp(-(FaceDistance.^2)/(2*sigma^2));
             belta(j,1) = exp(-norm(1-dot(b,d)) ^2  /  (1-cos(theta))^2);
             
             % activate alpha/belta/alpha_with_belta
             p(j,:) = norm(e)/2*alpha(j)*NeighborFaces(j) * d;          %FaceArea = norm(FNormal(i,:))/2 = norm(e)/2
             %p(j,:) = norm(e)/2*belta(j)*NeighborFaces(j) .* d;
             %p(j,:)= norm(e)/2*alpha*belta*NeighborFaces(j) .* d;

             NeighborFaces = zeros(nface,1);
    end
    ith_face_newvector_origversion = sum(p);
    newFaceNormals(i,:) = ith_face_newvector_origversion./norm(ith_face_newvector_origversion);  % new surface normal & a weighted average of its neighbors
end
%% vertex position update
q = zeros(nface,3);
ith_vertex = zeros(nvert,3);
delta_of_vertex_i = zeros(nvert,3);
newVertex = zeros(nvert,3);
for i = 1:nvert
    nVertNeighbourfaces = 0;
    for j = 1:nface  % check whether jth-face has vi
        if face(j,1) == i || face(j,2) == i || face(j,3) == i
            nVertNeighbourfaces = nVertNeighbourfaces + 1 ; % the number of neighbouring faces of vertex vi
            q(j,:) = (FaceCentroid(j,:) - vertex(i,:)) .* newFaceNormals(j,:) .* FaceNormals(j,:);
        end
    end
    ith_vertex(i,:) = sum(q);
    q = zeros(nface,3);
    delta_of_vertex_i(i,:) = ith_vertex(i,:)./nVertNeighbourfaces;   % vertex displacement value
    newVertex(i,:) = vertex(i,:) + delta_of_vertex_i(i,:);   % vertex update
    norm_delta = sqrt(delta_of_vertex_i(:,1).^2+delta_of_vertex_i(:,2).^2+delta_of_vertex_i(:,3).^2);
end
% clear ith_vertex;
% for bar graph of vertices change
for i = 1:nvert
    for j = 1:nvert
        if(norm_delta(i)>norm_delta(j))
            change = norm_delta(j);
            norm_delta(j)=norm_delta(i);
            norm_delta(i)=change;
        end
    end
end

%% display new simplified model with face normals

% find centroid of new faces
newFaceCentroid = zeros(nface,3);
for i = 1:nface
    pointone = newVertex(face(i,1),:);
    pointtwo = newVertex(face(i,2),:);
    pointthree = newVertex(face(i,3),:);
    newFaceCentroid(i,:)=(pointone + pointtwo + pointthree) /3;
end
clear pointone pointtwo pointthree;


newobj.v = newVertex;  
newobj.f.v = face;  % newFace = face;
newobj.norm_delta = norm_delta;