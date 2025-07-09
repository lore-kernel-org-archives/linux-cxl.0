Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3C1E5B6A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Jul 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091668; cv=none; b=Z8IPgqj+lo6iNfugGp4+1XZZzjv7KarXc0nv26HxUjDSC6wMex5GyN8guwutDGV5unE+Yv0yk7GMvpt35+JrU2XU0rl6KT2qJcYlvjn9Ye4CYIskvMAxL+2Q+xBZUzRCnzPiQ5cLrpM2PA4q5M0TFLHQIUFSYpYKcCYzC/MvT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091668; c=relaxed/simple;
	bh=LdOzgW6+S7FE1UMx9mclkEjHS4gJ+GEtH4/GyGUzD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFQTTPkcE66LogN42NeM3Hpbz/4+CgNY78zvV44g/AvWjcw4sfi3UqtUkhe5RkaJ/6JlptDHIL8FkfL5s2tU74I/4l8qtDCE3TTmsRdplU+Rcf2bqwOrlE1W6fdJjDrykTbaRptIuVVVN/QfzPTi1SK5vJozS15VpAX4pzxxNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F957C4CEEF;
	Wed,  9 Jul 2025 20:07:47 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Add hpa_to_spa to the root decoder callback operations
Date: Wed,  9 Jul 2025 13:07:46 -0700
Message-ID: <20250709200746.2567860-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
callback function to cxl_decoder_ops. Refactor to group all the root
decoder callbacks together.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c        |  9 +++++++--
 drivers/cxl/core/port.c   |  2 +-
 drivers/cxl/core/region.c | 11 ++++++++---
 drivers/cxl/cxl.h         | 13 ++++++++-----
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 48478bc406ee..9f7e2a49dc5a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -20,6 +20,10 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
+static u64 cxl_default_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	return hpa;
+}
 
 static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 {
@@ -342,8 +346,9 @@ static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
 }
 
-static const struct cxl_rd_ops acpi_rd_ops = {
+static struct cxl_rd_ops acpi_rd_ops = {
 	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
+	.hpa_to_spa = cxl_default_hpa_to_spa,
 };
 
 DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
@@ -425,7 +430,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
-		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;
 
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6f4cd50ddf25..081dd59b422e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1802,7 +1802,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						const struct cxl_rd_ops *ops)
+						struct cxl_rd_ops *ops)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0a5effbc0529..f148c398b7bb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2902,6 +2902,11 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
+static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
+{
+	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
@@ -2956,8 +2961,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (cxlrd->hpa_to_spa)
-		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+	if (has_hpa_to_spa(cxlrd))
+		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
 
 	if (hpa < p->res->start || hpa > p->res->end) {
 		dev_dbg(&cxlr->dev,
@@ -2966,7 +2971,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
 		return ULLONG_MAX;
 
 	return hpa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 91cb1e570907..1e7396d2ca6c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,18 +418,22 @@ struct cxl_switch_decoder {
 };
 
 struct cxl_root_decoder;
-typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
+/**
+ * struct cxl_rd_ops - CXL root decoder callback operations
+ * @get_extended_linear_cache_size: Get the extended linear cache size
+ * @hpa_to_spa: Convert host physical address to system physical address
+ */
 struct cxl_rd_ops {
 	int (*get_extended_linear_cache_size)(struct resource *backing_res,
 					      int nid, resource_size_t *size);
+	u64 (*hpa_to_spa)(struct cxl_root_decoder *cxlrd, u64 hpa);
 };
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
- * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -439,11 +443,10 @@ struct cxl_rd_ops {
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-	const struct cxl_rd_ops *ops;
+	struct cxl_rd_ops *ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
@@ -783,7 +786,7 @@ bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						const struct cxl_rd_ops *ops);
+						struct cxl_rd_ops *ops);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);

base-commit: 1a45e1cd694fdf2d2a22e3c70a6917ff39fe77ab
-- 
2.50.0

