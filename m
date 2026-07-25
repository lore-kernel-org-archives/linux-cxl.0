Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75142E2DD2
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941742; cv=none; b=WYjyYwDg38HY+JzIYZJjOBpXJIsP91pJHIwQ2HkqSoI2E+8wZD54lurwuPM1Qc9z4wzlGkCXT9TmpxfNyYj34IZe3ug33/gCUm1yMliLlAIGqvcge29UXxagTnrYyVqpK+XbgPWnjLbkTlYtOrsZm3r3UbQn20IdFle12veQDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941742; c=relaxed/simple;
	bh=hysWfFrmvibg6SX5nMO035gsopk/cp+XvJ+ugUQA2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsi+CwxkVyME7OoelpOajbQ8mP4PhCA5Co7Xd6hVKpGhyLgrxnzDvxOj+e9Rd7jf3bjmujReRAuOGtTFwEsruTPFIK44Tv8r6QZZNGwHsZ2mUsK6cOWyDmO0IHHRZT8rRkn0buw8opUwxE8aKeC91o20p8JrYZIv2atZ1dth32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7PPVVgq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7PPVVgq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784941741; x=1816477741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hysWfFrmvibg6SX5nMO035gsopk/cp+XvJ+ugUQA2NI=;
  b=H7PPVVgqVSfHqDClRBNxIWVqXXkEVp6HhIS9LKrlDB5RtpMa7zhMKIGa
   sLDsIVCDHit68mIxubey007YsQeTD69cCjJS0ew6H5UhKlG3XmAj7QQZQ
   y4w00FzGGMTXjTeyjqyw3Vpuj9eZiD3XchBN2GA+cnyF+J44QZvwiPAUo
   RyRfA8hYi2ddaRdvtDw56/gnN5RYAUPDR/yKtmiUhKIh8aaBS9IlbyFE9
   kc43lYI85HWTFCXOTPDYBhd8vuS47fgH6eZhiw6BMwc4CAe4ZNfLfoBlU
   3rszjMgYuDMAOq2Gmmzq8sF+v8R+zpHWMNHcZF8AilPeSC6SvPcoj0t+O
   Q==;
X-CSE-ConnectionGUID: KN5yv6nRSbuFr4xnors6Jw==
X-CSE-MsgGUID: kssH6uRHQJ2WVHMTUkSpSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85622201"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85622201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:09:01 -0700
X-CSE-ConnectionGUID: lhA7BbJPRPK6euEB3vNEQg==
X-CSE-MsgGUID: l0UIompxT1akHJDrNRHNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="259506724"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:09:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K granularity
Date: Fri, 24 Jul 2026 18:08:54 -0700
Message-ID: <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784940306.git.alison.schofield@intel.com>
References: <cover.1784940306.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region configuration rejects valid topologies that contain a
passthrough decoder beneath a wide parent interleave.

For example, a passthrough switch below an 8-way root decoder with
4K granularity computes a 32K granularity. That exceeds the maximum
encodable value of the HDM Decoder Control IG field, causing region
setup to fail even though a non-interleaving decoder does not consume
the IG field.

Only require the granularity to be encodable for interleaving decoders,
both where it is inherited from the parent and where it is computed for
the current decoder. Keep the computed value for passthrough decoders so
it can seed descendant decoder setup.

When committing a non-interleaving decoder, still program the granularity
if it is encodable; use a don't-care IG encoding only when it is not. This
preserves an encodable passthrough granularity across re-enumeration, so
descendants do not inherit a stale value.

As a consequence, the interleave_granularity attribute of a decoder
whose interleave_ways is 1 may report a value above 16K. Document that
the reported granularity for non-interleaving decoders is a don't-care
value that may exceed the maximum encodable in hardware.

Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
Suggested-by: Sashiko AI Review <sashiko-bot@kernel.org>
Assisted-by: Claude:Opus-4-8
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
 drivers/cxl/core/hdm.c                  |  8 ++++-
 drivers/cxl/core/region.c               | 47 +++++++++++++++----------
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..3f96e5bf1fd3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -407,7 +407,10 @@ Description:
 		space this decoder claims at address N before the decode rotates
 		to the next target in the interleave at address N +
 		interleave_granularity (assuming N is aligned to
-		interleave_granularity).
+		interleave_granularity). When 'interleave_ways' is 1, the
+		decoder does not interleave and the reported granularity is
+		a don't-care value that may exceed the maximum encodable in
+		hardware.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..d2ada82fe3c7 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -691,7 +691,13 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+
+	/*
+	 * A non-interleaving decoder ignores the IG field, so an
+	 * unencodable granularity is a don't-care rather than a failure.
+	 */
+	if (granularity_to_eig(cxld->interleave_granularity, &eig) &&
+	    WARN_ONCE(cxld->interleave_ways > 1,
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
 		return;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..5a443551288c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1521,12 +1521,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_ig);
-		return rc;
+	/*
+	 * A non-interleaving parent does not encode its granularity, so its
+	 * stored value may exceed the maximum encodable and need not be
+	 * validated here.
+	 */
+	if (parent_iw > 1) {
+		rc = granularity_to_eig(parent_ig, &peig);
+		if (rc) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: invalid parent granularity: %d\n",
+				dev_name(parent_port->uport_dev),
+				dev_name(&parent_port->dev), parent_ig);
+			return rc;
+		}
 	}
 
 	rc = ways_to_eiw(parent_iw, &peiw);
@@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	 * Interleave granularity is a multiple of @parent_port granularity.
 	 * Multiplier is the parent port interleave ways.
 	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
+	ig = parent_ig * parent_iw;
 
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
+	/*
+	 * Keep the computed granularity for descendant setup. Only
+	 * interleaving decoders require an encodable granularity.
+	 */
+	if (iw > 1) {
+		rc = granularity_to_eig(ig, &eig);
+		if (rc) {
+			dev_dbg(&cxlr->dev,
+				"%s: invalid granularity calculation (%d * %d)\n",
+				dev_name(&parent_port->dev), parent_ig,
+				parent_iw);
+			return rc;
+		}
 	}
 
 	if (iw > 8 || iw > cxlsd->nr_targets) {
-- 
2.37.3

