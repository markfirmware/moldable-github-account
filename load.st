(IceRepository registry
    anySatisfy: [ :repo | repo location = '..' asFileReference])
        ifFalse: [
            (IceRepositoryCreator new
                location: '..' asFileReference;
                createRepository) register
        ]
