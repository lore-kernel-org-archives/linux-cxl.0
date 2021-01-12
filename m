Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FFC433E0
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E7A22D6D
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbhALAfT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:35:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:52245 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbhALAfB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 11 Jan 2021 19:35:01 -0500
IronPort-SDR: ZPcs394jSM40kdyx5aZDOO876HdrOQVmXoQuFlHrkMq+saieJGOYDlboqkZMgsWC219XWvB0/t
 pHAXXhTfG34Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157736789"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157736789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:20 -0800
IronPort-SDR: ql/yuCwS3FAteOBB2nyODDcqJjqo7iodAveGCbJhTJEzqt694AkYACLZ1+hALhd8RFMbgN9HDJ
 QkE0PngE+iOQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381212090"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:19 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl RFC PATCH 2/5] cxl: add a local copy of the cxl_mem UAPI header
Date:   Mon, 11 Jan 2021 17:34:00 -0700
Message-Id: <20210112003403.2944568-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While CXL functionality is under development, it is useful to have a
local copy of the UAPI header for cxl_mem definitions. This allows
building cxl and libcxl on systems where the appropriate kernel headers
are not installed in the usual locations.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Makefile.am.in      |   1 +
 cxl/cxl_mem.h       | 176 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/Makefile.am |   2 +-
 3 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 cxl/cxl_mem.h

diff --git a/Makefile.am.in b/Makefile.am.in
index 6931d8c..e476bce 100644
--- a/Makefile.am.in
+++ b/Makefile.am.in
@@ -11,6 +11,7 @@ AM_CPPFLAGS = \
 	-DNDCTL_MAN_PATH=\""$(mandir)"\" \
 	-I${top_srcdir}/ndctl/lib \
 	-I${top_srcdir}/ndctl \
+	-I${top_srcdir}/cxl \
 	-I${top_srcdir}/ \
 	$(KMOD_CFLAGS) \
 	$(UDEV_CFLAGS) \
diff --git a/cxl/cxl_mem.h b/cxl/cxl_mem.h
new file mode 100644
index 0000000..ce309e9
--- /dev/null
+++ b/cxl/cxl_mem.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/* Copyright (C) 2020-2021, Intel Corporation. All rights reserved. */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/types.h>
+#include <sys/user.h>
+#include <unistd.h>
+
+#define __user
+
+/**
+ * DOC: UAPI
+ *
+ * CXL memory devices expose UAPI to have a standard user interface.
+ * Userspace can refer to these structure definitions and UAPI formats
+ * to communicate to driver. The commands themselves are somewhat obfuscated
+ * with macro magic. They have the form CXL_MEM_COMMAND_ID_<name>.
+ *
+ * For example "CXL_MEM_COMMAND_ID_INVALID"
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
+
+#undef CMDS
+#define CMDS                                                                   \
+	C(INVALID,	"Invalid Command"),                                    \
+	C(IDENTIFY,	"Identify Command"),                                   \
+	C(RAW,		"Raw device command"),                                 \
+	C(GET_SUPPORTED_LOGS,		"Get Supported Logs"),                 \
+	C(GET_LOG,	"Get Log"),                                            \
+	C(MAX,		"Last command")
+
+#undef C
+#define C(a, b) CXL_MEM_COMMAND_ID_##a
+
+enum { CMDS };
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ *
+ *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
+ *    kernel use.
+ *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
+ *    the kernel in order to complete successfully.
+ *
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. The is returned as part of an array from the query ioctl. The
+ * following would be a command named "foobar" that takes a variable length
+ * input and returns 0 bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_NONE 0
+#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
+#define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(31, 2)
+
+	__s32 size_in;
+	__s32 size_out;
+};
+
+/**
+ * struct cxl_mem_query_commands - Query supported commands.
+ * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
+ *		return min(num_support_commands, n_commands). When @n_commands
+ *		is 0, driver will return the number of total supported commands.
+ * @rsvd: Reserved for future use.
+ * @commands: Output array of supported commands. This array must be allocated
+ *            by userspace to be at least min(num_support_commands, @n_commands)
+ *
+ * Allow userspace to query the available commands supported by both the driver,
+ * and the hardware. Commands that aren't supported by either the driver, or the
+ * hardware are not returned in the query.
+ *
+ * Examples:
+ *
+ *  - { .n_commands = 0 } // Get number of supported commands
+ *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
+ *    supported commands
+ *
+ *  See struct cxl_command_info.
+ */
+struct cxl_mem_query_commands {
+	/*
+	 * Input: Number of commands to return (space allocated by user)
+	 * Output: Number of commands supported by the driver/hardware
+	 *
+	 * If n_commands is 0, kernel will only return number of commands and
+	 * not try to populate commands[], thus allowing userspace to know how
+	 * much space to allocate
+	 */
+	__u32 n_commands;
+	__u32 rsvd;
+
+	struct cxl_command_info __user commands[]; /* out: supported commands */
+};
+
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @size_in: Size of the payload to provide to the device (input).
+ * @size_out: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @in_payload: Pointer to memory for payload input (little endian order).
+ * @out_payload: Pointer to memory for payload output (little endian order).
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes, but the payload input
+ * and output are not introspected. Userspace is required to allocate large
+ * enough buffers for max(size_in, size_out).
+ */
+struct cxl_send_command {
+	__u32 id;
+	__u32 flags;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
+	__u32 retval;
+
+	struct {
+		__s32 size_in;
+		__u64 in_payload;
+	};
+
+	struct {
+		__s32 size_out;
+		__u64 out_payload;
+	};
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif
diff --git a/cxl/lib/Makefile.am b/cxl/lib/Makefile.am
index 01adf9f..dfd2784 100644
--- a/cxl/lib/Makefile.am
+++ b/cxl/lib/Makefile.am
@@ -3,7 +3,7 @@ include $(top_srcdir)/Makefile.am.in
 %.pc: %.pc.in Makefile
 	$(SED_PROCESS)
 
-pkginclude_HEADERS = ../libcxl.h
+pkginclude_HEADERS = ../libcxl.h ../cxl_mem.h
 lib_LTLIBRARIES = libcxl.la
 
 libcxl_la_SOURCES =\
-- 
2.29.2

