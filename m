Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6343E9CB;
	Tue, 20 Jan 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919373; cv=none; b=SsL2DPvpWI0yniCFP2ILCMm7b3BfQtzL+UDub0mIi3aiM2WFYyaBlpn77lbqV/JPU9IQECGg+wgBRAHEm5+sjQMyVAqEvWkUulyShKKe8KlsPHH4u2R8RPmsnUBWeP1wStjG2RTDytL8gQDZMd3WWYKWuGkjTiALRZvKfrcoc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919373; c=relaxed/simple;
	bh=JMOoyH9OPEql0w8XvTzblSwIOeS6YrEhvnoQYcjH4xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvEk09P1ufhV2aB0nfv/rF+6DkyEQRuedsflMsu38QX+iSaeKGseVh47jxyYa6k6itamvqR+aCnooRXsK+SjcaCgumLEWe3NNw5AdULRjxy+0fPYqJUUFcxArWowgkUtsnsCfcZ6lM/lYFHhw66W//CALOhn5NmT2YgCBTN1cLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tkLDA12H; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tkLDA12H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1768919370; x=1800455370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMOoyH9OPEql0w8XvTzblSwIOeS6YrEhvnoQYcjH4xU=;
  b=tkLDA12HC+UutNOW/u9K8ys58kNEX5/dFklhkONF76SZsEfTqz5WLdNo
   TLzZ60tIrCxg6yNQiVoyTDwi126PSXPkkY7p+V54xab7hDxut2uxO8z5o
   C/kerZovNQPoAuWgCDtJCsdOvZvqVHR7lU+DH15oS1fn6cavM/cmkqZib
   jYlCDEE5S99AXR54G5JZkDw3J1gcDMa+lfve+uBPQa0r+XP3QbJMOTU54
   sXhe3YaSBi5Fe+BDbbYrtaN7dMwG4SNETN+ZKDmKtzA3GDsSZ0GjugrKh
   M0Lq1xsi9zinz1NSbVYALGnz/ybjiq8vZJ6ymKXEZGfWbm442EzMBiyyE
   A==;
X-CSE-ConnectionGUID: nIMuqQCiSmi8w5noFJgfzA==
X-CSE-MsgGUID: r1/DlEtaToizfZPvjW8kZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="226445639"
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="226445639"
Received: from unknown (HELO az2uksmgr3.o.css.fujitsu.com) ([52.151.125.128])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:28:18 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id D6BBC1002BAD;
	Tue, 20 Jan 2026 14:28:19 +0000 (UTC)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTP id 54A278D29F6;
	Tue, 20 Jan 2026 14:28:19 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 987FB20053F2;
	Tue, 20 Jan 2026 23:28:17 +0900 (JST)
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
Subject: [PATCH v2 1/1] cxl/cli: enforce HPA-descening teardown order for destroy-region
Date: Tue, 20 Jan 2026 23:32:12 +0900
Message-ID: <20260120143212.3006273-2-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120143212.3006273-1-pawel.mielimonka@fujitsu.com>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20260120143212.3006273-1-pawel.mielimonka@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: This revision collapses the previous 2patch series into a single
patch.

Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
---
 cxl/region.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d0..2e0f215d 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -831,6 +831,59 @@ out:
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
+		struct cxl_port *root_port = cxl_decoder_get_port(root)
+
+		cxl_decoder_foreach(root_port, decoder) {
+		if (!cxl_port_is_root(port))
+			continue;
+			cxl_region_foreach(decoder, region) {
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
@@ -895,6 +948,58 @@ static int destroy_region(struct cxl_region *region)
 	return cxl_region_delete(region);
 }
 
+static int destroy_multiple_regions(struct cxl_ctx *ctx,
+	struct parsed_params *p,
+	int *count)
+{
+	struct cxl_region **list;
+	int nr, rc, i;
+	bool skipped = false;
+
+	rc = collect_regions_sorted(ctx, NULL, &list, &nr);
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
@@ -902,8 +1007,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
 		return cxl_region_enable(region);
 	case ACTION_DISABLE:
 		return disable_region(region);
-	case ACTION_DESTROY:
-		return destroy_region(region);
 	default:
 		return -EINVAL;
 	}
@@ -956,6 +1059,9 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	if (action == ACTION_CREATE)
 		return create_region(ctx, count, p);
 
+	if (action == ACTION_DESTROY)
+		return destroy_multiple_regions(ctx, p, count);
+
 	cxl_bus_foreach(ctx, bus) {
 		struct cxl_decoder *decoder;
 		struct cxl_port *port;
-- 
2.45.1.windows.1

