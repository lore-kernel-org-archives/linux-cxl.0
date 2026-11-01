Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496871;
	b=ghZrpFgapkC4F55ahzrOeca918dY94bYoxL08vHO8Iuo8DZerkAO522yyiH4/ZTRuLKM
	 wi26HeI/gVdSJKfyv3AYilv+Y7AAtDnrym3MqWpovOIzEx+QWilsV7/Ej2nBLtgDeVBez
	 vkZHamjXPcW/CWOfMfU4RaSgXDt9ajtw5l4OYLJM7dBv1/ZBMNZ6NHI83b4UoCCcBNQie
	 /Ho8J+n0irXIL66/w1kSuRIac/hHHFB4IR6mIqskjSExDKLTGIImjhJ7xaDUdVJLXrUjb
	 HseIPybGKOP2UZvloh9gRNNa2FdpdupZkUO41yT7Goyi4CtS8DXI6OdTAi+dzyX4juQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496871;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pp6rXKSE5E3HxcF7WT8oNamyuZmfcfT+UhC0o/i7RWU=;
	b=5G3MdhankvSot7Ao15bYFAXfcna1MjvOiRXlW1Fnyd9325AWI5RYElbh+kI4vtSkHpRY
	 p7Bo/pHHlN+tzvWncCzONSSrntPNjLEprI/OSPZAr4A5rb8dbwKmB6KYc3sr6zRdZa0t6
	 U7p/Wk1ZUN84mZTJyNCDNotGpDuSaAcd9DTYWDf/rL7isaFOwySSSp7evz+knJKLbgyQs
	 KJ0rOOlx3/ohq1ZwsQebGxln08zoi6rFhgWTdQJD09Y8ICkli+cvqIY2AUvS6m8d9Sm0O
	 zgmWL11nDGc4YETB1rnCsxBInkxcF5AoqEeO3qfaAxxHU3feOg6VCTkYmYGJ73ToMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A87606A322
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 01:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A87606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1220490a91.2
        for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 18:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496869; x=1794101669;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pp6rXKSE5E3HxcF7WT8oNamyuZmfcfT+UhC0o/i7RWU=;
        b=ndUUiT+NK12RkQiOOd8g8ca5UtdjODt4IsVCp43b0uwX+CkZeKuUstnjZ5xsBI5hea
         2a+DBtbul6J9TEBKrWMsiOuR5YqWuo26AN95KrQBJ5E1jnw6s18BEE6Q50lg/Q4RJqqw
         0zmtMuwvQNAIk3IXdPqgClAfyCBBrtUQ6e5dilv0xcUbMYm3kiEDwuc6i7aVwdEAp4ZM
         b02e9HTjZAB3JPefuUuw5U8L5KOAD1CIHT7yfM6dIBMSFbRxJhBp/hsMjav115hxL7uu
         fVFOsJ516P751rd0PEZof5h0jkevunIreptFzuduK8EnZLn4a6YMyPlScUXE4EydVoNS
         t8wA==
X-Forwarded-Encrypted: i=1; AKwUvByn7CZFPg+erIciMCDzPi2x6avWfqobOfxV1JK/lTHDiNuGHnm/HN2sUOh0y0ths0F0bhELJWpUSeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zDy4b0Wipv7+mhUzB+QjVYMg7D2nQMVwB6Lh6qHMgnmu+fqTE
	Gu57SQJSNAGUzhZu/lNeW2BebkSoXxpkDJujzqDvnek1yYm1cireOsxeL3A239osAWoi
X-Gm-Gg: AYBFou1cX+VP2iSfSdMIxoWG3pFj0Xdxzj5+uix3VHZSIfyXgLw3P2VEZbUtGOWPgo/
	fTTpzWEe1JG+857pQjjd+zbWJUJB+GOfz3KDl7Z9+T088d1YTrQfiFboj6dQGiLLHlzd8b6z1OK
	XdliG7sT/tugdgNd81rQ600d3752LiXS9ffa0Ry9QUHXJfHx/MEHVdHz/2AofWC/vSjzD7o1qWP
	HK/3+zDknKuollPKrWBiHhSeoLPVRiNd8RMZ9WJqfRxca2wdc4KAWe7WvAXOlByhMTygwDVOPrw
	LlQTsuje6J3m8EQkdM8Bo8qWt1q3yH+SehzZvJbNIkEQGRRgt0kc++cdlMHkOt8ZHwysR++XXQ0
	mjkrz2HpiNNNoWwVscHD/IOETqWNs+G+kmSvAlp+FOkppwfF6papk67ND9MQT3UPixDWX2a7afX
	n/wsiR+dGfmc/Y4HQZJpxvKapKb5ur94B1+pgjuOGJ//ozdH/eTp6wGcx3oazDVQzvOswe6kozY
	4mFbdPA4akfnGIYs3jZXUJ9UXBUhA6jdom+9/948vZG1bB8MIQN7F7m9r2YLyPvQpigCEIZnhW7
	0UuY9IC5ubXCaRHQ2tuHuRAcv7RZLZynyXBK1rn0xaqdDrHCXf5/+2lg/qb4sTRqV7weM0uBnrS
	kyuV56PUQ8Kq1BveCCZbALWT1L4frzSO0+sdA6F5Px7FmnEOsZUGU2igiQg1s
X-Received: by 2002:a17:90b:17c5:b0:3ab:413:49b1 with SMTP id 98e67ed59e1d1-3ae897c0a0dmr5789728a91.48.1793496869337;
        Sat, 31 Oct 2026 18:34:29 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm8727943a91.17.2026.10.31.18.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Oct 2026 18:34:28 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH v3 1/2] cxl/edac: Read cached DRAM event records under the xarray lock
