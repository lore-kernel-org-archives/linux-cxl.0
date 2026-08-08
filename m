Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F422083
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147563; cv=none; b=a3LaEY+cC6d2v2LI7gWnztzYwSJW9C+PA8z2rGfBGP5SoemaxBKyu5s4bk5Xg4A5Gm5aAGu/6ReNH76tS4Nfbez4hCa+twTpy+AvcB7FE2YGng1Fqq8eMwmx502GA2l0s2iHdv98aUrndTzPnH1D5J1VJ2n9KVJaXdaejyje1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147563; c=relaxed/simple;
	bh=Ed4XaA1SmMnggS/VlvGHRNiWk94ICxn9q/ATNeL7ZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxn5fps5hL90sw6fNXwiNS0cFTaKEdAN8EjvQmf7j/k9mBiL6S1443bYqaROA3xyXGIJFdOALRbjkykzpstHgCC1qd8XSd82O4gOmrYaaSlMOKtDYLshLe8fzLXustq8uV+YgafPXhhGO/cL2RxRKS7Uix4lAAIfyI+2Q+Z1QII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw5osLCA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw5osLCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147562; x=1817683562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ed4XaA1SmMnggS/VlvGHRNiWk94ICxn9q/ATNeL7ZRY=;
  b=Tw5osLCAUIwA1DXHKuQP1zi73cHYlpLkQpVTTiuzCXy7wsPT7F6tPQBh
   nzYex4lFElK/tm1ZU+OOr1LOyHqSxSqqBr0r6qXTSgdckqMagJbcv/Vo7
   I79YRY8pGzUlBKfJWq9A8/euUHf1L0/iPmEEdJye5lzktGPbt0YOs3CJm
   touLrFHyFpqcwdQYN1QDnewYi4RVI4lXbwo92FewNfx5ZvPXFIQO61h8Z
   kADlhemHvES2+WoFvV5oA53U6LYZNaWlWbEFIHrSkI4D8tAzTv0cH7KrL
   GEcQfkVtaJrlJz/vG62bmeEwQR5iO4pKbutYALbFKvDLKeWWPAocShtDM
   g==;
X-CSE-ConnectionGUID: Ecpdw+WgSZWpXhUG50HV1g==
X-CSE-MsgGUID: byjYVGBySJWlGtvd8KBCtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90441206"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90441206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:06:02 -0700
X-CSE-ConnectionGUID: T+amKlZQTyuQuTbl2M+OaA==
X-CSE-MsgGUID: 8/hRwAbTRDyMG7MTs+IpFA==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:06:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v5 4/4] cxl/port: Bound switch decoder target array access by nr_targets
Date: Fri,  7 Aug 2026 17:05:51 -0700
Message-ID: <d7577652cc6d414e1de0ee4045d4d6b2808172ce.1786143520.git.alison.schofield@intel.com>
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

Switch decoder target lookups walk the target array using interleave
ways as the bound. The array is allocated with nr_targets entries, so a
decoder whose interleave ways exceeds nr_targets reads and writes past
the end of it. That happens during dport activation, during decoder
target population, and when userspace reads the target_list attribute.

Bounding by nr_targets alone is not correct either. Commit d6488fee6647
("cxl/port: Fix decoder initialization when nr_targets > interleave_ways")
moved target population to interleave ways precisely so that targets a
decoder does not use are left unpopulated. Neither field alone is a safe
bound, so add a helper that returns the minimum of the two and use it at
every walk of the target array.

Valid configurations keep interleave ways within nr_targets, so this is
not a behavior change for them.

Fixes: 40ba17afdfab ("cxl/acpi: Introduce cxl_decoder objects")
Fixes: d6488fee6647 ("cxl/port: Fix decoder initialization when nr_targets > interleave_ways")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/port.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 28eccfdd75b8..757b48584ac2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -147,20 +147,29 @@ static ssize_t target_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_type);
 
+/*
+ * Interleave ways selects how many targets a decoder uses, but the target
+ * array is only nr_targets long. Bound array access by both.
+ */
+static int cxlsd_nr_used_targets(struct cxl_switch_decoder *cxlsd)
+{
+	return min(cxlsd->cxld.interleave_ways, cxlsd->nr_targets);
+}
+
 static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 {
-	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int nr_used = cxlsd_nr_used_targets(cxlsd);
 	ssize_t offset = 0;
 	int i, rc = 0;
 
-	for (i = 0; i < cxld->interleave_ways; i++) {
+	for (i = 0; i < nr_used; i++) {
 		struct cxl_dport *dport = cxlsd->target[i];
 		struct cxl_dport *next = NULL;
 
 		if (!dport)
 			break;
 
-		if (i + 1 < cxld->interleave_ways)
+		if (i + 1 < nr_used)
 			next = cxlsd->target[i + 1];
 		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
 				   next ? "," : "");
@@ -1603,7 +1612,7 @@ static int update_decoder_targets(struct device *dev, void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_decoder *cxld;
-	int i;
+	int i, nr_used;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -1611,8 +1620,9 @@ static int update_decoder_targets(struct device *dev, void *data)
 	cxlsd = to_cxl_switch_decoder(dev);
 	cxld = &cxlsd->cxld;
 	guard(rwsem_write)(&cxl_rwsem.region);
+	nr_used = cxlsd_nr_used_targets(cxlsd);
 
-	for (i = 0; i < cxld->interleave_ways; i++) {
+	for (i = 0; i < nr_used; i++) {
 		if (cxld->target_map[i] == dport->port_id) {
 			cxlsd->target[i] = dport;
 			dev_dbg(dev, "dport%d found in target list, index %d\n",
@@ -1910,7 +1920,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port)
 {
 	struct cxl_decoder *cxld = &cxlsd->cxld;
-	int i;
+	int i, nr_used;
 
 	device_lock_assert(&port->dev);
 
@@ -1918,7 +1928,8 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 		return 0;
 
 	guard(rwsem_write)(&cxl_rwsem.region);
-	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
+	nr_used = cxlsd_nr_used_targets(cxlsd);
+	for (i = 0; i < nr_used; i++) {
 		struct cxl_dport *dport = find_dport(port, cxld->target_map[i]);
 
 		if (!dport) {
-- 
2.37.3

