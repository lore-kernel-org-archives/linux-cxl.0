Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA2C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355497AbhLBEnj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:61245 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355512AbhLBEnc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438370"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717395"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:04 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 03/14] cxl/core: Move target population locking to caller
Date:   Wed,  1 Dec 2021 20:37:39 -0800
Message-Id: <20211202043750.3501494-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for a port driver that enumerates a descendant port +
decoder hierarchy, arrange for an unlocked version of cxl_decoder_add().
Otherwise a port-driver that adds a child decoder will deadlock on the
device_lock() in ->probe().

As a result of this change the device lock for the port is held for a
longer amount of time.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
- Fix kdoc describing the lock held (Dan)
---
 drivers/cxl/core/bus.c | 61 +++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  1 +
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 2bf9c0704a70..4bf355a3e396 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -487,28 +487,22 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 {
 	int rc = 0, i;
 
+	device_lock_assert(&port->dev);
+
 	if (!target_map)
 		return 0;
 
-	device_lock(&port->dev);
-	if (list_empty(&port->dports)) {
-		rc = -EINVAL;
-		goto out_unlock;
-	}
+	if (list_empty(&port->dports))
+		return -EINVAL;
 
 	for (i = 0; i < cxld->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
-		if (!dport) {
-			rc = -ENXIO;
-			goto out_unlock;
-		}
+		if (!dport)
+			return -ENXIO;
 		cxld->target[i] = dport;
 	}
 
-out_unlock:
-	device_unlock(&port->dev);
-
 	return rc;
 }
 
@@ -621,7 +615,7 @@ struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
 
 /**
- * cxl_decoder_add - Add a decoder with targets
+ * cxl_decoder_add_locked - Add a decoder with targets
  * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
  * @target_map: A list of downstream ports that this decoder can direct memory
  *              traffic to. These numbers should correspond with the port number
@@ -631,12 +625,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
  * is an endpoint device. A more awkward example is a hostbridge whose root
  * ports get hot added (technically possible, though unlikely).
  *
- * Context: Process context. Takes and releases the cxld's device lock.
+ * This is the locked variant of cxl_decoder_add().
+ *
+ * Context: Process context. Expects the device lock of the port that owns the
+ *	    @cxld to be held.
  *
  * Return: Negative error code if the decoder wasn't properly configured; else
  *	   returns 0.
  */
-int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -673,6 +670,40 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	return device_add(dev);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
+
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * This is the unlocked variant of cxl_decoder_add_locked().
+ * See cxl_decoder_add_locked().
+ *
+ * Context: Process context. Takes and releases the device lock of the port that
+ *	    owns the @cxld.
+ */
+int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
+{
+	struct cxl_port *port;
+	int rc;
+
+	if (WARN_ON_ONCE(!cxld))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(IS_ERR(cxld)))
+		return PTR_ERR(cxld);
+
+	port = to_cxl_port(cxld->dev.parent);
+
+	device_lock(&port->dev);
+	rc = cxl_decoder_add_locked(cxld, target_map);
+	device_unlock(&port->dev);
+
+	return rc;
+}
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b3904788762..762d8254c7c6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -293,6 +293,7 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets);
 struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.34.1

