Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660574;
	b=SGdzyzHsXoc9sI/HXPERGAxGb/pyIeqLkypM4p+/9IZizWhV/oSVcVm7C0WRkPtG6ZS+
	 vsnqF83lqA8jlfPwFHUopV6poJua610LWjKxQaiQZLS10Ksd9Y3iccv6H3YIfLi6HuvNa
	 hD2EUIii+Z6HckYAz9HaiF/h344vcOfxH76SrO1u2/xp7JUnOWluEUGdiBMj28L0eGlhB
	 QOddEo5mXpwiUu5kk+/vg4qZz5A0sysVv0K2rUoKalFny8YW5jXK+HW7RNs4c+UJAL8li
	 dOmB7BVztm4ZZbJsJs//lAUupn00fH2VK7tfGtIrFlWedVYop29zlSv1bpemzquS0ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660574;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/QPB6KdEon9Hls7KBc1ZetoO1hG+IGhWAru13tWVszM=;
	b=m1WCCb1ouJI8lOKAQWw51uA5uq5lwD+RlXaHDTYLSNnHHG53b5Iuw0DjeSyLBFkfWvgO
	 qfqt0KL27kfj29pt3BhnUlrNihnoFnfiefYjvqqoyHXEv3Jp/Ac5YJh3Af8Dk+e+pA3cN
	 2NrpODPtJ3hvZ4dGKzqvYbH2hdZQXjS2PmjaHug933OqQ/QMb9MHVgG07Q03SAMRhtjjw
	 d6itnQknn2xaeQp6x6VQSwTgwYscGYbNZ5EWfsLRknK0IGDrSBMxdQ99BUnVdUtEOVgeZ
	 UotihJ1WEkcLyUGbbg/+ZuzR7Z0Lj7gF4G9W1SKl6EOo0y7QMruoxPwrop3WMB4+CtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA86606A31E
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385c497bf94so4379456eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660573; x=1796265373;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QPB6KdEon9Hls7KBc1ZetoO1hG+IGhWAru13tWVszM=;
        b=hwwifSo8HtdlskMY0ZeHkMFBXAjOV6M8RyW2hcqpISHxjlgXzEU22BQVwHPjYSVSVG
         9DRpYAClnGzvWB/oDw7TAK547/5U2YfFUYRaVsRln6vQpqd+hUVyOGxZ16xQGecn6ez4
         yErt485ijJxyzXdO3Rh4Y2nkeNZaA91aaOG216kpBdeQD48HnyVHotASJblu9cM7GXQ4
         R7gmAC0jmKSzEuYs56BfoKAb6qmhVRWayA2byRRNJNG1a2OBgsuzLB1wD9Bhd43Pbdr7
         NC3jMon5XFbk2khpP/6V9ifNSZqV/DlVY2nrVIsWDOzCaEvBct30/VgeDNvh4zt4ZWgm
         900w==
X-Forwarded-Encrypted: i=1; AL+hErFCVtf2OTf8rTegj7ELlzcrU6kI1L9d7DTLizCQf4HZnuTsuZDhrJSRiipPMfFNFtZxph1iYMOUTtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HQIMYoTOKZH1yMzQ78FwK7xp/VxtsY+Wh5rskXOwl5lh+Rnrl
	J5HiXxDofZwuT5StCZQaT4TGJyTb7BASRLgv/y99FhvWou6JNVwKHFShiRLA68uLl4Y4
X-Gm-Gg: AZFdTZd3R/eY9XeB/aYBXx8aAV7P2MSTxbBR1qQoecuAfoeFksMBn/Lsb1pb6W+vmVZ
	qzFJk4jVb7OKJOtJC63Iat84EiJe8r+VLpKcKRZ99MG4xzXTekDa2x44euwgQDFErFHGQwr6Seq
	OMOqg+LRyLBdk7/tdAQkKmk9KRY9vBN+yNnO3L6DtcDaSIlNrVrQ1whjhZBPUyvSgThATqB5P97
	zLX7+j3LhXFXh8U9Ews9FXjx2VIFtRgTa4JizS7CZ9iECGdkx94+c6HIK6xJJtMeZ1RYTSHStP4
	0IXwvJY86z3t115OIH8J1ykCQEWa3RI4h1oBgssor+O5Vs9ObRmz4J/9k6fZmaBx5BmYCe4B3y9
	c/AWSgGd98sgowwpfTC+FXD0bcD3MpirgEvexZlY+KgXe4Su5JCb+4vTrXRzMZWYEfsJSS7Qtsn
	0xVV/E18iW1tsZLFUjL176S4JgYBlsqpUMBePmLhOg2cVJdYGAmP+Wsbp/n+IoThK708ffkyy0F
	GjeJ6htxaF3WyUbBiMX/PJkkDE6DQQKC4gCqX8Cz7G3gqT5rkQlXQ4VG0JOThtZCAZxu3n78sw5
	fb1ITOIXljm07I07aN/KzirXKsoVq3BWd0Ar/C1QaYXFdNozDg==
X-Received: by 2002:a05:7300:2728:b0:383:c2f0:e753 with SMTP id 5a478bee46e88-3856c0d0a68mr22802373eec.3.1795660572514;
        Wed, 25 Nov 2026 18:36:12 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:36:11 -0800 (PST)
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
Subject: [PATCH v6 3/3] cxl/edac: Mask DPA flags in the event record cache key
Date: Thu, 26 Nov 2026 11:35:23 +0900
Message-ID: <20261126023520.39368-4-ai@linux.com>
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

The low bits of the DPA field in General Media and DRAM event records
are flags. Bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace
events print the DPA with CXL_DPA_MASK applied, while
cxl_store_rec_gen_media() and cxl_store_rec_dram() use the raw value as
the xarray key.

User space takes the DPA from the trace event and writes it to the
mem_repair dpa attribute. If the record has any flag set, xa_load() does
not find it and the repair fails with -EINVAL.

Use the masked DPA as the key. Records marked NOT_REPAIRABLE are still
rejected, because the lookup skips them. This patch depends on
"cxl/edac: Skip event records marked NOT_REPAIRABLE" for that check; if
this patch is backported, that one has to go with it.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 7aaf1242ba2f..411d586c3484 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -925,6 +925,16 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
+/*
+ * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
+ * Records are looked up by the DPA user space writes back, which comes from
+ * the trace event and has the flags masked off, so key them the same way.
+ */
+static inline unsigned long cxl_rec_dpa(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
+}
+
 static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
 {
 	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
@@ -1141,8 +1151,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_gen_media,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
@@ -1171,8 +1180,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_dram,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
-- 
2.55.0

