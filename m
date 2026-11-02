Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650571;
	b=G3lapWkzCXqeXYrqhsvnOL3eS2yeOliTFUSaKs76r30LtZgg8KkBKhvS0nAY0VTiBx8z
	 MvPSlL+9d9vM9mf1+Xol364MsC4g8im4KzppNIP7P7UGh2EDl97yzcYo5tVPKss9K3YM+
	 Fuf9uDyLzNKYi63n24RD4TFjXLptU0mql3FC3gf7xEdW/D/Y6ybhCFJypOEE98f9xrlkg
	 gJOklqFuZxaluOJ8FBCnd+FJdiEh+f1PZ9vV5osjThuzfN8dJhYoM+64cMuTcg6LPaTAt
	 PK1rjaDPr8R8kzVFA5uZm3uMLqIoAkvfjHzlS2uaw0gRnBI0I+kX/g4E1cXzjzuYD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MDWAHzVUqC4TDGYWI/BZhbzpcMqVsenPLMG2lhnPL5U=;
	b=bik4kwMVCovfMTDR9lDIhorJbz1tNgVKB1ZnzphsubZApcVvkdjvgcVaD2oVzRIhcMbf
	 kCTE8pQlSpo9yVy0VM7lWWUx1A6kCRjn6rtG9XROixQ4tDU90Wpy55Dk5Ci3ojw9qkW2j
	 +ML0/wkC//S2fgoQrDnar11On/nt2do4tYWUnxcB8DlIWqIAxmLU1uaU0PO/4eRJnYpyf
	 3a9dxZjV0MOK4GunkqGRjWf5f/dW6mjF/UgcYD3xOurD5rufCpwMdxmjLoBH7hUNwdsuQ
	 zotXUYq8j9/qrGfWPN4ObX0m9sZjcGabDEWDSUxBs+eUXFzFF7lLAaZX/vzoqJFCGjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JLET4sws;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38653606A336
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38653606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JLET4sws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650571; x=1825186571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mxCHbU/jqlKcGTa+JvqOWMZKMh+M63Edx8fhKG9yk8=;
  b=JLET4swsdVhKEYhBbDCHGuiZhUAnxuu8RQpylHzgyIbA45MvAzpp/kOA
   KHRiLKF/0xlTnMJ4o5mi1cdSHufSMxelnup1ZgYZoBBYz4lk/d+epq1WH
   Mjt2GjV/eU1oJmgCh5vc9vQtp12AZ++ZwUpEFdJFI44xMT7iJglISuBXA
   9adf2lUTMnL74bCvaVx2bHfrBToqSzaIk5DQxolXoKU7MP65wAkNkfOML
   bcvfkfBmGzAy8BFQwqTXroOkerkf6H1sW5GzU83nqwJaLv6Bca4LEF51Y
   xsD6dX9g+I0Vm/HHy5i+a5r3t9CdiRRbOwTkGKJ4wIhIrmH83/tRlWaIg
   w==;
X-CSE-ConnectionGUID: duLigHd2TvSnCQqjkDVElQ==
X-CSE-MsgGUID: JsiLrC99SBuHdlCUZ0vdqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464000"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:10 -0800
X-CSE-ConnectionGUID: W4XUDbcJQke/N20nk+DjcA==
X-CSE-MsgGUID: 6qc7RFNTRUWKYt2DlkAi9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215597"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:10 -0800
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
Subject: [PATCH v5 2/9] cxl/region: Rename cxl_port_setup_targets() to cxl_switch_port_setup_targets()
Date: Mon,  2 Nov 2026 12:15:57 -0800
Message-ID: <3d4e8c486e7ca0c298780fb7e00516deef807226.1793649898.git.alison.schofield@intel.com>
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

