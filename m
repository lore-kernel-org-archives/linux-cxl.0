Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E615C11F6B
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B496140D
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhGAUM4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:12:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:63970 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhGAUM4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Jul 2021 16:12:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208653261"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="208653261"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:23 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="409271395"
Received: from anandvig-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.38.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:22 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 15/21] libcxl: PLACEHOLDER: add an interface to determine whether a memdev is active
Date:   Thu,  1 Jul 2021 14:09:59 -0600
Message-Id: <20210701201005.3065299-16-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701201005.3065299-1-vishal.l.verma@intel.com>
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add an interface to determine whether a memdev is bound to a region
driver and therefore is currently active.

For now, this just returns '0' all the time - i.e. devices are always
considered inactive. Flesh this out fully once the region driver is
available.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/libcxl.c   | 10 ++++++++++
 cxl/libcxl.h       |  1 +
 cxl/lib/libcxl.sym |  1 +
 3 files changed, 12 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index ae03e03..246fa2a 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -361,6 +361,16 @@ CXL_EXPORT size_t cxl_memdev_get_lsa_size(struct cxl_memdev *memdev)
 	return memdev->lsa_size;
 }
 
+CXL_EXPORT int cxl_memdev_is_active(struct cxl_memdev *memdev)
+{
+	/*
+	 * TODO: Currently memdevs are always considered inactive. Once we have
+	 * cxl_bus drivers that are bound/unbound to memdevs, we'd use that to
+	 * determine the active/inactive state.
+	 */
+	return 0;
+}
+
 CXL_EXPORT void cxl_cmd_unref(struct cxl_cmd *cmd)
 {
 	if (!cmd)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index eeace11..65f6c62 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -43,6 +43,7 @@ unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_lsa_size(struct cxl_memdev *memdev);
+int cxl_memdev_is_active(struct cxl_memdev *memdev);
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index a5a1371..d90502f 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -59,4 +59,5 @@ global:
 LIBCXL_4 {
 global:
 	cxl_memdev_get_lsa_size;
+	cxl_memdev_is_active;
 } LIBCXL_3;
-- 
2.31.1

