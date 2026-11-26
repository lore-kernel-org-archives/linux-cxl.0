Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660544;
	b=BX4bSoA3WbLOrtlb2sQjsOx+pmx2iAyDzkNpPvSvSbUAmeW9w3fc56f6mxkgsQ95zpPh
	 Q16fo7JrvNQpURAx7O7DIKjAM2RpoLY+arCFo+NATNagLyXiWKkVv07nGgp8FvRxMJGB2
	 nHT9brcmC4WlgRGGB7r/gXNAAeNkS/SpuuaEm9Pqdc5gb6nTax41Hdkbz9ev3IorohxBP
	 y3WfL5lk0jxWr4gjn8XkdTdwqqMwoqRNci5IRA+qogxp2vy3ggHYenLfdu4EcqO8BVBGZ
	 e5cydgP/nuIPGh4itBzN8OAEF9hTz08iW1IdhZZY4od7Ef/tnScqpdZ1eNMDfzqa4dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660544;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=c6GsLhHPsz7MggNwvAtHjw6vDwkQYlZStNNgVvITAvw=;
	b=OtWgmUXrB/Zp6rnD8QDoRceIe7XD5C4F6mX64Qzx4yBPn+oUL2s1phfr9EbaotPAzC/b
	 BC988XKBIjHRVHwT80sfT8viS+Y80emHTfr/1QiAnMNdnqiftUoZ3uPRMKZSUyGsrqTcB
	 hKqQUE1xauwxnmpaH9Rc8b1sUVtEpylVVrP0bLjjn4YEGLz9AjbYGdMNXA1Y07VOBX0I8
	 wef5V73I2zUwWzcFDa4PmR7QLp1xB1DOK1BSaLms6MGdhSMMV+AeLtZumq2oCPKIs6S6V
	 WRxfV37caZ662UbWQlv9cndszytm7c2oPLpVhRnZj+P92wlAoVAfMlN5YkbzDxHcSXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B58606A323
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B58606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1ae58d17cd9so7187606c88.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660544; x=1796265344;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6GsLhHPsz7MggNwvAtHjw6vDwkQYlZStNNgVvITAvw=;
        b=KH2aYuQXL3guHyAQeQsums2lv9kV6E/RNfdS68D8UuyBT6sgZNGbxjzU7mMBDSlmkQ
         T+VPomdJZCLuBewx/72qosyh/VaNs7qjxYlID/b+I0HkbIaAei5Pw7qu/CHH/Zf3Ente
         RBtxnWasmcX0+pFuuH6KJQJ92MSEFviYCfW1kTcSxsSxmM/IUWHmH4ZbnbPiQTipBYqX
         LW9YuLW8e+NFJHMjwfI2dsNnpVjt3w6eNRKuELoaG2VM/6HzM2qgMd2tqwk/AvcJyqGd
         rzMJop4RsCWvqf7jY3Lvq1xEZQfXlLVpi8JxsiB8BCfWOXcVcwREWV0RvvRluuPYiu4Y
         zNag==
X-Forwarded-Encrypted: i=1; AL+hErFBfhBdj9I3iryPHSlVuFx+Mz0S6SfY/USL2zXzwnrPrm6ZskfS9Af7H4NJV/jT0Z1NE+3Tk67qEsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/taSvtnkY5AaIcM2Se0GPa0/y3qhs8WIRzIDec+5uJ81uhuyXw
	6+VGEgwBFAVdTEaNHPk0kZSC0FtvjMCxkLeX1H+P1ZbwxLvmEM8BFlbsS4buUHFnOjrt
X-Gm-Gg: AZFdTZeYpOBvIpI2iQb4OVvFyKz5omtU6Z79JtW8YVNPZsHatt2MFPrPPlzg1x6oXaD
	dXXlgsvs1LQuy+HIIhRmfzxDdXQvkdLaKIMMHeVHWtyHXdd7FL9dzZYZj6uyJu7Kvxf0nNtApfq
	kA7JN4IIeZsvZfqtuy7Afxm5WDXEM9CDB2r0IA9ZM7kY1lOTdI6isImTyK51IV6Y0d++s2Vu8zd
	U+8Lq8uuuuEq77naaW6djAeWzEeqx65AlTtlUJ4ARRSn/k0eEXoU4wC5cno9pjAnksFWAhnvo0g
	E9jzPzCzVkq0D0dCok6MUDWSPUWCrGm08d148bI92WSK7bFCUaPajwPf8fJHP3prfLeEUGEQ4Y/
	PqZaRlRq6LDuVPXyahC9kt9GMHv8USJ4UDcYBSCiih5HKwS3oxd7K5JmG2Px77KqnPoSDGLktXs
	DfLV2zliUjwJ5UiHUvD8JzAo34aDUNr915iPyr/SHnWq90E83z8mv11y7imD9AxMKB+45gAzWmy
	iBjKdfhk+3xbkPcJlIAERBmK/mzG/rSVLAdtxWG5Kgrw197Bobf0Rp6vNWrdWyZHBnhzPmRxjKC
	VBYjXTOXzGnN+o2+gNUQmi30sKppLwmynQ98tnMXj9XRRJzJGQ==
X-Received: by 2002:a05:7300:ce8f:b0:369:f035:661 with SMTP id 5a478bee46e88-38570450918mr16416084eec.15.1795660543302;
        Wed, 25 Nov 2026 18:35:43 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.35.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:35:42 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH v6 1/3] cxl/edac: Read cached DRAM event records under the xarray lock
Date: Thu, 26 Nov 2026 11:35:21 +0900
Message-ID: <20261126023520.39368-2-ai@linux.com>
In-Reply-To: <20261126023520.39368-1-ai@linux.com>
References: <20261126023520.39368-1-ai@linux.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 56e50eea3994..bd217dccf119 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -945,18 +945,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
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
 
@@ -1036,6 +1035,30 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
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
 
@@ -1305,9 +1328,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
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
 
@@ -1339,10 +1362,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
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
@@ -1351,7 +1374,8 @@ cxl_mem_perform_sparing(struct device *dev,
 {
 	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
 	struct cxl_memdev_sparing_in_payload sparing_pi;
-	struct cxl_event_dram *rec = NULL;
+	struct cxl_event_dram rec;
+	bool rec_found = false;
 	u16 validity_flags = 0;
 	int ret;
 
@@ -1369,11 +1393,14 @@ cxl_mem_perform_sparing(struct device *dev,
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
@@ -1383,13 +1410,10 @@ cxl_mem_perform_sparing(struct device *dev,
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
@@ -1406,9 +1430,9 @@ cxl_mem_perform_sparing(struct device *dev,
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
@@ -1820,7 +1844,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
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

