Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793463090;
	b=Vas4A8MgvSHWzpV7fdObubQ8cmzYy1VPVmUUEQlfSjgpOK27GAhh/rwvLD1bkaLQyNrb
	 6V8RJzvUoEU2w9OpbK8cPRPoI+msUMkD6gApEf3FLQ6nw30hWHeTTpGZjMUmYIi1A8cvh
	 jlHoRhhGr9zHZU+DM+vRQoW+d+yFp8LWMc73gVSCnDSrPFxNWM44/r4jsAjnhyLKzEAjD
	 zIj16B4D4/jjMi0ow4CPWuBk/2BquFIIXx3x4UpzV9WsCKVIGm7CxuadOyst7BDh4Ydx9
	 muoYRhSqBWepa7vN6uxfOEBhlVZKBbNLzp+EVBfZjm3NrQ30e4FIDusL9WlG1mblw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463090;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=J6XXVdZ2sRu/Aglz0WkyROyyzIAaDf4Y/GZJgKKRZhw=;
	b=cBnJ8aNLSs+B8Tj0vPFa5Lk4zcZSN9kxqXQlBky/9L25MMtZSklHHnxCIwzBYh/JyZcn
	 /TBNncWmfIpkgxl74ydTv4yTs3e8sXzlJWkQKCVwPx3BG588Mzkql15hsK8cNSNpJs82S
	 VfU6dpZPcSrn3v2aCVQ/UOPmhT8onxabQlH1grehyet1S2YBkXfEi0hQhlcjE6trXyit4
	 +BpVH8taGO7yBYixK2Miea3mG4fnk67NM7YhD/Mx5/JOKPMGLB9b+/kc2GXDzLLMp2CY5
	 tl2TC5Sl8u1PSwYMEwJLwSX5BVQz5ttMnoiLC+Uut7HU3/wDmysuGE3M9xyIusaQbWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD31606A324
	for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 16:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD31606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-886e61fa30fso651260b3a.1
        for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 09:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793463089; x=1794067889;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J6XXVdZ2sRu/Aglz0WkyROyyzIAaDf4Y/GZJgKKRZhw=;
        b=JK4zS7Jd+cCgNogw2FWEGSUyviKu7lC42cK9p2BkuZr9W8wrCapUz0ONp8dcN7G++e
         +MPamnuvbS6X0ejOhcJQeyJE8cIHM5sFf2u5mBjMPKzgFIOzFVQA6eSKrtNwtEesvLG6
         e+QkvZo5j+md0jl2L5COd/7GEYL30DjpPi/PzPqQD5jIOcogLUSh6W6qdORFKMr2vUOl
         WYAbrngRlBqfSbeKgl5LKlYH94ZuDFSuWWD0LitsAQAWPPxSafp///PRQTfGM4Q9vx6I
         DjiM4sYcuqg+SBw7WqWYg3mm5BArgxFQrH10mZlRljwFz9/W1XbAE1lq7gS6OSmzQObm
         RXAg==
X-Forwarded-Encrypted: i=1; AKwUvBwPmz9cyF7pGH67WlwKqphyepRrbDonGL0DO+jetjJxOl1kaQztzx1R5k7sgb0MpEHzDl9oykKtf3Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeTktTQyhudSvT++58BPEOpYxVlTNiyx+ZX6s4tDTPnwq4Xs0m
	6ZDrQF0lj21gJGTUFPp0Vbr3itd8jHEVutjirZD+Y4hAqjIwSQNnNuaOtriYPOlO8Iu3
X-Gm-Gg: AYBFou2l4j5YpW4mMk5bH+MKkWo7O7etholto0AvUxH9H3Um3AXKUVwrbrVDsXlOUXQ
	XghzoB2MIj67Ta+kMQxM9PiFvRIXMsI8M2rL6rPJ0doRvUuUzCmTn9K5QUnVSIxxqeaGvX79x6j
	ivmNqilInKKYkvBzKPIzLELUBQ5FdyWSfH41EmTrp3bG9U+etVWLfFZq47Gy5DJP1htsz4gR2Ws
	1M5SeZYZjKTwyf7nCV5j4dCyZ9+T7d21LCZkaFJ31sTq4PjOBqxPPVZJ+wGRXkV3sY2/KWVazib
	rMzu4KD6gJC8sCst3jDeRnZJOc0Jp/4Dz3wjLTgEcY+eVge7rFDAtQ3xlLmcBzyXlgRKSZzZGL8
	OuxLIkpmNn/50NpBaoVEVc0AX7/4OHQHx7GrjlE3bp74MkhTBr05tmMnMBMTzG/UF22kjvZGvcP
	qi5gf9e9ecvA2FNv1hdO7FaBjW2CiPtZKrBKkynTezzix/uNA8WhXp7DdKG3ibQ5npHbYGOPE3i
	HlHD+yY3p4CX260Lrue2UUK6a31jmYUm4QXFjxR8X4qW6+/tTfQNVg1IvGnNVIh4zkZXt6Ved39
	3Xxrp4CWl+xxWGeFlX/6Hwuqkt20iEmNmtdFgUS8hu4vHBaXV1KAofBQbn6WhALJcRg1moqauNP
	UgUKemA8u8nmkbl4c+U8DXb7SaahuCWBP/glFpfQ=
X-Received: by 2002:a05:6a00:9a7:b0:878:6ee:672b with SMTP id d2e1a72fcca58-8a9bf04f139mr3954262b3a.35.1793463089071;
        Sat, 31 Oct 2026 09:11:29 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d6acsm812368b3a.18.2026.10.31.09.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Oct 2026 09:11:28 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] cxl/edac: Mask DPA flags in the event record cache key
Date: Sun, 01 Nov 2026 01:11:21 +0900
Message-ID: <20261031161121.15948-1-ai@linux.com>
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
NOT_REPAIRABLE.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Jongwon Lee <ai@linux.com>
---

Notes:
    Changes in v2:
    - Moved the Claude Code note below the --- (Dave Jiang)
    
    This patch was developed with Claude Code.
    
    Tested on QEMU master (b574eaf) with a CXL type 3 device, region
    committed, KASAN and PROVE_LOCKING on. DRAM events injected with
    cxl-inject-dram-event at 0x1001, 0x2000 and 0x3002, then a repair
    requested through mem_repair0..4. Same result for all five:
    
      DPA written   before    after
      0x1000        -EINVAL   ok
      0x1001        ok        -EINVAL
      0x2000        ok        ok
      0x3000        -EINVAL   -EINVAL
      0x3002        ok        -EINVAL
      0x5000        -EINVAL   -EINVAL
    
    No KASAN, lockdep or WARN output. Only DRAM events were injected; the
    General Media path has the same change but was not exercised. Not
    tested on real CXL hardware.

 drivers/cxl/core/edac.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 34b81e8dfb..b3dfc33ca6 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -918,6 +918,21 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
+/*
+ * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
+ * Records are looked up by the DPA user space writes back, which comes from
+ * the trace event and has the flags masked off, so key them the same way.
+ */
+static unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
+}
+
+static bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
+}
+
 static struct cxl_event_gen_media *
 cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
 		       struct cxl_mem_repair_attrbs *attrbs)
@@ -929,7 +944,7 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
 		return NULL;
 
 	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
-	if (!rec)
+	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
 		return NULL;
 
 	if (attrbs->repair_type == CXL_PPR)
@@ -950,7 +965,7 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
 		return NULL;
 
 	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
-	if (!rec)
+	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
 		return NULL;
 
 	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
@@ -1105,8 +1120,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_gen_media,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
@@ -1135,8 +1149,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
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

