Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968166FD9
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6KuYrhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703225541; x=1734761541;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nOIE+Qx8uaCpv8RfSRQe48ejQ18BPssU1m2umlrYFa0=;
  b=V6KuYrhmKxyaol8KvW7lS43PVl7GpvgbIcCpWb1cvmom3r1JP1TjhdWJ
   tyzbxtraSgKEvKlZEHwgqA5YsLKHFZ33WD9nZVc772+a8szqPoS4PMY1C
   Sh6ONw1TRPTQAR+jKAW2og/rDXWtV0jadQ4Fo5jc9nnDSWZsuJOqWtibr
   IyGQJBPkdFPOwIbnXKKmKmbgb+WI9wYns0q1lH/JmJB/RGt2jXKZAUcKC
   E4cfG65DQG4St9oGdNp1AZhz+NruM+KBxfyE/O7TjbAglFN/eFdVa03hR
   RM8xJha1bJFg4Z4kIy8QDnPy2ANld3NS5Idg+w5Ppqonko63VntH8mwqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3330553"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3330553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920567599"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920567599"
Received: from yvgambhi-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.48])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:12:19 -0800
Subject: [PATCH] cxl/port: Fix missing target list lock
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Date: Thu, 21 Dec 2023 22:12:19 -0800
Message-ID: <170322553909.110939.1669280651596703652.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

cxl_port_setup_targets() modifies the ->targets[] array of a switch
decoder. target_list_show() expects to be able to emit a coherent
snapshot of that array by holding by holding ->target_lock. The
target_lock is held for write during initialization of the ->targets[]
array, but it is not held for write during cxl_port_setup_targets().

The ->target_lock() predates the introduction of @cxl_region_rwsem. That
semaphore protects changes to host-physical-address (HPA) decode which
is precisely what writes to a switch decoder's target list affects.

Replace ->target_lock with @cxl_region_rwsem.

Now the side-effect of snapshotting a unstable view of a decoder's
target list is likely benign so the Fixes: tag is presumptive.

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   22 +++++++---------------
 drivers/cxl/cxl.h       |    2 --
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 57495cdc181f..6b386771cc25 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -172,14 +172,10 @@ static ssize_t target_list_show(struct device *dev,
 {
 	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
 	ssize_t offset;
-	unsigned int seq;
 	int rc;
 
-	do {
-		seq = read_seqbegin(&cxlsd->target_lock);
-		rc = emit_target_list(cxlsd, buf);
-	} while (read_seqretry(&cxlsd->target_lock, seq));
-
+	guard(rwsem_read)(&cxl_region_rwsem);
+	rc = emit_target_list(cxlsd, buf);
 	if (rc < 0)
 		return rc;
 	offset = rc;
@@ -1633,7 +1629,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
 {
-	int i, rc = 0;
+	int i;
 
 	if (!target_map)
 		return 0;
@@ -1643,19 +1639,16 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	if (xa_empty(&port->dports))
 		return -EINVAL;
 
-	write_seqlock(&cxlsd->target_lock);
+	guard(rwsem_write)(&cxl_region_rwsem);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
-		if (!dport) {
-			rc = -ENXIO;
-			break;
-		}
+		if (!dport)
+			return -ENXIO;
 		cxlsd->target[i] = dport;
 	}
-	write_sequnlock(&cxlsd->target_lock);
 
-	return rc;
+	return 0;
 }
 
 struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
@@ -1725,7 +1718,6 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
 		return -EINVAL;
 
 	cxlsd->nr_targets = nr_targets;
-	seqlock_init(&cxlsd->target_lock);
 	return cxl_decoder_init(port, &cxlsd->cxld);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 687043ece101..62fa96f8567e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -412,7 +412,6 @@ struct cxl_endpoint_decoder {
 /**
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
- * @target_lock: coordinate coherent reads of the target list
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  *
@@ -424,7 +423,6 @@ struct cxl_endpoint_decoder {
  */
 struct cxl_switch_decoder {
 	struct cxl_decoder cxld;
-	seqlock_t target_lock;
 	int nr_targets;
 	struct cxl_dport *target[];
 };

