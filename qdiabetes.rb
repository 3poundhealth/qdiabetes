#!/usr/bin/ruby


# Original License
# -------------------------------------------
 
# Copyright 2012 ClinRisk Ltd.
# 
# This file is part of QDiabetes-2013 (http://qdiabetes.org, http://svn.clinrisk.co.uk/opensource/qdiabetes).
# 
# QDiabetes-2013 is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# QDiabetes-2013 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with QDiabetes-2013.  If not, see <http://www.gnu.org/licenses/>.
# 
# Additional terms
# 
# The following disclaimer must be displayed alongside any risk score generated by this code.
#   The initial version of this file, to be found at http://svn.clinrisk.co.uk/opensource/qdiabetes, faithfully implements QDiabetes-2013.
#   We have released this code under the GNU Lesser General Public License to enable others to implement the algorithm faithfully.
#   However, the nature of the GNU Lesser General Public License is such that we cannot prevent, for example, someone altering the coefficients.
#   We stress, therefore, that it is the responsibility of the end user to check that the source that they receive produces the same results as the original code posted at http://svn.clinrisk.co.uk/opensource/qdiabetes.
#   Inaccurate implementations of risk scores can lead to wrong patients being given the wrong treatment.
# 
# This file has been auto-generated.
# XML source: Q68_qdiabetes_2013_1_1.xml
# STATA dta time stamp: 15 Feb 2013 11:36
# This file was created on: Fri 15 Feb 2013 11:40:42 GMT

# Supplemental Info
# -------------------------------------------
# Ruby port by 3poundHealth.
# Copyright 2013 3poundHealth
# Released under GNU Lesser General Public License

# qdiabetes is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# qdiabetes is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.



module QDiabetes extend self

