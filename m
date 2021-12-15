Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D7C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Dec 2021 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhLOCBO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Dec 2021 21:01:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:14966 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239026AbhLOCBO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 14 Dec 2021 21:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639533674; x=1671069674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U20nyyEoj+csLH5pbQ+ETBDoOx42ji5shnMmCW347zQ=;
  b=RXjiGOKKRmLXoHUOybVhXXq1BSqB2k8Bv+rwgVb9AhvKaKK/J0sqV/bv
   Lz8mINLCoQCEKD2OuQX++AbG5V4TQ8x03f0YSDb1cvEALmP4ht1wiXttR
   KqJvRu7qcDNqZOn75Mlr1kshXqPhpuB4jBuTikW+/0F/4SkGMkXWERQSr
   i4KtccRBZNHKcTBHG5h4wC8HJSk+HuzCGKIBvGypwmhqwpLRXm+KGmEF/
   nm+iSFHmNWDBMM0IleYF1DsivzeHezpAc7DVt5PxA+QVqhMXmy+SAX4Kc
   miwjWuhSVo//nuqx8324nMJ7SeuKZryv3IWFIeux9Bcm/0oMf9Iunv5fP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="237863363"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="237863363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 18:01:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465342029"
Received: from ooniyind-mobl.amr.corp.intel.com (HELO vverma7-mobl4.amr.corp.intel.com) ([10.254.4.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 18:01:13 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH] scripts: Add a man page template generator
Date:   Tue, 14 Dec 2021 19:01:02 -0700
Message-Id: <20211215020102.97880-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a script to generate man page templates for the utils and libraries
under ndctl - including cxl, libcxl, ndctl, and daxctl.

The script can control certain include options depending on the options
supplied, and either dump the templates to stdout, or write the actual
files in their eventual directories, and open up an editor to further
edit them (unless --no-edit is used).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 scripts/docsurgeon                     | 339 +++++++++++++++++++++++++
 scripts/docsurgeon_parser_generator.m4 |  23 ++
 2 files changed, 362 insertions(+)
 create mode 100755 scripts/docsurgeon
 create mode 100644 scripts/docsurgeon_parser_generator.m4

diff --git a/scripts/docsurgeon b/scripts/docsurgeon
new file mode 100755
index 0000000..ca0ad78
--- /dev/null
+++ b/scripts/docsurgeon
@@ -0,0 +1,339 @@
+#!/bin/bash -eE
+
+this_script="docsurgeon"
+script_dir="$(cd "$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")" && pwd)"
+env_file="${script_dir}/.env"
+if [ -e "$env_file" ]; then
+	# shellcheck source=.env
+	. "$env_file"
+fi
+
+sources_file="${script_dir}/.sources"
+
+parser_generator="${script_dir}/${this_script}_parser_generator.m4"
+parser_lib="${script_dir}/${this_script}_parser.sh"
+if [ ! -e "$parser_lib" ] || [ "$parser_generator" -nt "$parser_lib" ]; then
+	if command -V argbash > /dev/null; then
+		argbash --strip user-content "$parser_generator" -o "$parser_lib"
+	else
+		echo "error: please install argbash" >&2
+		exit 1
+	fi
+fi
+
+if [[ $1 != "bin" ]]; then
+	# shellcheck source=docsurgeon_parser.sh
+	. "${script_dir}/${this_script}_parser.sh" || { echo "Couldn't find $parser_lib" >&2; exit 1; }
+fi
+
+# some script defaults - override using '.env'
+docbase="Documentation"
+copyright_cli="// SPDX-License-Identifier: GPL-2.0"
+copyright_footer_cli="include::../copyright.txt[]"
+copyright_lib="// SPDX-License-Identifier: LGPL-2.0"
+copyright_footer_lib="include::../../copyright.txt[]"
+
+# List of files we're creating, to be edited/renamed later
+# This starts out blank, and is filled in as we go by gen_*() functions
+declare -a outfiles
+
+cleanup()
+{
+	if [ ${#outfiles[@]} -gt 0 ]; then
+		rm -f "${outfiles[@]}"
+	fi
+	set +x
+}
+
+trap cleanup EXIT
+
+auto_detect_params()
+{
+	fs=""
+	module=""
+	section=""
+
+	# if module and section were explicitly specified, respect them
+	if [[ $_arg_module ]] && [[ $_arg_section ]]; then
+		return
+	fi
+
+	# check if names are self-consistent, and determine 'fs'
+	for name in ${_arg_name[@]}; do
+		if [[ ! $fs ]]; then
+			if [[ $name == *-* ]]; then
+				fs="-"
+			elif [[ $name == *_* ]]; then
+				fs="_"
+			else
+				# can't autodetect section
+				return
+			fi
+		fi
+		if [[ $fs == "-" ]] && [[ $name == *_* ]]; then
+			die "can't auto-detect params with mixed-style names"
+		fi
+		if [[ $fs == "_" ]] && [[ $name == *-* ]]; then
+			die "can't auto-detect params with mixed-style names"
+		fi
+	done
+
+	# try to detect module name
+	for name in ${_arg_name[@]}; do
+		str=${name%%$fs*}
+		if [[ $module ]]; then
+			if [[ $str != $module ]]; then
+				die "Can't autodetect module because of mixed names ($str and $module)"
+			fi
+		else
+			module="$str"
+		fi
+	done
+
+	# try to detect section number
+	case "$fs" in
+	-)
+		section=1
+		;;
+	_)
+		section=3
+		;;
+	*)
+		die "Unknown fs, can't autodetect section number"
+		;;
+	esac
+
+	if [[ $module ]]; then
+		_arg_module="$module"
+	fi
+	if [[ $section ]]; then
+		_arg_section="$section"
+	fi
+}
+
+process_options_logic()
+{
+	if [[ $_arg_debug == "on" ]]; then
+		set -x
+	fi
+
+	auto_detect_params
+}
+
+gen_underline()
+{
+	name="$1"
+	char="$2"
+	num="${#name}"
+
+	printf -v tmpstring "%-${num}s" " "
+	echo "${tmpstring// /$char}"
+}
+
+gen_header()
+{
+	printf "\n%s\n%s\n" "$1" "$(gen_underline "$1" "=")"
+}
+
+gen_section()
+{
+	printf "\n%s\n%s\n" "$1" "$(gen_underline "$1" "-")"
+}
+
+gen_section_name()
+{
+	name="$1"
+
+	gen_section "NAME"
+	cat <<- EOF
+		$name - 
+	EOF
+}
+
+gen_section_synopsis_1()
+{
+	name="$1"
+
+	gen_section "SYNOPSIS"
+	cat <<- EOF
+		[verse]
+		'$_arg_module ${name#*-} [<options>]'
+	EOF
+}
+
+gen_section_synopsis_3()
+{
+	name="$1"
+
+	gen_section "SYNOPSIS"
+	cat <<- EOF
+		[verse]
+		----
+		#include <$_arg_module/lib$_arg_module.h>
+
+		<type> $name();
+		----
+	EOF
+}
+
+gen_section_example_1()
+{
+	name="$1"
+
+	gen_section "EXAMPLE"
+	cat <<- EOF
+		----
+		# $_arg_module ${name#*-}
+		----
+	EOF
+}
+
+gen_section_example_3()
+{
+	name="$1"
+
+	gen_section "EXAMPLE"
+	cat <<- EOF
+		See example usage in test/lib$_arg_module.c
+	EOF
+}
+
+gen_section_options_1()
+{
+	gen_section "OPTIONS"
+cat << EOF
+-o::
+--option::
+	Description
+EOF
+
+	if [[ $_arg_human_option == "on" ]]; then
+		printf "\n%s\n" "include::human-option.txt[]"
+	fi
+	if [[ $_arg_verbose_option == "on" ]]; then
+		printf "\n%s\n" "include::verbose-option.txt[]"
+	fi
+}
+
+gen_section_seealso_1()
+{
+	gen_section "SEE ALSO"
+	cat <<- EOF
+	link$_arg_module:$_arg_module-list[$_arg_section],
+	EOF
+}
+
+gen_section_seealso_3()
+{
+	gen_section "SEE ALSO"
+	cat <<- EOF
+	linklib$_arg_module:${_arg_module}_other_API[$_arg_section],
+	EOF
+}
+
+gen_cli()
+{
+	name="$1"
+	path="$docbase/$_arg_module"
+	if [ ! -d "$path" ]; then
+		die "Not found: $path"
+	fi
+
+	tmp="$(mktemp -p "$path" "$name.txt.XXXX")"
+	outfiles+=("$tmp")
+
+	# Start template generation
+	printf "%s\n" "$copyright_cli" > "$tmp"
+	gen_header "$name" >> "$tmp"
+	gen_section_name "$name" >> "$tmp"
+	gen_section_synopsis_1 "$name" >> "$tmp"
+	gen_section "DESCRIPTION" >> "$tmp"
+	gen_section_example_1 "$name" >> "$tmp"
+	gen_section_options_1 >> "$tmp"
+	printf "\n%s\n" "$copyright_footer_cli" >> "$tmp"
+	gen_section_seealso_1 >> "$tmp"
+}
+
+gen_lib()
+{
+	name="$1"
+	path="$docbase/$_arg_module/lib"
+	if [ ! -d "$path" ]; then
+		die "Not found: $path"
+	fi
+
+	tmp="$(mktemp -p "$path" "$name.txt.XXXX")"
+	outfiles+=("$tmp")
+
+	# Start template generation
+	printf "%s\n" "$copyright_lib" > "$tmp"
+	gen_header "$name($_arg_section)" >> "$tmp"
+	gen_section_name "$name" >> "$tmp"
+	gen_section_synopsis_3 "$name" >> "$tmp"
+	gen_section "DESCRIPTION" >> "$tmp"
+	gen_section "RETURN VALUE" >> "$tmp"
+	gen_section_example_3 "$name" >> "$tmp"
+	printf "\n%s\n" "$copyright_footer_lib" >> "$tmp"
+	gen_section_seealso_3 >> "$tmp"
+}
+
+gen_man()
+{
+	name="$1"
+	case "$_arg_section" in
+	1)
+		gen_cli "$name"
+		;;
+	3)
+		gen_lib "$name"
+		;;
+	*)
+		die "Unknown section: $_arg_section"
+		;;
+	esac
+}
+
+gen_include()
+{
+	echo "in gen_include"
+}
+
+main()
+{
+	process_options_logic
+
+	cmd="$_arg_command"
+	case "$cmd" in
+	gen-man)
+		for name in ${_arg_name[@]}; do
+			gen_man "$name"
+		done
+		;;
+	gen-include)
+		for name in ${_arg_name[@]}; do
+			gen_include
+		done
+		;;
+	*)
+		die "Unknown command: $cmd"
+		;;
+	esac
+
+	if [[ $_arg_dump == "on" ]]; then
+		for file in ${outfiles[@]}; do
+			echo "${file##*/}"
+			cat "$file"
+			rm "$file"
+		done
+	elif [ ${#outfiles[@]} -gt 0 ]; then
+		if [[ $_arg_edit = "on" ]]; then
+			vim -p "${outfiles[@]}"
+		fi
+
+		for file in ${outfiles[@]}; do
+			mv "$file" "${file%.*}"
+		done
+	fi
+}
+
+main "$@"
diff --git a/scripts/docsurgeon_parser_generator.m4 b/scripts/docsurgeon_parser_generator.m4
new file mode 100644
index 0000000..9283c7c
--- /dev/null
+++ b/scripts/docsurgeon_parser_generator.m4
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+# m4_ignore(
+echo "This is just a parsing library template, not the library - pass this file to 'argbash' to fix this." >&2
+exit 11  #)Created by argbash-init v2.9.0
+# Rearrange the order of options below according to what you would like to see in the help message.
+# ARG_OPTIONAL_REPEATED([name], [n], [Command or function name to generate a template for.\n Can be repeated for multiple names. ], [])
+# ARG_OPTIONAL_BOOLEAN([edit], [e], [Edit template files after creation], [on])
+# ARG_OPTIONAL_BOOLEAN([debug], [], [Debug script problems (enables set -x)], )
+# ARG_OPTIONAL_BOOLEAN([dump], [], [Write generated file to stdout instead of a file], )
+# ARG_OPTIONAL_SINGLE([module], [m], [Module (Docs subdir) in which to create the template], [])
+# ARG_OPTIONAL_SINGLE([section], [s], [man section for which to create the template], [])
+# ARG_OPTIONAL_BOOLEAN([human-option], [u], [Include the human option in 'OPTIONS'], )
+# ARG_OPTIONAL_BOOLEAN([verbose-option], [V], [Include the verbose option in 'OPTIONS'], )
+# ARG_POSITIONAL_DOUBLEDASH()
+# ARG_POSITIONAL_SINGLE([command], [Operation to perform:\n  gen-man\n  gen-include], [])
+# ARGBASH_SET_DELIM([ =])
+# ARG_OPTION_STACKING([getopt])
+# ARG_RESTRICT_VALUES([no-local-options])
+# ARG_DEFAULTS_POS
+# ARG_HELP([Tool to aid in creating and managing man page templates])
+# ARG_VERSION([echo "docsurgeon 0.1"])
+# ARGBASH_GO
-- 
2.33.1

