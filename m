Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AC26D4F9
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871645; cv=none; b=sGbYCKdqEpxbPDfZoRbpNo9mzXDJhnSmuuIXXmANlETD9FIAbis0tue8z6BfFa0gpOAtNDdItiWV862AJN0aIgq3ZcPSsbra6gOe1tkZpV79t5OwXRIRTEGNuUwQz+0qXzb4pYT4ay8MWXc7cgnpG0/Qvax9dnKR4egl+wnaNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871645; c=relaxed/simple;
	bh=CnUyb8K4IKoNoHwuP8C4pP8dLJcnwQZOS7vxNgDK9dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toeRuidOvpET1Stnkv+XAOIwx61JjXyz8J5Vf8CCdy7qdg2lGT8asEFpHO8dsyyfyWJiT5TT0Z8RBvcRyO2xL2eK9bjQ5m4R/H2/b3cVHMIFDIlWn8eOCkCMpC9oHOhikozscwcAmWTbGrO4iPLOA2uxCotow2PJQd62uKQsn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbFKBIJW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFKBIJW"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7a43424f861so22787047b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871642; x=1776476442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZemOb7Nr3A613tO6Z4B+BfUUwzc//YehLmE03EZx3Q=;
        b=YbFKBIJW25a2nZOcGJtqTNU6tepbCAsyPs/JhoeLn2yfQbAJnWCzAvfCRUHAkXC0hE
         pcQeDaoffwC0gwsqyPDes0iOAHsGiXHjAdLsYoxMSEJvXd2wOIObpAyw5POaN+qRikAN
         KW7vO2d5udn0I4knmHvE0NRIgc1H1KFZnuFf88Uuw7jhbwAu1EHI5IxMPAeUwSVIBZtw
         aNSwWo3fqe77pmgZW5XwIQcA/GguArdBJLQ7yrAfdjKpQiei2qb9ba8k9Vk3BQ6YxiZF
         jZPTA1m4FViwMpWwnQtJrRxZXoeHLNp0xm4nWYkLWFdYFhEOoeEoYuemDs+fPwR1YZc8
         S7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871642; x=1776476442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZemOb7Nr3A613tO6Z4B+BfUUwzc//YehLmE03EZx3Q=;
        b=L8FHvRQUkRBQhZxNn+7qpXpQ1aA0rUVz2jJ9B6IRkPz0WOTY66kXg4TxgeI+IVjxsG
         e6fenJJLXvlHVzS2837pdbr4AQYLoacFVe/UouSBjLPQLmqZeRiUd97fFXne8p+vfTwa
         f5iRIzVbYUvfuWQ80XQkEddW7tG9CnoNT2HIW+C10KSg1PezrTbtzAHkmtW5QdM/1H6t
         YZcxeu5LYuEKxzSpqFB+ajqcBib5Fsn6qWnRg8bWjg7vWklPBzQZs0xUdHUEiPPSFoaT
         XlwQELXoQZttxXKJJzvHGicyEqiQx+F2+DeyCRF2SOs+lO7Ue1ze1zvcKmG3Od0XhduM
         mjtg==
X-Gm-Message-State: AOJu0YzxJ7AJ4uI3/SaQ4ZTyoCJUisFbMujQ9DGwy+v26uHtFAZ8j18D
	/YV95FgsYMmtpiyKk+dQ0hsygx091iRAER2wmQCY4Ib4AObGlpw+i7GFnXOXUg==
X-Gm-Gg: AeBDies9+/cKwLe2OnHeY/mG2LNCtsBtX2Iqz2NAE3wO00ShDysHN6RdTYLRa5MiC7Y
	wSozRVBBg1bnRoXpqyOeird/ZXgpQk1zG1w6zo3+VD7DgcyPy5jSpdAfYGcIgTqA9rWT1FZXeof
	66spzCZ5d05+4n6lSWfdNCeUMaXrDDr16yA/I8CDfKQ4nNNqVdYMJa4u/DYXPCS/8TmemsZS+9N
	J+wovztV2WMCb4oWdlr4ahTLqM/nHUXMQhuvQGOLkHvZj420FbkVhH82lknEbFYQtIECIh/8UA8
	dtieuKeLyrUutI4wkLh19xTu5BJ52LPU6uBdEgQ3N7By6tYzBpXan3aMIKfKshz5A83dV5zk1VM
	bXNvYj+W3vSip4XzkJ63F87rUezZjqidxht4T5qhJ87V3mrtp4a5cmDv32lcnP+fP7FnoMM3NPf
	Ex1AXcBEOD1xCmPIRGLtHrjMj3vNRkqHnoTf5Jvi045w==
X-Received: by 2002:a05:690c:8d05:b0:79b:e1e1:9e4d with SMTP id 00721157ae682-7af71e4e8c4mr50472217b3.40.1775871641767;
        Fri, 10 Apr 2026 18:40:41 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:41 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 11/20] cxl/core: Return endpoint decoder information from region search
Date: Fri, 10 Apr 2026 18:23:06 -0700
Message-ID: <20260411013958.47422-12-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
The search involves finding the device endpoint decoder as well.

Dynamic capacity extent processing uses the endpoint decoder HPA
information to calculate the HPA offset.  In addition, well behaved
extents should be contained within an endpoint decoder.

Return the endpoint decoder found to be used in subsequent DCD code.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/cxl/core/core.h   | 6 ++++--
 drivers/cxl/core/mbox.c   | 2 +-
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 +++++++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8881cc9323e0..14723cfd05f0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -58,7 +58,8 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
@@ -71,7 +72,8 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
 	return NULL;
 }
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f9a5e21f5d09..01b1a318f34f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -968,7 +968,7 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
-		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 		if (cxlr) {
 			u64 cache_size = cxlr->params.cache_size;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 064cfd628577..b8b3489f69e5 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -320,7 +320,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		return rc;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(cxl_mbox->host,
 			      "poison inject dpa:%#llx region: %s\n", dpa,
@@ -389,7 +389,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		return rc;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(cxl_mbox->host,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d2ce844a142f..e00fdb74589c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2991,6 +2991,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 struct cxl_dpa_to_region_context {
 	struct cxl_region *cxlr;
 	u64 dpa;
+	struct cxl_endpoint_decoder *cxled;
 };
 
 static int __cxl_dpa_to_region(struct device *dev, void *arg)
@@ -3024,11 +3025,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 			dev_name(dev));
 
 	ctx->cxlr = cxlr;
+	ctx->cxled = cxled;
 
 	return 1;
 }
 
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
 	struct cxl_dpa_to_region_context ctx;
 	struct cxl_port *port = cxlmd->endpoint;
@@ -3042,6 +3045,9 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	if (cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
+	if (cxled)
+		*cxled = ctx.cxled;
+
 	return ctx.cxlr;
 }
 
-- 
2.43.0

