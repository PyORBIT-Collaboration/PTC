include ../../conf/make_root_config

DIRS  = $(patsubst %/, %, $(filter %/, $(shell ls -F))))
SRCS  = $(wildcard *.cc)
SRCS += $(foreach dir, $(DIRS), $(patsubst $(dir)/%.cc, %.cc, $(wildcard $(dir)/*.cc)))

OBJS = $(patsubst %.cc, ./obj/%.o, $(SRCS))

FORT_DIRS  = source interface
FORT_SRCS  = $(wildcard *.f90)
FORT_SRCS += $(foreach dir, $(FORT_DIRS), $(patsubst $(dir)/%.f90, %.f90, $(wildcard $(dir)/*.f90)))

FORT_OBJS = $(patsubst %.f90, ./obj/%.o, $(FORT_SRCS))

# Include files can be anywhere, we use only two levels
UPPER_DIRS = $(filter-out test%, $(patsubst %/, %, $(filter %/, $(shell ls -F ../../src))))
LOWER_DIRS = $(foreach dir, $(UPPER_DIRS), $(patsubst %/, ../../src/$(dir)/%, $(filter %/, $(shell ls -F ../../src/$(dir)))))

INCLUDES_LOCAL = $(patsubst %, -I../../src/%, $(UPPER_DIRS))
INCLUDES_LOCAL += $(filter-out %obj, $(patsubst %, -I%, $(LOWER_DIRS)))
INCLUDES_LOCAL += $(patsubst %, -I./%, $(filter %/, $(shell ls -F ./)))
INCLUDES_LOCAL += -I./

INC  = $(wildcard *.hh)
INC += $(wildcard *.h)
INC += $(foreach dir, $(DIRS), $(wildcard ./$(dir)/*.hh))
INC += $(foreach dir, $(DIRS), $(wildcard ./$(dir)/*.h))

#-------------------------------------------------------------------------------
# External library locations
#-------------------------------------------------------------------------------

LIBS += -L/usr/lib/gcc/x86_64-redhat-linux/4.4.4/ -lgfortran

#-------------------------------------------------------------------------------
# External 'include' locations
#-------------------------------------------------------------------------------

INCLUDES +=

#-------------------------------------------------------------------------------
# Wrappers CC FLAGS
#-------------------------------------------------------------------------------

WRAPPER_FLAGS = -fno-strict-aliasing

#-------------------------------------------------------------------------------
# CXXFLAGS
#-------------------------------------------------------------------------------

CXXFLAGS += -fPIC

#-------------------------------------------------------------------------------
# Shared library flags
#-------------------------------------------------------------------------------

SHARED_LIB = -shared

#-------------------------------------------------------------------------------
# ptc-orbit shared library
#-------------------------------------------------------------------------------

ptc_orbit_lib = libptc_orbit.so

#-------------------------------------------------------------------------------
#========rules=========================
#-------------------------------------------------------------------------------

compile: $(OBJS_WRAP) $(FORT_OBJS) $(OBJS) $(INC)
	$(CXX) -fPIC $(SHARED_LIB) $(LIBS) $(LINKFLAGS) -o ../../lib/$(ptc_orbit_lib) $(OBJS) $(FORT_OBJS)
	rm -rf ./*.mod

clean:
	rm -rf ./obj/*.o
	rm -rf ./obj/*.os
	rm -rf ../../lib/$(ptc_orbit_lib)
	rm -rf ./*.mod
	rm -rf ./source/*~

./obj/wrap_%.o : wrap_%.cc $(INC)
	$(CXX) $(CXXFLAGS) $(WRAPPER_FLAGS) $(INCLUDES_LOCAL) $(INCLUDES) -c $< -o $@;

./obj/wrap_%.o : ./*/wrap_%.cc $(INC)
	$(CXX) $(CXXFLAGS) $(WRAPPER_FLAGS) $(INCLUDES_LOCAL) $(INCLUDES) -c $< -o $@;

./obj/%.o : %.cc $(INC)
	$(CXX) $(CXXFLAGS) $(INCLUDES_LOCAL) $(INCLUDES) -c $< -o $@;

./obj/%.o : ./*/%.cc $(INC)
	$(CXX) $(CXXFLAGS) $(INCLUDES_LOCAL) $(INCLUDES) -c $< -o $@;

./obj/%.o : ./source/%.f90
	gfortran -fpic -c $< -o $@;

./obj/%.o : ./interface/%.f90
	gfortran -fpic -I ./source -c $< -o $@;

./obj/Sma_multiparticle.o: ./obj/Sm_tracking.o
./obj/pointers.o : ./obj/Sp_keywords.o
./obj/Sp_keywords.o : ./obj/So_fitting.o
./obj/So_fitting.o : ./obj/Sn_mad_like.o
./obj/Sn_mad_like.o : ./obj/Sma_multiparticle.o
./obj/Sm_tracking.o : ./obj/Sl_family.o
./obj/Sl_family.o : ./obj/Sk_link_list.o
./obj/Sk_link_list.o :  ./obj/Si_def_element.o
./obj/Si_def_element.o : ./obj/Sh_def_kind.o
./obj/Sh_def_kind.o : ./obj/Sf_def_all_kinds.o
./obj/Sf_def_all_kinds.o : ./obj/Se_status.o
./obj/Se_status.o : ./obj/Sd_frame.o
./obj/Sd_frame.o : ./obj/Sc_euclidean.o
./obj/Sc_euclidean.o : ./obj/Sa_extend_poly.o
./obj/Se_status.o : ./obj/Sb_sagan_pol_arbitrary.o
./obj/Si_def_element.o : ./obj/Sg_sagan_wiggler.o
./obj/my_fortran_catia.o : ./obj/zzy_run_madx.o  ./obj/Spc_pointers.o
./obj/zzy_run_madx.o :  ./obj/Spa_fake_mad.o
./obj/Spa_fake_mad.o :  ./obj/Sp_keywords.o
./obj/Sa_extend_poly.o : ./obj/o_tree_element.o
./obj/o_tree_element.o : ./obj/n_complex_polymorph.o
./obj/Sqa_beam_beam_ptc.o : ./obj/Sq_orbit_ptc.o
./obj/Sma0_beam_beam_ptc.o : ./obj/Sm_tracking.o
./obj/Sra_fitting.o : ./obj/Sr_spin.o
