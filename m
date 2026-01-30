Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399A1607A4
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747001; cv=none; b=JKioFVbMNYqbvoEa0xAlFgMDQdCUtUF1XB6fo8Q/qoP6KOqebV+9zK3JAoV4sQD5OhQT8ny411cPpEG69YU9fpStBU90iUDFqzuBGerWvy2K0AIcAesmOCzQNDpszsj1A5wSMGB2TTtOjUHJaCsueeEx0G8LCxNnJ9uajRk9e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747001; c=relaxed/simple;
	bh=WCoLHuTacYRbXlWG4KvJSNmY3UErJOQbvj+fLGtHf6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+XXuq0LoFbFXH7U6DDkWl4XK+h8HhHunm5F/4f7iSZQc/Tqdlj1M0PfCtNpRlKre8L7D8j18ZS7Qa5PZtcB/5R6PEdxlf4rytz4uvc33dteg5hfnhc2v/OlKaK5ETSz7mivKVC/No/XdsA/nGj+Mipi1DyVig/otdm+A1fULaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmYG41pI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmYG41pI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769747000; x=1801283000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCoLHuTacYRbXlWG4KvJSNmY3UErJOQbvj+fLGtHf6o=;
  b=TmYG41pIUH0oplGg++CLtmwzqv6OoYawTHFzRtxmrtbO49yxUNkR6kOo
   xBupQC+isNJTKwH/v1i7efmV09bKtOoA97aIBXvjr/7m4uFPPweFJYvYx
   i+vwMck/hgolsUo7stUmVa1Uao0oXTXD9BNjUFXG4/KVOiLDodh64uuNP
   A2BtgC/2VpWjNlZyOLQ4gdxShNlben7vYaPiQ+9Ixam0tofQV214dAp6p
   QMKjQITuhjlcZOUjcH0RLXFMMxaxTll0u/zAlgx+/lEICHYQA8CpNSnJR
   dBjVWQhRpRGe3t+dkt4w0bzv1DkOxqlAZ6Vk6DPIQttQnK08oTfZoMvUS
   g==;
X-CSE-ConnectionGUID: vXVsYhKFQQuibkaKbKaHuA==
X-CSE-MsgGUID: SCi8UqgASPGXnXCfSZlQ/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70713560"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70713560"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:23:19 -0800
X-CSE-ConnectionGUID: hbjASybuQv6L+2YkxkVYuw==
X-CSE-MsgGUID: GpmyVusoToivl8oeP+pZkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213251506"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.124])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:23:19 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for endpoints
Date: Thu, 29 Jan 2026 20:23:10 -0800
Message-ID: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if not all expected endpoints arrive for an auto-created
region, the region remains registered but disabled indefinitely. The
region continues to reserve its memory resource, preventing DAX from
registering the memory, and provides no indication that endpoints
failed to arrive (useful for non-DAX configurations).

Start a 30 second timeout when the first endpoint attaches. If the
remaining endpoints have not attached before the timeout expires,
abort region assembly and unregister the region.

Cancel the timeout when all expected endpoints attach or the region is
unregistered for any reason.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 51 ++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..183cb0b49d8b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1968,6 +1968,35 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static void unregister_region(void *dev);
+
+#define CXL_REGION_EP_WAIT_MS (30 * 1000) /* 30 seconds */
+
+static void cxl_region_endpoint_wait_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct cxl_region *cxlr =
+		container_of(dwork, struct cxl_region, endpoint_wait_work);
+	struct cxl_region_params *p = &cxlr->params;
+	bool timeout_expired;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+	{
+		timeout_expired = (p->nr_targets < p->interleave_ways);
+	}
+
+	if (timeout_expired) {
+		struct cxl_root_decoder *cxlrd =
+			to_cxl_root_decoder(cxlr->dev.parent);
+		struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+		dev_err(&cxlr->dev,
+			"timeout waiting for endpoints: %d of %d arrived, unregistering region\n",
+			p->nr_targets, p->interleave_ways);
+		devm_release_action(port->uport_dev, unregister_region, cxlr);
+	}
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2059,8 +2088,23 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			return rc;
 
 		/* await more targets to arrive... */
-		if (p->nr_targets < p->interleave_ways)
+		if (p->nr_targets < p->interleave_ways) {
+			if (cxlr->endpoint_wait_armed)
+				return 0;
+
+			INIT_DELAYED_WORK(&cxlr->endpoint_wait_work,
+					  cxl_region_endpoint_wait_work);
+			schedule_delayed_work(
+				&cxlr->endpoint_wait_work,
+				msecs_to_jiffies(CXL_REGION_EP_WAIT_MS));
+			cxlr->endpoint_wait_armed = true;
+			dev_dbg(&cxlr->dev,
+				"waiting %d ms for %d more endpoints\n",
+				CXL_REGION_EP_WAIT_MS,
+				p->interleave_ways - p->nr_targets);
+
 			return 0;
+		}
 
 		/*
 		 * All targets are here, which implies all PCI enumeration that
@@ -2444,6 +2488,11 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	if (cxlr->endpoint_wait_armed) {
+		cancel_delayed_work_sync(&cxlr->endpoint_wait_work);
+		cxlr->endpoint_wait_armed = false;
+	}
+
 	device_del(&cxlr->dev);
 
 	/*
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..f6441a18b3bb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -551,6 +551,8 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct delayed_work endpoint_wait_work;
+	bool endpoint_wait_armed;
 };
 
 struct cxl_nvdimm_bridge {

base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.37.3