def eval options = {}
  begin
    #initialize
    options = QDiabetes.OPTIONS.merge options
    @errors = QDiabetes.ERRORS
    to_i = QDiabetes.method :to_i

    #assign attributes
    @age = options[:age]
    @age_centering = QDiabetes.AGE_CENTERING
    @age_continuous = QDiabetes.AGE_CONTINUOUS
    @age_polynomial = QDiabetes.AGE_POLYNOMIAL
    @age_range = QDiabetes.AGE_RANGE
    @blood_pressure_treatment_independent = QDiabetes.BLOOD_PRESSURE_TREATMENT_INDEPENDENT
    @bmi = options[:body_mass_index]
    @bmi_centering = QDiabetes.BMI_CENTERING
    @bmi_continuous = QDiabetes.BMI_CONTINUOUS
    @bmi_dependent = QDiabetes.BMI_DEPENDENT
    @bmi_polynomial = QDiabetes.BMI_POLYNOMIAL
    @bmi_range = QDiabetes.BMI_RANGE
    @corticosteroids_independent = QDiabetes.CORTICOSTEROIDS_INDEPENDENT
    @decade_odds = QDiabetes.DECADE_ODDS
    @diabetes_relative_dependent = QDiabetes.DIABETES_RELATIVE_DEPENDENT
    @diabetes_relative_independent = QDiabetes.DIABETES_RELATIVE_INDEPENDENT
    @ethnicity = options[:ethnicity].to_sym
    @ethnicity_risk = QDiabetes.ETHNICITY_RISK
    @ethnicity_types = QDiabetes.ETHNICITY_TYPES
    @gender = options[:gender].to_sym
    @genders = QDiabetes.GENDERS
    @heart_disease_independent = QDiabetes.HEART_DISEASE_INDEPENDENT
    @smoker = options[:smoker].to_sym
    @smoker_independent = QDiabetes.SMOKER_INDEPENDENT
    @smoker_types = QDiabetes.SMOKER_TYPES

    @debug = options[:internal_debug]

    #validate
    raise @errors[:age] unless @age_range.include? @age or @age == 0
    raise @errors[:bmi] unless @bmi_range.include? @bmi or @bmi == 0
    raise @errors[:ethnicity] unless @ethnicity_types.include? @ethnicity
    raise @errors[:gender] unless @genders.include? @gender
    raise @errors[:smoker] unless @smoker_types.include? @smoker

    #scale these "constants"
    @age *= QDiabetes.AGE_SCALE
    @bmi *= QDiabetes.BMI_SCALE

    #ranged constants
    @age_upper = @age.zero? ? 0 : @age_polynomial[@gender][:age_upper].call(@age) - @age_centering[@gender][:age_upper]
    @age_lower = @age.zero? ? 0 : @age ** @age_polynomial[@gender][:age_lower]    - @age_centering[@gender][:age_lower]
    @bmi_upper = @bmi.zero? ? 0 : @bmi ** @bmi_polynomial[@gender][:bmi_upper]    - @bmi_centering[@gender][:bmi_upper]
    @bmi_lower = @bmi.zero? ? 0 : @bmi ** @bmi_polynomial[@gender][:bmi_lower]    - @bmi_centering[@gender][:bmi_lower]

    printf "a1: %6.2f, a2: %6.2f\n", @age_upper, @age_lower if @debug
    printf "b1: %6.2f, b2: %6.2f\n", @bmi_upper, @bmi_lower if @debug

    #evaluate booleans
    @blood_pressure_treatment = to_i options[:blood_pressure_treatment]
    @corticosteroids          = to_i options[:corticosteroids]
    @diabetes_relative        = to_i options[:diabetes_relative]
    @heart_disease            = to_i options[:heart_disease]
    
    printf "tr:%5.2f, rl:%5.2f\n",
      @blood_pressure_treatment              * @blood_pressure_treatment_independent [@gender],
      @diabetes_relative                     * @diabetes_relative_independent  [@gender] if @debug

    printf "i:%6.2f u:%6.2f l:%6.2f er:%6.2f\n",
      @ethnicity_risk                         [@gender][@ethnicity]                                           +
      @smoker_independent                     [@gender][@smoker]                                              +
      @bmi_upper                             * @bmi_continuous                       [@gender][:bmi_upper]    +
      @bmi_lower                             * @bmi_continuous                       [@gender][:bmi_lower]    +
      @diabetes_relative                     * @diabetes_relative_independent        [@gender]                +
      @corticosteroids                       * @corticosteroids_independent          [@gender]                +
      @heart_disease                         * @heart_disease_independent            [@gender]                +
      @blood_pressure_treatment              * @blood_pressure_treatment_independent [@gender],

      #age spread dependent risks
      @age_upper * @diabetes_relative        * @diabetes_relative_dependent          [@gender][:age_upper]    +
      @age_upper * @bmi_upper * @bmi_dependent             [@gender][:age_upper][:bmi_upper]                  +
      @age_upper * @bmi_lower * @bmi_dependent             [@gender][:age_upper][:bmi_lower],

      @age_lower * @diabetes_relative        * @diabetes_relative_dependent          [@gender][:age_lower]    +
      @age_lower * @bmi_upper * @bmi_dependent             [@gender][:age_lower][:bmi_upper]                  +
      @age_lower * @bmi_lower * @bmi_dependent             [@gender][:age_lower][:bmi_lower],

      @ethnicity_risk[@gender][@ethnicity] if @debug

  rescue => exception
    raise exception if @debug
    abort "\033[31merror: " + exception.message + "\033[0m"
  else
    #calculate
    options.to_s + " => "
    "%.6f" % (
      100 * (1 - @decade_odds[@gender] ** Math.exp(
        #age spread independent risks
        @ethnicity_risk                         [@gender][@ethnicity]                                           +
        @smoker_independent                     [@gender][@smoker]                                              +
        @bmi_upper                             * @bmi_continuous                       [@gender][:bmi_upper]    +
        @bmi_lower                             * @bmi_continuous                       [@gender][:bmi_lower]    +
        @blood_pressure_treatment              * @blood_pressure_treatment_independent [@gender]                +
        @corticosteroids                       * @corticosteroids_independent          [@gender]                +
        @diabetes_relative                     * @diabetes_relative_independent        [@gender]                +
        @heart_disease                         * @heart_disease_independent            [@gender]                +

        #age spread dependent risks
        @age_upper                             * @age_continuous                       [@gender][:age_upper]    +
        @age_upper * @diabetes_relative        * @diabetes_relative_dependent          [@gender][:age_upper]    +
        @age_upper * @bmi_upper * @bmi_dependent             [@gender][:age_upper][:bmi_upper]                  +
        @age_upper * @bmi_lower * @bmi_dependent             [@gender][:age_upper][:bmi_lower]                  +

        @age_lower                             * @age_continuous                       [@gender][:age_lower]    +
        @age_lower * @diabetes_relative        * @diabetes_relative_dependent          [@gender][:age_lower]    +
        @age_lower * @bmi_upper * @bmi_dependent             [@gender][:age_lower][:bmi_upper]                  +
        @age_lower * @bmi_lower * @bmi_dependent             [@gender][:age_lower][:bmi_lower]
      ))
    )
  end
end

def help
  "QDiabetes display help info..."
end

protected

$, = ", " #default join

def OPTIONS;{ #default options
  gender:                  :male,
  age:                      0,
  blood_pressure_treatment: false,
  body_mass_index:          0,
  corticosteroids:          false,
  diabetes_relative:        false,
  ethnicity:               :white,
  heart_disease:            false,
  smoker:                  :non
};end

def ERRORS;{
  age:              "age must be in range: " + QDiabetes.AGE_RANGE.to_s,
  bmi:              "bmi must be in range: " + QDiabetes.BMI_RANGE.to_s,
  ethnicity:        "invalid ethnicity type, options: " + QDiabetes.ETHNICITY_TYPES.join,
  gender:           "invalid gender, options: " + QDiabetes.GENDERS.join,
  smoker:           "invalid smoker type, options: " + QDiabetes.SMOKER_TYPES.join
};end

def ETHNICITY_TYPES;[
  :white,
  :indian,
  :pakistani,
  :bangladeshi,
  :other_asian,
  :black_caribbean,
  :black_african,
  :chinese,
  :other
];end

def GENDERS;[
  :male,
  :female
];end

def SMOKER_TYPES;[
  :non,
  :ex,
  :light,
  :moderate,
  :heavy
];end

