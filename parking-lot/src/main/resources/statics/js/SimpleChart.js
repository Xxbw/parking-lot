
/**
 * Helper method to draw rectangle with a corner radius
 * @param {Object} ctx 2d context
 * @param {Number} x x-start
 * @param {Number} y y-start
 * @param {Number} w width
 * @param {Number} h height
 * @param {Number} cr corner radius
 * @param {String} color valid CSS color
 */
function roundedRect(ctx, x, y, w, h, cr, color) {
    if (h === 0) return;
    ctx.strokeStyle = color
    ctx.lineJoin = "round";
    ctx.lineWidth = cr;
    ctx.strokeRect(x+(cr/2), y+(cr/2), w-cr, h-cr);
    ctx.shadowSize = 0
    ctx.shadowColor = color
    ctx.fillStyle = color
    ctx.fillRect(x+(cr/2), y+(cr/2), w-cr, h-cr);
    ctx.lineWidth = 1
}


/**
 * Number formatter for grid values on y-axis
 * @param {Number} n 
 */
function formatNumber(n) {
    return Intl.NumberFormat('en-US', { notation: "compact" , compactDisplay: "short" }).format(n)
}

/**
 * ColorWheel class for providing random colors
 */
class ColorWheel {
    /**
     * Default constructor for color wheel class
     * @param {String[]} colors list of colors optional 
     */
    constructor(colors=null) {
        this.colors = colors || [
            '#05386B',
            '#379683',
            '#5CDB95',
            '#8EE4AF',
            '#EDF5E1'
        ]
        this.index = 0
    }

    /**
     * Helper method to get next color
     */
    get() {
        if (this.index == this.colors.length) {
            this.index = 0
        }
        return this.colors[this.index++]
    }

}

/**
 * Helper method to draw a line on a canvas
 * @param {Object} ctx 2d context
 * @param {Number} x1 Starting x-coordinate
 * @param {Number} y1 Starting y-coordinate
 * @param {Number} x2 Ending x-coordinate
 * @param {Number} y2 Ending y-coordinate
 * @param {String} color Valid CSS color
 */
function drawLine(ctx, x1, y1, x2, y2, color='black') {
    ctx.beginPath();
    ctx.strokeStyle = color;
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.stroke()
}

/**
 * Helper method to draw a label on a canvas
 * @param {Object} ctx 2d context
 * @param {String} text text to display
 * @param {Number} x x-location
 * @param {Number} y y-location
 * @param {String} size pixel size of text - must end in px
 * @param {String} font font style
 * @param {String} color valid CSS color
 */
function drawLabel(ctx, text, x, y, size='18px', font='sans-serif', color='black', align='left') {
    ctx.font = `${size} ${font}`
    ctx.fillStyle = color
    ctx.textAlign = align
    ctx.fillText(text, x, y)
}

/**
 * Viewport class to allow for scrolling if elected by user
 */
class ViewPort {
    constructor(x, y, w, h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
}

/**
 * Pointer class to manage hover interactions
 */
class Pointer {
    constructor( x, y ) {
        this.x = x;
        this.y = y;
    }

    moveTo( x, y ) {
        this.x = x;
        this.y = y;
    }
}

/**
 * Scroller class to manage scroll interactions
 * TBD - practiced functionality in test.html plan to migrate after styling is complete, w/viewport implemented we are all set.
 */
class Scroller {
    constructor( x, y, w, h ) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h =h;
        this.mouseDown = false;
    }

    intersect = (x, y) => {
        return x >= this.x && x <= this.x + this.w
    }
}


/**
 * Base SimpleChart class for all chart types
 */
