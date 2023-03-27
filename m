Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC52CC7619A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC0FCY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC0FCY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:02:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B0E3A8C
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893342; x=1711429342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CkHY+u3XlCgO9iJQxg6rcYAE8hR1/kqUaVpgjK3zZfA=;
  b=dPzFMXXCnseTY14e7q6YjRtpgkF1/env05WqJr7HYu8sv5QiyYn58F03
   f3hQkhHXfQ8oVlGYl+/DKAqfkGJ+ZP75k93iDw5M2F7rpZn65s7+ygjik
   ZgwSAKS/+N/KiLrt7eHB7Sl2U43flk0cd18TBPZavfMa/mTekgA+nJqWt
   GLWoxqpBWnE1H80M6qwJjzu4kZkfuSh2g5v3R055E9Nn1bRcXrcCKt700
   HXM2vvbJjSCHa+zCoo66Nc80/HCbWHnrQfe3eoqJk5+JkPYEZXSKNh51B
   7gzcV2FGe4JC+w5wjMhhPNym4qWda8dV8mw6Z2o8epsI8nnNsUBToy3i4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341753865"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="341753865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747856158"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="747856158"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:21 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 4/6] cxl/region: Provide region info to the cxl_poison trace event
Date:   Sun, 26 Mar 2023 22:02:10 -0700
Message-Id: <f5bfd91ce391c1ee13a0d55c698be2417072d02d.1679888450.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679888450.git.alison.schofield@intel.com>
References: <cover.1679888450.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

User space may need to know which region, if any, maps the poison
address(es) logged in a cxl_poison trace event. Since the mapping
of DPAs (device physical addresses) to a region can change, the
kernel must provide this information at the time the poison list
is read. The event informs user space that at event <timestamp>
this <region> mapped to this <DPA>, which is poisoned.

The cxl_poison trace event is already wired up to log the region
name and uuid if it receives param 'struct cxl_region'.

In order to provide that cxl_region, add another method for gathering
poison - by committed endpoint decoder mappings. This method is only
available with CONFIG_CXL_REGION and is only used if a region actually
maps the memdev where poison is being read. After the region driver
reads the poison list for all the mapped resources, control returns
to the memdev driver, where poison is read for any remaining unmapped
resources.

Mixed mode decoders are not currently supported in Linux. Add a debug
message to the poison request path. That will serve as an alert that
poison list retrieval needs to add support for mixed mode.

The default method remains: read the poison by memdev resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h   | 11 +++++++
 drivers/cxl/core/memdev.c | 62 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e888e293943e..57bd22e01a0b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
+int cxl_get_poison_by_endpoint(struct device *dev, void *data);
 #else
+static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
+{
+	return 0;
+}
 static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 }
@@ -68,4 +73,10 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_LIST,
 };
 
+struct cxl_trigger_poison_context {
+	struct cxl_port *port;
+	enum cxl_decoder_mode mode;
+	u64 offset;
+};
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 297d87ebaca6..f26b5b6cda10 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,6 +106,47 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
+				   struct cxl_trigger_poison_context *ctx)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 offset, length;
+	int rc = 0;
+
+	/*
+	 * Collect poison for the remaining unmapped resources
+	 * after poison is collected by committed endpoints.
+	 *
+	 * Knowing that PMEM must always follow RAM, get poison
+	 * for unmapped resources based on the last decoder's mode:
+	 *	ram: scan remains of ram range, then any pmem range
+	 *	pmem: scan remains of pmem range
+	 */
+
+	if (ctx->mode == CXL_DECODER_RAM) {
+		offset = ctx->offset;
+		length = resource_size(&cxlds->ram_res) - offset;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT)
+			rc = 0;
+		if (rc)
+			return rc;
+	}
+	if (ctx->mode == CXL_DECODER_PMEM) {
+		offset = ctx->offset;
+		length = resource_size(&cxlds->dpa_res) - offset;
+		if (!length)
+			return 0;
+	} else if (resource_size(&cxlds->pmem_res)) {
+		offset = cxlds->pmem_res.start;
+		length = resource_size(&cxlds->pmem_res);
+	} else {
+		return 0;
+	}
+
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+}
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -139,14 +180,33 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
 				const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_trigger_poison_context ctx;
+	struct cxl_port *port;
 	bool trigger;
 	ssize_t rc;
 
 	if (kstrtobool(buf, &trigger) || !trigger)
 		return -EINVAL;
 
+	port = dev_get_drvdata(&cxlmd->dev);
+	if (!port || !is_cxl_endpoint(port))
+		return -EINVAL;
+
 	down_read(&cxl_dpa_rwsem);
-	rc = cxl_get_poison_by_memdev(cxlmd);
+	if (port->commit_end == -1) {
+		/* No regions mapped to this memdev */
+		rc = cxl_get_poison_by_memdev(cxlmd);
+	} else {
+		/* Regions mapped, collect poison by endpoint */
+		ctx = (struct cxl_trigger_poison_context) {
+			.port = port,
+		};
+		rc = device_for_each_child(&port->dev, &ctx,
+					   cxl_get_poison_by_endpoint);
+		if (rc == 1)
+			rc = cxl_get_poison_unmapped(cxlmd, &ctx);
+	}
+
 	up_read(&cxl_dpa_rwsem);
 
 	return rc ? rc : len;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..4c4d3a6d631d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2213,6 +2213,69 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
 
+int cxl_get_poison_by_endpoint(struct device *dev, void *arg)
+{
+	struct cxl_trigger_poison_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port = ctx->port;
+	struct cxl_memdev *cxlmd;
+	u64 offset, length;
+	int rc = 0;
+
+	down_read(&cxl_region_rwsem);
+
+	if (!is_endpoint_decoder(dev))
+		goto out;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		goto out;
+
+	/*
+	 * Regions are only created with single mode decoders: pmem or ram.
+	 * Linux does not currently support mixed mode decoders. This means
+	 * that reading poison per endpoint decoder adheres to the spec
+	 * requirement that poison reads of pmem and ram must be separated.
+	 * CXL 3.0 Spec 8.2.9.8.4.1
+	 *
+	 * Watch for future support of mixed with a dev_dbg() msg.
+	 */
+	if (cxled->mode == CXL_DECODER_MIXED) {
+		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
+		goto out;
+	}
+
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->skip) {
+		offset = cxled->dpa_res->start - cxled->skip;
+		length = cxled->skip;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+			rc = 0;
+		if (rc)
+			goto out;
+	}
+
+	offset = cxled->dpa_res->start;
+	length = cxled->dpa_res->end - offset + 1;
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+		rc = 0;
+	if (rc)
+		goto out;
+
+	/* Iterate until commit_end is reached */
+	if (cxled->cxld.id == port->commit_end)
+		rc = 1;
+
+	/* ctx informs the memdev driver of last read poison */
+	ctx->mode = cxled->mode;
+	ctx->offset = cxled->dpa_res->end + 1;
+out:
+	up_read(&cxl_region_rwsem);
+	return rc;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

