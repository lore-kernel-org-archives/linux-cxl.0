Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E734A3BF
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264809; cv=none; b=quDhcyEG3C3VPFwDN2iY+ze2e/G5xqyLQPmyqnuiUdMM1Fo9LoD1h2nYuCoy+UzzOKXyasRWg31McqOa+X4rCbnpjBV0Te/w8WJUCPPO614WJCc70vSloEIUbUsF1pJpeH0cE0YJPCUkoyDDZssHr8asVxHBZWHfAcCOiUot/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264809; c=relaxed/simple;
	bh=7mxCHbU/jqlKcGTa+JvqOWMZKMh+M63Edx8fhKG9yk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmRGwrMk8RUHA7PkZ7pzoZcWCj4NI3oJBRCfUtNvaN4qqUmBLe3j/h6oRy7lzzW6tvI6FD8QST1TG2jQzHQUQSCKusJRlHyf2aYt0cltD/D1hIacCgQl66RmeEAfkv9TsDGr2bBigbq1hPsPwGY+TiXmY66UqsMj/S70tagJPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYOiXy9B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYOiXy9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264806; x=1823800806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mxCHbU/jqlKcGTa+JvqOWMZKMh+M63Edx8fhKG9yk8=;
  b=IYOiXy9B1yUmgEABIgOh55q7fBBiu/9MMAsGjZH1N6JSGBtJkG5NoXpQ
   oGtdQd8LYMfmZelnjjEv1pChF8Q/NouEz0bDWgHauM0D4p5dBMxUw/gco
   k69QnschQzjFRknv+RasrWRUbKUP9lZtl+lEMecRsb2dtUWSJFAJbvq9P
   LiNU5Dub4ubd8s4h8FRLkv6wdWKvP9Sl/C+ioCA6kgYRBdJ3kqFyz0p2w
   KoL0KfJtkHs5rp6zy3AuMsXr5vF9SXvpGdn2uYjdXUBt5JKUH17mxLjCi
   n0UrCkZVrxlRPxBC7pq6/ctP0ZEqzQ7fhvaVkmYiEzoKKesTkJIRN1L/x
   A==;
X-CSE-ConnectionGUID: 8nG6RJDJQQC5jQNo8zs6YQ==
X-CSE-MsgGUID: 4yP3cSBnS8OXMivxfm5J/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034669"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034669"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:06 -0700
X-CSE-ConnectionGUID: As5edvN+S12/knJASht/dA==
X-CSE-MsgGUID: SeibOflfTAKjHJ3Ry382xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282211"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:06 -0700
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
Subject: [PATCH v4 2/9] cxl/region: Rename cxl_port_setup_targets() to cxl_switch_port_setup_targets()
Date: Sat, 17 Oct 2026 12:19:47 -0700
Message-ID: <db71ddde2fae81e1406d0184080386500af0e26a.1792263750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() configures the switch decoder targets for a
region. It runs for each switch port, including host bridges, between the
root and an endpoint.

Rename the function to cxl_switch_port_setup_targets() to make its scope
explicit and pass it the switch decoder so the parameter type enforces
that scope.

No functional change.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bc087ca63946..6ce27b8b63be 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,10 +1432,11 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
-static int cxl_port_setup_targets(struct cxl_port *port,
-				  struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled)
+static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
@@ -1443,8 +1444,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
 	struct cxl_port *iter = port;
 
 	/*
@@ -1458,7 +1458,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -EINVAL;
 	}
 
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
 		int i, distance = 1;
 		struct cxl_region_ref *cxl_rr_iter;
@@ -1716,7 +1715,11 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 		 */
 		for (ep = cxl_ep_load(iter, cxlmd); iter;
 		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
-			rc = cxl_port_setup_targets(iter, cxlr, cxled);
+			struct cxl_region_ref *cxl_rr = cxl_rr_load(iter, cxlr);
+			struct cxl_switch_decoder *cxlsd;
+
+			cxlsd = to_cxl_switch_decoder(&cxl_rr->decoder->dev);
+			rc = cxl_switch_port_setup_targets(cxlsd, cxlr, cxled);
 			if (rc) {
 				cxl_region_teardown_targets(cxlr);
 				return rc;
-- 
2.37.3