class SimpleChart {
    constructor(props) {
        // Minimum required
        this.id = props.id;
        this.values = props.values;
        this.labels = props.labels || [];
        this.context = document.querySelector(`#${this.id}`).getContext('2d');
        this.scale()

        //Location management
        this.viewport = new ViewPort(0, 0, this.width, this.height);
        this.pointer = new Pointer(0,0);
        // this.scroller = new Scroller( 0, 0, 0, 100);

        // Style attributes
        this.backgroundColor = props.backgroundColor || 'lightcoral';
        this.context.canvas.style.backgroundColor = this.backgroundColor;
        
        //Grid / Y-Axis Style
        this.gridLineColor = props.gridLineColor || 'black';
        this.gridFontFamily = props.gridFontFamily || 'sans-serif';
        this.gridFontSize = props.gridFontSize || '18px';
        this.gridFontColor = props.gridFontColor || 'black';
        this.gridLabelInset = props.gridLabelInset || 4;
        this.showZero = props.showZero || false;
        this.unit = props.unit || '';
        this.gridLineStyle = props.gridLineStyle || 'solid';//Options solid, dashed
        this.dashes = props.dashes || 50
        this.dashGap = props.dashGap || 2
        this.yAxisLine = props.hasOwnProperty('yAxisLine') ? props.yAxisLine : false;
        this.showYAxisLabels = props.hasOwnProperty('showYAxisLabels') ? props.showYAxisLabels : true;
        
        //X-Axis Style -- might change this to dataStyle
        this.xAxisFontFamily = props.xAxisFontFamily || 'sans-serif';
        this.xAxisFontSize = props.xAxisFontSize || '18px';
        this.xAxisFontColor = props.xAxisFontColor || 'black';
        this.xAxisLine = props.hasOwnProperty('xAxisLine') ? props.xAxisLine : true;
        this.labelSpace = props.labelSpace || 30;
        //End style attributes

        //Listeners
        this.context.canvas.addEventListener('mousemove', this.mouseDidMove);
        this.context.canvas.addEventListener('mouseout', this.mouseDidLeave);
    }

    /**
     * Helper method to scale canvas to device pixel ratio on initialization
     */
    scale() {
        const width = +getComputedStyle(this.context.canvas).getPropertyValue("width").slice(0, -2) * window.devicePixelRatio;
        const height = +getComputedStyle(this.context.canvas).getPropertyValue("height").slice(0, -2) * window.devicePixelRatio;
        this.width = width;
        this.height = height;
        this.context.canvas.setAttribute('width', width);
        this.context.canvas.setAttribute('height', height)
    }

    /**
     * Method for mousemove event to update pointer location
     * @param {Object} e mousemove event object 
     */
    mouseDidMove = e => {
        const rect = this.context.canvas.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        this.pointer.moveTo(x * window.devicePixelRatio, y * window.devicePixelRatio)
    }

    /**
     * Method for mouseout event to update pointer location
     * @param {Object} e mouseout event object
     */
    mouseDidLeave = e => {
        this.pointer.moveTo(0,0)
    }

    /**
     * Helper method to start main loop and apply any render methods for subclass
     * @param {function} fn function to be applied in main render loop 
     */
    mainLoop = fn => {
        this.context.clearRect(0,0,this.width, this.height)
        fn()
        requestAnimationFrame(() => this.mainLoop(fn))
    }

    /**
     * Method for all subclasses to emit an event upon data point interation
     * @param {Object} details object containing details about the data point
     */
    dataPointEvent(eventName, details) {
        this.context.canvas.dispatchEvent(new CustomEvent(eventName, {detail: details}))
    }

    /**
     * Method to add listener for custom events
     */
    addEventListener(eventName, method) {
        this.context.canvas.addEventListener(eventName, method)
    }
}

/**
 * Bar chart class
 */
class SimpleBarChart extends SimpleChart {
    constructor(props) {
        super(props);

        // Bar Attributes
        this.fillEvenly = props.hasOwnProperty('fillEvenly') ? props.fillEvenly : true;
        this.barSpacing = props.barSpacing || 20;
        this.barWidth = props.barWidth || 30;

        //Bar Styles
        this.barHoverFontFamily = props.barHoverFontFamily || 'sans-serif'
        this.barHoverFontSize = props.barHoverFontSize || '24px'
        this.barHoverFontColor = props.barHoverFontColor || 'black'
        this.cornerRadius = props.hasOwnProperty('cornerRadius') ? props.cornerRadius : 8;

        this.hover = props.hover || true;
        this.colors = props.colors || null
        this.colorWheel = new ColorWheel(this.colors)
        this.colorMap = {}
        this.topSpacing = props.topSpacing || 50;
        this.shadowColor = props.shadowColor || 'black';
        this.shadowSize = props.shadowSize || 4
        this.scale = props.scale || 5;

    }

    /**
     * Method to update constant variables
     */
    setConstants() {
        this._LABEL_INSET = parseInt(this.gridFontSize) + 8
        this._MAX_ARR = Math.max(...this.values);
        this._GRID_LINES = Math.ceil( this._MAX_ARR / this.scale )
        this._MAX = this._GRID_LINES * this.scale
        this._MAX_BAR_HEIGHT = this.height - this.topSpacing - this.labelSpace - this.cornerRadius
        this._GRID_LINE_SPACE = this._MAX_BAR_HEIGHT / this._GRID_LINES
        this._BAR_BOTTOM = this.height - this.labelSpace
    }

