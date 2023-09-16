Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A669CC46CA1
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Sep 2023 04:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjIPEqF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Sep 2023 00:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjIPEpg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 16 Sep 2023 00:45:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AB173C
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694839531; x=1726375531;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=khmoIdZMk/HtiIC6deGzSmVz2lb+C3vPVzcjQhYHCXo=;
  b=Z+MSooUNpCyvmTit+2fElkuJOMrrvLO/8q1oZYi++D3xFb4sTDwcQQCz
   jSofiBpUCIB927qU4XOLsKsHOKskngZGvu/U8HlPQKx+NU+PC1zqRHisX
   ifT8hQCJq3TfByMUU1TiEA7iYjAtSweXJ1rL6ZisoHOIt6wcjAwcbhsKd
   GeyFa/u85dXf4Ldli/tTlLJscz2lwjxxzxzj+kg2eGf9NEHBGqPZdqjdv
   OsGeq1kpw353DaDUWn2DhcubuDKOeMFH3dZeBGvrWTq1R/zPJMyb8qPz4
   hpEbDvcPyO3EhkXbfSf9zWnI2Ny9PMUIkLV6p7aer1EESLEOVsPhXhRIA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445858593"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="445858593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 21:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="780331208"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="780331208"
Received: from sseo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.244.110])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 21:45:30 -0700
Subject: [PATCH] cxl/port: Fix @host confusion in cxl_dport_setup_regs()
From:   Dan Williams <dan.j.williams@intel.com>
To:     rrichter@amd.com
Cc:     Terry Bowman <terry.bowman@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Fri, 15 Sep 2023 21:45:30 -0700
Message-ID: <169483932200.1122515.18350677749691374974.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

commit 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")

...moved the dport component registers from a raw component_reg_phys
passed in at dport instantiation time to a 'struct cxl_register_map'
populated with both the component register data *and* the "host" device
for mapping operations.

While typical CXL switch dports are mapped by their associated 'struct
cxl_port', an RCH host bridge dport registered by cxl_acpi needs to wait
until the cxl_mem driver makes the attachment to map the registers. This
is because there are no intervening 'struct cxl_port' instances between
the root cxl_port and the endpoint port in an RCH topology.

For now just mark the host as NULL in the RCH dport case until code that
needs to map the dport registers arrives. Name the field @reg_map,
because @reg_map->host will be used for mapping operations beyond
component registers (i.e. AER registers).

This patch is not flagged for -stable since nothing in the current
driver uses the dport->reg_map.

Now, I am slightly uneasy that cxl_setup_comp_regs() sets map->host to a
wrong value and then cxl_dport_setup_regs() fixes it up, but the
alternatives I came up with are more messy. For example, adding an
@logdev to 'struct cxl_register_map' that the dev_printk()s can fall
back to when @host is NULL. I settled on "post-fixup+comment" since it
is only RCH dports that have this special case where register probing is
split between a host-bridge RCRB lookup and when cxl_mem_probe() does
the association of the cxl_memdev and endpoint port.

Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
Cc: Robert Richter <rrichter@amd.com>
Cc: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Robert,

I think this should be included in v11. The expectation is that cxl_mem
would then do:

    dport->reg_map.host = &cxlmd->dev;
    devm_cxl_dport_map_regs(dport);

...since the root cxl_port has the wrong lifetime to for mapping the RCD
endpoint registers.

 drivers/cxl/core/port.c |   47 +++++++++++++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |    4 ++--
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 01c9623be17e..02264e56812e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -716,13 +716,23 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
-static int cxl_dport_setup_regs(struct cxl_dport *dport,
+static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 				resource_size_t component_reg_phys)
 {
+	int rc;
+
 	if (dev_is_platform(dport->dport_dev))
 		return 0;
-	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
-				   component_reg_phys);
+
+	/*
+	 * use @dport->dport_dev for the context for error messages during
+	 * register probing, and fixup @host after the fact, since @host may be
+	 * NULL.
+	 */
+	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
+				 component_reg_phys);
+	dport->reg_map.host = host;
+	return rc;
 }
 
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
@@ -983,7 +993,16 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
-	if (rcrb != CXL_RESOURCE_NONE) {
+	dport->dport_dev = dport_dev;
+	dport->port_id = port_id;
+	dport->port = port;
+
+	if (rcrb == CXL_RESOURCE_NONE) {
+		rc = cxl_dport_setup_regs(&port->dev, dport,
+					  component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+	} else {
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -992,21 +1011,17 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			return ERR_PTR(-ENXIO);
 		}
 
+		/*
+		 * RCH @dport is not ready to map until associated with its
+		 * memdev
+		 */
+		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+
 		dport->rch = true;
 	}
 
-	if (component_reg_phys != CXL_RESOURCE_NONE)
-		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
-			&component_reg_phys);
-
-	dport->dport_dev = dport_dev;
-	dport->port_id = port_id;
-	dport->port = port;
-
-	rc = cxl_dport_setup_regs(dport, component_reg_phys);
-	if (rc)
-		return ERR_PTR(rc);
-
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b5b015b661ea..68abf9944383 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -620,7 +620,7 @@ struct cxl_rcrb_info {
 /**
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
- * @comp_map: component register capability mappings
+ * @reg_map: component and ras register mapping parameters
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -628,7 +628,7 @@ struct cxl_rcrb_info {
  */
 struct cxl_dport {
 	struct device *dport_dev;
-	struct cxl_register_map comp_map;
+	struct cxl_register_map reg_map;
 	int port_id;
 	struct cxl_rcrb_info rcrb;
 	bool rch;

