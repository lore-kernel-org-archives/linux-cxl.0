Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A613A3F2;
	Wed, 11 Jun 2025 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613064; cv=pass; b=cilZFT8M17vHZi3maanbWyBe3eOLuyN4pzAFUURSqoQ8nQuU/6NfCj+UwyiM5X6hrTRtQ49iJ5Vbj6lIq60tK04vy2yAkM9u2G899cIlbNnMf/e3ZFaIJFDO/4P08FPczSuSNdMufu6yDzgpzeQxNwwhSloFv8M+F4WjY2bHP4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613064; c=relaxed/simple;
	bh=WBYZJNpKxuiJOBYXbR+TQh0cq5L9uaE7NAB6VnlearM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AzzaspXmV4ZMZV2lasXeebnNYKS6qz6b2EQGeWxT3tItvmldWK4jUEP5xNNjXyWklt/dO924lYZmIc1V7af8N8K9iUXrgUQl44TBq56UqJ2Ual/Ijj7Z1LGsaSb18BIcm3TAAwyB55huCLRKvDx3uTf7iSfNq57ha9X5vdYl+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=B+Xbi1c4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="B+Xbi1c4"
ARC-Seal: i=1; a=rsa-sha256; t=1749613046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h2HgZfUvVxnMbpFC3jyOX2cKHFCJPINOMZE7CgeHOSNOg6/PjdZ+hwfWryek1o7AjmhVGUYS+9hksWH3WguW+SNsOL2AqgALqbwQyZUpFXHMJwmnkzAzcyzQlZf+vsHu51jV4iqSf4AhYvm48xhziSoLihJND8i5oHAElZe2Y2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749613046; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=faHRvR+SGHmxzSv7cHI84PGrtEsnJDo9oDvQ6DBDa2A=; 
	b=Wg56mmLhoeKFAe28KoUTcqxEIxSs+oDI7jrH03Frd/+IMs1XoCQaQ8lsUeZcb8rEoO1spuUJrN1dddCbnPIErVcdZKvuutROGCuWrfhW1DAUse/1rCcN/jjf0g2apS+aM8Wu81r79Fo+VSzOh+0lxF26SZUBd0EMhXblhR2j5yE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749613046;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=faHRvR+SGHmxzSv7cHI84PGrtEsnJDo9oDvQ6DBDa2A=;
	b=B+Xbi1c4KU0Wv/RnuPEFwyGGm/PsPL0VAgi3cRmsxvdWfJrWBK0GgfeZKjoCres7
	729Z0pcEAP9BRLYurR15VAzjPhys9wxvZl5GdN9GzpvYvMX1HkkQAn9JpIYxSPR1OW9
	rTTYNh4p8gKDXSBN4t2Pj9FSR4VFHgHM2p9EgGIc=
Received: by mx.zohomail.com with SMTPS id 1749613044314624.6785588017032;
	Tue, 10 Jun 2025 20:37:24 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
Date: Wed, 11 Jun 2025 11:35:42 +0800
Message-Id: <20250611033542.96184-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227d2a18e541872dd899b08b2780000ef9113495e4c5a724022f8f4c8e44db4221c7aba003b0413a7:zu080112276e7654b12c07aa55d2c5f5cc0000fbb3770a9a91b5c2455bf3c8fbdc8947ce237166555cdb479d:rf0801122d1cc9bff403e174513f9128b40000900505c44c2c6c26ab15d56e00452bc821e69e23e7997452209261b63b08e5:ZohoMail
X-ZohoMailClient: External

In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
duplicate a cxl gen_media/dram event to store the event in a xarray by
xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
be freed in the case that the xa_store() fails.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/fixes
---
 drivers/cxl/core/edac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..b4c5c23a45d4 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1086,13 +1086,13 @@ static void cxl_del_overflow_old_recs(struct xarray *rec_xarray)
 int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 {
 	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
-	struct cxl_event_gen_media *rec;
 	void *old_rec;
 
 	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
 		return 0;
 
-	rec = kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
+	struct cxl_event_gen_media *rec __free(kfree) =
+		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
 	if (!rec)
 		return -ENOMEM;
 
@@ -1106,6 +1106,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 
 	cxl_del_expired_gmedia_recs(&array_rec->rec_gen_media, rec);
 	cxl_del_overflow_old_recs(&array_rec->rec_gen_media);
+	retain_and_null_ptr(rec);
 
 	return 0;
 }
@@ -1114,13 +1115,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
 int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 {
 	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
-	struct cxl_event_dram *rec;
 	void *old_rec;
 
 	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
 		return 0;
 
-	rec = kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
+	struct cxl_event_dram *rec __free(kfree) =
+		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
 	if (!rec)
 		return -ENOMEM;
 
@@ -1134,6 +1135,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 
 	cxl_del_expired_dram_recs(&array_rec->rec_dram, rec);
 	cxl_del_overflow_old_recs(&array_rec->rec_dram);
+	retain_and_null_ptr(rec);
 
 	return 0;
 }
-- 
2.34.1

