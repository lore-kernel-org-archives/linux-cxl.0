Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4744C77;
	Tue,  3 Jun 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929113; cv=none; b=YW5parTp1sG/gmXksAnJVO/H5CRNfnaS33zxfP+wgvRGSQbHhUBNlmjHdlEOnAp/GnBQayN0K2u3W+Y+46E0+tQfeLnb2ooDrnQ4+LYewUsDkcwMOLGXeptVFi0fAEH6ZYXwyVI1MfGCYc8u3CxxX0cEdtv9rJJbn8eJaYkl88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929113; c=relaxed/simple;
	bh=XZLex7oG1HhVeOhHXYnE4iIFVXtHzYyltteFa/GbZPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDol3leVBqwqgU5zJXJYMDwkHnkG20uNd67xcnY5B8uOvnGe0EWgCL5xb9w70BBUg/v6Eib/X6E4ERo+b85mQyJ2OXREPsS1LEawrG7s5Lh9xRH8HphMNlXkRnzAx4hv316vSckNQ9SKHOwkw9FSCAlPnABsbM9BuhzF4u14dGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DruleAX4; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DruleAX4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1748929112; x=1780465112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XZLex7oG1HhVeOhHXYnE4iIFVXtHzYyltteFa/GbZPg=;
  b=DruleAX4ynOue3YXPygyq53xJ/VjDyGkPnPvn+T1qqGVEc2nTMfqx2OA
   YTyUU6dw+v54JV0nx4d5HtY0e3a4CNSSq3jfrQnKsh2lfROzNBoOmB07y
   o04nMypKirW5tapwis17DYajenO8SHeu26SNg9fQClzQBPX1cRi2E40FQ
   XJBT8jImjfbHzzZOMEQ15VKGb6SOw6WxUE3z4646qCu2Hu0QLoSz7hkz0
   W2vWjscOVFewcXUfMF+1ZnD/IyKFkfdqxFcEX6PWJ8IdM06CqGoQLJZdP
   5Wj+GhkFqKxPVDPsTumqHUfHoRLZpppoBDhTRFdxdCxGMMTFNb93NlPbq
   w==;
X-CSE-ConnectionGUID: IsqXnKdqTniaPlkQqFpk+A==
X-CSE-MsgGUID: Qg11MBYfSJu0Zryga/hJYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="180443151"
X-IronPort-AV: E=Sophos;i="6.16,205,1744038000"; 
   d="scan'208";a="180443151"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:37:19 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4085DD6863;
	Tue,  3 Jun 2025 14:37:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E749CCFBB5;
	Tue,  3 Jun 2025 14:37:15 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8D4301A0078;
	Tue,  3 Jun 2025 13:37:14 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next] cxl/core: Consolidate auto region attachment logic
Date: Tue,  3 Jun 2025 13:36:45 +0800
Message-ID: <20250603053645.3099299-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all auto-attach handling from cxl_region_attach() into the
cxl_region_attach_auto() function. This combines the partial handling
previously in cxl_region_attach_auto() with the remaining logic that
was directly implemented in cxl_region_attach().

Specifically, cxl_region_attach_auto() now handles:
- Adding new targets when in auto-discovery mode
- Waiting for all required targets
- Sorting and validating targets when ready

This improves code organization by:
- Keeping all auto-attach logic in a single function
- Reducing complexity in the main attach function
- Making the control flow easier to follow

