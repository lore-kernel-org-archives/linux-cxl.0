Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104432;
	b=QGi31jR1vWHmBWEyb9KHjDsdktlIfVS8lpDwKwPzC+/C6tCvQ4SWoguTJvJ35TElz2xS
	 ugcOjFNvYhDovylZti1RYRh22toCzkA6PIn2/uJpGJ8FPYjgnjxM1kYZSUCzpgpXvE3sF
	 jACP+QO13vodVHczHAi63RzYljv6X8lyxrfPQms1ajcdxyAuJXbYXAGtbjdXqMvqcdz3u
	 Ij4EepnmRA2CVZ7o/NZ3PCPDiqweDmm41lSMg5F8IZagmj+6PqGL4V46229mPqutDGTkG
	 vkS2qrCQUKZp5ScCHDrazeBBLp/m8055QYoC44y1UXhU1uFI/gwpFupP8xFEiy4vSNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104432;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bPFKW90LkXEsOjhZSpUDe3eH68p7GxhnPXqSklKdp+k=;
	b=MdQpNMPoBCOLK2KHhgWOeh6XtVqZKGQxdwQoJ3gLM2sAhEqQQJxVqFuK738Iom9aSWnO
	 So8A9LUJ6zGAhDQZTgHzJCZcXmny9rHPBClHV/m1cW9D4brDYA0bVNl0k37FG6EiS/AK/
	 8Hqg9g9LZJ6Z3iAWfekvlJFsXEKQOv+emnDLe8w52yckR6RSnE5qVffSvDGMO8p0CjIXb
	 OLgW9oNi4z5qVKtekkOO4Xrxd+PjL3sE8D+izbXMcLQPr6rWKbb5+2BtSUmj1IR6d6KTS
	 +Hq/bGYkOCu9gb1jn20Wi8ZL773l4m612Rzg6Ji0kuX6UzhLSGIrdFqFUcCzBDdM5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDD606A31A
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 02:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1931ff67a29so297719c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 18:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104431; x=1794709231;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPFKW90LkXEsOjhZSpUDe3eH68p7GxhnPXqSklKdp+k=;
        b=tMlOr1N4LGlXMDDfn8gh9YFcRsRzPoAydqlP5KeAUMwtPwJ+nHdwE6EmX7Set4m4kl
         ApN/QYWURrasc+4SpVDEfsCzN8XaY2o2c2JO3h5s2+IuROYX5WBPX1SyOHgeyGf+tXMZ
         nzLHbeuTLstctZvo/KfO9/0B2iiDyt3OOKUzLr8mTVR15QgiPcGMqVLeMsy8ObybQNNk
         gQwRjdxYpzhyXO31qFIlCFoD46rSkCAEwKV9r8XW7bbx+p8FoM0KBQVfhVTrfdWL7Uk8
         VQrO4um7xC0TR/Us2baPUtuyTNU+qx5RT89HrR9NVkWWhYkJFwsRichQDwPeB0AQw8sB
         TAag==
X-Forwarded-Encrypted: i=1; AKwUvBzDbqNClsSl60BRpN/Sj4/cT0KLOxjfC6z9gw101sP5XxhamQPM8esEiRpDj+bkK55so15NaQz9wRY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tAUBfBMUqlW+Jhz8MO9/pDqjknd46RIZibk0NA+lItDXj08h3
	XRkeGaQdWs88z7P6cPTneAwRrfprA+FVpL2ifQkhIJV0t1QumA0yM+osn3LKlFRuk4Wk
X-Gm-Gg: AYBFou2ahwHcVClxx1Sy69+XvGwI5chzDSlxPmqpUmSyTupIE5P1b3f7Ge+fBrvxOeJ
	wrLwQR2s2cpV313h7J41HZiGTO/oViUvYmgPmX+BCd4nq+5NdOinOn1b6xrfzw0yr0bufgSoQwr
	KpDMSuGhp4vXxgY1ILJSHmtuJ9OhUBcrkjaWMRtgct7N7Ou7dVoBIoblh4uu9lpaqSH6myyBqTD
	EOk2bN0uEYoM4AHjyx6QAsWEeFaqyAwJ613jSiOnYdQBzaKcNMfc2uGKL4MT+lzbZ5mLBuMS3yL
	q7+BiWs6xJoiosd9fONhu7pYZmb0RYBv/2LeQ2S/xn746FeI8ldxnyyNcz0QcpQbj06CQEXr8le
	qeZ5g/NQbQnfTPZk9i/JPZe7CGGNN6rPj2UWhvAF6zOyUfYUDrGTlHjibEWJaVjBrHolXriW8h4
	KstRW0tQPTFvBXLEQbG7rJulLUSWgr9wlBHSTOQ2oRsb33Hjy9SHK1T4E58FgpedkNLk8IxKKz/
	RgB9dNq93WwxOlA8NM2TzYg5r6LYn63m9Smhj4+UuviOwDt+q2Y01GLiEj6d00C7GlVWlJ/NPdS
	TA+qspdHn4WpmNNM2neHftLE4scsImvIUCUleFNXjz6R1VZtKbsZLKFbbTRKX/fvlB9gSdpUbw5
	HmL82nhuloTLnlBqoLaA2anOxQdTTyft/sHx1O/o=
