# *******************************************************************************
# OpenStudio(R), Copyright (c) Alliance for Sustainable Energy, LLC.
# See also https://openstudio.net/license
# *******************************************************************************

class OpenStudio::Model::ZoneHVACLowTempRadiantVarFlow
  def maxWaterFlowRate
    vals = []
    vals << coolingCoil.get.maxWaterFlowRate.get if coolingCoil.is_initialized && coolingCoil.get.maxWaterFlowRate.is_initialized
    vals << heatingCoil.get.maxWaterFlowRate.get if heatingCoil.is_initialized && heatingCoil.get.maxWaterFlowRate.is_initialized
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
    effs += coolingCoil.get.performanceCharacteristics if coolingCoil.is_initialized
    effs += heatingCoil.get.performanceCharacteristics if heatingCoil.is_initialized
    return effs
  end
end
