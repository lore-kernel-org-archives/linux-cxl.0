Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7D47F3A5
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865572; cv=none; b=NXiSGouq7AT4wYRbDvrYAcWIaZonas1sivxDVCk1UV1goZ3MKN+bMYJSWXoH7PZFzvXp1XsZb5F492BYkUVoLfWgFgbLczHQ0tbJHymDdymcNeR9x4qHU/BT+/AVqU+44dzheP3zZJsvM3W0hJ/Q3Qo8uP8FoXpFO2o4BWDxszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865572; c=relaxed/simple;
	bh=NQ06WDJSA7K0A2TsC5Pvlpi2SVxA+3hHcVfF/acTBnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOvOHLJAKPJNN04HQ/SyCFAUwrEKZ1zpgknHYl9hoHmKtqUNIkNuMCM0+e9eDec32NDbhlc4GY/R4N0r5Q7sRzDcXFYHvkssmGCogad5PkkIhKf6+KV8T8lppQWhMtvZqHFwd+iYyL4Iz2VWbo72HNwB7Trk0ZDmXvrSs6eYLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wx/HQNjO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wx/HQNjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865572; x=1823401572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQ06WDJSA7K0A2TsC5Pvlpi2SVxA+3hHcVfF/acTBnE=;
  b=Wx/HQNjOFY/XoNP/+GXcfNDABgwQ0Rx9BxwopXNobGMl2eXG3qVluiAM
   aIrP9T/x2vkq/SFPtM/LmN+mu5FTWCgntZRlbOiOXVWWvcWqd/BYHUYm2
   K+5ve5uiC0wtX2nSHbR9SvbQvhB+N1123KTjnrXWdI8WMQxjmnH1XhMFL
   23UX7ZNOQJnWky02IFsBJ7zhr0XKXr+JUofVvsHA75D4sw0M+1kDOW2+a
   n+I9leMfMTW2pGb3uaoXf9HjcGGJboztuuUd2p6ZGjd0E0NueN8OOHQNv
   4iqQ1G0TNqqxVDpDnZVMZF/Bcl2HMMKTYhdIl5Og04PG5ai2urnuZ92br
   A==;
X-CSE-ConnectionGUID: LJIXwDIUTICY25rZZ3tXJg==
X-CSE-MsgGUID: P5LXLd/uRN23yYIbaZM86g==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455474"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455474"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:10 -0700
X-CSE-ConnectionGUID: NAUUKE9RTiyetZcVf+X1TQ==
X-CSE-MsgGUID: ANd1cg97QjOvyEo1midtEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391076"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:09 -0700
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
Subject: [PATCH v3 2/7] cxl/region: Rename cxl_port_setup_targets() to cxl_switch_port_setup_targets()
Date: Mon, 12 Oct 2026 21:25:58 -0700
Message-ID: <3342ed1a893f001bb96efb3aecaccbe311697e87.1791860305.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
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
explicit.

No functional change.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bc087ca63946..9b0e2f195d1f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
-static int cxl_port_setup_targets(struct cxl_port *port,
-				  struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled)
+static int cxl_switch_port_setup_targets(struct cxl_port *port,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
@@ -1716,7 +1716,7 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 		 */
 		for (ep = cxl_ep_load(iter, cxlmd); iter;
 		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
-			rc = cxl_port_setup_targets(iter, cxlr, cxled);
+			rc = cxl_switch_port_setup_targets(iter, cxlr, cxled);
 			if (rc) {
 				cxl_region_teardown_targets(cxlr);
 				return rc;
-- 
2.37.3

