Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619F1F8723
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137814; cv=none; b=njVYLFVzAHVCzJ3pF1Hbkyb9q5vcmNchYhWo2mjlSSn4/QBRwDZrEpD8b2S/H8hW1iv3WxNZdz2xwfk2VHppEKZONdNePcmvOsDItNnY2X7/zrhOC9KHoivVgoeLszE/ste1xTLy1CWKgpjN8Rko5EhT7Pb0K8ROUXOwBk0I5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137814; c=relaxed/simple;
	bh=HufYVGfIrlRz8BxTTpBe0zelZ4kjSe4Cb+01IYD1Oss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTUCZlUKc4c+aYZPvuBAB6lmgvwjvvw3gCblKAkxQOEC77VNbr5uV3VP7oek+ELqplcVjtTwP2EJHcYpwQOsRNGY+2qDpsqgFgSsDIDpQSrCBsSQoeP8BrL13DdsQH4Xmj3K5kxfTkrgKJIoR4i4ifyKf/4LzrGCq/MQ2D1cJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjrCNNhv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjrCNNhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781137812; x=1812673812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HufYVGfIrlRz8BxTTpBe0zelZ4kjSe4Cb+01IYD1Oss=;
  b=OjrCNNhvCdNqpdzV43L4XDsErGUSeunB4Q0Y24uBAThS6spJbNQKEAvf
   y2xJ4XqhfxjZ73XN0Rv6b91rLoRVdDOMyxNY+ZmINTLT9XGCBlTE18bb2
   NZU/MaBvSZnrsBLIyABaaSBf7ECw2TVX1GUOgtzYaglsgwoYSsVRuFc8F
   GbIJoYlxyGFg4eA9AH1qKyX9XyMJYb+RzmAtA5D/FSl6adO0vx9IMC1bt
   qKs/Vf9/i2nHOsUkhI7Tf7MUlj11MStVVOa2pMqptji1TWMJeRFNHZSoi
   eEYoNtjy1+JJYDZPGg9Dcy8OEv67UWatZxn3M1RA8oR9tE/E7jkMr+Wu+
   w==;
X-CSE-ConnectionGUID: dQqV3UBqQF2srHXKL5ZZeQ==
X-CSE-MsgGUID: fKniQDIEQvWfL4g9jRoMqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81794426"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81794426"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:10 -0700
X-CSE-ConnectionGUID: fe4k3FukT12p56EcTyAMCg==
X-CSE-MsgGUID: snQKPUBaSWKy2l86WGxzEg==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:10 -0700
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
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH 1/2] cxl/region: Allow passthrough decoders with >16K granularity
Date: Wed, 10 Jun 2026 17:29:30 -0700
Message-ID: <e8cd395fc7cee8d126449db9d7fd8b37ddd43459.1781136281.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1781136281.git.alison.schofield@intel.com>
References: <cover.1781136281.git.alison.schofield@intel.com>
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
it can seed descendant decoder setup, and program a don't-care IG
encoding when committing a non-interleaving decoder.

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
 drivers/cxl/core/hdm.c                  | 13 +++++--
 drivers/cxl/core/region.c               | 47 +++++++++++++++----------
 3 files changed, 42 insertions(+), 23 deletions(-)

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
index 0c80b76a5f9b..d164662668c1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
+
+	/*
+	 * A non-interleaving decoder ignores the IG field. Encode a
+	 * don't-care value instead of validating the stored granularity.
+	 */
+	if (cxld->interleave_ways == 1)
+		eig = 0;
+	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+			   "invalid interleave_granularity: %d\n",
+			   cxld->interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..c3ad6db7c278 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1510,12 +1510,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1538,20 +1546,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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