X-Received: by 2002:a05:7022:7e8e:b0:1b2:610b:878 with SMTP id a92af1059eb24-1b39fe2fcfamr615063c88.6.1794104431026;
        Sat, 07 Nov 2026 18:20:31 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm3027961c88.1.2026.11.07.18.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2026 18:20:30 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH v5 1/3] cxl/edac: Read cached DRAM event records under the xarray lock
Date: Sun, 08 Nov 2026 11:20:23 +0900
Message-ID: <20261108022022.3352-2-ai@linux.com>
In-Reply-To: <20261108022022.3352-1-ai@linux.com>
References: <20261108022022.3352-1-ai@linux.com>
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

The event path caches DRAM event records in an xarray. It frees a record
when xa_store() replaces it, when the record expires, and when the cache
overflows. The event path runs with device_lock() and cxl_rwsem held for
read.

The repair path looks up records with cxl_find_rec_dram() while holding
only cxl_rwsem for read, so both paths can run at the same time.
cxl_find_rec_dram() reads the record after xa_load() returns, and
cxl_mem_perform_sparing() reads validity_flags from the returned record
again later. Both reads can hit a record that the event path has just
freed.

Move the lookup into __cxl_find_rec_dram(), which is called with the
xarray lock held. cxl_find_rec_dram() now returns whether a record
matched, and copies the matching record into a buffer passed in by the
caller. The PPR path only needs to know whether there is a match, so it
passes NULL. No caller keeps a pointer to the record after the lock is
dropped. The event path frees a record only after xa_store() or
xa_erase() has removed it from the xarray, and both of them take the
same lock.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 34b81e8dfb..4624ab4644 100644
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
 
@@ -1029,6 +1028,30 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
 	return NULL;
 }
 
+/*
+ * cxl_store_rec_dram() replaces and frees records while the repair path only
+ * holds cxl_rwsem for read, so look the record up and read it under the
+ * xarray lock, and hand back a copy of the record.
+ */
+static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+			      struct cxl_mem_repair_attrbs *attrbs,
+			      struct cxl_event_dram *out)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
+	struct cxl_event_dram *rec;
+
+	if (!array_rec)
+		return false;
+
+	xa_lock(&array_rec->rec_dram);
+	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
+	if (rec && out)
+		*out = *rec;
+	xa_unlock(&array_rec->rec_dram);
+
+	return rec;
+}
+
 #define CXL_MAX_STORAGE_DAYS 10
 #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
 
@@ -1298,9 +1321,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	return 0;
 }
 
-static struct cxl_event_dram *
-cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
-		     struct cxl_mem_sparing_context *ctx)
+static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
+				 struct cxl_mem_sparing_context *ctx,
+				 struct cxl_event_dram *rec)
 {
 	struct cxl_mem_repair_attrbs attrbs = { 0 };
 
@@ -1332,10 +1355,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
 		attrbs.repair_type = CXL_RANK_SPARING;
 		break;
 	default:
-		return NULL;
+		return false;
 	}
 
-	return cxl_find_rec_dram(cxlmd, &attrbs);
+	return cxl_find_rec_dram(cxlmd, &attrbs, rec);
 }
 
 static int
@@ -1344,7 +1367,8 @@ cxl_mem_perform_sparing(struct device *dev,
 {
 	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
 	struct cxl_memdev_sparing_in_payload sparing_pi;
-	struct cxl_event_dram *rec = NULL;
+	struct cxl_event_dram rec;
+	bool rec_found = false;
 	u16 validity_flags = 0;
 	int ret;
 
@@ -1362,11 +1386,14 @@ cxl_mem_perform_sparing(struct device *dev,
 			return -EBUSY;
 	} else {
 		if (cxl_is_memdev_memory_online(cxlmd)) {
-			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
-			if (!rec)
+			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
+							 &rec);
+			if (!rec_found)
 				return -EINVAL;
 
-			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
+			validity_flags =
+				get_unaligned_le16(rec.media_hdr.validity_flags);
+			if (!validity_flags)
 				return -EINVAL;
 		}
 	}
@@ -1376,13 +1403,10 @@ cxl_mem_perform_sparing(struct device *dev,
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
@@ -1399,9 +1423,9 @@ cxl_mem_perform_sparing(struct device *dev,
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
@@ -1814,7 +1838,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
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

