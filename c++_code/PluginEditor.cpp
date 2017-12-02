/*
  ==============================================================================

    This file was auto-generated!

    It contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"


//==============================================================================
UmreverbAudioProcessorEditor::UmreverbAudioProcessorEditor (UmreverbAudioProcessor& p)
    : AudioProcessorEditor (&p), processor (p)
{
    
    ///Set size of GUI
    setSize (400, 300);
    
    // these define the parameters of our slider object
    Volume.setSliderStyle (Slider::LinearBarVertical);
    Volume.setRange(0.0, 1.0, 0.1);
    Volume.setTextBoxStyle (Slider::NoTextBox, false, 90, 0);
    Volume.setPopupDisplayEnabled (true, false, this);
    Volume.setTextValueSuffix (" Volume");
    Volume.setValue(0.2);
    Volume.addListener(this);
    // this function adds the slider to the editor
    addAndMakeVisible (&Volume);
    
    // these define the parameters of our slider object
    HPF_Cutoff_Slider.setSliderStyle (Slider::LinearBarVertical);
    HPF_Cutoff_Slider.setRange(20, 10000, 1);
    HPF_Cutoff_Slider.setTextBoxStyle (Slider::NoTextBox, false, 90, 0);
    HPF_Cutoff_Slider.setPopupDisplayEnabled (true, false, this);
    HPF_Cutoff_Slider.setTextValueSuffix ("HPF Cutoff");
    HPF_Cutoff_Slider.setValue(20);
    HPF_Cutoff_Slider.addListener(this);
    // this function adds the slider to the editor
    addAndMakeVisible (&HPF_Cutoff_Slider);
    
    // these define the parameters of our slider object
    LPF_Cutoff_Slider.setSliderStyle (Slider::LinearBarVertical);
    LPF_Cutoff_Slider.setRange(40, 20000, 1);
    LPF_Cutoff_Slider.setTextBoxStyle (Slider::NoTextBox, false, 90, 0);
    LPF_Cutoff_Slider.setPopupDisplayEnabled (true, false, this);
    LPF_Cutoff_Slider.setTextValueSuffix ("LPF Cutoff");
    LPF_Cutoff_Slider.setValue(18000);
    LPF_Cutoff_Slider.addListener(this);
    // this function adds the slider to the editor
    addAndMakeVisible (&LPF_Cutoff_Slider);
}

UmreverbAudioProcessorEditor::~UmreverbAudioProcessorEditor()
{
}

//==============================================================================
void UmreverbAudioProcessorEditor::paint (Graphics& g)
{
    // (Our component is opaque, so we must completely fill the background with a solid colour)
    g.fillAll (getLookAndFeel().findColour (ResizableWindow::backgroundColourId));

    g.setColour (Colours::white);
    g.setFont (15.0f);
    g.drawFittedText ("UMVerb " + std::to_string(processor.bufferSize), getLocalBounds(), Justification::centred, 1);
}

void UmreverbAudioProcessorEditor::resized()
{
    // sets the position and size of the slider with arguments (x, y, width, height)
    Volume.setBounds (40, 30, 20, getHeight() - 60);
    HPF_Cutoff_Slider.setBounds (80, 30, 20, getHeight() - 60);
    LPF_Cutoff_Slider.setBounds (120, 30, 20, getHeight() - 60);
}


///This is where you would specify what each slider does
///NOTE: processor is a given object of class PluginProcessor to access all its variables
void UmreverbAudioProcessorEditor::sliderValueChanged (Slider* slider)
{
    if(slider == &Volume)
    {
        processor.volumeValues = Volume.getValue();
    }
    
    else if(slider == &HPF_Cutoff_Slider)
    {
        processor.HPF_Cutoff_Value = HPF_Cutoff_Slider.getValue();
        
        processor.HPF_C = tan(PI*processor.HPF_Cutoff_Value/processor.currentSampleRate);
        processor.HPF_a0 = 1/(1+ 0.707*processor.HPF_C + processor.HPF_C*processor.HPF_C);
        processor.HPF_a1 = -2*processor.HPF_a0;
        processor.HPF_a2 = processor.HPF_a0;
        processor.HPF_b1 = 2*processor.HPF_a0*(-1 + processor.HPF_C*processor.HPF_C);
        processor.HPF_b2 = processor.HPF_a0*(1-0.707*processor.HPF_C + processor.HPF_C*processor.HPF_C);
    }
    
    else if(slider == &LPF_Cutoff_Slider)
    {
        processor.LPF_Cutoff_Value = LPF_Cutoff_Slider.getValue();
        
        processor.LPF_C = 1/tan(PI*processor.LPF_Cutoff_Value/processor.currentSampleRate);
        processor.LPF_a0 = 1/(1+ 0.707*processor.LPF_C + processor.LPF_C*processor.LPF_C);
        processor.LPF_a1 = 2*processor.LPF_a0;
        processor.LPF_a2 = processor.LPF_a0;
        processor.LPF_b1 = 2*processor.LPF_a0*(1 - processor.LPF_C*processor.LPF_C);
        processor.LPF_b2 = processor.LPF_a0*(1-0.707*processor.LPF_C + processor.LPF_C*processor.LPF_C);
    }
}
















