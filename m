Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345249;
	b=RxZk0TbJGUAIHX/oraybQE2XtIxJ+8KmnH8BXdQ0MkJF8BVs0A8Ax0ovtgQy8Izp5XYq
	 xEdsmzdAgsjJ/QOORtAgcjtt2EOZ6kdXAzuD/9+dQlxgqqPkyfgCfuAdI2ZrBpgHdQVA7
	 7Z9Ivejj/VlPF0xv5X/rIp2hd6HZRAl6l8ommbUPLNTVl/0ERf71w7bG+jElXvwYLSgiM
	 8vBzfZusJSFvubio4rR+V4Lw+2ZbWkE5Q5o7h4vSBxohX6urDDUcVXzzFWaMtMxrVVPGQ
	 W54onJwdE7GRk8SaEcXZyOcAVpU8KLYM3aln052VZfBi80G+bE1IWyykTGX8yFC0gnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345249;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6O9nBSIoP2u3yOwnerkPj+AewG07nffiGXPyUnk1aN8=;
	b=Y4DxYJouL4UkAHDG1sWwcUBtsMVu1bi64hOaIJyrxpvkGY2T6u5d/eq3WbbNbTQxzAHp
	 i4lYwvhHmNguXq/0Sh4gR6VYhZ9E3+V5CpslK5ZsXapGNmSWXHEK7FNvJGYZl8yPuSvC6
	 gHRy26Ej+YghYv44UqNqRYUaaHND0w2CQlY4ude/QFzeiPdUL9X+okeG4uR2adES3PCwg
	 X6eobrYrH0tNwPOjGZmian8PEYS/tidPB84y42MvRlDB9wWAXP+PW6IXp+Ml1Y60iYDAT
	 kUWpojuBA+fHMNBZLW5Bm+vYa4GSQ9UYCCP/sRhAwVU99zPSmOfPLB8d50c9xyinMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC4606A31C
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 07:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73AC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so210188b3a.1
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 00:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345248; x=1793950048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6O9nBSIoP2u3yOwnerkPj+AewG07nffiGXPyUnk1aN8=;
        b=yo6++ayeZPzDrjeaCk0e2ewzLQE7uhlkeX+h/ZMM9sncCx2pWhXe7c/HVcrkJiArNI
         q0EaylWk3jWu5eW6/+sPsuarCuoQHPkWHVRW10NxYdusMKj4F4V9OOTvZ2PGhvY99Pp7
         UdvV2KMdpnCcDE1yfoZXwlIrZqWp5Lj66pblyacF3ywzUqbD9815W0PNHG+Dz/GXo6Z/
         0wGxZ7iNVuc6gQhKozgHNOqhYkepSIpj6qFeRe2wqKQFN3CNbcIqG/4aQ42FkNgpUycz
         gbpGPr0qRVzXrg4QGLwBQkaJPQ9bGuRUWNdILjpDADOw3cu4k3JPhYLZhsLVdRt+jLTP
         e2Pg==
X-Forwarded-Encrypted: i=1; AKwUvBzcAbArq53wN1JIHNuYPCNhAL2m1T95hEjrOFFzE4U8iV50CfwXwvhcwrEKfRh2YfngRrb/dQdXDc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZn/C4HLiO6Jdp9NWwuXKmGu2BcjQv5y5JW5NhPr5t3b3Wng2T
	XeVNRbTfTmnETdsHeqx2BpcKaQNNRDt/vXyEerJf4b5tCr+ToJHuL3YVzCpeRqATNlGZdKsgXtw
	tQWZevJIRSPXANg==
X-Gm-Gg: AYBFou0l/tG0ex5IBkRYqmfUmRJQttothzdDy0cveyQ0lBFTlgLH/PqLgwA5UhpRmPo
	aYRdXatt/Ywy0FBbRBIYRSwri8ocucL9OF4Z/IGKhf2/3mFtFgky0PKTwO58er5PpABI0mPf0On
	CdRNuU2KvD/wZzYZ5fpPmIK4lLjML5ACxMuQYqwWgsP36RzRThqPE18o8OqtoD8aiMdpDaNQkkv
	VYg58lqlocgH7PC9cNF6GolQQdc19/t0Q/IJuraZKNpWoNqlfdj7vY5dBVVDS+b/aI1bavkd+cT
	MgIxfYpr6+IEhi0QaoS5u4fnsvOYTRb+AP4XlxAr+YtiZDscM8ptltry5zaGSt8giD1TuZV5LQc
	V0dQBsh7u+h97OpWAwbdOvzpTXGjHz43T7HG+IjRWQCh5jlUneG66Eib05vsSz7V69WvVdb1hqm
	+bBeUmpfMc0jAg1BAmzGBOgMmiI5FXb3NohHAT0TLTgqBREQYKjM4Jr8+mNCe0shMTH4y9t84X+
	T7Tb0hk9GWIhXTwiR/a9LVwxFE3sBbbcQkPIxjjh7RvSmBl7WliGki65uD/QelBKTmwRd+GPGkT
	OV7t6AR9j1rFXy9i0rpYY91eg/pipKujCx3Hwbk+ogFw7w==
X-Received: by 2002:a05:6a00:1389:b0:881:8b53:f66 with SMTP id d2e1a72fcca58-8a9bc34c20fmr1396753b3a.24.1793345247635;
        Fri, 30 Oct 2026 00:27:27 -0700 (PDT)
Received: from localhost.localdomain ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ef952aa5sm411665b3a.34.2026.10.30.00.27.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 00:27:27 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/edac: Mask DPA flags in the event record cache key
Date: Fri, 30 Oct 2026 16:27:21 +0900
Message-ID: <20261030072721.31970-1-ai@linux.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Co-developed with Claude Code.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Jongwon Lee <ai@linux.com>
---

Notes:
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

