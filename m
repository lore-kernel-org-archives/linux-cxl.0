Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E99FC35273
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 01:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiBHBFL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbiBGXGQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 18:06:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C6C061A73
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 15:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275176; x=1675811176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a1uUUbOO0AxoqFBQlTh5tCofZu6Z8iVnPREr/9wVts0=;
  b=hzQlmrekpbm2SPBxRQak/x825kgEpZVZ/iRNuExGd5L0UDueBvYd5Tms
   AaJzQouzDQavnLWIEXzKb+D7ZGvTgLtRqxqnLLr2ECFUyhf6gFn+ljWPs
   spf4awLMyt3vzoXjxRiEVsH3jCtCmkXo47XCfm6e1TFq5/e0E0KqbJEZ1
   4w1KHTkWE+VJcIsZHyJNaovGDGAgSaEHAUSgBRTMBYXaDiD7E65Q+Hgnc
   1vMAWTeAxp3KZsQBVwNBwjvwLBQUGiQ5fomQNZ+wpQdHr+WDCI2gozSMy
   EI0UrRVhk4BwMcXCcYh47cfROjOzYnaMrD2ONdhzewKI1z31khN+IAYdX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248775567"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248775567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="632639197"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v4 1/6] libcxl: add GET_PARTITION_INFO mailbox command and accessors
Date:   Mon,  7 Feb 2022 15:10:15 -0800
Message-Id: <396ccc39525b3eb829acd4e06f704f6fb57a94a8.1644271559.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644271559.git.alison.schofield@intel.com>
References: <cover.1644271559.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Users need access to the CXL GET_PARTITION_INFO mailbox command
to inspect and confirm changes to the partition layout of a memory
device.

Add libcxl APIs to create a new GET_PARTITION_INFO mailbox command,
the command output data structure (privately), and accessor APIs to
return the different fields in the partition info output.

Per the CXL 2.0 specification, devices report partition capacities
as multiples of 256MB. Define and use a capacity multiplier to
convert the raw data into bytes for user consumption. Use byte
format as the norm for all capacity values produced or consumed
using CXL Mailbox commands.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |  1 +
 cxl/lib/libcxl.c                 | 57 ++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  5 +++
 cxl/lib/private.h                | 10 ++++++
 cxl/libcxl.h                     |  5 +++
 util/size.h                      |  1 +
 6 files changed, 79 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 4392b47..a6986ab 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -131,6 +131,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			  size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			   size_t offset);
+struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 
 ----
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e0b443f..33cf06b 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1985,6 +1985,12 @@ static int cxl_cmd_validate_status(struct cxl_cmd *cmd, u32 id)
 	return 0;
 }
 
+static unsigned long long
+capacity_to_bytes(unsigned long long size)
+{
+	return le64_to_cpu(size) * CXL_CAPACITY_MULTIPLIER;
+}
+
 /* Helpers for health_info fields (no endian conversion) */
 #define cmd_get_field_u8(cmd, n, N, field)				\
 do {									\
@@ -2371,6 +2377,57 @@ CXL_EXPORT ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd,
 	return length;
 }
 
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev,
+				   CXL_MEM_COMMAND_ID_GET_PARTITION_INFO);
+}
+
+static struct cxl_cmd_get_partition *
+cmd_to_get_partition(struct cxl_cmd *cmd)
+{
+	if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_GET_PARTITION_INFO))
+		return NULL;
+
+	return cmd->output_payload;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_active_volatile_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	return c ? capacity_to_bytes(c->active_volatile) : ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_active_persistent_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	return c ? capacity_to_bytes(c->active_persistent) : ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	return c ? capacity_to_bytes(c->next_volatile) : ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	return c ? capacity_to_bytes(c->next_persistent) : ULLONG_MAX;
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index e56a2bf..509e62d 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -155,4 +155,9 @@ global:
 	cxl_dport_get_port;
 	cxl_port_get_dport_by_memdev;
 	cxl_dport_maps_memdev;
+	cxl_cmd_new_get_partition;
+	cxl_cmd_partition_get_active_volatile_size;
+	cxl_cmd_partition_get_active_persistent_size;
+	cxl_cmd_partition_get_next_volatile_size;
+	cxl_cmd_partition_get_next_persistent_size;
 } LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index f483c30..7f3a562 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -7,6 +7,7 @@
 #include <cxl/cxl_mem.h>
 #include <ccan/endian/endian.h>
 #include <ccan/short_types/short_types.h>
+#include <util/size.h>
 
 #define CXL_EXPORT __attribute__ ((visibility("default")))
 
@@ -185,6 +186,15 @@ struct cxl_cmd_get_health_info {
 	le32 pmem_errors;
 } __attribute__((packed));
 
+struct cxl_cmd_get_partition {
+	le64 active_volatile;
+	le64 active_persistent;
+	le64 next_volatile;
+	le64 next_persistent;
+} __attribute__((packed));
+
+#define CXL_CAPACITY_MULTIPLIER		SZ_256M
+
 /* CXL 2.0 8.2.9.5.3 Byte 0 Health Status */
 #define CXL_CMD_HEALTH_INFO_STATUS_MAINTENANCE_NEEDED_MASK		BIT(0)
 #define CXL_CMD_HEALTH_INFO_STATUS_PERFORMANCE_DEGRADED_MASK		BIT(1)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 3b2293b..2c0a8d1 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -242,6 +242,11 @@ ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
 		unsigned int length);
 struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
 		void *buf, unsigned int offset, unsigned int length);
+struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
+unsigned long long cxl_cmd_partition_get_active_volatile_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_active_persistent_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/util/size.h b/util/size.h
index a0f3593..e72467f 100644
--- a/util/size.h
+++ b/util/size.h
@@ -15,6 +15,7 @@
 #define SZ_4M     0x00400000
 #define SZ_16M    0x01000000
 #define SZ_64M    0x04000000
+#define SZ_256M	  0x10000000
 #define SZ_1G     0x40000000
 #define SZ_1T 0x10000000000ULL
 
-- 
2.31.1

