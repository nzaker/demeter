package Demeter::StrTypes;

# predeclare our own types
use MooseX::Types -declare => [qw( Empty
				   IfeffitCommand
				   IfeffitFunction
				   IfeffitProgramVar
				   Window
				   PathParam
				   Element
				   Edge
				   AtomsEdge
				   FeffCard
				   Clamp
				   Config
				   Statistic
				   AtomsLattice
				   AtomsGas
				   AtomsObsolete
				   SpaceGroup
				   Plotting
				   DataPart
				   FitSpace
				   DataType
				   TemplateProcess
				   TemplateFit
				   TemplatePlot
				   TemplateFeff
				   TemplateAnalysis
				   PgplotLine
				   MERIP
				   PlotWeight
				   Interp
				   GDS
				   NotReserved
				)];

## to do: modes

# import builtin types
use MooseX::Types::Moose 'Str';

use Regexp::List;
use Regexp::Optimizer;
my $opt  = Regexp::List->new;


subtype Empty,
  as Str,
  where { lc($_) =~ m{\A\s*\z} },
  message { "That string is not an empty string" };

## -------- Ifeffit commands
use vars qw(@command_list $command_regexp);
@command_list = (qw{ f1f2 bkg_cl chi_noise color comment correl cursor
		     def echo erase exit feffit ff2chi fftf fftr
		     get_path guess history linestyle load
		     log macro minimize newplot path pause plot
		     plot_arrow plot_marker plot_text pre_edge print
		     quit random read_data rename reset restore
		     save set show spline sync unguess window
		     write_data zoom } );
$command_regexp = $opt->list2re( @command_list );
subtype IfeffitCommand,
  as Str,
  where { lc($_) =~ m{\A$command_regexp\z} },
  message { "That string is not an Ifeffit command" };


## -------- Ifeffit function
use vars qw(@function_list $function_regexp);
@function_list = qw{abs min max sign sqrt exp log ln log10 sin cos tan asin acos
		    atan sinh tanh coth gamma loggamma erf erfc gauss loren pvoight debye
		    eins npts ceil floor vsum vprod indarr ones zeros range deriv penalty
		    smooth interp qinterp splint eins debye };
$function_regexp = $opt->list2re( @function_list );
subtype IfeffitFunction,
  as Str,
  where { lc($_) =~ m{\A$function_regexp\z} },
  message { "That string is not an Ifeffit function" };

## -------- Ifeffit program variables
use vars qw(@program_list $program_regexp);
@program_list = qw(chi_reduced chi_square core_width correl_min
		   cursor_x cursor_y dk dr data_set data_total
		   dk1 dk2 dk1_spl dk2_spl dr1 dr2 e0 edge_step
		   epsilon_k epsilon_r etok kmax kmin kmax_spl
		   kmax_suggest kmin_spl kweight kweight_spl kwindow
		   n_idp n_varys ncolumn_label nknots norm1 norm2
		   norm_c0 norm_c1 norm_c2 path_index pi pre1 pre2
		   pre_offset pre_slope qmax_out qsp r_factor rbkg
		   rmax rmax_out rmin rsp rweight rwin rwindow toler);
$program_regexp = $opt->list2re(@program_list);
subtype IfeffitProgramVar,
  as Str,
  where { lc($_) =~ m{\A$program_regexp\z} },
  message { "That string is not an Ifeffit program variable" };

## -------- Window types
use vars qw(@window_list $window_regexp);
@window_list = qw(kaiser-bessel hanning welch parzen sine gaussian);
$window_regexp = $opt->list2re(@window_list);
subtype Window,
  as Str,
  where { lc($_) =~ m{\A$window_regexp\z} },
  message { "That string is not the name of Fourier transform window type" };

## -------- Path Parameters
use vars qw(@pathparam_list $pathparam_regexp);
@pathparam_list = qw(e0 ei sigma2 s02 delr third fourth dphase);
$pathparam_regexp = $opt->list2re(@pathparam_list);
subtype PathParam,
  as Str,
  where { lc($_) =~ m{\A$pathparam_regexp\z} },
  message { "That string is not a path parameter" };

## -------- Element symbols
use vars qw(@element_list $element_regexp);
@element_list = qw(h he li be b c n o f ne na mg al si p s cl ar k ca
		   sc ti v cr mn fe co ni cu zn ga ge as se br kr rb
		   sr y zr nb mo tc ru rh pd ag cd in sn sb te i xe cs
		   ba la ce pr nd pm sm eu gd tb dy ho er tm yb lu hf
		   ta w re os ir pt au hg tl pb bi po at rn fr ra ac
		   th pa u np pu);
$element_regexp = $opt->list2re(@element_list);
subtype Element,
  as Str,
  where { lc($_) =~ m{\A$element_regexp\z} },
  message { "That string is not an element symbol" };

