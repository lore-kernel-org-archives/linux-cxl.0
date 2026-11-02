Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650574;
	b=N2Xnlli+2nbHiBYjJnH6oMO0LLZk5cSiV429iMw5qoo35/F+U8ITY5c14nsA9vIOA5Mp
	 HIHQfQQGH9zBgdWZs7gyZ0ThbITm7U17rjq+mOsv1EZ7C08v0H6Eg7/qXN0gHizz1qmB6
	 Vm3/BGER675QvfV44kLRX3Ngf6R6hNaPjVxfgCCq5HQWolPlowgowJorE1bVb4+NIUGX2
	 efGgM8+hMlMa6WOOQEkMhm02graektz8oWmrrS8tXIRhv30o1wNIBK6CPeT9exXAIfXZu
	 l5AVnBiUjigy56R1X5vfYCLlCuS7W2cIuO5Oeew8QZNd1LeYnzL/vLwz7zFpOSFK0Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650574;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HhNzZTNtibcZikD+wegM3T3UJtdS0E2sRUJd3haBBHw=;
	b=BY8WGRkP00ERRi6MxlP1I+AdkX03zJn1dd1xDcehYz4zlO+Ar5olA6FCDfATn3wqTyCU
	 cLdvxAlU5QbtWTj3ygHKF4dHMPNBhAHhuSyTaAdLYtBU7OrxRRu/mh17oxt4jc2bVM7UF
	 ZOIX38YWSoV6Ssg7fgvwis6Hmhq6YisY9gJS4lzEEgKuGfDi82XlsN2w9rJe9y/l1r+lM
	 UghnuQQxNENUQKQhhBywwcIt098dI19/ltORhy5wsmOmvN/8GKS5uAj/5e60FgoHQDQIB
	 sH2wfDexIxl6sfnUWG3P9Mmo2MUV0jyUEPnX5EScmyn+C+iGjH4888dxTo4VfCkRS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ak45Cp7I;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F948606A327
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F948606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ak45Cp7I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650573; x=1825186573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymR+04y2EwtWx2rbv774L4WjlSkRdOQHsZMDo3Gu2mU=;
  b=Ak45Cp7Ig5QMp6hhBVzTBgdq3YN5DgCBp2Q8xEtH07BWJ50TRSyLU+1v
   7awofMdS+0FRUdByMSMf/E+sVm96OHczj4L4fNEgbF0uoB/QDDll+3P4i
   mfalL5SoCw16Qu+p2KGl+n4nyIvj/MFDl99MFRD9hGKxQpsP6gxv2YSLY
   3S7ti3d/SBKk9QRMhq7UbxEDiAOvUD0+2TxnSKQ4kNjYE8HiZlPZmmUgo
   yST5neYItlxCrZNVZkkartil6SnwPVgkoSxtvex3hbVl0T1vvtmB92wUx
   oDNMiuXc2xrzFCSSru6XjJ+mzcjnm0JubbOBbQPMg+Q13jhie1ce1sI+R
   A==;
X-CSE-ConnectionGUID: 2K+ccvhqT+mBwyH9p5r15Q==
X-CSE-MsgGUID: yoxg0ARwRAWoHOCGvO1t7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464023"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464023"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:13 -0800
X-CSE-ConnectionGUID: /bRRDzczSFi+aho4PFyGqw==
X-CSE-MsgGUID: s24G+NQEQr+F9IhIjm/NJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215615"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 5/9] cxl/region: Factor out cxl_port_parent_interleave()
Date: Mon,  2 Nov 2026 12:16:00 -0800
Message-ID: <c9517ef7c5cb0c2622b7cf5067f8f83fcb8de7f8.1793649898.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793649898.git.alison.schofield@intel.com>
References: <cover.1793649898.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_switch_port_setup_targets() derives a decoder's interleave from the
interleave of the decoder above it. That parent interleave comes from
either the root decoder or a switch decoder, and each case is open coded
along with the parent validity checks.

Move the parent interleave lookup and validation to a new helper,
cxl_port_parent_interleave().

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 99 ++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8bfebe3e1025..cdf90fb6ea64 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1459,44 +1459,21 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	return distance;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
-					 struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+/*
+ * Get the parent interleave ways and granularity.
+ *
+ * For address bit routing, use power-of-2 math for switch ports.
+ * Root interleave ways of 3, 6, or 12 are normalized to 1, 2, or 4
+ * in @out_iw.
+ */
+static int cxl_port_parent_interleave(struct cxl_port *port,
+				      struct cxl_region *cxlr,
+				      int *out_iw, int *out_ig)
 {
-	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = &cxlsd->cxld;
-
-	/*
-	 * While root level decoders support x3, x6, x12, switch level
-	 * decoders only support powers of 2 up to x16.
-	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
-		return -EINVAL;
-	}
-
-	if (cxl_rr->nr_targets_set) {
-		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
-			if (ep->dport == cxlsd->target[i]) {
-				int distance = cxl_port_peer_distance(port, cxlr);
-
-				rc = check_last_peer(cxled, ep, cxl_rr,
-						     distance);
-				if (rc)
-					return rc;
-				goto out_target_set;
-			}
-		goto add_target;
-	}
+	int parent_iw, parent_ig;
 
 	if (is_cxl_root(parent_port)) {
 		/*
@@ -1508,10 +1485,6 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 		 */
 		parent_ig = p->interleave_granularity;
 		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
-		/*
-		 * For purposes of address bit routing, use power-of-2 math for
-		 * switch ports.
-		 */
 		if (!is_power_of_2(parent_iw))
 			parent_iw /= 3;
 	} else {
@@ -1538,6 +1511,54 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 		return -EINVAL;
 	}
 
+	*out_iw = parent_iw;
+	*out_ig = parent_ig;
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+
+	/*
+	 * While root level decoders support x3, x6, x12, switch level
+	 * decoders only support powers of 2 up to x16.
+	 */
+	if (!is_power_of_2(cxl_rr->nr_targets)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			cxl_rr->nr_targets);
+		return -EINVAL;
+	}
+
+	if (cxl_rr->nr_targets_set) {
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
+			if (ep->dport == cxlsd->target[i]) {
+				int distance = cxl_port_peer_distance(port, cxlr);
+
+				rc = check_last_peer(cxled, ep, cxl_rr,
+						     distance);
+				if (rc)
+					return rc;
+				goto out_target_set;
+			}
+		goto add_target;
+	}
+
+	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	if (rc)
+		return rc;
+
 	iw = cxl_rr->nr_targets;
 	if (!ways_valid(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-- 
2.37.3

