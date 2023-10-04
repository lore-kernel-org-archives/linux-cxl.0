Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFCE936EB
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 22:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJDWCf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 18:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJDWCf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 18:02:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C0C9
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696456951; x=1727992951;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RyPxMOYTcXCAD+qR0D5OPIEf5iK6psJ/d8Wo11hpRKM=;
  b=Jhaa8ibXCZ3FtVbRKp8vuv3HPC7oJWXuRFKL/cag0+nFRSrbsSVbxgkr
   FUa28nz3t76qNq92ebBd0HiCQpeYLE2r3/HT4gLH5zQycWOEdq3OXZBqT
   oJVgozcZ7nL2sHlxt+s9AfSlpAisE1oTM9FLRhvTU7QBWkQvWCMmm7e69
   XwQywKBFAXDax9O3HOyREMN+gvw8R65odyXCvzkBeQotX4KxekGVi23Wm
   yZzriJVUreFl860qS32Vpls8Pz5jOowD5j0t101AZ/UWc+lHfuckcAVwq
   Mw8UGh/0d1mxWF4O82Zmb7QHBXChwSmaP+l8hL7+0cOR9ic/Vl3m98hGb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414267231"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="414267231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="755118492"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="755118492"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.170.46])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:02:27 -0700
Subject: [PATCH] cxl: Add cxl_decoders_committed() helper
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Wed, 04 Oct 2023 15:02:26 -0700
Message-ID: <169645694613.622744.16961380551670781524.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a helper to retrieve the number of decoders committed for the port.
Replace all the open coding of the calculation with the helper.

Link: https://lore.kernel.org/linux-cxl/651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c    |    7 ++++---
 drivers/cxl/core/memdev.c |    8 ++++----
 drivers/cxl/core/port.c   |    6 ++++++
 drivers/cxl/cxl.h         |    1 +
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..1b1ba46decfd 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -643,10 +643,11 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
 
-	if (port->commit_end + 1 != id) {
+	if (cxl_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
-			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+			dev_name(&cxld->dev), port->id,
+			cxl_decoders_committed(port));
 		return -EBUSY;
 	}
 
@@ -844,7 +845,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
-		if (cxld->id != port->commit_end + 1) {
+		if (cxld->id != cxl_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
 				 port->id, cxld->id);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..cb88a2dd723a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -164,7 +164,7 @@ static ssize_t security_sanitize_store(struct device *dev,
 		return -EINVAL;
 
 	/* ensure no regions are mapped to this memdev */
-	if (port->commit_end != -1)
+	if (cxl_decoders_committed(port))
 		return -EBUSY;
 
 	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SANITIZE);
@@ -191,7 +191,7 @@ static ssize_t security_erase_store(struct device *dev,
 		return -EINVAL;
 
 	/* ensure no regions are mapped to this memdev */
-	if (port->commit_end != -1)
+	if (cxl_decoders_committed(port))
 		return -EBUSY;
 
 	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SECURE_ERASE);
@@ -242,7 +242,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;
 
-	if (port->commit_end == -1) {
+	if (!cxl_decoders_committed(port)) {
 		/* No regions mapped to this memdev */
 		rc = cxl_get_poison_by_memdev(cxlmd);
 	} else {
@@ -293,7 +293,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 		.dpa = dpa,
 	};
 	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
+	if (port && is_cxl_endpoint(port) && cxl_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
 	return ctx.cxlr;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7ca01a834e18..16efb68eacfa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -31,6 +31,12 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+int cxl_decoders_committed(struct cxl_port *port)
+{
+	return port->commit_end + 1;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_decoders_committed, CXL);
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..2728700d8b33 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -679,6 +679,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport_dev == port->dev.parent;
 }
 
+int cxl_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
 struct pci_bus;


