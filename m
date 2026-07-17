Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB337DE99
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324585; cv=none; b=MfN4IRmkkqGSsTbXfLfemfFlCTieKK2BuX3BrtfeB322tyPz7/o8gbm398X5HsjAzOqOLWxxTpY+KR7LUT+/CjOBC/JQyxMnmVzAyvXa995aAI1iVfQn/gxIC9/t5sJ/dQzshaGPrHZK8BaCZQbtYbXLxTwmNJLWTR+MSc9ZO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324585; c=relaxed/simple;
	bh=9Ie4cfTn6kpgn1q/uiFzHMrGGd3bOYvduziCQblihRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ancy7kX80CogPXAz0iW7BLN1/eYFLi8unTYE/2YaMNgzyQLe3sTaclNSxMfr6X+FAB6xiZo1pa60ijeWpTbJg7n51QfdQhhUlHUln6dDdfSGqGR2Minn2k4093JnhRm8lLdY6PMYkPKSuItGNPfWAUOCdSoSY7nNGi1BsYbmgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKNat6pv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKNat6pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324584; x=1815860584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Ie4cfTn6kpgn1q/uiFzHMrGGd3bOYvduziCQblihRU=;
  b=LKNat6pvQwmtjxL5vyFngLkSVkz4zR4poZFWXTomky7A5K6D4r0JgLk4
   aZlpIa+gIkXdjHBCHKyPLTO8RV7SMll+m61jmHN92aUF8pFFqXHc+Nq04
   4O7ccNZb5f54JnHQ6OEl1ogsVv2bFG7NYPwUzKiaM8Tydeti15uVA2EjE
   mHLTC+s6LstHZfn44iqrScrPYOCB3C42oquwM8knK+pZ+3ymtxG8nU0FN
   ZqZCCiQ7mujw0PU0HCwJ9SIQdREXEqdhZVQdXsfxMN3yDr65Mes+PgIFA
   9qZDqSLteJ2GrD6n9wp1cA1HLZ660bFTYHLURuUzQX/y7Nt9ET+A0baUl
   Q==;
X-CSE-ConnectionGUID: yJE4b5y3QKODeg9ltYOk1g==
X-CSE-MsgGUID: wjGR69taQjKKtWzqzDW3Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84129164"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="84129164"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:43:03 -0700
X-CSE-ConnectionGUID: VZhzFtRMQl+TzuHHHpSkGg==
X-CSE-MsgGUID: OWRDSryWTuGEt+D0E4sBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="261161278"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:43:03 -0700
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
Subject: [PATCH v3 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails
Date: Fri, 17 Jul 2026 14:42:48 -0700
Message-ID: <d75080ecb9fad922623781e9e354baab05842c2a.1784322343.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784322343.git.alison.schofield@intel.com>
References: <cover.1784322343.git.alison.schofield@intel.com>
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
torn down, so a subsequent probe rebuilds it from scratch. Register the
reset before the decoders are added so that on unwind it runs after
every decoder has been unregistered. This prevents commit_end from
dropping below the highest committed decoder still registered and
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
index 4aaadb842d90..6dc6e53c28c6 100644
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
@@ -1183,18 +1184,34 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
  * @cxlhdm: Structure to populate with HDM capabilities
  * @info: cached DVSEC range register info
  */
+static void cxl_reset_commit_end(void *data)
+{
+	struct cxl_port *port = data;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+	port->commit_end = -1;
+}
+
 static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				       struct cxl_endpoint_dvsec_info *info)
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
+	rc = devm_add_action_or_reset(&port->dev, cxl_reset_commit_end, port);
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

