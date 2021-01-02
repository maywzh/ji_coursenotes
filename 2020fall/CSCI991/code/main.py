with open('../data/hmath/context_entity','r',encoding="utf-8") as f:
    for i in f.readlines():
        sentence , entitys = i.split(' ')

def getTag(dataset):
    entity_dict = readEntitys()
    context_tag = []
    for i in dataset:
        raw_context = i[0]
        entitys = i[1]
        tag = ['O']*len(raw_context)
        entitys.sort(key=lambda x: len(x))
        entitys.reverse()
        for j in entitys:
            label = kind_dict[entity_dict[j]]
            label_start = 'B-' + label
            label_ = 'I-' + label            
            for k in re.finditer(j,raw_context):
                if 'O' in tag[k.start():k.end()]:
                    tag[k.start():k.end()]=[label_start] + [label_]*(len(j)-1)
        context_tag.append([raw_context,tag])
    return context_tag