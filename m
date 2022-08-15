Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4771C00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiHOV2L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347812AbiHOV0T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 17:26:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA5E8335
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660591364; x=1692127364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BFJRklHB9Q8+ZO+vRUd1gtiGtVTpF4CnQfiprfpVzs=;
  b=OIGq20txxBMH2dMSjdtJ5jHbbYY5ydNwkWzJDQSoxZFUsKXDi9Jh+eQO
   1+qxkfbbPFXxQ/+lCSFh8iMITth5pBf0dVAVIGle7KxHCjNhZoOk9Avg2
   lTd+9VsHwyw5QUlc6WeDuW2Xln+gxCEoqFZXjVMY5swh2FdyjWHn2pJMU
   1RvwsC2BMGNp0pFu9nHAaMxCenbwpucZKQ+D8SBUcRDExZGwpkKAS6Z9s
   1dm7E+b2c5DYqMhXpV/cbzPXX4nHLCwAV9bKbp9K0vBxa8Hnyofvx6wCU
   A0VY0GP1GEwDxgpR+P0NmY0LbSb2UXa0GuEgULNn/vlmUC+ApuGCmaHGl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293313125"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="293313125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="606758246"
Received: from smadiset-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.5.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:18 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 03/11] cxl/memdev: refactor decoder mode string parsing
Date:   Mon, 15 Aug 2022 13:22:06 -0600
Message-Id: <20220815192214.545800-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815192214.545800-1-vishal.l.verma@intel.com>
References: <20220815192214.545800-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; h=from:subject; bh=7BFJRklHB9Q8+ZO+vRUd1gtiGtVTpF4CnQfiprfpVzs=; b=owGbwMvMwCXGf25diOft7jLG02pJDEm/5jztzCo/tKB8F+Oe5+LaT50fTJ5nyLgn7C/PpapJscbe woUCHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZhIzSNGhvnHjP/td3yurSb19gZfwF zv53sPB9Xser2vwbrguZlAhCUjw4HGoFvpqmFTak///y/Iu6HmKHvfuv28/JEfiwUavs2ZzQMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for create-region to use a similar decoder mode string
to enum operation, break out the mode string parsing into its own inline
helper in libcxl.h, and call it from memdev.c:__reserve_dpa().

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/libcxl.h | 13 +++++++++++++
 cxl/memdev.c | 11 ++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 33a216e..c1f8d14 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -4,6 +4,7 @@
 #define _LIBCXL_H_
 
 #include <stdarg.h>
+#include <string.h>
 #include <unistd.h>
 #include <stdbool.h>
 
@@ -154,6 +155,18 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return names[mode];
 }
 
+static inline enum cxl_decoder_mode
+cxl_decoder_mode_from_ident(const char *ident)
+{
+	if (strcmp(ident, "ram") == 0)
+		return CXL_DECODER_MODE_RAM;
+	else if (strcmp(ident, "volatile") == 0)
+		return CXL_DECODER_MODE_RAM;
+	else if (strcmp(ident, "pmem") == 0)
+		return CXL_DECODER_MODE_PMEM;
+	return CXL_DECODER_MODE_NONE;
+}
+
 enum cxl_decoder_mode cxl_decoder_get_mode(struct cxl_decoder *decoder);
 int cxl_decoder_set_mode(struct cxl_decoder *decoder,
 			 enum cxl_decoder_mode mode);
diff --git a/cxl/memdev.c b/cxl/memdev.c
index e42f554..0b3ad02 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -154,15 +154,8 @@ static int __reserve_dpa(struct cxl_memdev *memdev,
 	int rc;
 
 	if (param.type) {
-		if (strcmp(param.type, "ram") == 0)
-			mode = CXL_DECODER_MODE_RAM;
-		else if (strcmp(param.type, "volatile") == 0)
-			mode = CXL_DECODER_MODE_RAM;
-		else if (strcmp(param.type, "ram") == 0)
-			mode = CXL_DECODER_MODE_RAM;
-		else if (strcmp(param.type, "pmem") == 0)
-			mode = CXL_DECODER_MODE_PMEM;
-		else {
+		mode = cxl_decoder_mode_from_ident(param.type);
+		if (mode == CXL_DECODER_MODE_NONE) {
 			log_err(&ml, "%s: unsupported type: %s\n", devname,
 				param.type);
 			return -EINVAL;
-- 
2.37.1

