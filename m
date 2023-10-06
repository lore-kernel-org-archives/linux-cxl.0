Return-Path: <linux-cxl+bounces-5-linux-cxl=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EA9E92FD2
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:27 +0000 (UTC)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 09EB7282067
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2A15AD;
	Fri,  6 Oct 2023 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUn5o+ju"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DAA2D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:43:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE9F0
	for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696552998; x=1728088998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85b5pqVhYEqafl/oi6WMPGvDv2w/15Y9t3amk+/eGos=;
  b=jUn5o+juDd5n20ES0AJo1blNPxvIW4sl0giPLDssCgedZvpEYLkKg+/s
   8w18ZZYJ/0YG+Ky7GgrwMtAafutyeiI7RcneJ8YKQpyblPGFgwDKLVVNc
   fBHzPBkaM2vrgYaH/GLPdeZ1TPzYUPB9Y8AmIXk3M3GprGvHFynpPsIj7
   SzMDkwYhMRtLp4KF6psBHITNVl7rZYtFO7RxcLd8Oi0E6Trs2eiBFJ8yv
   Mo8R3QtCdmCCiITRKpfGsJjwbiDLoSxd5rsJFajEyt2TwgKuqLAxFMh2I
   iJxuVXCw53lDVlmMfvOS89whsZQW8L/HjOwBNlr6Kb4l+uVF2y+16bIA7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363010983"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363010983"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925781561"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925781561"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.219.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:17 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: [PATCH 2/3] cxl/region: Calculate a target position in a region interleave
Date: Thu,  5 Oct 2023 17:43:12 -0700
Message-Id: <5a7133e0ab7eb11f96daa73d88ec765f3536634a.1696550786.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1696550786.git.alison.schofield@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Introduce a calculation that determines a targets position in a region
interleave. Perform a selftest of the calculation on user-defined
regions.

The region driver users the kernel sort() function to put region
targets in relative order. Positions are assigned based on each
targets index in that sorted list. That relative sort doesn't
consider the offset of a port into its parent port causing some
autodiscovered regions to fail creation. In one failure case,
a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
put all targets of one port ahead of another port, when they were
expected to be interleaved.

In preparation for repairing the autodiscovery region assembly,
introduce a new method for discovering a target position in the
region interleave.

cxl_interleave_pos() offers a method to determine a targets position
by ascending from an endpoint to a root decoder. The calculation starts
with the endpoints local position and its position in its parents port.
Traversing towards the root decoder and examining position and ways,
allows the position to be refined all the way to the root decoder.

This calculation, applied iteratively, yields the correct position:

position = position * parent_ways + parent_pos;

...when you follow these rules:

Rule #1 - When (parent_ways == region_ways), abort.
	  position = parent_position;
	  This rule is applied in calc_interleave_pos()

Rule #2 - Use an index into the target list when finding pos.
	  This rule is applied in the helper find_pos_and_ways().

Include a selftest that exercises this new position calculation against
every successfully configured user-defined region.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 100 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 64206fc4d99b..297b9132d5b3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1500,6 +1500,91 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 	return range_contains(r1, r2);
 }
 
+/* Find the position of a port in it's parent and the parents ways */
+static int find_pos_and_ways(struct cxl_port *port, struct range *range,
+			     int *pos, int *ways)
+{
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *parent;
+	int child_ways = *ways;
+	int child_pos = *pos;
+	struct device *dev;
+	int index = 0;
+	int rc = -1;
+
+	parent = next_port(port);
+	if (!parent)
+		return rc;
+
+	dev = device_find_child(&parent->dev, range,
+				match_switch_decoder_by_range);
+	if (!dev) {
+		dev_err(port->uport_dev,
+			"failed to find decoder mapping %#llx-%#llx\n",
+			range->start, range->end);
+		return rc;
+	}
+	cxlsd = to_cxl_switch_decoder(dev);
+	*ways = cxlsd->cxld.interleave_ways;
+
+	/* Use the child ways/pos as index to target list */
+	if (cxlsd->nr_targets > child_ways)
+		index = child_pos * child_ways;
+
+	for (int i = index; i < *ways; i++) {
+		if (cxlsd->target[i] == port->parent_dport) {
+			*pos = i;
+			rc = 0;
+			break;
+		}
+	}
+	put_device(dev);
+
+	return rc;
+}
+
+static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+			       int region_ways)
+{
+	struct cxl_port *iter, *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *range = &cxled->cxld.hpa_range;
+	int parent_ways = 0;
+	int parent_pos = 0;
+	int rc, pos;
+
+	/* Initialize pos to its local position */
+	rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
+	if (rc)
+		return -ENXIO;
+
+	pos = parent_pos;
+
+	if (parent_ways == region_ways)
+		goto out;
+
+	/* Iterate up the ancestral tree refining the position */
+	for (iter = next_port(port); iter; iter = next_port(iter)) {
+		if (is_cxl_root(iter))
+			break;
+
+		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		if (rc)
+			return -ENXIO;
+
+		if (parent_ways == region_ways) {
+			pos = parent_pos;
+			break;
+		}
+		pos = pos * parent_ways + parent_pos;
+	}
+out:
+	dev_dbg(&cxlmd->dev,
+		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
+		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
+		dev_name(&port->dev), range->start, range->end, pos);
+
+	return pos;
 }
 
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
@@ -1765,6 +1850,21 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		.end = p->res->end,
 	};
 
+	if (p->nr_targets != p->interleave_ways)
+		return 0;
+
+	/* Exercise position calculator on user-defined regions */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		int test_pos;
+
+		test_pos = calc_interleave_pos(cxled, p->interleave_ways);
+		dev_dbg(&cxled->cxld.dev,
+			"Interleave calc match %s test_pos:%d cxled->pos:%d\n",
+			(test_pos == cxled->pos) ? "Success" : "Fail",
+			test_pos, cxled->pos);
+	}
+
 	return 0;
 
 err_decrement:
-- 
2.37.3