## -------- Edge symbols
use vars qw(@edge_list $edge_regexp);
@edge_list = qw(k l1 l2 l3);
$edge_regexp = $opt->list2re(@edge_list);
subtype Edge,
  as Str,
  where { lc($_) =~ m{\A$edge_regexp\z} },
  message { "That string is not an edge symbol" };

## -------- Atoms Edge symbols
use vars qw(@atomsedge_list $atomsedge_regexp);
@atomsedge_list = qw(1 2 3 4 k l1 l2 l3);
$atomsedge_regexp = $opt->list2re(@atomsedge_list);
subtype AtomsEdge,
  as Str,
  where { lc($_) =~ m{\A$atomsedge_regexp\z} },
  message { "That string is not an atoms edge symbol" };

## -------- Feff "cards"
use vars qw(@feffcard_list $feffcard_regexp);
@feffcard_list = qw(atoms control print title end rmultiplier
		    cfaverage overlap afolp edge hole potentials s02
		    exchange folp nohole rgrid scf unfreezef
		    interstitial ion spin exafs xanes ellipticity ldos
		    multipole polarization danes fprime rphases rsigma
		    tdlda xes xmcd xncd fms debye rpath rmax nleg
		    pcriteria ss criteria iorder nstar debye
		    corrections sig2);
$feffcard_regexp = $opt->list2re(@feffcard_list);
subtype FeffCard,
  as Str,
  where { lc($_) =~ m{\A$feffcard_regexp\z} },
  message { "That string is not a Feff keyword" };

## -------- Clamp words
use vars qw(@clamp_list $clamp_regexp);
@clamp_list = qw(none slight weak medium strong rigid);
$clamp_regexp = $opt->list2re(@clamp_list);
subtype Clamp,
  as Str,
  where { lc($_) =~ m{\A$clamp_regexp\z} },
  message { "That string is not a clamp strength" };


## -------- Configuration keywords
use vars qw(@config_list $config_regexp);
@config_list = qw(type default minint maxint options units onvalue offvalue);
$config_regexp = $opt->list2re(@config_list);
subtype Config,
  as Str,
  where { lc($_) =~ m{\A$config_regexp\z} },
  message { "That string is not a Demeter configuration keyword" };

## -------- Statistics keywords
use vars qw(@stat_list $stat_regexp);
@stat_list = qw(n_idp n_varys chi_square chi_reduced r_factor epsilon_k
		epsilon_r data_total happiness);
$stat_regexp = $opt->list2re(@stat_list);
subtype Statistic,
  as Str,
  where { lc($_) =~ m{\A$stat_regexp\z} },
  message { "That string is not a Demeter statistical parameter" };


## -------- Atoms lattice keywords
use vars qw(@lattice_list $lattice_regexp);
@lattice_list = qw(a b c alpha beta gamma space shift);
$lattice_regexp = $opt->list2re(@lattice_list);
subtype AtomsLattice,
  as Str,
  where { lc($_) =~ m{\A$lattice_regexp\z} },
  message { "That string is not an Atoms lattice keyword" };

## -------- Atoms gas keywords
use vars qw(@gas_list $gas_regexp);
@gas_list = qw(nitrogen argon helium krypton xenon);
$gas_regexp = $opt->list2re(@gas_list);
subtype AtomsGas,
  as Str,
  where { lc($_) =~ m{\A$gas_regexp\z} },
  message { "That string is not an Atoms gas keyword" };

## -------- Atoms obsolete keywords
use vars qw(@obsolete_list $obsolete_regexp);
@obsolete_list = qw(output geom fdat nepoints xanes modules message
		    noanomalous self i0 mcmaster dwarf reflections
		    refile egrid index corrections emin emax estep
		    egrid qvec dafs );
$obsolete_regexp = $opt->list2re(@obsolete_list);
subtype AtomsObsolete,
  as Str,
  where { lc($_) =~ m{\A$obsolete_regexp\z} },
  message { "That string is not an Atoms obsolete keyword" };

## -------- Spacegroup database keys
use vars qw(@sg_list $sg_regexp);
@sg_list = qw(number full new_symbol thirtyfive schoenflies bravais
	      shorthand positions shiftvec npos);
$sg_regexp = $opt->list2re(@sg_list);
subtype SpaceGroup,
  as Str,
  where { lc($_) =~ m{\A$sg_regexp\z} },
  message { "That string is not a spacegroup database key" };

## -------- Plotting backends
use vars qw(@plotting_list $plotting_regexp);
@plotting_list = qw(pgplot gnuplot demeter);
$plotting_regexp = $opt->list2re(@plotting_list);
subtype Plotting,
  as Str,
  where { lc($_) =~ m{\A$plotting_regexp\z} },
  message { "That string is not a Demeter plotting backend" };

