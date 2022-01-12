Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6AC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jan 2022 06:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350986AbiALG2e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:28:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:56878 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350988AbiALG2e (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 12 Jan 2022 01:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641968914; x=1673504914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rXeIZWlZ4MaR5SiTd9P5N37auWUvFhOUNkOo5BEkuak=;
  b=dU9soJSfC85uUYl17ocr4uPb/+viAfOgdDGvFLt1vJnmOQSYAYRl//8w
   gBya7gWQNKqspoBkMOakfREbdmctJo0yyhtBaG2d36HT52SdsfFn2SyfI
   62UzU/wR+VXGgRlLvYdL4kDVl0+W+rb79KQZeMPXMqYxKXCd5FuVGoN3Z
   kESysnT6mlLgjYXyOUtFe6B1sCI7TWoFiK9qGLrci4Nm8JJZxipR962Y5
   NnUFazyW6iPIQDSpBTzyilXuNFdzTK26hwOhV6aK/bNRZW1RiwbDDzd0F
   yBnmfEDZSL4LfyrA9Vp9bl3gm96S/Pk0r3ZeangjCSzHc9zBXwIPV2Ffg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243624917"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243624917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 22:28:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529051350"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 22:28:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v2 2/6] libcxl: add accessors for capacity fields of the IDENTIFY command
Date:   Tue, 11 Jan 2022 22:33:30 -0800
Message-Id: <55800f227e4d72f90fcdd49affb352fe4386f628.1641965853.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641965853.git.alison.schofield@intel.com>
References: <cover.1641965853.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Users need access to a few additional fields reported by the IDENTIFY
mailbox command: total, volatile_only, and persistent_only capacities.
These values are useful when defining partition layouts.

Add accessors to the libcxl API to retrieve these values from the
IDENTIFY command.

The fields are specified in multiples of 256MB per the CXL 2.0 spec.
Use the capacity multiplier to convert the raw data into bytes for user
consumption.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 29 +++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 +++
 cxl/libcxl.h       |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 58181c0..1fd584a 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1105,6 +1105,35 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
 	return le32_to_cpu(id->lsa_size);
 }
 
+#define cmd_identify_get_capacity_field(cmd, field)			\
+do {										\
+	struct cxl_cmd_identify *c =					\
+		(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;\
+	int rc = cxl_cmd_validate_status(cmd,					\
+			CXL_MEM_COMMAND_ID_IDENTIFY);			\
+	if (rc)									\
+		return ULLONG_MAX;							\
+	return le64_to_cpu(c->field) * CXL_CAPACITY_MULTIPLIER;			\
+} while (0)
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_total_bytes(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, total_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_volatile_only_bytes(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, volatile_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_persistent_only_bytes(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, persistent_capacity);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 		int opcode)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index e019c3c..b7e969f 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -31,6 +31,9 @@ global:
 	cxl_cmd_get_out_size;
 	cxl_cmd_new_identify;
 	cxl_cmd_identify_get_fw_rev;
+	cxl_cmd_identify_get_total_bytes;
+	cxl_cmd_identify_get_volatile_only_bytes;
+	cxl_cmd_identify_get_persistent_only_bytes;
 	cxl_cmd_identify_get_partition_align;
 	cxl_cmd_identify_get_label_size;
 	cxl_cmd_new_get_health_info;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 08fd840..46f99fb 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -68,6 +68,9 @@ int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
 int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
 int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
+unsigned long long cxl_cmd_identify_get_total_bytes(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_volatile_only_bytes(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_persistent_only_bytes(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
-- 
2.31.1

