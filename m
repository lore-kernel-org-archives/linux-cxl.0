Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496876;
	b=x6v+5Nm+mj0y60VuYmjYH28kqsQnNMW7CkvToAF2sXI9rGoSmY2L7YdO6meKfbIMkTu9
	 vCiYR8kCB1o41WvzBhTeHzpsiJp4yL1mK+wXYnX4CSWw/N9KOAmsXsOum2ea9JmOFnG3h
	 600ulZGtTiSxUF4wUNVzqHtyi/NorpwLwkvsyG6C/hCiAIh4Sz7HEkin5lgrOYLLyuUKq
	 oHrbPyoLgRygQr4MWP0e3MF3BVjxgcHR9sqbHS7LudLvLQ9vtRfVnb37dqectbO6cu3y3
	 6bEZs2lR2slLQQ1x6KuydOw5zAeFvYjsCDUOLzhKPRZhjBNT4oGpPIImPqAGjvfXt3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496876;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9IJ5Kz5Zp6zRcvTEXTwAZXNkMiKdhVQoKzRKESsvxgE=;
	b=WE6xwcjLc01bjqOWir0P00riUvooFzhQhkFpDxYNzuaGNAGkOj3VcqwTwu+KxUeToj1s
	 TNahE/m//67oejcxgcMVdL/tQdavVXoCK7uX2eut6hLi4sHKjXGxFscGc4czHfu7p11ff
	 6iZKtckuMwU5CT7zZz3lwZ4ugdz8l5TuxMNKVFxkZMTp4eLR12XvjyvQZNzfUVlsi4kMi
	 vNB9s5+89zVGz3CWQdMcf28uV9jaj1Mp1X1xyXngh5QswgUeCc14xzkLrjvNzm4TBukeZ
	 psRpjtwRtJuT/IGninfhCjXpwueGP3IV5Qa3kTmkw8S7lDzRqmQ3TIaq951ym8ErfTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFD606A31E
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 01:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e5fb79ce82so12349825ad.0
        for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 18:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496875; x=1794101675;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IJ5Kz5Zp6zRcvTEXTwAZXNkMiKdhVQoKzRKESsvxgE=;
        b=xX5ZXe/mZce9w5KFQslGvK9DYBN6zcgap3PiwlkwjbqGsDw5h1ayCkC2EHHui4fMFJ
         Y1Zkmb/HqR75yu9RaQI9kTR3VNcZXno3ANLtWi0lZM/4Zov6yWcIBUCdrbBQEGzPmXez
         vXiVxsC6efCkQtG1/OwP9N+rOBl8otZ3JywDbbtqO57mELedAv8kAjK28kfjPCmzj+KC
         EKnlQDfw6UbSZ1urQXOW45zDjYxhC4NTpwHX3ono7ohVAxtsAvzlewPe1XT+PFNig0Zj
         2Pmj4vJfwOyAFsNB1/orPc9mI5YdDRyvZnTgu0tqYyeGkJmORPmBJe/D0gGrxKqoFHRT
         uTqg==
X-Forwarded-Encrypted: i=1; AKwUvBxck8z5TwCkbi6g5SjV4mmodnKN7g+iQ4ZgU0dsRTVezFQnKZ7dsF9j/D+w8tyuZHUdvNC3QQc6lq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ikpmh1nWqpdKl/YilbBZ19H6NsAsAPpET0k145muTcHvwfP+z
	3zMoO27D9qUz8XgM/p0p0YZ4nt6Jm+QPrkkc/XiFwVTIdx87CVUWYo/DYNfQj8ERXQis
X-Gm-Gg: AYBFou3ccq75bzoZl1zM/lQJUph/C6ofMlavKV+ywjakmoz2NupYbM+FlPHojE2e2er
	qd1QQALlf6eSa30ZqRdSCvEED/MNZ122Fm9qMabrkfd81jJJ5smIDKpckoTD8lo7j6W9CwLSjqV
	c+vkKhF9KevJiBN1VFDg/k9AtvfeAcyTIkM/XQl3oj+Lj7vRMeasAMYudb/rvhtXgF2vkJ6NQfU
	JzwaNMXC2BADpQf5rTcKvcdS8eydqCWmFLVlHhftOtpcuUAGaEYPV0YivRcOxIsvXcl3035Xvyo
	n6yjDCcoRsGwZBSpT/LzRE553oXTHw46AvnapKpshcNhstMCTgbBAIbVPh7Xx7y0dujYV2qNZKB
	fpgnmMhL9OzPj06CZ9RVk0caFsDmH1IYHQG1kuhzUH9X+lp5Aq30CuXy5CzCWcfvDdNHC2nnDuM
	rq5haCyolIf61lWCFa8SSBt6cM7hXnHJr4+4/imccU5lp1mM1pmlSIarESCItUfEreGrWnZiFE8
	nLs3AZ78/iEU6umqDmTXtPSUsRoJX6S3Z6N1hrWhkh8exx+4gda0JulhQWmyvf8RMJ5/B82ai2C
	BOyiP01vvl1osR1j93YkwiI5d7SLwepw5YoiQaAmK2cVgbKeymyoigPuW6J2rj1PuaC9wDPP+fB
	ZFBLhW6qWUxlUsll4ymWoW/L431yph2IvpnsewcY=
X-Received: by 2002:a17:90b:224f:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3ae8976f156mr5587601a91.42.1793496875276;
        Sat, 31 Oct 2026 18:34:35 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm8727943a91.17.2026.10.31.18.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Oct 2026 18:34:34 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/edac: Mask DPA flags in the event record cache key
Date: Sun, 01 Nov 2026 10:34:20 +0900
Message-ID: <20261101013418.87326-3-ai@linux.com>
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
index f0c12871bd..94d44a3dc1 100644
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

