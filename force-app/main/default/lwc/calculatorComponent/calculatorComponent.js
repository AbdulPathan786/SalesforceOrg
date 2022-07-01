import { LightningElement, track } from 'lwc';
export default class calculatorComponent extends LightningElement{
  firstNumber;
  secondNumber;
  output;
// method
     operation(event){
        this.firstNumber = parseFloat(this.template.querySelector('lightning-input[data-id ="firstNumber"]').value);
        this.secondNumber = parseFloat(this.template.querySelector('lightning-input[data-id ="secondNumber"]').value);
        //console.log('event.target.name' , event.target.name);
        const resultName = event.target.name;
        if((!isNaN(this.firstNumber)) & (!isNaN(this.secondNumber))){
                if(resultName == 'additions'){
                    this.output = (this.firstNumber + this.secondNumber);
                    return this.output;
                }
                else if(resultName == 'substractions'){
                    this.output = (this.firstNumber - this.secondNumber);
                    return this.output;
                }
                else if(resultName == 'multiplications'){
                    this.output = (this.firstNumber * this.secondNumber);
                    return this.output;
                }
                else {
                    this.output = (this.firstNumber / this.secondNumber);
                    return this.output;
                } 
            }else{
                // console.log('result);
            } 
    }  
}