def AGE_SCALE;            0.1; end

def AGE_CONTINUOUS;{
  male:{
    age_upper:            4.4205598323371680000000000,
    age_lower:           -0.0041132238299394193000000
  },
  female:{
    age_upper:            4.3848331212989669000000000,
    age_lower:           -0.0049763964406541149000000
  }
};end

def AGE_POLYNOMIAL;{
  male:{
    age_upper:            lambda{|_| Math.log _},
    age_lower:            3
  },
  female:{
    age_upper:            lambda{|_| _**0.5},
    age_lower:            3
  }
};end

def AGE_CENTERING;{
  male:{
    age_upper:            1.496771812438965,
    age_lower:           89.149559020996094
  },
  female:{
    age_upper:            2.135220289230347,
    age_lower:           94.766799926757813
  }
};end

def AGE_RANGE; (25..84); end


def BLOOD_PRESSURE_TREATMENT_INDEPENDENT;{
  male:                   0.5010787979849035100000000,
  female:                 0.5314598436974725700000000
};end

def BMI_SCALE;            0.1; end

def BMI_POLYNOMIAL;{
  male:{
    bmi_upper:            2,
    bmi_lower:            3
  },
  female:{
    bmi_upper:            1,
    bmi_lower:            3
  }
};end

def BMI_CENTERING;{
  male:{
    bmi_upper:            6.832604885101318,
    bmi_lower:           17.859918594360352
  },
  female:{
    bmi_upper:            2.549620866775513,
    bmi_lower:           16.573980331420898
  }
};end

def BMI_CONTINUOUS;{
  male:{
    bmi_upper:            1.1169895991721528000000000,
    bmi_lower:           -0.1793529530251269100000000
  },
  female:{
    bmi_upper:            3.3753336326064329000000000,
    bmi_lower:           -0.0631628488667318330000000
  }
};end

def BMI_DEPENDENT;{
  male:{
    age_upper:{
      bmi_upper:          0.5051031253768063500000000,
      bmi_lower:         -0.1375233635462656000000000
    },
    age_lower:{
      bmi_upper:         -0.0015800686452772700000000,
      bmi_lower:          0.0003394090057824062300000
    }
  },
  female:{
    age_upper:{
      bmi_upper:          1.3037832873997990000000000,
      bmi_lower:         -0.0708293717769046120000000
    },
    age_lower:{
      bmi_upper:         -0.0067725323761278549000000,
      bmi_lower:          0.0002374980728666116700000
    }
  }
};end

def BMI_RANGE; (20..40); end

def CORTICOSTEROIDS_INDEPENDENT;{
  male:                   0.2059811979905692400000000,
  female:                 0.2681990966241487000000000
};end

def DECADE_ODDS;{
  male:                   0.974455237388611,
  female:                 0.982810735702515
};end

def DIABETES_RELATIVE_DEPENDENT;{
  male:{
    age_upper:           -1.1463560542602569000000000,
    age_lower:            0.0018524160353981260000000
  },
  female:{
    age_upper:           -0.7968266815834251800000000,
    age_lower:            0.0017048228889394394000000
  }
};end

def DIABETES_RELATIVE_INDEPENDENT;{
  male:                   0.8385800403428993500000000,
  female:                 0.7315358845837640600000000
};end

def ETHNICITY_RISK;{
  male:{
    white:                0,
    indian:               1.2366090720913343000000000,
    pakistani:            1.4716746107789032000000000,
    bangladeshi:          1.8073235649498174000000000,
    other_asian:          1.2056055595936399000000000,
    black_caribbean:      0.6032369975938766100000000,
    black_african:        0.9095436207452737300000000,
    chinese:              0.9137604632927512900000000,
    other:                0.7123719045990779500000000
  },
  female:{
    white:                0,
    indian:               1.2672136244963337000000000,
    pakistani:            1.4277605208830098000000000,
    bangladeshi:          1.8624060798103199000000000,
    other_asian:          1.2379988338989651000000000,
    black_caribbean:      0.4709034172907677900000000,
    black_african:        0.3476400901703160500000000,
    chinese:              1.1587283467731935000000000,
    other:                0.7335499325010315100000000
  }
};end

def HEART_DISEASE_INDEPENDENT;{
  male:                   0.3914728454990503100000000,
  female:                 0.3596176830984252900000000
};end

def SMOKER_INDEPENDENT;{
  male:{
    non:                  0,
    ex:                   0.1618238582395977700000000,
    light:                0.1902020385619117000000000,
    moderate:             0.3210636179312467100000000,
    heavy:                0.4140001301797494600000000
  },
  female:{
    non:                  0,
    ex:                   0.1012537024947505100000000,
    light:                0.1915520564380613400000000,
    moderate:             0.3091894136143333900000000,
    heavy:                0.4646730392693820800000000
  }
};end

def to_i value
  (value.eql? true or value.to_s == "true" or (
    value.to_f != 0 if value.respond_to? 'to_f'
  )) ? 1 : 0
end

end

puts QDiabetes.eval eval(ARGV[0].to_s) if ARGV.length !=0

