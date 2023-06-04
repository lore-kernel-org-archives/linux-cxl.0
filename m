Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFCC77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjFDXcf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjFDXce (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF93CE
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921553; x=1717457553;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EdPsbC9cigPOwNEVsQNnrU2zjTpzZY2C6Q3JlHoLIcA=;
  b=F8Bkwu6X/WyeaM4sNFjA9oqmoTnm2HxiOunM8QhqMY/1kBQqTAVw5rNN
   nQHgSKMRJAQ9DkYFaiultEj9do33lYmOQ6KmM4c36gZ3JWWDgfio0mNKz
   Kws3x6E3up5fjc9QSwGVzZgNhONSGL9i0rkQgftU4vaA3dOjmv2UhncNb
   E1sL9eQ20MGaf+fAj4D64UT5EkpgBp2/WMLHpSKbH/pTBgW56qWs+149k
   QdsOEqw5XXlJ0UaGTmoTpaeJG2Wm0PyCs1BSKU0b34+n5DRlzT/Sus6X6
   l8mRoFshRKOY0CnZOzbGR3cbFawv25KANCd9VxOWnv2njGoM+iG+kDMcg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336596786"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336596786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038571962"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038571962"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:33 -0700
Subject: [PATCH 10/19] cxl/memdev: Indicate probe deferral
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:32 -0700
Message-ID: <168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The first stop for a CXL accelerator driver that wants to establish new
CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
topology up to the root.

If the root driver has not attached yet the expectation is that the
driver waits until that link is established. The common cxl_pci driver
has reason to keep the 'struct cxl_memdev' device attached to the bus
until the root driver attaches. An accelerator may want to instead defer
probing until CXL resources can be acquired.

Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
accelerator driver probing should be deferred vs failed. Provide that
indication via a new cxl_acquire_endpoint() API that can retrieve the
probe status of the memdev.

The first consumer of this API is a test driver that exercises the CXL
Type-2 flow.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |    2 +-
 drivers/cxl/cxlmem.h      |    2 ++
 drivers/cxl/mem.c         |    7 +++++--
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 65a685e5616f..859c43c340bb 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -609,6 +609,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+/*
+ * Try to get a locked reference on a memdev's CXL port topology
+ * connection. Be careful to observe when cxl_mem_probe() has deposited
+ * a probe deferral awaiting the arrival of the CXL root driver
+ */
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	int rc = -ENXIO;
+
+	device_lock(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		goto err;
+
+	if (IS_ERR(endpoint)) {
+		rc = PTR_ERR(endpoint);
+		goto err;
+	}
+
+	device_lock(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		goto err_endpoint;
+
+	return endpoint;
+
+err_endpoint:
+	device_unlock(&endpoint->dev);
+err:
+	device_unlock(&cxlmd->dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
+
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	device_unlock(&endpoint->dev);
+	device_unlock(&cxlmd->dev);
+}
+EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
+
 __init int cxl_memdev_init(void)
 {
 	dev_t devt;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6720ab22a494..5e21b53362e6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1336,7 +1336,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7ee78e79933c..e3bcd6d12a1c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -83,6 +83,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport);
 }
 
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 584f9eec57e4..2470c6f2621c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -154,13 +154,16 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	rc = devm_cxl_enumerate_ports(cxlmd);
-	if (rc)
+	if (rc) {
+		cxlmd->endpoint = ERR_PTR(rc);
 		return rc;
+	}
 
 	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
-		return -ENXIO;
+		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
+		return -EPROBE_DEFER;
 	}
 
 	if (dport->rch)

