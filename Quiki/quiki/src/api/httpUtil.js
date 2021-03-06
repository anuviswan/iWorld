import store from "../store/index"
import axios from "axios"
const getCategories = ()=>{
    return [
        {
            title:"Birds",
            icon : "fa fa-twitter",
        },
        {
            title:"Animals",
            icon : "fa fa-hippo"
        },
        {
            title:"Flags",
            icon : "fa fa-flag"
        }
    ]
}


const getItemsForCategory = async (category)=>{

    const fromCache = store.getters.questionCache.filter(e => e.categoryName === category);

    if(fromCache.length > 0)
    {
        console.log(fromCache[0])
        return fromCache[0].values;
    }

    var params = {
        params:{
            appName:'quiki',
            categoryName:category   
        }
         
    };
    var response = await axios.get(process.env.VUE_APP_APIGETFORCATEGORY,params);
    const result = response.data.map(item=>{
       
        const serializedData = JSON.parse(item.value);

        return {
            type: serializedData.type,
            url: serializedData.url,
            key: serializedData.key,
            description:serializedData.description,
            funfact:serializedData.funfact
        };
    });

    store.dispatch('AddToCache',{
        categoryName:category,
        values:result
    });

    return result;

}


const getRandomItem = async (category) =>{

    const items = await getItemsForCategory(category);
    var item = items[Math.floor(Math.random() * items.length)];
    return item;
}


const validate = async(userName,password) =>{

    const params = {
        'uid':userName,
        'appName':"junglebook",
        'passKey':password
    };

    console.log(params);
    console.log(process.env.VUE_APP_VALIDATE)
    const response = await axios.post(process.env.VUE_APP_VALIDATE,params);
    console.log(response);
    return {
        result:false,
        uid:userName,
        pkey: password
    }
}
export {
    getCategories,
    getItemsForCategory,
    getRandomItem,
    validate
}