Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D0C432BE
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 23:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6428E60FD8
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 23:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhHZXdC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:33:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:34092 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhHZXdC (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 26 Aug 2021 19:33:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="205066899"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="205066899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 16:32:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="474384093"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 16:32:13 -0700
Subject: [PATCH] cxl/core: Replace devm_cxl_add_decoder() with non-devm
 version
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        vishal.l.verma@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Thu, 26 Aug 2021 16:32:13 -0700
Message-ID: <163002073312.1700305.17017280228713298614.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The split of devm_cxl_add_decoder() to factor out cxl_decoder_alloc()
introduced a couple bugs. An initialization order bug, and a layering
violation around assumptions about who is responsible for put_device()
when device_add() for the decoder fails. Fix this by making the caller
responsible for registering a devm callback to trigger
device_unregister() for the decoder device.

Fixes: b7ca54b62551 ("cxl/core: Split decoder setup into alloc + add")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   14 +++++++++++---
 drivers/cxl/core/bus.c  |   45 ++++++++++++++++++++++++++-------------------
 drivers/cxl/core/core.h |    5 -----
 drivers/cxl/core/pmem.c |    7 ++++++-
 drivers/cxl/cxl.h       |    5 +++--
 5 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0b7c6268bba4..7130beffc929 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -133,7 +133,11 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 		cxld->interleave_granularity =
 			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
-		rc = devm_cxl_add_decoder(dev, cxld, target_map);
+		rc = cxl_decoder_add(dev, cxld, target_map);
+		if (rc)
+			put_device(&cxld->dev);
+		else
+			rc = cxl_decoder_autoremove(dev, cxld);
 		if (rc) {
 			dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
 				cfmws->base_hpa, cfmws->base_hpa +
@@ -340,10 +344,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 
 	single_port_map[0] = dport->port_id;
 
-	rc = devm_cxl_add_decoder(host, cxld, single_port_map);
+	rc = cxl_decoder_add(host, cxld, single_port_map);
+	if (rc)
+		put_device(&cxld->dev);
+	else
+		rc = cxl_decoder_autoremove(host, cxld);
+
 	if (rc == 0)
 		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
-
 	return rc;
 }
 
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 1320a996220a..3991ac231c3e 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -491,10 +491,10 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
 
-int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
-			 int *target_map)
+int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
+		    int *target_map)
 {
-	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port *port;
 	struct device *dev;
 	int rc = 0, i;
 
@@ -504,44 +504,51 @@ int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
-	if (cxld->interleave_ways < 1) {
-		rc = -EINVAL;
-		goto err;
-	}
+	if (cxld->interleave_ways < 1)
+		return -EINVAL;
 
+	port = to_cxl_port(cxld->dev.parent);
 	device_lock(&port->dev);
-	if (list_empty(&port->dports))
+	if (list_empty(&port->dports)) {
 		rc = -EINVAL;
+		goto out_unlock;
+	}
 
 	for (i = 0; rc == 0 && target_map && i < cxld->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
 		if (!dport) {
 			rc = -ENXIO;
-			break;
+			goto out_unlock;
 		}
 		dev_dbg(host, "%s: target: %d\n", dev_name(dport->dport), i);
 		cxld->target[i] = dport;
 	}
 	device_unlock(&port->dev);
-	if (rc)
-		goto err;
 
 	dev = &cxld->dev;
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
 	if (rc)
-		goto err;
+		return rc;
 
-	rc = device_add(dev);
-	if (rc)
-		goto err;
+	return device_add(dev);
 
-	return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
-err:
-	put_device(dev);
+out_unlock:
+	device_unlock(&port->dev);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(devm_cxl_add_decoder);
+EXPORT_SYMBOL_GPL(cxl_decoder_add);
+
+static void cxld_unregister(void *dev)
+{
+	device_unregister(dev);
+}
+
+int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
+{
+	return devm_add_action_or_reset(host, cxld_unregister, &cxld->dev);
+}
+EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
 
 /**
  * __cxl_driver_register - register a driver for the cxl bus
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c85b7fbad02d..e0c9aacc4e9c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,11 +9,6 @@ extern const struct device_type cxl_nvdimm_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
-static inline void unregister_cxl_dev(void *dev)
-{
-	device_unregister(dev);
-}
-
 struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 68046b6a22b5..f9a260f54f2b 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -203,6 +203,11 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
 	return cxl_nvd;
 }
 
+static void cxl_nvd_unregister(void *dev)
+{
+	device_unregister(dev);
+}
+
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm *cxl_nvd;
@@ -225,7 +230,7 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
 	dev_dbg(host, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
+	return devm_add_action_or_reset(host, cxl_nvd_unregister, dev);
 
 err:
 	put_device(dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3705b2454b66..708bfe92b596 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -289,8 +289,9 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
-int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
-			 int *target_map);
+int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
+		    int *target_map);
+int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
 extern struct bus_type cxl_bus_type;
 

