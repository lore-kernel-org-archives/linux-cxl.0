Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCCC433DB
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 21:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C82064D74
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 21:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhBVVmN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:42:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:16324 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhBVVlf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 22 Feb 2021 16:41:35 -0500
IronPort-SDR: hR50j+uqg7QanHrJj/Jpm4gibRdRej5pzplv2+vOdqXiqkITXE+Paxa+irbWjwMKnTRz6dAg4D
 9/5KKUIdCFVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="248658632"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="248658632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:41:09 -0800
IronPort-SDR: 0ckPDhRhKnZTcayX+JFJcTg3Fiic/fNHlmWVvnQ+iKYHi867JsmXnT4ez4lBBIofBf64AotELf
 ZsE9viOHuMqw==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="596134749"
Received: from hlgebhar-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.144])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:41:08 -0800
Date:   Mon, 22 Feb 2021 13:41:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 02/13] cxl: add a local copy of the cxl_mem UAPI
 header
Message-ID: <20210222214106.pz5f3czykq3r7ojw@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
 <20210219020331.725687-3-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219020331.725687-3-vishal.l.verma@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-18 19:03:20, Vishal Verma wrote:
> While CXL functionality is under development, it is useful to have a
> local copy of the UAPI header for cxl_mem definitions. This allows
> building cxl and libcxl on systems where the appropriate kernel headers
> are not installed in the usual locations.

It it meant to be able to use a system, or dev copy of cxl_mem.h? Could you
maybe spell out in the commit message how one could select between the two?

> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Makefile.am         |   3 +-
>  Makefile.am.in      |   1 +
>  cxl/cxl_mem.h       | 181 ++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/Makefile.am |   2 +-
>  4 files changed, 185 insertions(+), 2 deletions(-)
>  create mode 100644 cxl/cxl_mem.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 428fd40..4904ee7 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -89,4 +89,5 @@ libutil_a_SOURCES = \
>  
>  nobase_include_HEADERS = \
>  	daxctl/libdaxctl.h \
> -	cxl/libcxl.h
> +	cxl/libcxl.h \
> +	cxl/cxl_mem.h
> diff --git a/Makefile.am.in b/Makefile.am.in
> index aaeee53..a748128 100644
> --- a/Makefile.am.in
> +++ b/Makefile.am.in
> @@ -11,6 +11,7 @@ AM_CPPFLAGS = \
>  	-DNDCTL_MAN_PATH=\""$(mandir)"\" \
>  	-I${top_srcdir}/ndctl/lib \
>  	-I${top_srcdir}/ndctl \
> +	-I${top_srcdir}/cxl \
>  	-I${top_srcdir}/ \
>  	$(KMOD_CFLAGS) \
>  	$(UDEV_CFLAGS) \
> diff --git a/cxl/cxl_mem.h b/cxl/cxl_mem.h
> new file mode 100644
> index 0000000..be9c7ad
> --- /dev/null
> +++ b/cxl/cxl_mem.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2020-2021, Intel Corporation. All rights reserved. */
> +/*
> + * CXL IOCTLs for Memory Devices
> + */
> +
> +#ifndef _UAPI_CXL_MEM_H_
> +#define _UAPI_CXL_MEM_H_
> +
> +#include <linux/types.h>
> +#include <sys/user.h>
> +#include <unistd.h>
> +
> +#define __user
> +
> +/**
> + * DOC: UAPI
> + *
> + * CXL memory devices expose UAPI to have a standard user interface.
> + * Userspace can refer to these structure definitions and UAPI formats
> + * to communicate to driver. The commands themselves are somewhat obfuscated
> + * with macro magic. They have the form CXL_MEM_COMMAND_ID_<name>.
> + *
> + * For example "CXL_MEM_COMMAND_ID_INVALID"
> + *
> + * Not all of all commands that the driver supports are always available for use
> + * by userspace. Userspace must check the results from the QUERY command in
> + * order to determine the live set of commands.
> + */
> +
> +#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> +#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
> +
> +#define CXL_CMDS                                                          \
> +	___C(INVALID, "Invalid Command"),                                 \
> +	___C(IDENTIFY, "Identify Command"),                               \
> +	___C(RAW, "Raw device command"),                                  \
> +	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> +	___C(GET_FW_INFO, "Get FW Info"),                                 \
> +	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> +	___C(GET_LSA, "Get Label Storage Area"),                          \
> +	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> +	___C(GET_LOG, "Get Log"),                                         \
> +	___C(MAX, "Last command")
> +
> +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> +enum { CXL_CMDS };
> +
> +#undef ___C
> +#define ___C(a, b) { b }
> +static const struct {
> +	const char *name;
> +} cxl_command_names[] = { CXL_CMDS };
> +#undef ___C
> +
> +/**
> + * struct cxl_command_info - Command information returned from a query.
> + * @id: ID number for the command.
> + * @flags: Flags that specify command behavior.
> + *
> + *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
> + *    kernel use.
> + *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
> + *    the kernel in order to complete successfully.
> + *
> + * @size_in: Expected input size, or -1 if variable length.
> + * @size_out: Expected output size, or -1 if variable length.
> + *
> + * Represents a single command that is supported by both the driver and the
> + * hardware. This is returned as part of an array from the query ioctl. The
> + * following would be a command named "foobar" that takes a variable length
> + * input and returns 0 bytes of output.
> + *
> + *  - @id = 10
> + *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
> + *  - @size_in = -1
> + *  - @size_out = 0
> + *
> + * See struct cxl_mem_query_commands.
> + */
> +struct cxl_command_info {
> +	__u32 id;
> +
> +	__u32 flags;
> +#define CXL_MEM_COMMAND_FLAG_NONE 0
> +#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
> +#define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
> +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(1, 0)

This is changed upstream, but shouldn't effect much.

> +
> +	__s32 size_in;
> +	__s32 size_out;
> +};
> +
> +/**
> + * struct cxl_mem_query_commands - Query supported commands.
> + * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
> + *		return min(num_support_commands, n_commands). When @n_commands
> + *		is 0, driver will return the number of total supported commands.
> + * @rsvd: Reserved for future use.
> + * @commands: Output array of supported commands. This array must be allocated
> + *            by userspace to be at least min(num_support_commands, @n_commands)
> + *
> + * Allow userspace to query the available commands supported by both the driver,
> + * and the hardware. Commands that aren't supported by either the driver, or the
> + * hardware are not returned in the query.
> + *
> + * Examples:
> + *
> + *  - { .n_commands = 0 } // Get number of supported commands
> + *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
> + *    supported commands
> + *
> + *  See struct cxl_command_info.
> + */
> +struct cxl_mem_query_commands {
> +	/*
> +	 * Input: Number of commands to return (space allocated by user)
> +	 * Output: Number of commands supported by the driver/hardware
> +	 *
> +	 * If n_commands is 0, kernel will only return number of commands and
> +	 * not try to populate commands[], thus allowing userspace to know how
> +	 * much space to allocate
> +	 */
> +	__u32 n_commands;
> +	__u32 rsvd;
> +
> +	struct cxl_command_info __user commands[]; /* out: supported commands */
> +};
> +
> +/**
> + * struct cxl_send_command - Send a command to a memory device.
> + * @id: The command to send to the memory device. This must be one of the
> + *	commands returned by the query command.
> + * @flags: Flags for the command (input).
> + * @raw: Special fields for raw commands
> + * @raw.opcode: Opcode passed to hardware when using the RAW command.
> + * @raw.rsvd: Must be zero.
> + * @rsvd: Must be zero.
> + * @retval: Return value from the memory device (output).
> + * @in.size: Size of the payload to provide to the device (input).
> + * @in.rsvd: Must be zero.
> + * @in.payload: Pointer to memory for payload input (little endian order).
> + * @out.size: Size of the payload received from the device (input/output). This
> + *	      field is filled in by userspace to let the driver know how much
> + *	      space was allocated for output. It is populated by the driver to
> + *	      let userspace know how large the output payload actually was.
> + * @out.rsvd: Must be zero.
> + * @out.payload: Pointer to memory for payload output (little endian order).
> + *
> + * Mechanism for userspace to send a command to the hardware for processing. The
> + * driver will do basic validation on the command sizes. In some cases even the
> + * payload may be introspected. Userspace is required to allocate large
> + * enough buffers for size_out which can be variable length in certain
> + * situations.
> + */
> +struct cxl_send_command {
> +	__u32 id;
> +	__u32 flags;
> +	union {
> +		struct {
> +			__u16 opcode;
> +			__u16 rsvd;
> +		} raw;
> +		__u32 rsvd;
> +	};
> +	__u32 retval;
> +
> +	struct {
> +		__s32 size;
> +		__u32 rsvd;
> +		__u64 payload;
> +	} in;
> +
> +	struct {
> +		__s32 size;
> +		__u32 rsvd;
> +		__u64 payload;
> +	} out;
> +};
> +
> +#endif
> diff --git a/cxl/lib/Makefile.am b/cxl/lib/Makefile.am
> index 277f0cd..72c9ccd 100644
> --- a/cxl/lib/Makefile.am
> +++ b/cxl/lib/Makefile.am
> @@ -3,7 +3,7 @@ include $(top_srcdir)/Makefile.am.in
>  %.pc: %.pc.in Makefile
>  	$(SED_PROCESS)
>  
> -pkginclude_HEADERS = ../libcxl.h
> +pkginclude_HEADERS = ../libcxl.h ../cxl_mem.h

Do you do this for ndctl? It seems weird to install a Linux UAPI header via
libcxl. You will end up with potentially divergent:
/usr/include/libcxl/cxl_mem.h
/usr/include/linux/cxl_mem.h

>  lib_LTLIBRARIES = libcxl.la
>  
>  libcxl_la_SOURCES =\
> -- 
> 2.29.2
> 
