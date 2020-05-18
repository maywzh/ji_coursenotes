/*
 * Copyright (c) 2006, Seweryn Habdank-Wojewodzki
 * Copyright (c) 2006, Janusz Rybarski
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms,
 * with or without modification, are permitted provided
 * that the following conditions are met:
 *
 * Redistributions of source code must retain the above
 * copyright notice, this list of conditions and the
 * following disclaimer.
 *
 * Redistributions in binary form must reproduce the
 * above copyright notice, this list of conditions
 * and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
 * AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * e-mail: habdank AT gmail DOT com
 * e-mail: janusz.rybarski AT gmail DOT com
 *
 * File created: Mon 06 Feb 2006 17:51:24 CET
 * Last modified: Wed 08 Aug 2007 18:28:01 CEST
 */

#include "configuration.hpp"

/**
 * \file configuration.cpp
 * \ingroup config
 * \brief File contains code for functions of the template ::config::Basic_configuration.
 */

namespace config
{
    ::boost::int32_t do_program_options
    (
        ::boost::int32_t argc, char * argv[],
        Configuration & conf_
    )
    {
        namespace bpo = ::boost::program_options;

        // prepare 3 separated groups of options
        bpo::options_description generic_opts ( "Generic options",screen_width ); // e.g.-h help -V version
        bpo::options_description config_opts ( "Configuration",screen_width ); // for configuring program
        bpo::options_description hidden_opts ( "Hidden options",screen_width ); // e.g. input file

        // add options
        generic_opts.add_options()
             ( "help,h", "help message" )
             ( "version,V", "version string" );

        // add options
        config_opts.add_options()
            (
                "verbose,v",
                bpo::value< ::boost::int32_t > ( &conf_.parameters.verbosity )->default_value ( 0 ),
                "verbosity level"
            )
            (
                "no-rows,r",
                bpo::value< ::boost::uint32_t > ( &conf_.parameters.no_rows )->default_value ( 2 ),
                "number of rows in kohonen network"
            )
            (
                "no-columns,c",
                bpo::value< ::boost::uint32_t > ( &conf_.parameters.no_columns )->default_value ( 3 ),
                "number of columns in kohonen network"
            )
            (
                "no-epochs,e",
                bpo::value< ::boost::uint32_t > ( &conf_.parameters.no_epochs )->default_value ( 20 ),
                "number of training epochs"
            );

        // add options
        hidden_opts.add_options()
            (
                "input-file,i",
                bpo::value< ::std::string > ( &conf_.parameters.input_file_name ),
                "input file name"
            );

        // set that if there is no options set then input file could be taken
        // without explicit declaration that input file is set
        // e.g. pf--input-file myfile.csv is the same as
        // pf myfile.csv
        bpo::positional_options_description popts;
        popts.add ( "input-file", -1 );

        // add all options to set of options
        bpo::options_description cmdline_options;
        cmdline_options.add ( generic_opts ).add ( config_opts ).add ( hidden_opts );

        // not all options are available in the config file
        bpo::options_description config_file_options;
        config_file_options.add ( config_opts ).add ( hidden_opts );

        // display only generic and config options
        bpo::options_description visible ( "Allowed options" );
        visible.add ( generic_opts ).add ( config_opts );

        // set local variables
        bpo::variables_map vm;
        // parse command line
        bpo::store ( bpo::command_line_parser ( argc, argv ).options ( cmdline_options ).positional ( popts ).run(), vm );
        // set parameters
        bpo::notify ( vm );

        // if-h is chosen then print help
        if ( vm.count ( "help" ) )
        {
            ::std::cout << std::endl << conf_.get_program_name() << " ";
            ::std::cout << conf_.get_version_string() << ::std::endl << ::std::endl;
            ::std::cout << "Program usage: pf [OPTIONS] [FILE]" << ::std::endl << ::std::endl;
            ::std::cout << "If FILE is not given then standard input ( stdin ) is taken as input stream." << ::std::endl;
            ::std::cout << cmdline_options << ::std::endl;

            return EXIT_SUCCESSFUL;
        }

        // if-V then print version number
        if ( vm.count ( "version" ) )
        {
            ::std::cout << conf_.get_program_name() << " ";
            ::std::cout << conf_.get_version_string() << ::std::endl;

            return EXIT_SUCCESSFUL;
        }

        // if verbosity is set then
        if ( conf_.parameters.verbosity > 0 )
        {
            if ( vm.count ( "input-file" ) )
            {
                ::std::cout << "Input file is: " << conf_.parameters.input_file_name << "\n";
            }
            else
            {
                ::std::cout << "Input file was not set- standard input is treated as input." << ::std::endl;
            }

            // if stronger verbosity is set
            if ( conf_.parameters.verbosity > 0 )
            {
                if ( vm.count ( "no-rows" ) )
                {
                    ::std::cout << "Number of rows in kohonen network is: " << conf_.parameters.no_rows << "\n";
                }

                if ( vm.count ( "no-columns" ) )
                {
                    ::std::cout << "Number of columns in kohonen network is: " << conf_.parameters.no_columns << "\n";
                }

                if ( vm.count ( "no-epochs" ) )
                {
                    ::std::cout << "Number of epochs of the training algorithm is: " << conf_.parameters.no_epochs << "\n";
                }
            }
        }
        // exit with proper status
        return PROCEED;
    }
} // namespace config

