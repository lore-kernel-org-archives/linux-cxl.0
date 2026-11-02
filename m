Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622770;
	b=yXLjYK9a5iStUnZkx80KXQPHoO+sCsLWtFXD+/Bd6XDln+JlCRXWnx6TB1g8tVTpCikn
	 JNMweZy/Ii6Ri7EBNBymP9vx0s6TYl+DD+nzDqHp3I6xN3M//6yuh1rHPNL5CWBed1t9B
	 YPpgGCQ7ggLQmbZjZMV0R4NntvaIgNa9NBBS8HUmZ/CpkfY69b+QXsJO8d6ulCHJpmNVS
	 6VrcZAUz98rfpddaGX5HsrGuiHY3QpvCytSn/+QpLVtXhs5Mny9kcB4Vq4c7Y8PxUxB4l
	 pQ4Vp+VAR/sO/lDwlsdWsV0jEXGdCdCu1eo1j1F10IXVqlQ27c0ooWGsUrjFJVmwMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622770;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Fmx+M4AB2hm825WG5Tk2E+M0SAzq97vo8VARk3oiOhs=;
	b=vyF20hP+kmX16jzFQlyBanNziarFW6Oob/0D8Jda8UZaCzbOGVeUGoUWZJQTXBmn7DWZ
	 J9UWn3JVndDp0JFt3+4O7oRqjk+KCMZEjXhb74a9FP88htsmazv1g43fyDIvoNRoLvyNO
	 1BrNPTbQM4r1KIvrh97sXwJLF8qRkHNUnFj6ZINQD6diEN7bMTHdtocAoQjpOlv9s91ZY
	 bKhEUl0hsllUNy7J/7YGV+HCtQoLLfZjEMGvzS+tAmwKaomvJrq9wshdQF26hRYs7hbiS
	 J5PkgfOinpUsFekWU5vmY1o79+CDES3A0xrfwbKpixkjiXd6SwLhG04h5kyN7KW2NKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B59606A335
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 12:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B59606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea94541adbso12295445ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Nov 2026 04:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622769; x=1794227569;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fmx+M4AB2hm825WG5Tk2E+M0SAzq97vo8VARk3oiOhs=;
        b=Dv0gBTqMp8U5l9FRlVWRZvoh0Tz1ooECPfl0y1tH5imNuvU3TDgxGRo1srlySMRShN
         iGcE3841E2nXZBboBmqsxb8TrG4xxHTDlLZ5MPUDjhtAmv1Gktg0ZhiDeuq+eX0h/W4s
         52Ag5MsvW1SAViNffiSPM/q0qB3z2mW/K2WQPAYt6Hd/ACQ9jC+JQRCccdx+VW08tIti
         3PzXXWY/X7SckBIPy3Rqbn9TrHBWKiqVwfeYZ969eihJOt5vEfcV+m/KoehJVxJq2peG
         udJYrx0EESnnufYhoqHQhj9U3N6q0zvxjAbqp1f7k7VUzNkNmHShxjf7N4mrSVsYwDRM
         3MBQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0LjZh5p7cy9smmiyorZrG7GTGsikBy0OnKr1Y+ko0W+dwKtZDMAe65ZTWTL7xnA/wGQibOaUqysY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jr0CEJAY92+w+33muISprmpIv2tfvORygToX/Vp+qGDe13Zwl
	ItpuArLYw2/USor8ZNn3gNyaMZltlOaijOqXIwWT0VfFQiPf931hZWnJsl+0D/ryrS0Q
