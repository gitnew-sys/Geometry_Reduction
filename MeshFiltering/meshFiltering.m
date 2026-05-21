% memory-friendly mesh filtering Code
function [newobj,newFaceCentroid,newFaceNormals,newVertex] = meshFiltering(obj)

% obj = readObj_2('Eurogress_0001.obj');

%%  Face normals

[~,~,Fa,Fb,Fc,~]=patchnormals(obj);
vertex = obj.v;   % set of vertices
face = obj.f.v;   % 3 vertices of 1 face

nface = size(face,1);
nvert = size(vertex,1);

% find centroid of a triangle face and initial normal of a triangle face
pointone = zeros(nface,3);
pointtwo = zeros(nface,3);
pointthree = zeros(nface,3);
FaceCentroid = zeros(nface,3);
e1 = zeros(nface,3);
e2 = zeros(nface,3);
e3 = zeros(nface,3);
FNormal = zeros(nface,3);
FaceNormals = zeros(nface,3);
e1norm = zeros(nface,3);
e2norm = zeros(nface,3);
e3norm = zeros(nface,3);
onetriangle = zeros(nface,3);
for i = 1:nface
    pointone(i,:) = vertex(Fa(i,:),:);
    pointtwo(i,:) = vertex(Fb(i,:),:);
    pointthree(i,:) = vertex(Fc(i,:),:);
    FaceCentroid(i,:)=(pointone(i,:) + pointtwo(i,:) + pointthree(i,:)) / 3;   % centroid of a triangle face

    e1(i,:) = pointone(i,:) - pointtwo(i,:);
    e2(i,:) = pointtwo(i,:) - pointthree(i,:);
    e3(i,:) = pointthree(i,:) - pointone(i,:);
    FNormal(i,:) = cross(e1(i,:),e3(i,:));
    FaceNormals(i,:) = FNormal(i,:)/norm(FNormal(i,:),2);   % initial normal of a triangle face

    e1norm(i,:) = norm(e1(i,:));
    e2norm(i,:) = norm(e2(i,:));
    e3norm(i,:) = norm(e3(i,:));
    onetriangle(i,:) = e1norm(i,:) + e2norm(i,:) + e3norm(i,:);    % peimeter of one triangle, used for calculating Alpha
end

%% spatial distance-based weights alpha & normal proximity-based weights belta
FaceDistance = zeros(nface,nface);
belta = zeros(nface,nface);
NeighborFaces = zeros(nface,nface);
non_Neighborfaces = zeros(nface,nface);
theta = 20;
for i = 1: nface 
    for j = 1:nface
        FaceDistance(i,j) = norm(FaceCentroid(i) - FaceCentroid(j)) ;
        belta(i,j) = exp(-   norm(1-dot(FaceNormals(i,:),FaceNormals(j,:))) ^2  /  (1-cos(theta))^2    ); % belta
% find neighborhood set of face
        if Fa(i) == Fa(j) || Fa(i) == Fb(j) || Fa(i) == Fc(j) || Fb(i) == Fa(j) || Fb(i) == Fb(j) || Fb(i) == Fc(j) || Fc(i) == Fa(j) || Fc(i) == Fb(j) || Fc(i) == Fc(j)  % 要求1
            if dot(FaceNormals(i,:),FaceNormals(j,:)) > cos(theta)   
                NeighborFaces(i,j) = j;        % neighborhood set of face_i (include face_i) : the j-th face be saved in this matrix
            end
        else
            non_Neighborfaces(i,j) = j;
        end

    end
end

nEdeges = nvert + nface - 2;   % Euler's polyhedron formula: V-E+F=2

EdgesLength = sum(onetriangle,'all')/2;
sigma = EdgesLength/nEdeges;   % average edge length
alpha = exp(-(FaceDistance.^2)/(2*sigma^2));  % alpha

n = (NeighborFaces ~= 0);
nNeighborFaces = zeros(nface,1);
FaceArea = zeros(1,nface);
for i = 1:nface
    nNeighborFaces(i) = sum(n(i,:));  % i-th face has nNeighborFaces neighborfaces
    FaceArea(1,i) = norm(FNormal(i,:))/2;   % the area of the i-th face
end

%% compute the filtered normal of face fi(new surface normal & a weighted average of its neighbors)
p_chu = zeros(nface,nface);
p = zeros(nface,3);
ith_face_newvector_origversion = zeros(nface,3);
w_i = zeros(1,nface);
newFaceNormals = zeros(nface,3);
for i = 1:nface
    for j = 1:nface 
        %activate weights
%         p_chu(j,i) = FaceArea(i)*alpha(j,i)*belta(j,i)*NeighborFaces(j,i)/i; 
        p_chu(j,i) = FaceArea(i)*alpha(j,i)*NeighborFaces(j,i)/i;  % this line for checking impacts of weighting factors
        p(j,:) = p_chu(j,i) * FaceNormals(j,:);
    end
    ith_face_newvector_origversion(i,:) = sum(p);
    w_i(i) = norm(ith_face_newvector_origversion(i,:)); % normalization term ensuring the results is a unit vector
    newFaceNormals(i,:) = ith_face_newvector_origversion(i,:)./w_i(i); % new surface normal & a weighted average of its neighbors
end


%% vertex position update
nVertNeighbourfaces = zeros(1,nvert);
VertNeighbourfaces = zeros(nvert,nface);
% find neighbourfaces of i-th vertex & ascertain how many neighbourfaces does vi have
for i = 1:nvert
    nVertNeighbourfaces(i) = 0;
    for j = 1:nface  % check whether jth-face has vi
        if face(j,1) == i || face(j,2) == i || face(j,3) == i
            VertNeighbourfaces(i,j) = j;   % neighbourfaces of vi; just got the face sequence number--> check "face"
            nVertNeighbourfaces(i) = nVertNeighbourfaces(i) + 1;   % the number of neighbouring faces of vertex vi
        end
    end
end
q_chu = zeros(nface,3);
q = zeros(nface,3);
ith_vertex = zeros(nvert,3);
delta_of_vertex_i = zeros(nvert,3);
newVertex = zeros(nvert,3);
% update --> get newVertex
for i = 1:nvert
    for k = 1:nface    % check whether k-th face is neighbourface of vi
        if VertNeighbourfaces(i,k) ~= 0  % if it is
            q_chu(k,:) = FaceCentroid(k,:) - vertex(i,:); 
            q(k,:) = q_chu(k,:) .* newFaceNormals(k,:) .* FaceNormals(k,:);
        end
    end
    ith_vertex(i,:) = sum(q);
    q_chu = zeros(nface,3); % reset q and q_chu as 0 matrix
    q = zeros(nface,3);
    delta_of_vertex_i(i,:) = ith_vertex(i,:)./nVertNeighbourfaces(i);   % vertex displacement value
    newVertex(i,:) = vertex(i,:) + delta_of_vertex_i(i,:);   % vertex update
    norm_delta = sqrt(delta_of_vertex_i(:,1).^2+delta_of_vertex_i(:,2).^2+delta_of_vertex_i(:,3).^2);
end

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


% newFace = face;
newobj.v = newVertex;
newobj.f.v = face;
newobj.norm_delta = norm_delta;

