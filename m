Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B731BC43219
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Nov 2022 18:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKXSfa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Nov 2022 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKXSf2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Nov 2022 13:35:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD510FEDF
        for <linux-cxl@vger.kernel.org>; Thu, 24 Nov 2022 10:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669314927; x=1700850927;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbIimtTYa9EA+7o9E5j9BEN7MwgO58THFBCeYdzhym4=;
  b=OybIUpKE4dtIyGoezs/QIg8qcZ3o0h7FUtX9zp0wk6IZmIGzoSlZoRaS
   3XcWWO5NYKWL6pTXDFMQe5+jcfYcB3M+9YHU84utbonxL6IwzjKtUqDLQ
   yWZz3Q0qPDz+j/6LuFJyI9nQ0bfxicu8gU68xYAmn4l4ICJfmhHoKplgB
   lIy35pKyRClG6xdBdV6+Pb7aC4++rdtFVyyHHpNH2qDopaoa/nImwx4Cp
   ONU82i6QsYvVqHKQjSB4fht7BgjQTDF9pO3cIdScUoVhQjJQKmoM67Vfb
   Qamn1ppiIdgAj2uHkij/27Nkhr5Qp24aWRPvTXhZJSp/VgYwKunYvzEpX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="400642132"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="400642132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 10:35:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="816925998"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="816925998"
Received: from aglevin-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.65.252])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 10:35:27 -0800
Subject: [PATCH v4 09/12] cxl/mem: Move devm_cxl_add_endpoint() from
 cxl_core to cxl_mem
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, terry.bowman@amd.com, bhelgaas@google.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev
Date:   Thu, 24 Nov 2022 10:35:27 -0800
Message-ID: <166931492718.2104015.1866183528350401708.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166931487492.2104015.15204324083515120776.stgit@dwillia2-xfh.jf.intel.com>
References: <166931487492.2104015.15204324083515120776.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for devm_cxl_add_endpoint() to call out to
cxl_rcrb_to_component() to map the upstream port component registers,
move devm_cxl_add_endpoint() from the cxl_core to the cxl_mem driver.
This is due to the organization of cxl_test that mandates that the
cxl_core not call out to any mocked symbols. It also cleans up the
export of devm_cxl_add_endpoint() which is just a wrapper around
devm_cxl_add_port().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h |    8 --------
 drivers/cxl/core/port.c |   39 ---------------------------------------
 drivers/cxl/cxl.h       |    2 --
 drivers/cxl/cxlmem.h    |    9 +++++++++
 drivers/cxl/mem.c       |   38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..8c04672dca56 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -58,14 +58,6 @@ extern struct rw_semaphore cxl_dpa_rwsem;
 
 bool is_switch_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
-static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
-					 struct cxl_memdev *cxlmd)
-{
-	if (!port)
-		return NULL;
-
-	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
-}
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d9fe06e1462f..c7f58282b2c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1203,45 +1203,6 @@ static void reap_dports(struct cxl_port *port)
 	}
 }
 
-int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
-			  struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
-				     cxlds->component_reg_phys, parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, CXL);
-
 static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 43c43d1ec069..d94635e43a50 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -560,8 +560,6 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
-int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
-			  struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct device *dev);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c1c9960ab05f..e082991bc58c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -80,6 +80,15 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 
+static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
+					 struct cxl_memdev *cxlmd)
+{
+	if (!port)
+		return NULL;
+
+	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
+}
+
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
  * @opcode: (input) The command set and command submitted to hardware.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 549b6b499bae..aa63ce8c7ca6 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,44 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
+				 struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
+				     cxlds->component_reg_phys, parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);

