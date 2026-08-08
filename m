Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1981862
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147562; cv=none; b=eNyYpqBvgpbiIxRnai6sWuj94yYu6lY5EAUT+qxgiXGpkwoPY2Llmzkd2IZJqs8ymG9re4mPrvMrqzIWfLpMSUGzEGxRy7l/zbv7HGzMp7gZdj1Sr6FaDWmi76hYilp2vfVrU+/Eb2EEQcJNYZCCdANUo+i7txRul7K8hhzfxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147562; c=relaxed/simple;
	bh=Ooayd1AaiCFbx0te2kb8l+3JShGS0KLezTkmvpu1cBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxx124ZXzsRonj5Jocbgbt7TbGu3c4GeW/dimzFREIgtPeZPylVx3EvQ5EdF9zzycb1DxVgCFZLvrEZ39oXi5EfERUzHA23bgpSmzlDb2T/gL4xgssECJPPWS8WFATNksXbVgCF0mAb9obkEqGoi3JjG15zWdw5Ec8VIKVra2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiTz0JUf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiTz0JUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147561; x=1817683561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ooayd1AaiCFbx0te2kb8l+3JShGS0KLezTkmvpu1cBE=;
  b=RiTz0JUf3D1ALv2CWxJCoPqL2WqTWV6bNUR8RE364U6qQ/fl8yOoVrqM
   mO3/4LxJlQ1qu/pb3kOLUCNO0hVRrp6sWNvE+RnARSJ1TUZey/A+BlWqF
   DAlsLtZAHo+Qjq3kc/4uJnCoHc1NOBvx8mmB7vKkuxNTkus5Q81YNbsta
   dp7xEAWg8bLvleMyPr3kJ4MSq6gSPBCepqDdum6gliSeoi+toG/CPHW7t
   kKY2mCdH52kX1MYbD912uxAaBK3OeHNagbY5EevqLfrMUgxDGblTVgz1o
   P8foK7DnSG88GQkPJdIeNAzw/ZOuTKb+OefaAPhCiwGmKW4DNOsfkDnpE
   A==;
X-CSE-ConnectionGUID: 7542+2XfSMGN8LOFsL1Zow==
X-CSE-MsgGUID: tv8Alb1YQOe2I7kqLQwaEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90441197"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90441197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:06:01 -0700
X-CSE-ConnectionGUID: 461+k2nIQGaMCTly7Zoe8g==
X-CSE-MsgGUID: meRlPJE1QY+vILyX7s5Dcg==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 3/4] cxl/hdm: Restore commit_end when decoder enumeration fails
Date: Fri,  7 Aug 2026 17:05:50 -0700
Message-ID: <4802c5abc906b858a4754bfc4fa3e4c2c455d0c3.1786143520.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1786143520.git.alison.schofield@intel.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
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

Reset commit_end to the uncommitted baseline once the decoders are
torn down, so a subsequent probe rebuilds it from scratch. Register
the reset before the decoders are added so that on unwind it runs
after every decoder has been unregistered. This prevents commit_end
from dropping below the highest committed decoder still registered and
exposing an inconsistent value to a concurrent reader.

Protect the commit_end advance in the DVSEC emulation path against
concurrent readers, matching the register-programmed path.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fc22d515b638..cb24901dd289 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -956,7 +956,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	 * change the range registers at run time.
 	 */
 	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
-	port->commit_end = cxld->id;
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		port->commit_end = cxld->id;
 
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
 	if (rc) {
@@ -1159,6 +1160,14 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
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
@@ -1169,8 +1178,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
 	u64 dpa_base = 0;
+	int i, rc;
 
 	/*
 	 * Per CXL 4.0 8.2.4.20.1 Target Count is the number of target ports
@@ -1186,8 +1195,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
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

