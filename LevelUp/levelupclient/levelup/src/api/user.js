import axios from "axios";

// Leadership Board
const getLeaderBoard = async () => {

    const config = {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json'
        }
      };

    const response = await axios.post(process.env.VUE_APP_GETLEADERBOARD_URL,config)
  // const response = await axios.post(
  //   "https://levelupbackend.azurewebsites.net/api/GetScores?code=Ylaa8g4Zb2HMPICspVRNuaPcuaJ7hZ7Nc8H5J8OFF7CqWaIPGIfUUg==",config
  // );

  return response;
};


const getNextQuestion= async(userName)=>{
  const config={
    userName:userName.toLowerCase()
  };

 console.log(process.env.VUE_APP_GET_NEXT_QUESTION)
 const response = await axios.post(process.env.VUE_APP_GET_NEXT_QUESTION,config);
 //const response = await axios.post('https://levelupbackend.azurewebsites.net/api/GetNextQuestion?code=YpVS9XThdnImq/vACcSHa6vfEYXhI5Yo5JjzUOGTTcxO8kvITcw8UA==',config);
  return response;
}

const validateAnswer = async (userName,level,answer)=>{
  const config ={
    userName:userName.toLowerCase(),
    level : level,
    answer:answer
  };

  const response = await axios.post(process.env.VUE_APP_VALIDATE,config);
 //const response = await axios.post('https://levelupbackend.azurewebsites.net/api/Validate?code=Bip1glLTjmtHXhLyjWn8ce/WE4DUfaSIuIRa/l9mj48Nj/t9Ku/VDg==',config);
  return response;
}


export {
    getLeaderBoard,getNextQuestion,validateAnswer
}