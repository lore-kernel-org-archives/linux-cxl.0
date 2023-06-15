Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A252EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFOBbs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjFOBbs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:31:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10442135
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792705; x=1718328705;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6wtOT2KnatZ1oshPWSzTOBX/0GPeVhaucYeup9uHCI=;
  b=C81vfmBETsOHlpQks/u0gldoUF1depcx86b3S78bQGooVauU/y5+ul74
   Not1SIuxF3DsosF/Tpyus47+cDqlQKTwD0gwEJ+l0jGNwf6vHtv+tRGGP
   IqqOMCaibSND6QwUmfHW6GJTqUSWpy2ekuXIr00A0zgrqYMz3LxT4QHI0
   m9KHTDTWBo2JNEvm/0aVQmw33Sg3nGlmH+hPR4HYdeNdXqIcSN5iqnnhX
   zP38bRMFF5Sn/hnZQue2vrpNYW7O0PAVEqos/qfRXEB8DC3oNEPQ8wQDU
   1OW7YldtduptA1w8L3Le4VJoyv7mVHQ1Kposn7h+z/zf17762FsnXRS/e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362160586"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362160586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712273899"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712273899"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:43 -0700
Subject: [PATCH v2 12/12] cxl/memdev: Formalize endpoint port linkage
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 14 Jun 2023 18:30:43 -0700
Message-ID: <168679264292.3436160.3901392135863405807.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move the endpoint port that the cxl_mem driver establishes from drvdata
to a first class attribute. This is in preparation for device-memory
drivers reusing the CXL core for memory region management. Those drivers
need a type-safe method to retrieve their CXL port linkage. Leave
drvdata for private usage of the cxl_mem driver not external consumers
of a 'struct cxl_memdev' object.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    4 ++--
 drivers/cxl/core/pmem.c   |    2 +-
 drivers/cxl/core/port.c   |    5 +++--
 drivers/cxl/cxlmem.h      |    2 ++
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3f2d54f30548..65a685e5616f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -149,7 +149,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	struct cxl_port *port;
 	int rc;
 
-	port = dev_get_drvdata(&cxlmd->dev);
+	port = cxlmd->endpoint;
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
@@ -207,7 +207,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 	ctx = (struct cxl_dpa_to_region_context) {
 		.dpa = dpa,
 	};
-	port = dev_get_drvdata(&cxlmd->dev);
+	port = cxlmd->endpoint;
 	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index f8c38d997252..fc94f5240327 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,7 +64,7 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_port *port = find_cxl_root(dev_get_drvdata(&cxlmd->dev));
+	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
 	struct device *dev;
 
 	if (!port)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bf8f25063914..19252ef5ecbc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1167,7 +1167,7 @@ static struct device *grandparent(struct device *dev)
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
-	struct cxl_port *endpoint = dev_get_drvdata(&cxlmd->dev);
+	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct cxl_port *parent_port;
 	struct device *parent;
 
@@ -1182,6 +1182,7 @@ static void delete_endpoint(void *data)
 		devm_release_action(parent, cxl_unlink_uport, endpoint);
 		devm_release_action(parent, unregister_port, endpoint);
 	}
+	cxlmd->endpoint = NULL;
 	device_unlock(parent);
 	put_device(parent);
 out:
@@ -1193,7 +1194,7 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 	struct device *dev = &cxlmd->dev;
 
 	get_device(&endpoint->dev);
-	dev_set_drvdata(dev, endpoint);
+	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;
 	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1b39afeb369e..9aa8876a4eea 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -38,6 +38,7 @@
  * @detach_work: active memdev lost a port in its ancestry
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
+ * @endpoint: connection to the CXL port topology for this memory device
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  */
@@ -48,6 +49,7 @@ struct cxl_memdev {
 	struct work_struct detach_work;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
+	struct cxl_port *endpoint;
 	int id;
 	int depth;
 };

