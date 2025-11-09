from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def accueil():
    return render_template('accueil_fr.html')

@app.route('/about')
def about():
    return render_template('about_fr.html')

@app.route('/don')
def don():
    return render_template('don_fr.html')

@app.route('/jeddi')
def jeddi():
    return render_template('jeddi_fr.html')

@app.route('/legendes')
def legendes():
    return render_template('legendes_fr.html')

if __name__ == '__main__':
    app.run(debug=True)
