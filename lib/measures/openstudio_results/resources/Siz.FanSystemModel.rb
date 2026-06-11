# *******************************************************************************
# OpenStudio(R), Copyright (c) Alliance for Sustainable Energy, LLC.
# See also https://openstudio.net/license
# *******************************************************************************

class OpenStudio::Model::FanSystemModel
  def maxAirFlowRate
    if designMaximumAirFlowRate.is_initialized
      designMaximumAirFlowRate
    else
      autosizedDesignMaximumAirFlowRate
    end
  end

  def maxAirFlowRateAutosized
    if designMaximumAirFlowRate.is_initialized
      # Not autosized if hard size field value present
      return OpenStudio::OptionalBool.new(false)
    else
      return OpenStudio::OptionalBool.new(true)
    end
  end

  def performanceCharacteristics
    effs = []
    effs << [fanTotalEfficiency, 'Fan Total Efficiency']
    effs << [designPressureRise, 'Design Pressure Rise']
    effs << [motorEfficiency, 'Motor Efficiency']
    return effs
  end
end
