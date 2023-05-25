/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable @typescript-eslint/indent */
import * as openai from 'openai';
require('dotenv').config();

const configuration = new openai.Configuration({
    apiKey: process.env.OPENAI_API_KEY,
});

const openAi = new openai.OpenAIApi(configuration);

// Function to generate chat response using OpenAI
async function generateChatResponse(message: string): Promise<string> {
    const prompt = `User: ${message}\nSupport:`;
    const options = {
        temperature: 0.7,
        max_tokens: 100,
        n: 1,
        stop: '\n',
        presence_penalty: 0.6,
        frequency_penalty: 0.0,
    };

    const completionRequest: openai.CreateCompletionRequest = {
        prompt,
        ...options,
        model: '',
    };

    const completion: openai.CreateCompletionRequest = {
        prompt,
        model: 'text-davinci-003',
        temperature: .7,
    };

    console.log(completion.data.choices[0].text);
    const reply = completion.data.choices[0].text.trim();
    return reply;
}

async function callChatGPT(text: String) {
    try {
        const completion: await openai.CreateChatResponse  = ({
            model: 'text-davinci-003',
            prompt: text,
            max_tokens: 3000,
        });
        console.log(completion.data.choices[0].text);
    } catch (e) {
        console.log(e);
    }
}



callChatGPT('write an article on advantages of chatgpt');

export default generateChatResponse;