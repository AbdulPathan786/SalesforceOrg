({
    // Method for fireworks confetti mode
    fireworks : function(component, event, helper){
        var end = Date.now() + (15 * 100);
        var interval = setInterval(function() {
            if (Date.now() > end) {
                return clearInterval(interval);
            }
            confetti({
                particleCount : 450,
                startVelocity: 30,
                spread: 360,
                ticks: 60,
                origin:{
                    x: Math.random(),
                    y: Math.random() 
                },    
            });
        }, 200);
    },
    
})