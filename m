Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DFC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jan 2022 06:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiALG2e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:28:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:56878 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350989AbiALG2e (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 12 Jan 2022 01:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641968914; x=1673504914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4vyc81ks1FKetNmznAiO7ACwvf7cWXdvPd/K5QQq90=;
  b=X6ATBKr6sPoDfQIgAEno9VfVRN4lAfYz2Uo1BDrJinWsks13d03xvE6C
   cS3VIyGrJIec4CIRbjnCSsZhS6u7pFL6FGkaPjAmXLuz0h9SPLbEO+npZ
   El99/12h3d3JIqeVkTcaclLNzKi3PRcIsO+6zWxrse3HTstrrhkTo7qTj
   1EjJweLBuHHjIhriG4jfxqJy/2A+Ibxe47u+Gpiou2ogW/M44s3LjfbCR
   zz5cmTqkby0ylBOQFC4qs7nDbZx0kRlNgX7uEmxUqyW6a/tgLVe8wQoSz
   eQ2usBhzQK1T3unUqQIO/op+tLctwFWVDlXI0TuLY8TqB0d78TxkRl1uj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243624919"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243624919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 22:28:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529051354"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 22:28:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v2 3/6] libcxl: return the partition alignment field in bytes
Date:   Tue, 11 Jan 2022 22:33:31 -0800
Message-Id: <ca1821eee9f8e2372e378165d5c24bbf9161e6fe.1641965853.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641965853.git.alison.schofield@intel.com>
References: <cover.1641965853.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Per the CXL specification, the partition alignment field reports
the alignment value in multiples of 256MB. In the libcxl API, values
for all capacity fields are defined to return bytes.

Update the partition alignment accessor to return bytes so that it
is in sync with other capacity related fields.

Rename the function to reflect the new return value:
cxl_cmd_identify_get_partition_align_bytes()

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 4 ++--
 cxl/lib/libcxl.sym | 2 +-
 cxl/libcxl.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 1fd584a..823bcb0 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1078,7 +1078,7 @@ CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
 	return 0;
 }
 
-CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
+CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align_bytes(
 		struct cxl_cmd *cmd)
 {
 	struct cxl_cmd_identify *id =
@@ -1089,7 +1089,7 @@ CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
 	if (cmd->status < 0)
 		return cmd->status;
 
-	return le64_to_cpu(id->partition_align);
+	return le64_to_cpu(id->partition_align) * CXL_CAPACITY_MULTIPLIER;
 }
 
 CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index b7e969f..1e2cf05 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -34,7 +34,7 @@ global:
 	cxl_cmd_identify_get_total_bytes;
 	cxl_cmd_identify_get_volatile_only_bytes;
 	cxl_cmd_identify_get_persistent_only_bytes;
-	cxl_cmd_identify_get_partition_align;
+	cxl_cmd_identify_get_partition_align_bytes;
 	cxl_cmd_identify_get_label_size;
 	cxl_cmd_new_get_health_info;
 	cxl_cmd_health_info_get_maintenance_needed;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 46f99fb..f19ed4f 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -71,7 +71,7 @@ int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
 unsigned long long cxl_cmd_identify_get_total_bytes(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_volatile_only_bytes(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_persistent_only_bytes(struct cxl_cmd *cmd);
-unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_partition_align_bytes(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
 int cxl_cmd_health_info_get_maintenance_needed(struct cxl_cmd *cmd);
-- 
2.31.1