X-Gm-Gg: AYBFou0dQqNi1K9vcEla/wDcIhRpA6IzihC/fvbM6LrJmbueh1/3ALzly6SoSSLHX60
	ZuMzg9NKwY/JtDMQwtu3/KXmcUR7JLUfbP460qzUMcXjUuvqRnUbwB2QFFgJCCytNnCe09XLJYe
	1ufc4lFqJgWvJvGDBgfmrwOnRd3/LDB0Om5OGGdeSXPciAUWK6oBZCRUasYyXOvjrYFNuxK8cUo
	CCVrVr8cqX1nqgAVkQkK8zS1cUqst5UZqiUFHiF6T4DI5GpeY+Dl4Mf4zxc7sWjKWeWSCxT+pKl
	T663xOQUU61vhfKMjV9dn3V39yd0kVcUwgGS10ZhExO1JbLrevQZ+emqVbdNvl1zDxQhU4/9NMz
	5pomsB30lAAIHWGKOV634RTTAd9x/fR3gZwz57IpMdck5NrFsJ3eI+edSOc5a/AZ5XoywfHUQrJ
	HJuDbTuJSo3KiEoP3brBnkWbI1C/LqsMRFMxrBytxeG77MdxY/kDI9QXL1rSv460k39RLuQx3K4
	ioXHaVmrxdYvkvdU5L1k6Uo734C4eENuUrpXIENNkJZJdo4Mhf9tpBLTeB/4TzW9puNKSYpzebe
	7lI925jzQZ2qogvIn7y+Ay3B+2vRSlAuXH5NENydU17rscPhBEPxie2GBkxfIqFQygIebczZWGV
	8EI8zEd8YJqZje2EOMix4t9Pwq+DQ64lt5poxXplpGnfGVcL/a3mGOaegap7z
X-Received: by 2002:a17:903:4683:b0:2dd:b837:48f7 with SMTP id d9443c01a7336-2eb3649f118mr95564035ad.25.1793622768735;
        Mon, 02 Nov 2026 04:32:48 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392492fbsm27101845ad.32.2026.11.02.04.32.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2026 04:32:48 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] cxl/edac: Mask DPA flags in the event record cache key
Date: Mon, 02 Nov 2026 21:32:35 +0900
Message-ID: <20261102123233.74598-3-ai@linux.com>
In-Reply-To: <20261102123233.74598-1-ai@linux.com>
References: <20261102123233.74598-1-ai@linux.com>
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

The low bits of the DPA in a General Media or DRAM event record are
flags: bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace events
report the DPA with CXL_DPA_MASK applied, but cxl_store_rec_gen_media()
and cxl_store_rec_dram() use the raw value as the xarray key.

User space reads the DPA from the trace event and writes it to the
mem_repair dpa attribute. If the record had any flag set, xa_load()
misses it and the repair fails with -EINVAL. The raw key also lets a
repair go through for a record the device marked NOT_REPAIRABLE, if the
DPA is written with bit 1 set.

Key the records by the masked DPA and skip records marked
NOT_REPAIRABLE. cxl_find_rec_gen_media() now reads the record, so do
the lookup under the xarray lock as cxl_find_rec_dram() does, and
return a bool since its only caller tests the result.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 43 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index c5c8dda20e..a5f198b561 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -918,24 +918,37 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
-static struct cxl_event_gen_media *
-cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
-		       struct cxl_mem_repair_attrbs *attrbs)
+/*
+ * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
+ * Records are looked up by the DPA user space writes back, which comes from
+ * the trace event and has the flags masked off, so key them the same way.
+ */
+static inline unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
+}
+
+static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
+}
+
+static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
+				   struct cxl_mem_repair_attrbs *attrbs)
 {
 	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
 	struct cxl_event_gen_media *rec;
+	bool found;
 
-	if (!array_rec)
-		return NULL;
+	if (!array_rec || attrbs->repair_type != CXL_PPR)
+		return false;
 
+	xa_lock(&array_rec->rec_gen_media);
 	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
-	if (!rec)
-		return NULL;
+	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
+	xa_unlock(&array_rec->rec_gen_media);
 
-	if (attrbs->repair_type == CXL_PPR)
-		return rec;
-
-	return NULL;
+	return found;
 }
 
 /* Caller holds the xarray lock. The record may be freed once it is dropped. */
@@ -949,7 +962,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
 	lockdep_assert_held(&rec_xarray->xa_lock);
 
 	rec = xa_load(rec_xarray, attrbs->dpa);
-	if (!rec)
+	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
 		return NULL;
 
 	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
@@ -1130,8 +1143,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_gen_media,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
@@ -1160,8 +1172,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_dram,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
-- 
2.55.0

