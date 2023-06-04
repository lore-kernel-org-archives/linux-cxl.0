Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64194C77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFDXcb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjFDXc2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485FD3
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921547; x=1717457547;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ypx9cmzM6FXHhuCoFQk1tSZ3VR7I5REanPXlp+5aKE=;
  b=fW8OV8j2dqkidzcnaocnIOSGLcB/gIu91Yj1QAQ/jKVIeY5iohzKajIS
   EMQyhHB85lo/XiwsEgB5PquD36AfwdPH59sgd447UJ7rA6MiTP70a0Z1N
   8y7lgXmZAnyY+ZUWTtz65KfbeCAH3JOFSyRggX9u6oor/0wIjOjOdp3cb
   SMsfkNtmyqCYTzGLnxuc7H9jBOuaVoqPCyy2KbWkbgLHr67jpoWhpHCsg
   MtWYZRNGUYcxrH3sOfAnipHb/UCUYYenqmWRXP2MW5fJQyJvp5hoH3g62
   X7IaevFrpMd/1ryn9ln6Wm5gm0dNIcrxYpH6b0KKg7n8iEAWfVV6hysIc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336596771"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336596771"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038571942"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038571942"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:27 -0700
Subject: [PATCH 09/19] cxl/memdev: Formalize endpoint port linkage
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:27 -0700
Message-ID: <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
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
index 71a7547a8d6f..6720ab22a494 100644
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
index b8bdf7490d2c..7ee78e79933c 100644
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