## -------- Data parts
use vars qw(@dataparts_list $dataparts_regexp);
@dataparts_list = qw(fit bkg res);
$dataparts_regexp = $opt->list2re(@dataparts_list);
subtype DataPart,
  as Str,
  where { lc($_) =~ m{\A$dataparts_regexp\z} },
  message { "That string is not a Demeter data part" };

## -------- Data types
use vars qw(@datatype_list $datatype_regexp);
@datatype_list = qw(xmu chi xmudat xanes);
$datatype_regexp = $opt->list2re(@datatype_list);
subtype DataType,
  as Str,
  where { lc($_) =~ m{\A$datatype_regexp\z} },
  message { "That string is not a Demeter data type" };

## -------- Fitting spaces
use vars qw(@fitspace_list $fitspace_regexp);
@fitspace_list = qw(k r q);
$fitspace_regexp = $opt->list2re(@fitspace_list);
subtype FitSpace,
  as Str,
  where { lc($_) =~ m{\A$fitspace_regexp\z} },
  message { "That string is not a Demeter fitting space" };


## -------- Mode object type contstraints
##
## is it a good idea to define these type constraints?  if precludes
## the user adding new template sets...
## Possibly, the validation should look for the template set on disk...?
subtype 'TemplateProcess'
      => as 'Str'
      => where { $_ =~ m{\A(?:demeter|ifeffit|iff_columns|feffit)\z}i }
      => message { "That is not a valid processing template group" };
subtype 'TemplateFit'
      => as 'Str'
      => where { $_ =~ m{\A(?:demeter|ifeffit|iff_columns|feffit)\z}i }
      => message { "That is not a valid fitting template group" };
subtype 'TemplatePlot'
      => as 'Str'
      => where { $_ =~ m{\A(?:demeter|gnuplot|pgplot)\z}i }
      => message { "That is not a valid plotting template group" };
subtype 'TemplateFeff'
      => as 'Str'
      => where { $_ =~ m{\Afeff[68]\z}i }
      => message { "That is not a valid Feff template group" };
subtype 'TemplateAnalysis'
      => as 'Str'
      => where { $_ =~ m{\A(?:demeter|ifeffit|iff_columns)\z}i }
      => message { "That is not a valid plotting template group" };


## -------- Line types in PGPLOT
use vars qw(@pgplotlines_list $pgplotlines_regexp);
@pgplotlines_list = qw(solid dashed dotted dot-dash points linespoints);
$pgplotlines_regexp = $opt->list2re(@pgplotlines_list);
subtype PgplotLine,
  as Str,
  where { lc($_) =~ m{\A$pgplotlines_regexp\z} },
  message { "That string is not a PGPLOT line type" };

subtype MERIP,
  as Str,
  where { lc($_) =~ m{\A(?:[merip]|rmr)\z} },
  message { "That string is not a complex function part" };

subtype PlotWeight,
  as Str,
  where { lc($_) =~ m{\A(?:1|2|3|arb)\z} },
  message { "That string is not a plotting k-weight" };

## -------- Ifeffit interpolation functions
use vars qw(@interp_list $interp_regexp);
@interp_list = qw(linterp qinterp splint);
$interp_regexp = $opt->list2re(@interp_list);
subtype Interp,
  as Str,
  where { lc($_) =~ m{\A$interp_regexp\z} },
  message { "That string is not an interpolation type" };

## -------- Parameter types
use vars qw(@gds_list $gds_regexp);
@gds_list = qw(guess def set lguess restrain after skip merge);
$gds_regexp = $opt->list2re(@gds_list);
subtype GDS,
  as Str,
  where { lc($_) =~ m{\A$gds_regexp\z} },
  message { "That string is not a parameter type" };

## -------- Reserved words cannot be parameter names
use vars qw(@notreserved_list $notreserved_regexp);
@notreserved_list = qw(reff pi etok cv);
$notreserved_regexp = $opt->list2re(@notreserved_list);
subtype NotReserved,
  as Str,
  where { lc($_) !~ m{\A$notreserved_regexp\z} },
  message { "reff, pi, etok, and cv are reserved words in Ifeffit or Demeter" };



1;

=head1 NAME

Demeter::StrTypes - String type constraints

=head1 VERSION

This documentation refers to Demeter version 0.3.

=head1 DESCRIPTION

This module implements string type constraints for Moose using
L<MooseX::Types>.

=head1 CONFIGURATION AND ENVIRONMENT

See L<Demeter::Config> for a description of the configuration system.

=head1 DEPENDENCIES

Demeter's dependencies are in the F<Bundle/DemeterBundle.pm> file.

=head1 BUGS AND LIMITATIONS

Please report problems to Bruce Ravel (bravel AT bnl DOT gov)

Patches are welcome.

=head1 AUTHOR

Bruce Ravel (bravel AT bnl DOT gov)

L<http://cars9.uchicago.edu/~ravel/software/>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2006-2009 Bruce Ravel (bravel AT bnl DOT gov). All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlgpl>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut
