Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11F298CBC;
	Fri, 30 Jan 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775151; cv=none; b=Nt5po/DoO1Ww/IwCEjJgghPEAjsLu8mJ4vS+0KNzHcxypJRwKJQDpHV4HbkHMN3C1FlBjAYrataLj/MGe+hqCYXZ5dxtGCjr5Dv7bkK4kbpq8xOmrhdKxK4KQRnvN+EkKVADXg3tl/chXvKdFWbo35V3taOwX8T5ERC83cjRINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775151; c=relaxed/simple;
	bh=6wnzGCKSbQfqEcVtpMTsLA+gaV/Yj5LOg0rzyqo9Dyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN5Qau0A+/eVpEO/A+5MQpatkb4md6lA5pxpjDaefDTMrZez9l27Y3nw7mPT5r07eOwo+aVHWkNRnIXlmfRr8CAxrr/NfmoMIvcRTO09LxZCV4RcdljDY59/OLPGipQYTPPq5KDEj9o6yGMXljnuk9q8RKCeyn5FMGjbxLs8oZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sD7Dkt0X; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sD7Dkt0X"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1769775149; x=1801311149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6wnzGCKSbQfqEcVtpMTsLA+gaV/Yj5LOg0rzyqo9Dyk=;
  b=sD7Dkt0X1gybcYvT3g2tQtPmZVHcaUtLueV0it5OQEhGxCIZ8S95QdtK
   RUEm/t0uF/Kpsw/VtsAfigp0mfMJLjyxrl23CHaakhwU2oWv9HL41DKIH
   qMGaHL0BfqF0u/3oMtYiL2EWyJ67H0roxgxr5MqXEsSowIXdf1E+Qi0hb
   yEwbDsuUc2Ua+etKD6Cgg9H8mjtZrcvBr18XFqVBIbXyr1FPB5Q3BEmuS
   zUD2HgOukDFoGziyoUVAGWmPOvQ9yri4rBJ61ekgHVSn3fLgyJgD/86/n
   Fi2d+z1o4wDkfF0O4t6EfuSg7yf2ofVsDxVvWuoobXdNetOJavTyc0g7C
   A==;
X-CSE-ConnectionGUID: DVl//pgsR+GgzD7i+sDJZg==
X-CSE-MsgGUID: P+Kq/k+DQsiKlw4to8m1hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="228530782"
X-IronPort-AV: E=Sophos;i="6.21,262,1763391600"; 
   d="scan'208";a="228530782"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([20.61.8.234])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 21:12:20 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id D32FE42A31C;
	Fri, 30 Jan 2026 12:12:20 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTP id 4883B1809AFE;
	Fri, 30 Jan 2026 12:12:20 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 73695206C440;
	Fri, 30 Jan 2026 21:12:18 +0900 (JST)
From: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
To: dan.j.williams@intel.com,
	alison.schofield@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	lizhijian@fujitsu.com,
	Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Subject: [ndctl PATCH v4] cxl/cli: enforce HPA-descending teardown
Date: Fri, 30 Jan 2026 21:16:38 +0900
Message-ID: <20260130121638.169160-1-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When destroying CXL regions, users may observe failures such as
"set_dpa_size failed: Device or resource busy" even when targeting
valid regions. Afer such failures, subsequent destroy/create cycles may
become impossible without a full system reset.

The current logic does not guarantee descenting HPA order across
regions, even when each region is mapped to a single endpoint decoder.
As a result, a region can only be destroyed if it is the last one in
HPA order.

Alison observed that the issue extends when a region's mappings reach
endpoint decoders under different root decoders. In such cases, the HPA
descending order must be considered across all endpoint decoders that
share any of the root decoders involved - effectively covering the
entire bus/port. Without this global ordering destroy operations may
fail unpredictably, and followng create operations can also be blocked.

This change does not alter the underlying kernel behaior or decoder
programming rules. Instead, it enforces the existing ordering
constraints at the CLI level, preventing users from issuing destroy
oprtation that would violate HPA continuity required by specification
(section 8.2.4.20.12).

Link to v2 - Alison's findings:
https://lore.kernel.org/linux-cxl/aTTKRCUmbNC9jIrG@aschofie-mobl2.lan/

base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d

v4 updates:
 - expand the commit message to include detailed description
 - add references to prior discussion and failure scenarions
 - follow guidelines for subject and formatting
 - no functional changes compared to v3

v3 updates:
 - fix iteration to cover all endpoint decoders under a common bus/port
 - collapse series into a single patch   

v2 updates:
 - sent by mistake from wrong local branch, does not compile, should
   be ignored

v1:
https://lore.kernel.org/linux-cxl/20251125143826.282312-1-pawel.mielimonka@fujitsu.com/

Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
---
 cxl/region.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d..d86e45f 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -831,6 +831,72 @@ out:
 	return cxl_region_disable(region);
 }
 
