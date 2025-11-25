Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D918FDBE;
	Tue, 25 Nov 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081460; cv=none; b=b9d+WDNkfzOnFzdS/G1MwLP32ER/HTL6Gcxc3cu6PZ56xf8AZNXlptKUyjeHwXcJKXdeeDuolggIeg1J2caVnvqBiOwgS5ZjgccIvs4DTXJfQ9gbDonWo4KE2tuce7YPDkFkAHVwqOgwT2sZKiBWBDWyBUTeIjrsiv0GLmJDWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081460; c=relaxed/simple;
	bh=4ZfhF/nit6+jZ7R00OaNpYr+i410Lqt3VQVUET5Wvm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgmd/NcuL/9Jee1ZGI7/vIo38iwtX2rbUfON/tpRDWnOWCtzrLJjMkJ0pBC2h6FUQmI/z9HJP5XqE21RTgeff0qdUogUxtqdSvZKdLMtTDSKsBczqv8sBBoojr047noniO3al9UN22nJ/WDY//Nq6fg1xIAObDdHMztvHYM0Zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NWws6v1s; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NWws6v1s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1764081458; x=1795617458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZfhF/nit6+jZ7R00OaNpYr+i410Lqt3VQVUET5Wvm8=;
  b=NWws6v1sP3ki7fhhrrZNTZzC+x973h20pF0Ii2sHFrlL7j7AOcuxfYUI
   m25AaAWSaRkGuzGCT065aRwk3n5P6xHdvc3m9BCBxEyhpvc9A7opq0j4Y
   4OfnKBkLDz9T1/OPtALMw1SJ3aTBueJGzo11p+6+D7S69BeS0sTnlgAr3
   mVFZBOdWX7rRBjDBUHNXO4TI1EyqjazAocHsXO+xL7rHGL0uzCuaExmUP
   vuxwd9bmJzZQQToU+mrVnONWcX3kzP4r6T0xtpZ8XCt/WW50rIJ+LaLhS
   rmdgo2ljZIJ3VUrSnOn5SNTwRty+/Pf6jUZjY2f5af+WQ9CLK9Tdlj01a
   A==;
X-CSE-ConnectionGUID: FZDzuV8OTjqjE/R8OkuHMQ==
X-CSE-MsgGUID: MMlH/nixRGauWB8iboomMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="220378823"
X-IronPort-AV: E=Sophos;i="6.20,225,1758553200"; 
   d="scan'208";a="220378823"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([51.138.80.169])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:36:26 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id B548542A301;
	Tue, 25 Nov 2025 14:36:26 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 26C5E1C0014C;
	Tue, 25 Nov 2025 14:36:26 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 81C572005371;
	Tue, 25 Nov 2025 23:36:24 +0900 (JST)
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
Subject: [RFC PATCH v1 1/2] cxl/cli: add helpers to collect and sort regions by HPA
Date: Tue, 25 Nov 2025 23:38:23 +0900
Message-ID: <20251125143826.282312-2-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce cmp_region_hpa() and collect_regions_sorted() helpers to
enumerate CXL regions under a given decoder and sort them by their host
physical address.
These helpers will be used by the "cxl destroy-region" command to tear
down regions in HPA-descending order, i.e. in the reverse order of
region creation. This matches the decoder programming requirements from
the CXL specification (8.2.4.20.12 - continuous HPA coverage at all
times when Lock On Commit is used) and avoids teardown sequences that
can leve decoder state inconsistent when the decoder is fully populated
(known problem).
This patch only adds the helpers; no functional changes is intended yet.

Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
---
 cxl/region.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d0..58765b3d 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -831,6 +831,61 @@ out:
 	return cxl_region_disable(region);
 }
 
+static int cmp_region_hpa(const void *l, const void *r)
+{
+	const struct cxl_region *const *left = l;
+	const struct cxl_region *const *right = r;
+	u64 left_start = cxl_region_get_resource((struct cxl_region *) *left);
+	u64 right_start = cxl_region_get_resource((struct cxl_region *) *right);
+
+	if (left_start < right_start)
+		return -1;
+	if (left_start > right_start)
+		return 1;
+	return 0;
+}
+
+static int collect_regions_sorted(struct cxl_decoder *root,
+								  const char *filter,
+								  struct cxl_region ***out,
+								  int *out_nr)
+{
+	struct cxl_region *region;
+	struct cxl_region **list = NULL;
+	int nr = 0, alloc = 0;
+
+	cxl_region_foreach(root, region) {
+		if (filter && !util_cxl_region_filter(region, filter))
+			continue;
+		if (nr == alloc) {
+			int new_alloc = alloc ? alloc * 2 : 8;
+			int new_size = (size_t)new_alloc * sizeof(*list);
+			struct cxl_region **tmp;
+
+			tmp = realloc(list, new_size);
+			if (!tmp) {
+				free(list);
+				return -ENOMEM;
+			}
+			list = tmp;
+			alloc = new_alloc;
+		}
+		list[nr++] = region;
+	}
+
+	if (!nr) {
+		free(list);
+		*out = NULL;
+		*out_nr = 0;
+		return 0;
+	}
+
+	qsort(list, nr, sizeof(*list), cmp_region_hpa);
+	*out = list;
+	*out_nr = nr;
+	return 0;
+}
+
 static int destroy_region(struct cxl_region *region)
 {
 	const char *devname = cxl_region_get_devname(region);
-- 
2.45.1.windows.1