Date: Sun, 01 Nov 2026 10:34:19 +0900
Message-ID: <20261101013418.87326-2-ai@linux.com>
In-Reply-To: <20261101013418.87326-1-ai@linux.com>
References: <20261101013418.87326-1-ai@linux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The event path caches DRAM event records in an xarray and frees a record
when xa_store() replaces it, when it expires and when the cache
overflows. It runs with device_lock() and cxl_rwsem held for read.

The repair path looks records up with cxl_find_rec_dram() while holding
only cxl_rwsem for read, so the two paths can run at the same time.
cxl_find_rec_dram() reads the record after xa_load() returns, and
cxl_mem_perform_sparing() reads validity_flags from the returned record
again later. Both reads can hit a record the event path has just freed.

Move the lookup into __cxl_find_rec_dram(), called with the xarray lock
held, and make cxl_find_rec_dram() return whether a record matched and
copy out the validity flags the sparing path needs. No caller keeps a
pointer to the record after the lock is dropped. The event path frees a
record only after xa_store() or xa_erase() has removed it from the
xarray, and both take the same lock.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 69 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 34b81e8dfb..f0c12871bd 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -938,18 +938,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
 	return NULL;
 }
 
+/* Caller holds the xarray lock. The record may be freed once it is dropped. */
 static struct cxl_event_dram *
-cxl_find_rec_dram(struct cxl_memdev *cxlmd,
-		  struct cxl_mem_repair_attrbs *attrbs)
+__cxl_find_rec_dram(struct xarray *rec_xarray,
+		    struct cxl_mem_repair_attrbs *attrbs)
 {
-	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
 	struct cxl_event_dram *rec;
 	u16 validity_flags;
 
-	if (!array_rec)
-		return NULL;
+	lockdep_assert_held(&rec_xarray->xa_lock);
 
-	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
+	rec = xa_load(rec_xarray, attrbs->dpa);
 	if (!rec)
 		return NULL;
 
@@ -1029,6 +1028,32 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
 	return NULL;
 }
 
+/*
+ * cxl_store_rec_dram() replaces and frees records while the repair path only
+ * holds cxl_rwsem for read, so look the record up and read it under the
+ * xarray lock, and hand back a copy of what the caller needs.
+ */
+static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+			      struct cxl_mem_repair_attrbs *attrbs,
+			      u16 *validity_flags)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
+	struct cxl_event_dram *rec;
+	bool found;
+
+	if (!array_rec)
+		return false;
+
+	xa_lock(&array_rec->rec_dram);
+	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
+	found = rec;
+	if (rec && validity_flags)
+		*validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
+	xa_unlock(&array_rec->rec_dram);
+
+	return found;
+}
+
 #define CXL_MAX_STORAGE_DAYS 10
 #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
 
@@ -1298,9 +1323,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	return 0;
 }
 
-static struct cxl_event_dram *
-cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
-		     struct cxl_mem_sparing_context *ctx)
+static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
+				 struct cxl_mem_sparing_context *ctx,
+				 u16 *validity_flags)
 {
 	struct cxl_mem_repair_attrbs attrbs = { 0 };
 
@@ -1332,10 +1357,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
 		attrbs.repair_type = CXL_RANK_SPARING;
 		break;
 	default:
-		return NULL;
+		return false;
 	}
 
-	return cxl_find_rec_dram(cxlmd, &attrbs);
+	return cxl_find_rec_dram(cxlmd, &attrbs, validity_flags);
 }
 
 static int
@@ -1344,7 +1369,7 @@ cxl_mem_perform_sparing(struct device *dev,
 {
 	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
 	struct cxl_memdev_sparing_in_payload sparing_pi;
-	struct cxl_event_dram *rec = NULL;
+	bool rec_found = false;
 	u16 validity_flags = 0;
 	int ret;
 
@@ -1362,11 +1387,12 @@ cxl_mem_perform_sparing(struct device *dev,
 			return -EBUSY;
 	} else {
 		if (cxl_is_memdev_memory_online(cxlmd)) {
-			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
-			if (!rec)
+			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
+							 &validity_flags);
+			if (!rec_found)
 				return -EINVAL;
 
-			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
+			if (!validity_flags)
 				return -EINVAL;
 		}
 	}
@@ -1376,13 +1402,10 @@ cxl_mem_perform_sparing(struct device *dev,
 	if (cxl_sparing_ctx->persist_mode)
 		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
 
-	if (rec)
-		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
-
 	switch (cxl_sparing_ctx->repair_type) {
 	case EDAC_REPAIR_CACHELINE_SPARING:
 		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
-		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
+		if (!rec_found || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
 			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
 			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
 		}
@@ -1399,9 +1422,9 @@ cxl_mem_perform_sparing(struct device *dev,
 		fallthrough;
 	default:
 		sparing_pi.channel = cxl_sparing_ctx->channel;
-		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
-		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
-			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
+		if ((rec_found && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
+		    (!rec_found && (!cxl_sparing_ctx->nibble_mask ||
+				    (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
 			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
 			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
 					   sparing_pi.nibble_mask);
@@ -1814,7 +1837,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
 			attrbs.repair_type = CXL_PPR;
 			attrbs.dpa = cxl_ppr_ctx->dpa;
 			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
-			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
+			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
 			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
 				return -EINVAL;
 		}
-- 
2.55.0