No functional change intended.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 164 +++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..e7618d59b548 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1702,44 +1702,6 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
-static int cxl_region_attach_auto(struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled, int pos)
-{
-	struct cxl_region_params *p = &cxlr->params;
-
-	if (cxled->state != CXL_DECODER_STATE_AUTO) {
-		dev_err(&cxlr->dev,
-			"%s: unable to add decoder to autodetected region\n",
-			dev_name(&cxled->cxld.dev));
-		return -EINVAL;
-	}
-
-	if (pos >= 0) {
-		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
-			dev_name(&cxled->cxld.dev), pos);
-		return -EINVAL;
-	}
-
-	if (p->nr_targets >= p->interleave_ways) {
-		dev_err(&cxlr->dev, "%s: no more target slots available\n",
-			dev_name(&cxled->cxld.dev));
-		return -ENXIO;
-	}
-
-	/*
-	 * Temporarily record the endpoint decoder into the target array. Yes,
-	 * this means that userspace can view devices in the wrong position
-	 * before the region activates, and must be careful to understand when
-	 * it might be racing region autodiscovery.
-	 */
-	pos = p->nr_targets;
-	p->targets[pos] = cxled;
-	cxled->pos = pos;
-	p->nr_targets++;
-
-	return 0;
-}
-
 static int cmp_interleave_pos(const void *a, const void *b)
 {
 	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
@@ -1905,6 +1867,86 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static int cxl_region_attach_auto(struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled, int pos)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_port *root_port;
+	int i, rc;
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO) {
+		dev_err(&cxlr->dev,
+			"%s: unable to add decoder to autodetected region\n",
+			dev_name(&cxled->cxld.dev));
+		return -EINVAL;
+	}
+
+	if (pos >= 0) {
+		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
+			dev_name(&cxled->cxld.dev), pos);
+		return -EINVAL;
+	}
+
+	if (p->nr_targets >= p->interleave_ways) {
+		dev_err(&cxlr->dev, "%s: no more target slots available\n",
+			dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Temporarily record the endpoint decoder into the target array. Yes,
+	 * this means that userspace can view devices in the wrong position
+	 * before the region activates, and must be careful to understand when
+	 * it might be racing region autodiscovery.
+	 */
+	pos = p->nr_targets;
+	p->targets[pos] = cxled;
+	cxled->pos = pos;
+	p->nr_targets++;
+
+	/* await more targets to arrive... */
+	if (p->nr_targets < p->interleave_ways)
+		return 0;
+
+	/*
+	 * All targets are here, which implies all PCI enumeration that
+	 * affects this region has been completed. Walk the topology to
+	 * sort the devices into their relative region decode position.
+	 */
+	rc = cxl_region_sort_targets(cxlr);
+	if (rc)
+		return rc;
+
+	root_port = cxlrd_to_port(cxlrd);
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_port *ep_port;
+		struct cxl_dport *dport;
+
+		cxled = p->targets[i];
+		ep_port = cxled_to_port(cxled);
+		dport = cxl_find_dport_by_dev(root_port,
+					      ep_port->host_bridge);
+		rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
+						dport, i);
+		if (rc)
+			return rc;
+	}
+
+	rc = cxl_region_setup_targets(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * If target setup succeeds in the autodiscovery case
+	 * then the region is already committed.
+	 */
+	p->state = CXL_CONFIG_COMMIT;
+	cxl_region_shared_upstream_bandwidth_update(cxlr);
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1986,50 +2028,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 
 	cxl_region_perf_data_calculate(cxlr, cxled);
 
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-		int i;
-
-		rc = cxl_region_attach_auto(cxlr, cxled, pos);
-		if (rc)
-			return rc;
-
-		/* await more targets to arrive... */
-		if (p->nr_targets < p->interleave_ways)
-			return 0;
-
-		/*
-		 * All targets are here, which implies all PCI enumeration that
-		 * affects this region has been completed. Walk the topology to
-		 * sort the devices into their relative region decode position.
-		 */
-		rc = cxl_region_sort_targets(cxlr);
-		if (rc)
-			return rc;
-
-		for (i = 0; i < p->nr_targets; i++) {
-			cxled = p->targets[i];
-			ep_port = cxled_to_port(cxled);
-			dport = cxl_find_dport_by_dev(root_port,
-						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
-			if (rc)
-				return rc;
-		}
-
-		rc = cxl_region_setup_targets(cxlr);
-		if (rc)
-			return rc;
-
-		/*
-		 * If target setup succeeds in the autodiscovery case
-		 * then the region is already committed.
-		 */
-		p->state = CXL_CONFIG_COMMIT;
-		cxl_region_shared_upstream_bandwidth_update(cxlr);
-
-		return 0;
-	}
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		return cxl_region_attach_auto(cxlr, cxled, pos);
 
 	rc = cxl_region_validate_position(cxlr, cxled, pos);
 	if (rc)
-- 
2.41.0

