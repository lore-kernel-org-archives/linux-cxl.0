Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D8C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB346125F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhHXQJ7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:09:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:32144 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhHXQJ7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:09:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="215502120"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="215502120"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="464484321"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:23 -0700
Subject: [PATCH v3 22/28] cxl/pmem: Add support for multiple nvdimm-bridge
 objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:07:23 -0700
Message-ID: <162982124325.1124374.4356765162960141442.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for a mocked unit test environment for CXL objects, allow
for multiple unique nvdimm-bridge objects.

For now, just allow multiple bridges to be registered. Later, when there
are multiple present, further updates are needed to
cxl_find_nvdimm_bridge() to identify which bridge is associated with
which CXL hierarchy for nvdimm registration.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pmem.c |   32 +++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |    2 ++
 drivers/cxl/pmem.c      |   15 ---------------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 69c97cc0d945..ec3e4c642fca 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -3,15 +3,19 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
 
 #include "core.h"
 
+static DEFINE_IDA(cxl_nvdimm_bridge_ida);
+
 static void cxl_nvdimm_bridge_release(struct device *dev)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
 
+	ida_free(&cxl_nvdimm_bridge_ida, cxl_nvb->id);
 	kfree(cxl_nvb);
 }
 
@@ -35,16 +39,38 @@ struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(to_cxl_nvdimm_bridge);
 
+static int match_nvdimm_bridge(struct device *dev, const void *data)
+{
+	return dev->type == &cxl_nvdimm_bridge_type;
+}
+
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(void)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&cxl_bus_type, NULL, NULL, match_nvdimm_bridge);
+	if (!dev)
+		return NULL;
+	return to_cxl_nvdimm_bridge(dev);
+}
+EXPORT_SYMBOL_GPL(cxl_find_nvdimm_bridge);
+
 static struct cxl_nvdimm_bridge *
 cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct device *dev;
+	int rc;
 
 	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
 	if (!cxl_nvb)
 		return ERR_PTR(-ENOMEM);
 
+	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+	cxl_nvb->id = rc;
+
 	dev = &cxl_nvb->dev;
 	cxl_nvb->port = port;
 	cxl_nvb->state = CXL_NVB_NEW;
@@ -55,6 +81,10 @@ cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 	dev->type = &cxl_nvdimm_bridge_type;
 
 	return cxl_nvb;
+
+err:
+	kfree(cxl_nvb);
+	return ERR_PTR(rc);
 }
 
 static void unregister_nvb(void *_cxl_nvb)
@@ -100,7 +130,7 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 		return cxl_nvb;
 
 	dev = &cxl_nvb->dev;
-	rc = dev_set_name(dev, "nvdimm-bridge");
+	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
 	if (rc)
 		goto err;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 53927f9fa77e..1b2e816e061e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -211,6 +211,7 @@ enum cxl_nvdimm_brige_state {
 };
 
 struct cxl_nvdimm_bridge {
+	int id;
 	struct device dev;
 	struct cxl_port *port;
 	struct nvdimm_bus *nvdimm_bus;
@@ -323,4 +324,5 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd);
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(void);
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 6cc76302c8f8..743e2d2fdbb5 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -33,21 +33,6 @@ static void unregister_nvdimm(void *_cxl_nvd)
 	clear_exclusive_cxl_commands(cxlm, exclusive_cmds);
 }
 
-static int match_nvdimm_bridge(struct device *dev, const void *data)
-{
-	return strcmp(dev_name(dev), "nvdimm-bridge") == 0;
-}
-
-static struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(void)
-{
-	struct device *dev;
-
-	dev = bus_find_device(&cxl_bus_type, NULL, NULL, match_nvdimm_bridge);
-	if (!dev)
-		return NULL;
-	return to_cxl_nvdimm_bridge(dev);
-}
-
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);

