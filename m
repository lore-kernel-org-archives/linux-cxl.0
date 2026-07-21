Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC13FE650
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599193; cv=none; b=Frjmc4ungrGBOqp3buQX+s6OJlldnXOSHYOvbBJd89eEypj2XEpAEFgo9WWo8TBU9wXW9xJWHeRD9UNMJq34/N5uDsq4ap1gXS2O886iFAnXiSW1S5o/af6utFyPHQUYx3onVW1i4EOoojKVvqELOLIKqZq80FwFYfx/nhULQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599193; c=relaxed/simple;
	bh=OIheaOw2y0qeq/u0U47X4BEfYjqVlajJTciWEUub72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr9GzKzyLL1fqzF6pWNWZFgb/pDrvFQ0at124YS2ftlW6gbs7DkM8yS7pUrc4AVJwj3LFVkAoFPZ6NdfyCq5KHdIHrmaIu3o9fNunGY8hIuyUmQOdAjhnt/aTLvOSCIOSvZtp1lNYjuLMI/440Kb0u9CUHWggBFDYZ3ou2M6T3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEUC7GID; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEUC7GID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784599192; x=1816135192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OIheaOw2y0qeq/u0U47X4BEfYjqVlajJTciWEUub72M=;
  b=NEUC7GIDc4CseG9EUbXuQN3x+Gh7zdPwD7XggS/3lVjNxr6R54f/3Hyc
   0/zuZ1C4PyT6KdfP2RF2IS5Zp2ulCBNAoAFf75Kqi9yCCnHDFYlHI7obF
   QszmeUv0/xmJ98MomgMmXl0NSsxy6Os/10VtOTJgMtXQfKJ5g+Q/8n0lF
   1Kh/oq6SRaINgrYk75u53UBzMwIOqKN9gIi04Sc4OYtzuc5zPO9bM5xhe
   2v9aGnC//uRIFDM32Y+nw3rek9z87yov4krpkLrfYEJj59cxNkTmWvAml
   QrCeO9Uy5S60PpzefaZHc7Csr56oOonCaeOIQtKRhJXtNSw8zR/BDkrpm
   w==;
X-CSE-ConnectionGUID: mGEuHfr8Q8CvSQ/4Upr2ow==
X-CSE-MsgGUID: A1YSkX5hSxyB8VpnfbFaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85209234"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85209234"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:52 -0700
X-CSE-ConnectionGUID: PB13VKgUTMGD2TBIUNL4gQ==
X-CSE-MsgGUID: wHaNDA32RManeHqdFFriSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261181263"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.174])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:50 -0700
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
Subject: [PATCH v4 4/4] cxl/hdm: Restore commit_end when decoder enumeration fails
Date: Mon, 20 Jul 2026 18:59:40 -0700
Message-ID: <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
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

Reset commit_end to the none committed baseline once the decoders are
torn down, so a subsequent probe rebuilds it from scratch. Register
the reset before the decoders are added so that on unwind it runs
after every decoder has been unregistered. This prevents commit_end
from dropping below the highest committed decoder still registered and
exposing an inconsistent value to a concurrent reader.

Protect the commit_end advance in the DVSEC emulation path against
concurrent readers, matching the register-programmed path.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 077aface1a2a..7d4ba7fa30fa 100644
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
@@ -1181,6 +1182,14 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
 		msleep(20);
 }
 
+static void cxl_reset_commit_end(void *data)
+{
+	struct cxl_port *port = data;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+	port->commit_end = -1;
+}
+
 /**
  * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @cxlhdm: Structure to populate with HDM capabilities
@@ -1191,13 +1200,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
 	u64 dpa_base = 0;
+	int i, rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	/*
+	 * Reset commit_end after all decoders have been torn down so a
+	 * subsequent probe rebuilds it from scratch.
+	 */
+	rc = devm_add_action(&port->dev, cxl_reset_commit_end, port);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
-- 
2.37.3