    /**
     * Method to draw axis
     */
    drawAxis = () => {
        this.yAxisLine ? drawLine(this.context, 0, this._BAR_BOTTOM, 0, 0) : null
        this.xAxisLine ? drawLine(this.context, 0, this._BAR_BOTTOM + 1, this.width, this._BAR_BOTTOM + 1) : null
    }

    /**
     * Method to draw grid lines
     */
    drawGrid = () => {
        this.setConstants();
        for(let x = 0; x < this._GRID_LINES + this.showZero; x ++) {
            let lineY = ((x * this.scale) / this._MAX ) * this._MAX_BAR_HEIGHT + this.topSpacing
            if(this.gridLineStyle === 'dashed') {
                const dashWidth = (this.width - (2 * this.dashGap * this.dashes)) / this.dashes
                const dashSpace = (this.width / this.dashes)
                for(let y = 0; y < this.dashes + 1; y++) {
                    drawLine(this.context, (dashSpace * y) + this.dashGap, lineY, dashWidth + (dashSpace * y), lineY, this.gridLineColor)
                }

            } else if (this.gridLineStyle === 'solid') {
                drawLine(this.context, 0, lineY,this.width, lineY,this.gridLineColor)
            }
            let gridValue = (this._GRID_LINES - x) * this.scale;
            if (this.showYAxisLabels) drawLabel(this.context, this.unit + formatNumber(gridValue), this.gridLabelInset, lineY - parseInt(this.gridFontSize),this.gridFontSize, this.gridFontFamily, this.gridFontColor)
        }
    }

    /**
     * Method to draw bars evenly across chart
     * 
     * Calculations if fillEvenly:
     * * N = (Width of chart - (yAxis label padding left + yAxis label font size)) / # of bars
     * * xStart = (n - 1) * N + (0.5  * spacing )
     * * Bar Width = Width - (yAxis label padding left + yAxis label font size) - ( spacing * # of bars) / # of bars
     * 
     * if !fillEvenly:
     * * N = this.barWidth + this.barSpacing
     * * barWidth = this.barWidth
     */
    drawBars = () => {

        const yAxisOffset = (this.gridLabelInset + this._LABEL_INSET)
        const N = this.fillEvenly ? (this.width - yAxisOffset) / this.values.length : this.barWidth + this.barSpacing;
        const barWidth = this.fillEvenly ? (this.width - yAxisOffset - (this.barSpacing * this.values.length)) / this.values.length : this.barWidth;
        
        for( let i = 0; i < this.values.length; i++ ) {
            const xStart = (N * i) + (0.5 * this.barSpacing) + yAxisOffset
            const xEnd = (xStart + barWidth)
            const yEnd = ( - this.values[i] / this._MAX) * this._MAX_BAR_HEIGHT;
            const yStart = this._BAR_BOTTOM;
            
            //If in viewport then render
            if ( xStart < this.viewport.x + this.viewport.w || xEnd > this.viewport.x) {
                if (this.hover && this.pointer.x >= (xStart - this.viewport.x) && this.pointer.x <= (xStart - this.viewport.x) + barWidth && this.pointer.y <= yStart && this.pointer.y >= yStart + yEnd) {
                    drawLabel(this.context, formatNumber(this.values[i]), xStart + (barWidth / 2), yStart + yEnd - 18, this.barHoverFontSize, this.barHoverFontFamily, this.barHoverFontColor, 'center')
                    this.context.shadowBlur = this.shadowSize;
                    this.context.shadowColor = this.shadowColor;
                    this.dataPointEvent('hover',{
                        index: i,
                        value: this.values[i],
                        action: 'hover',
                        timestamp: Date.now()
                    })
                }

                //Update color map on first run
                this.colorMap[i] = this.colorMap[i] || this.colorWheel.get();
                this.context.beginPath();
                roundedRect(this.context, xStart, yStart, barWidth, yEnd, this.cornerRadius, this.colorMap[i])

                this.context.shadowBlur = 0
                //Draw labels
                drawLabel(this.context, this.labels[i] || '', xStart + ( barWidth / 2), this.height - (this.labelSpace / 4), this.xAxisFontSize, this.xAxisFontFamily, this.xAxisFontColor, 'center')
            }
        }
    }

    /**
     * Render method to consolidate subroutines
     */
    render = () => {
        this.drawAxis();
        this.drawGrid();
        this.drawBars();
    }

    /**
     * All subclasses must have a draw method to be called upon to start their main renders
     */
    draw() {
        this.mainLoop(this.render)
    }
}


