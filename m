Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF9BA45
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161074; cv=none; b=mlkkfNmvPBfI4A+P43QOC9a/urYFMrMd3d88C/pbLeUkLxwjxhKeQV4JIq84cr6japGAJZ/UGQURRiCaAjJiXtoLH6VY7msMH5kWI8Vvwno3uYmjON+PuiqFu/Re1SJtp5p1xsCJavNamK0tKwL22a3ZzXpRnthVUqBO5oBL0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161074; c=relaxed/simple;
	bh=Z6AozJvzQquOQrKyvNyJ6ejPuesKHeFe4Y2EadNYO2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okmo0xgM3eK0Fbi1RuXjxq49XQW10p8vhmthI+C0MIKSzSR7dcOnWl1CyR/x7QasY6gOoe5WV3wmtT+qHyEVscLuvZk36V14ACJNo8me+0HvtbfI7ix4OsRW7MHWthUG0fHu4nQjwcO7T/Wnqt2oRXXc8Z+9GmOicP+d7Alm27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0+eQ7oh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0+eQ7oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161072; x=1745697072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z6AozJvzQquOQrKyvNyJ6ejPuesKHeFe4Y2EadNYO2g=;
  b=m0+eQ7oh3p9e6VhGViauMTXBUrvGz3WC4jgIKsIEe1W1ltUcscHhG32e
   aoBUL13bn5R1FauyIaAlLhZApyK2JWpcSDS+ymG/aan/iRGktxc9eLj4E
   tkKOewRBuJgLN2QJkQIsipKBp2l8O0Q9GQBswWNqBV2uj0f35y9lmDJ4G
   RNfLqMO99TyAlpzhMC+D0z2J6eptEn6XrCnuOn48A1N5JAU/S7IAnwON5
   zLgahEHR0qNzueN8lPfdVeLd85pHLsH9RTctH5aPlavH7c+rbH8hbkCxQ
   Q+LwFS9Wg344gPK1UANZs6YVsJ51l5TPoxxQC+XvBhbsQkpIVcJG4MQAi
   w==;
X-CSE-ConnectionGUID: O8UDEGi2R1aXuQEQe7x72Q==
X-CSE-MsgGUID: 3dJBsplXQwWNkaBoCpNZpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10067040"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10067040"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:11 -0700
X-CSE-ConnectionGUID: 9qUsQKPqT36EGcabf0oMBw==
X-CSE-MsgGUID: VBT2SybwS++/HFXlfc4ZOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56432092"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.224.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:11 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/acpi: Restore XOR'd position bits during address translation
Date: Fri, 26 Apr 2024 12:51:05 -0700
Message-Id: <d4e689f9a9645cbddb943188d508807da33bf91f.1714159486.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714159486.git.alison.schofield@intel.com>
References: <cover.1714159486.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When a CXL region is created in a CXL Window (CFMWS) that uses XOR
interleave arithmetic XOR maps are applied during the HPA->DPA
translation. The XOR function changes the interleave selector
bit (aka position bit) in the HPA thereby varying which host bridge
services an HPA. The purpose is to minimize hot spots thereby
improving performance.

When a device reports a DPA in events such as poison, general_media,
and dram, the driver translates that DPA back to an HPA. Presently,
the CXL driver translation only considers the modulo position and
will report the wrong HPA for XOR configured CFMWS's.

Add a helper function that restores the XOR'd bits during DPA->HPA
address translation. Plumb a root decoder callback to the new helper
when XOR interleave arithmetic is in use. For MODULO arithmetic, just
let the callback be NULL - as in no extra work required.

Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c       | 49 +++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/port.c  |  5 +++-
 drivers/cxl/core/trace.c |  5 ++++
 drivers/cxl/cxl.h        |  6 ++++-
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..519e933b5a4b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -74,6 +74,44 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	return cxlrd->cxlsd.target[n];
 }
 
+static u64 restore_xor_pos(u64 hpa, u64 map)
+{
+	int restore_value, restore_pos = 0;
+
+	/*
+	 * Restore the position bit to its value before the
+	 * xormap was applied at HPA->DPA translation.
+	 *
+	 * restore_pos is the lowest set bit in the map
+	 * restore_value is the XORALLBITS in (hpa AND map)
+	 */
+
+	while ((map & (1ULL << restore_pos)) == 0)
+		restore_pos++;
+
+	restore_value = (hweight64(hpa & map) & 1);
+	if (restore_value)
+		hpa |= (1ULL << restore_pos);
+	else
+		hpa &= ~(1ULL << restore_pos);
+
+	return hpa;
+}
+
+static u64 cxl_xor_trans(struct cxl_root_decoder *cxlrd, u64 hpa, int iw)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+
+	/* No xormaps for ways of 1 or 3 */
+	if (iw == 1 || iw == 3)
+		return hpa;
+
+	for (int i = 0; i < cximsd->nr_maps; i++)
+		hpa = restore_xor_pos(hpa, cximsd->xormaps[i]);
+
+	return hpa;
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
@@ -325,6 +363,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
+	cxl_addr_trans_fn addr_trans;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
@@ -365,12 +404,16 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		goto err_insert;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
 		cxl_calc_hb = cxl_hb_modulo;
-	else
+		addr_trans = NULL;
+
+	} else {
 		cxl_calc_hb = cxl_hb_xor;
+		addr_trans = cxl_xor_trans;
+	}
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb, addr_trans);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2b0cab556072..cd4f004f5372 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1808,6 +1808,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * @port: owning CXL root of this decoder
  * @nr_targets: static number of downstream targets
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @addr_trans: address translation helper function
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
  * 'CXL root' decoder is one that decodes from a top-level / static platform
@@ -1816,7 +1817,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb)
+						cxl_calc_hb_fn calc_hb,
+						cxl_addr_trans_fn addr_trans)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1839,6 +1841,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	cxlrd->calc_hb = calc_hb;
+	cxlrd->addr_trans = addr_trans;
 	mutex_init(&cxlrd->range_lock);
 
 	cxld = &cxlsd->cxld;
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index d0403dc3c8ab..a7ea4a256036 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -36,6 +36,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 			  struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	int pos = cxled->pos;
@@ -75,6 +76,10 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
+	/* An addr_trans helper is defined for XOR math */
+	if (cxlrd->addr_trans)
+		hpa = cxlrd->addr_trans(cxlrd, hpa, p->interleave_ways);
+
 	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
 		return ULLONG_MAX;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..f0c3bd377259 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -432,12 +432,14 @@ struct cxl_switch_decoder {
 struct cxl_root_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_addr_trans_fn)(struct cxl_root_decoder *cxlrd, u64 hpa, int ways);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @addr_trans: dpa->hpa address translation helper
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -447,6 +449,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_addr_trans_fn addr_trans;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
@@ -773,7 +776,8 @@ bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb);
+						cxl_calc_hb_fn calc_hb,
+						cxl_addr_trans_fn addr_trans);
 struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
-- 
2.37.3