+/*
+ * cmp_region_hpa() - Compare CXL regions by their HPA.
+ * @l: pointer to the first element (const struct cxl_region **).
+ * @r: pointer to the second element (const struct cxl_region **).
+ *
+ * Comparison function for CXL regions based on the Host Physical Address
+ * returned by cxl_region_get_resource().
+ *
+ * Return:
+ *   < 0 if the HPA of the region pointed to by @l is less than that of @r
+ *   = 0 if both regions have te same HPA (not expected)
+ *   > 0 if the HPA of the region pointed to by @l is greater than that of @r
+ */
+static int cmp_region_hpa(const void *l, const void *r)
+{
+	const struct cxl_region *const *left = l;
+	const struct cxl_region *const *right = r;
+	u64 hpa1 = cxl_region_get_resource((struct cxl_region *) *left);
+	u64 hpa2 = cxl_region_get_resource((struct cxl_region *) *right);
+
+	return (hpa1 > hpa2) - (hpa1 < hpa2);
+}
+
+static int collect_regions_sorted(struct cxl_decoder *root,
+	struct cxl_region ***out, int *out_nr)
+{
+	struct cxl_region *region;
+	struct cxl_region **list = NULL;
+	int nr = 0, alloc = 0;
+
+	struct cxl_port *port = cxl_decoder_get_port(root);
+	struct cxl_decoder *decoder;
+
+	cxl_decoder_foreach(port, decoder) {
+		if (!cxl_port_is_root(port))
+			continue;
+		cxl_region_foreach(decoder, region) {
+			if (nr == alloc) {
+				int new_alloc = alloc ? alloc * 2 : 8;
+				size_t new_size = (size_t)new_alloc * sizeof(*list);
+				struct cxl_region **tmp;
+
+				tmp = realloc(list, new_size);
+				if (!tmp) {
+					free(list);
+					return -ENOMEM;
+				}
+				list = tmp;
+				alloc = new_alloc;
+			}
+			list[nr++] = region;
+		}
+
+		if (!nr) {
+			free(list);
+			*out = NULL;
+			*out_nr = 0;
+			return 0;
+		}
+	}
+	qsort(list, nr, sizeof(*list), cmp_region_hpa);
+	*out = list;
+	*out_nr = nr;
+	return 0;
+}
+
 static int destroy_region(struct cxl_region *region)
 {
 	const char *devname = cxl_region_get_devname(region);
@@ -895,6 +961,59 @@ static int destroy_region(struct cxl_region *region)
 	return cxl_region_delete(region);
 }
 
+static int destroy_multiple_regions(
+	struct parsed_params *p,
+	struct cxl_decoder *decoder,
+	int *count)
+{
+	struct cxl_region **list;
+	int nr, rc, i;
+	bool skipped = false;
+
+	rc = collect_regions_sorted(decoder, &list, &nr);
+	if (rc) {
+		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
+		return rc;
+	}
+
+	for (i = nr - 1; i >= 0; --i) {
+		struct cxl_region *region = NULL;
+
+		for (int j = 0; j < p->argc; j++) {
+			region = util_cxl_region_filter(list[i], p->argv[j]);
+			if (region)
+				break;
+		}
+
+		if (!region) {
+			skipped = true;
+			continue;
+		}
+
+		/*
+		 * If current region matches filter, but previous didn't, destroying would
+		 * result in breaking HPA continuity
+		 */
+		if (skipped) {
+			log_err(&rl, "failed to destroy %s: out of order %s reset\n",
+				cxl_region_get_devname(region),
+				cxl_decoder_get_devname(decoder));
+			rc = -EINVAL;
+			break;
+		}
+
+		rc = destroy_region(region);
+		if (rc) {
+			log_err(&rl, "%s: failed: %s\n",
+				cxl_region_get_devname(region), strerror(-rc));
+			break;
+		}
+		++(*count);
+	}
+	free(list);
+	return rc;
+}
+
 static int do_region_xable(struct cxl_region *region, enum region_actions action)
 {
 	switch (action) {
@@ -902,8 +1021,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
 		return cxl_region_enable(region);
 	case ACTION_DISABLE:
 		return disable_region(region);
-	case ACTION_DESTROY:
-		return destroy_region(region);
 	default:
 		return -EINVAL;
 	}
@@ -971,7 +1088,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			if (!util_cxl_decoder_filter(decoder,
 						     param.root_decoder))
 				continue;
-			rc = decoder_region_action(p, decoder, action, count);
+
+			if (action == ACTION_DESTROY)
+				rc = destroy_multiple_regions(p, decoder, count);
+			else
+				rc = decoder_region_action(p, decoder, action, count);
+
 			if (rc)
 				err_rc = rc;
 		}
-- 
2.47.3

