/*
  ==============================================================================

    This file was auto-generated!

    It contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include "../JuceLibraryCode/JuceHeader.h"
#include "PluginProcessor.h"


//==============================================================================
/**
*/
class UmreverbAudioProcessorEditor  : public AudioProcessorEditor, public Slider::Listener
{
public:
    UmreverbAudioProcessorEditor (UmreverbAudioProcessor&);
    ~UmreverbAudioProcessorEditor();

    //==============================================================================
    void paint (Graphics&) override;
    void resized() override;
    
    

private:
    // This reference is provided as a quick way for your editor to
    // access the processor object that created it.
    UmreverbAudioProcessor& processor;
    
    
    ///I added this function to be able to edit how slider changes the values we want
    ///also to be able to specifiy what each slider should do when changed
    void sliderValueChanged (Slider* slider) override;
    
    ///Slider variables (Volume is not doing anything for now, but may be useful later)
    Slider Volume;
    Slider HPF_Cutoff_Slider;
    Slider LPF_Cutoff_Slider;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (UmreverbAudioProcessorEditor)
};
