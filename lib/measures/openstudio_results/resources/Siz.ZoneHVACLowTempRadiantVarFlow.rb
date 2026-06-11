# *******************************************************************************
# OpenStudio(R), Copyright (c) Alliance for Sustainable Energy, LLC.
# See also https://openstudio.net/license
# *******************************************************************************

class OpenStudio::Model::ZoneHVACLowTempRadiantVarFlow
  def maxWaterFlowRate
    vals = []
    if coolingCoil.is_initialized && coolingCoil.get.maxWaterFlowRate.is_initialized
      vals << coolingCoil.get.maxWaterFlowRate.get
    end
    if heatingCoil.is_initialized && heatingCoil.get.maxWaterFlowRate.is_initialized
      vals << heatingCoil.get.maxWaterFlowRate.get
    end
    if vals.size.zero?
      OpenStudio::OptionalDouble.new
    else
      OpenStudio::OptionalDouble.new(vals.max)
    end
  end

  def maxWaterFlowRateAutosized
    if coolingCoil.is_initialized && coolingCoil.get.maxWaterFlowRate.is_initialized
      return OpenStudio::OptionalBool.new(false)
    elsif heatingCoil.is_initialized && heatingCoil.get.maxWaterFlowRate.is_initialized
      return OpenStudio::OptionalBool.new(false)
    else
      return OpenStudio::OptionalBool.new(true)
    end
  end

  def performanceCharacteristics
    effs = []
    if coolingCoil.is_initialized
      effs += coolingCoil.get.performanceCharacteristics
    end
    if heatingCoil.is_initialized
      effs += heatingCoil.get.performanceCharacteristics
    end
    return effs
  end
end
