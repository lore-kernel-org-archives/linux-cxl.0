Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0F2356D9
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151964; cv=none; b=g80o1tEc24vHHCB17ftCtCCdxZ9fxHf9wR1w5OY7DrqqW8BhfVaj51qqBW8yfWqEKn4XxcaJ4tZe5/gtQNC7ZsG1UR/HrZHRYTZl2rCousaMXIhvZ7LOPtsivbR4gwFWVHBvcJ1Co9lTSJQa1lV4FXFUCk8xqqAzuBeNJP2xV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151964; c=relaxed/simple;
	bh=fiRwAT0OAlo6Op+9mjQsx21LnDvM4D6nGlj+obKHqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBvFcAhsBk4DEHZYyQucedL399fwPklTMXG8EV9jsjNQAJCmWtz/AYYvKsNtdMY/gevzSavW3A8MSAFMReYJ0LubvK2SiLLm3MHOqDTXjcVyrLxoIBGC61dsKvwSzYYMudnnmcpnjz/LQWMDNc1ZtMv8p6auyInGhw/V+SBS4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGIOOqTe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGIOOqTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151964; x=1815687964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fiRwAT0OAlo6Op+9mjQsx21LnDvM4D6nGlj+obKHqRk=;
  b=PGIOOqTe+4GdgRx0FXWRtr7GUcxUuwLyrc9WXXGVWUZr+cU+oNCKlZ6N
   nEgxQP3cgR0P0BC8n4g2DpGHf8d3BNyoKN0y/NDIecyWuV2qSg4l+vvd7
   qQ8ot6xbMzYqzKwF6skOOYMdk5Bie54Oq0lCrSZwsQIWa18TGzYbpOOdp
   0tEtLEgB3Sq9Pi+/pktY5tykKLuRqtGZxwnhLP8n68GgyXC5VZapDQGAK
   gDEE9USX2qQAIZxg3Lrz1Oz5T5cWuoqMoO96+4kdDIB1OZ7sFcBZGMnIm
   LabJAYHxt6e75uBxV7osMBZDbSA+uKTY8Ydsnki6yvK+lSjbDLOBckRYL
   g==;
X-CSE-ConnectionGUID: W8qQ542wQpW8FnGRJN/Rlg==
X-CSE-MsgGUID: kAS9nVpPTvuX7bWe4UChfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88632852"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88632852"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:03 -0700
X-CSE-ConnectionGUID: ib1WX8U4QFSECJdB+IZdvA==
X-CSE-MsgGUID: 5NvUWRzZSYK2/r/LdZ5e3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="254549537"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.156])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails
Date: Wed, 15 Jul 2026 14:45:49 -0700
Message-ID: <563095ff87e66b72651c15248a1a6dd6f5ddc3b5.1784150131.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784150131.git.alison.schofield@intel.com>
References: <cover.1784150131.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit_end tracks the highest committed decoder on a port. It gets
advanced before decoder enumeration is complete, so a later failure
leaves it pointing at a decoder that was never added. The next probe
then rejects decoder0 as out of order and enumeration fails.

Restore commit_end to the none-committed baseline on the enumeration
failure path so a subsequent probe can enumerate decoders cleanly. The
successful path never touches commit_end, so no transient count is
exposed to concurrent readers.

Protect the commit_end advance in the DVSEC emulation path against
concurrent readers, matching the register-programmed path.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 51ab154a73fe..850f509432aa 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	 * change the range registers at run time.
 	 */
 	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
-	port->commit_end = cxld->id;
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		port->commit_end = cxld->id;
 
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
 	if (rc) {
@@ -1181,13 +1182,13 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
 	u64 dpa_base = 0;
+	int i, rc;
 
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1198,7 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				dev_warn(&port->dev,
 					 "Failed to allocate decoder%d.%d\n",
 					 port->id, i);
-				return PTR_ERR(cxled);
+				rc = PTR_ERR(cxled);
+				goto err;
 			}
 			cxld = &cxled->cxld;
 		} else {
@@ -1209,7 +1211,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				dev_warn(&port->dev,
 					 "Failed to allocate decoder%d.%d\n",
 					 port->id, i);
-				return PTR_ERR(cxlsd);
+				rc = PTR_ERR(cxlsd);
+				goto err;
 			}
 			cxld = &cxlsd->cxld;
 		}
@@ -1220,17 +1223,23 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				 "Failed to initialize decoder%d.%d\n",
 				 port->id, i);
 			put_device(&cxld->dev);
-			return rc;
+			goto err;
 		}
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
 				 "Failed to add decoder%d.%d\n", port->id, i);
-			return rc;
+			goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	/* Reset to the none committed baseline for a fresh enumeration */
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		port->commit_end = -1;
+	return rc;
 }
 
 /**
-- 
2.37.3

