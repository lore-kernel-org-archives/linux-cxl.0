Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3C379C24
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268691; cv=none; b=U+YLhtgp0zE3HAXdWfbuqLsbjcMcRQpRLggiMMCRGWv9ZQIMrDhpkSM2VCs3skpVQifP7amSXPISWNHNXR7tLFfczPYAfPPKjLpgrIZNCy+XhcnAExtUNOnWRd7vesIGd/KHJAsCwZYibevpKeT54EMUva5qpmXKli6pUQpSo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268691; c=relaxed/simple;
	bh=AIXXvjN7QYTCiRAlOmiVy3NFOQEb8cVyqPT/AT2O+yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naF0ER3lw4j9iynZ1yRRu+GW6iXPPPQFOtkBrnUAyi82O462UuRhO1zsaRydiUaoMevjPbOozwohjfbXgupGuRBy29iepUi99/hOBj1Nb3p6dcoMV0EWMkMAdZ4TmCJnZaDX6hQxT77JipA6H2VwMjjHafyThkXTz8QDRv9cTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsHzN66R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsHzN66R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268690; x=1818804690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIXXvjN7QYTCiRAlOmiVy3NFOQEb8cVyqPT/AT2O+yg=;
  b=JsHzN66R3hi5rE5jvqcrpouoAdPpGuti9IbxOY99/ke2M9vYuchNKh7l
   PhQ/d9+7/vH49+zCn1AuA782k1EzJ/9OvrjKvZ7KVDCFKT+AQ89Cp9t4E
   n/4Yj10wiVzXehsVDHrHCJPPKrbgXut9SeXKOQQzechi7jML6iaUJ4dLJ
   vmg2Sh+FwW42RSIoeNV2YIqO0NR7jx18Tb79o9TXT7tcx61oDxrqKyVYC
   XCKYwJRqNLvfYieV7zFkxoqnfMC9iApQ6YKGAMfr6gPtjB4wAU8iO9EIs
   a0meqpTgCVKr4xPpfxTnk4jRZG0w7yTs0G0H2h508ZKIbEuAjjqi3Gjpz
   Q==;
X-CSE-ConnectionGUID: kgK56Wi2TxyAZKA88k4MgQ==
X-CSE-MsgGUID: +iwHsaa+TZKJ+PBOLTZruA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483415"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:30 -0700
X-CSE-ConnectionGUID: yO50HCJdRMCFAGoPw8ZFuA==
X-CSE-MsgGUID: KifAVvf4Q1q1QfVHLMMWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261905981"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 1/6] cxl/region: Warn on user region position mismatch
Date: Thu, 20 Aug 2026 16:31:19 -0700
Message-ID: <c393fd7884c251d86ce3f5c92ed747dc3eef6d8d.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation includes a self-test that checks the assigned
endpoint positions against the position calculation used by auto
region creation. A mismatch is reported with dev_dbg().

Promote that to a dev_warn() so bugs in the auto region position
calculation are easier to catch as that calculation is extended to
support more region configurations.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..3b640c9ba5a0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2218,10 +2218,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		int test_pos;
 
 		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
-		dev_dbg(&target->cxld.dev,
-			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
-			(test_pos == target->pos) ? "success" : "fail",
-			test_pos, target->pos);
+		if (test_pos != target->pos)
+			dev_warn(&target->cxld.dev,
+				 "position mismatch: calculated:%d programmed:%d\n",
+				 test_pos, target->pos);
 	}
 
 	return 0;
-- 
2.37.3

