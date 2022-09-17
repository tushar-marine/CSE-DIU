clear all
close all
clc

imdsTrain = imageDatastore('Dataset\train','IncludeSubfolders',true,'LabelSource','foldernames');
imdsTest = imageDatastore('Dataset\test','IncludeSubfolders',true,'LabelSource','foldernames');
%% RGB
%% HSV
% imdsTrain.ReadFcn=@(loc)rgb2hsv(imread(loc));
% imdsTest.ReadFcn=@(loc)rgb2hsv(imread(loc));
%% LSB
% imdsTrain.ReadFcn=@(loc)rgb2lab(imread(loc));
% imdsTest.ReadFcn=@(loc)rgb2lab(imread(loc));
%%
numTrainImages = numel(imdsTrain.Labels);
labels=imdsTrain.Labels;
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = imread(cell2mat(imdsTrain.Files(idx(i))));
    imshow(I)
    title(cellstr(nominal(labels(idx(i)))))
end

numTestImages = numel(imdsTest.Labels);
labels=imdsTest.Labels;
idx = randperm(numTestImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = imread(cell2mat(imdsTest.Files(idx(i))));
    imshow(I)
    title(cellstr(nominal(labels(idx(i)))))
end

tbl_train = countEachLabel(imdsTrain)
tbl_test = countEachLabel(imdsTest)

features_train=[];
class=[];
for i=1:length(imdsTrain)
    file=imdsTrain.Files{i, 1};
    temp=imread((file));
    [featureVector,coocMat,time] = cooc3d (temp);
    features_train=[features_train;featureVector(1:360)];
    class=[class;imdsTrain.Labels(i)];
end

coocMat2=(coocMat(:,:,:,1)+coocMat(:,:,:,2)+coocMat(:,:,:,3)+coocMat(:,:,:,4))./4;
[m,n,p]=size(coocMat2);
coocMat3=zeros(m,n);
for i=1:p
    coocMat3=coocMat3+coocMat2(:,:,i);
end
imshow(coocMat3,[])

Y = categorical(class);
tabulate(Y);

features_test=[];
class_test=[];
for i=1:length(imdsTest)
    file=imdsTest.Files{i, 1};
    temp=imread((file));
    [featureVector,coocMat] = cooc3d (temp);

    [featureVector,coocMat] = cooc3d (temp);

    features_test=[features_test;featureVector(1:360)];
    class_test=[class_test;imdsTest.Labels(i)];
end
features_train=features_train(:,1:312);
features_test=features_test(:,1:312);
%%
MdlLinear = fitcdiscr(features_train,class,'DiscrimType','pseudoquadratic','ClassNames',unique(train_labels));
YPred_train_LDA = predict(MdlLinear,features_train);
train_labels=class;
figure;plotconfusion(train_labels,YPred_train_LDA)
figure;plotroc(full(ind2vec(grp2idx(train_labels)')),full(ind2vec(grp2idx(YPred_train_LDA)')));
tic
YPred_test_LDA = predict(MdlLinear,features_test);
toc
test_labels=class_test;
figure;plotconfusion(test_labels,YPred_test_LDA)
figure;plotconfusion([train_labels;test_labels],[YPred_train_LDA;YPred_test_LDA])
figure;plotroc(full(ind2vec(grp2idx([class;class_test])')),full(ind2vec(grp2idx([YPred_train_LDA;YPred_test_LDA])')));
[c_matrix_LDA,Result_LDA,RefereceResult_LDA]=confusion_new.getMatrix(grp2idx([train_labels;test_labels]),grp2idx([YPred_train_LDA;YPred_test_LDA]),1);

%%
t = templateSVM('Standardize',1);
Mdl = fitcecoc(features_train,class,'Learners',t);
%% Confusion matrices
YPred_train = predict(Mdl,features_train);
train_labels=class;
figure;plotconfusion(train_labels,YPred_train)
figure;plotroc(full(ind2vec(grp2idx(train_labels)')),full(ind2vec(grp2idx(YPred_train)')));
%
YPred_test = predict(Mdl,features_test);
test_labels=class_test;
figure;plotconfusion(test_labels,YPred_test)
figure;plotroc(full(ind2vec(grp2idx(test_labels)')),full(ind2vec(grp2idx(YPred_test)')));
figure;plotconfusion([train_labels;test_labels],[YPred_train;YPred_test])
figure;plotroc(full(ind2vec(grp2idx([class;class_test])')),full(ind2vec(grp2idx([YPred_train;YPred_test])')));
[c_matrix_svm,Result_svm,RefereceResult_svm]=confusion_new.getMatrix(grp2idx([train_labels;test_labels]),grp2idx([YPred_train;YPred_test]),1);
% Cf = cfmatrix2(grp2idx([train_labels;test_labels]), grp2idx([YPred_train;YPred_test]), [1 2 3 4 5 6 7 8], 0, 1);
%%

Mdl_tree = fitctree(features_train,train_labels,'ClassNames',{'ADIPOSE','DEBRIS','EMPTY','LYMPHO','MUCOSA','OMPLEX','STROMA','TUMOR'});
YPred_train_tree = categorical(predict(Mdl_tree,features_train));
figure;plotconfusion(train_labels,YPred_train_tree)
tic
YPred_test_tree = categorical(predict(Mdl_tree,features_test));
toc
figure;plotconfusion(test_labels,YPred_test_tree)
figure;plotconfusion([train_labels;test_labels],[YPred_train_tree;YPred_test_tree])
figure;plotroc(full(ind2vec(grp2idx([train_labels;test_labels])')),full(ind2vec(grp2idx([YPred_train_tree;YPred_test_tree])')));

[c_matrix_tree,Result_tree,RefereceResult_tree]=confusion_new.getMatrix(grp2idx([train_labels;test_labels]),grp2idx([YPred_train_tree;YPred_test_tree]),1);
%%

Mdl_knn = fitcknn(features_train,train_labels,'NumNeighbors',5,'Standardize',1);
YPred_train_knn = categorical(predict(Mdl_knn,features_train));
figure;plotconfusion(train_labels,YPred_train_knn)

YPred_test_knn = categorical(predict(Mdl_knn,features_test));
figure;plotconfusion(test_labels,YPred_test_knn)
figure;plotconfusion([train_labels;test_labels],[YPred_train_knn;YPred_test_knn])
[c_matrix_knn,Result_knn,RefereceResult_knn]=confusion_new.getMatrix(grp2idx([train_labels;test_labels]),grp2idx([YPred_train_knn;YPred_test_knn]),1);
plotroc(ind2vec(grp2idx([train_labels;test_labels])'),ind2vec(grp2idx([YPred_train_knn;YPred_test_knn])'));

%%

YPred_test_ann = myNeuralNetworkFunction(features);
[c_matrix_ann,Result_ann,RefereceResult_ann]=confusion_new.getMatrix(vec2ind(class_nn'),vec2ind(YPred_test_ann'),1);
YPred_test_ann_ind=vec2ind(YPred_test_ann');
YPred_test_ann_f=[];
lab=unique(class);
for p=1:length(YPred_test_ann_ind)
    if(YPred_test_ann_ind(p)==1)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(1))));
    elseif(YPred_test_ann_ind(p)==2)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(2))));

    elseif(YPred_test_ann_ind(p)==3)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(3))));

    elseif(YPred_test_ann_ind(p)==4)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(4))));

    elseif(YPred_test_ann_ind(p)==5)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(5))));

    elseif(YPred_test_ann_ind(p)==6)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(6))));

    elseif(YPred_test_ann_ind(p)==7)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(7))));

    elseif(YPred_test_ann_ind(p)==8)
        YPred_test_ann_f{p}=cell2mat(cellstr(nominal(lab(8))));

    end
end

YPred_test_ann_f=categorical(YPred_test_ann_f);
figure;plotconfusion([train_labels;test_labels]',YPred_test_ann_f);

figure;plotroc(full((([class_nn])')),full((([YPred_test_ann])')));

figure
subplot 231
plotroc(full(ind2vec(grp2idx([class;class_test])')),full(ind2vec(grp2idx([YPred_train;YPred_test])')));
title('SVM ROC')
subplot 232
plotroc(full((([class_nn])')),full((([round(YPred_test_ann)])')));
title('ANN ROC')
subplot 233
plotroc(ind2vec(grp2idx([train_labels;test_labels])'),ind2vec(grp2idx([YPred_train_knn;YPred_test_knn])'));
title('KNN ROC')
plotroc(full(ind2vec(grp2idx([train_labels;test_labels])')),full(ind2vec(grp2idx([YPred_train_tree;YPred_test_tree])')));
subplot 234
title('CDT ROC')
subplot 235
plotroc(full(ind2vec(grp2idx([class;class_test])')),full(ind2vec(grp2idx([YPred_train_LDA;YPred_test_LDA])')));
title('QDA ROC')
