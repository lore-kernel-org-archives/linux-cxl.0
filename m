Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15642C19F35
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99B360F26
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhGWU0M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhGWU0J (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671220"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436191"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 22/23] cxl/mem: Add device as a port
Date:   Fri, 23 Jul 2021 14:06:22 -0700
Message-Id: <20210723210623.114073-23-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c |  5 ++++-
 drivers/cxl/mem.c      | 12 +++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 75f49fbb8c00..4b58b3f1ec99 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -446,7 +446,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 	dev = &port->dev;
 	if (parent_port)
-		rc = dev_set_name(dev, "port%d", port->id);
+		if (is_cxl_memdev(uport))
+			rc = dev_set_name(dev, "devport%d", port->id);
+		else
+			rc = dev_set_name(dev, "port%d", port->id);
 	else
 		rc = dev_set_name(dev, "root%d", port->id);
 	if (rc)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 40281dcc0f3e..4656636acb8a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -24,7 +24,7 @@ static int port_match(struct device *dev, const void *data)
 
 	port = to_cxl_port(dev);
 
-	if (find_dport_by_dev(port, data))
+	if (find_dport_by_dev(port, (struct device *)data))
 		return 1;
 
 	return 0;
@@ -37,7 +37,7 @@ static int cxl_memdev_probe(struct device *dev)
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *pdev_parent = cxlm->pdev->dev.parent;
 	struct device *port_dev;
-	int pcie_dvsec;
+	int pcie_dvsec, rc;
 	u16 dvsec_ctrl;
 
 	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
@@ -58,7 +58,13 @@ static int cxl_memdev_probe(struct device *dev)
 		return -ENODEV;
 	}
 
-	return 0;
+	rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,
+					       CXL_RESOURCE_NONE,
+					       to_cxl_port(port_dev)));
+	if (rc)
+		dev_err(dev, "Unable to add devices upstream port");
+
+	return rc;
 }
 
 static void cxl_memdev_remove(struct device *dev)
-- 
2.32.0

