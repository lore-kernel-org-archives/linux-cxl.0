Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4DC433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6F860FC0
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbhIDCWD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:22:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:53401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240791AbhIDCWC (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Sep 2021 22:22:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241848029"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="241848029"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:21:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="578915932"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:21:01 -0700
Subject: [PATCH 5/6] cxl/pmem: Fix Documentation warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, alison.schofield@intel.com,
        ben.widawsky@intel.com, Jonathan.Cameron@huawei.com
Date:   Fri, 03 Sep 2021 19:21:01 -0700
Message-ID: <163072206163.2250120.11486436976516079516.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Commit 06737cd0d216 ("cxl/core: Move pmem functionality") neglected to
add a DOC header for the new drivers/cxl/core/pmem.c file.

Reported-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    2 +-
 drivers/cxl/core/pmem.c                         |   30 +++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 46847d8c70a0..df799cdf1c3f 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -40,7 +40,7 @@ CXL Core
    :doc: cxl core
 
 .. kernel-doc:: drivers/cxl/core/pmem.c
-   :internal:
+   :doc: cxl pmem
 
 .. kernel-doc:: drivers/cxl/core/regs.c
    :internal:
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 69c97cc0d945..d24570f5b8ba 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -1,13 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
-
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <cxlmem.h>
 #include <cxl.h>
-
 #include "core.h"
 
+/**
+ * DOC: cxl pmem
+ *
+ * The core CXL PMEM infrastructure supports persistent memory
+ * provisioning and serves as a bridge to the LIBNVDIMM subsystem. A CXL
+ * 'bridge' device is added at the root of a CXL device topology if
+ * platform firmware advertises at least one persistent memory capable
+ * CXL window. That root-level bridge corresponds to a LIBNVDIMM 'bus'
+ * device. Then for each cxl_memdev in the CXL device topology a bridge
+ * device is added to host a LIBNVDIMM dimm object. When these bridges
+ * are registered native LIBNVDIMM uapis are translated to CXL
+ * operations, for example, namespace label access commands.
+ */
+
 static void cxl_nvdimm_bridge_release(struct device *dev)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
@@ -85,6 +97,13 @@ static void unregister_nvb(void *_cxl_nvb)
 	device_unregister(&cxl_nvb->dev);
 }
 
+/**
+ * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
+ * @host: platform firmware root device
+ * @port: CXL port at the root of a CXL topology
+ *
+ * Return: bridge device that can host cxl_nvdimm objects
+ */
 struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port)
 {
@@ -173,6 +192,13 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
 	return cxl_nvd;
 }
 
+/**
+ * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
+ * @host: same host as @cxlmd
+ * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
+ *
+ * Return: 0 on success negative error code on failure.
+ */
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm *cxl_nvd;

