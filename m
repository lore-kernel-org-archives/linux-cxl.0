Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E533C183;
	Mon, 26 Jan 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436742; cv=none; b=LyJSB4mGp6a12VgUJnsKp+ihhKapgjo8ic1gKohYoDtF3S5Yb4pWCXulTwoBS9JrxAgzyn9fm8zelPIFofDruXBPqipMjX400GIljc2vjIopzONLtkfSUjlveyVcSMevoADyXiqAtDVcO2hIoKXL0GE0Uwls+AlQWWp6dEJIr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436742; c=relaxed/simple;
	bh=Avljhde9a+bMRY9pj27KCMG2nuu6NlI+wgO+oEThz/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtBz4uY5Kiv51eK6nabOpfMraPjcnZfq0wQQFWPIIq/tiukjpJ1HFpLXqn0JijF9JCaR9+D74dY7MQ7uzaMIH9635ibYuH8mZEbuYpYJYRfL5uK9pSNc8xVz1mczgHza10iH4vERmnPYb9Fsh3m8n4pDcdV0YvreVSddeq8z34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iGsYafw6; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iGsYafw6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1769436739; x=1800972739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Avljhde9a+bMRY9pj27KCMG2nuu6NlI+wgO+oEThz/8=;
  b=iGsYafw6worezlWS/EjS0lEeFkla7jbwsNzJfAEwlcD4AXw7YC4s1aaC
   wAqkwAomYt8/ANUwjJkBd+Kr8/jcw3UfIRJHJtPEuNAhQGkjGY4op6Pze
   i2grJUYT2TO+10rKi8T2sjIslIvOuBLYg9D9BLB0loJiSsBNMvmds0rgu
   4BBuTbyXhQIcUBptfcgYE5wOl2vRQq5iz6F0IO4DdLp8cgHuI/NGCiDWa
   lQcHIRRtmoyo7eBW9FfxdMlEr/8lPkrBolGph5zZ5b7Xv0HV8DKYSqm0e
   k29vmo4GFCKcMXRixpLvfpqlH0l/QSrbNVpt1HQWqjkFXZdrNRI7Bekc8
   w==;
X-CSE-ConnectionGUID: R9w5fzZjTkC98O6nRzLn7A==
X-CSE-MsgGUID: ERCkqLXzSBqnPl7Oywz80A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="206103328"
X-IronPort-AV: E=Sophos;i="6.21,255,1763391600"; 
   d="scan'208";a="206103328"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([51.138.80.169])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:11:09 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id E0F3D1C00092;
	Mon, 26 Jan 2026 14:11:10 +0000 (UTC)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 548031C002CA;
	Mon, 26 Jan 2026 14:11:10 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 86B1D200B3B5;
	Mon, 26 Jan 2026 23:11:08 +0900 (JST)
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
	Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Subject: [PATCH v3 1/1] cxl/cli: enforce HPA-descending teardown order for destroy-region
Date: Mon, 26 Jan 2026 23:14:59 +0900
Message-ID: <20260126141459.3935967-2-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126141459.3935967-1-pawel.mielimonka@fujitsu.com>
References: <20260126141459.3935967-1-pawel.mielimonka@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: This revision collapses the previous 2-patch series into a single
patch.

Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
---
 cxl/region.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d..5ab9f4e 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -831,6 +831,60 @@ out:
 	return cxl_region_disable(region);
 }
 
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
+	struct cxl_region ***out,
+	int *out_nr)
+{
+	struct cxl_region *region;
+	struct cxl_region **list = NULL;
+	int nr = 0, alloc = 0;
+
+		struct cxl_port *port = cxl_decoder_get_port(root);
+		struct cxl_decoder *decoder;
+
+		cxl_decoder_foreach(port, decoder) {
+			if (!cxl_port_is_root(port))
+				continue;
+			cxl_region_foreach(decoder, region) {
+				if (nr == alloc) {
+					int new_alloc = alloc ? alloc * 2 : 8;
+					size_t new_size = (size_t)new_alloc * sizeof(*list);
+					struct cxl_region **tmp;
+
+					tmp = realloc(list, new_size);
+					if (!tmp) {
+						free(list);
+						return -ENOMEM;
+					}
+					list = tmp;
+					alloc = new_alloc;
+				}
+				list[nr++] = region;
+			}
+
+			if (!nr) {
+				free(list);
+				*out = NULL;
+				*out_nr = 0;
+				return 0;
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
@@ -895,6 +949,59 @@ static int destroy_region(struct cxl_region *region)
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
@@ -902,8 +1009,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
 		return cxl_region_enable(region);
 	case ACTION_DISABLE:
 		return disable_region(region);
-	case ACTION_DESTROY:
-		return destroy_region(region);
 	default:
 		return -EINVAL;
 	}
@@ -971,7 +1076,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
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

