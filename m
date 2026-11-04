Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833353;
	b=2M8/jp7vGvLWVgHPMWvTEhAN4CiUWLSoC2PqFTtUtSOhqEs8vDGChAO5oT2V9LC8cWan
	 t483BpuMbeezgtSpJQMRZwrqz9Veiwf0mjYSIJUIi5w2xAFRkQ60F5kWkeVwssbvTnJ/e
	 vulYLmGo2QOjR2zUBlowI2Z2VSvigs5vknr0wRKCLa8XsjYOAU2CYrSHNNtMLYpqj4VVL
	 t62OBfwwX227RiuqhZ17fl0w0h1MS4IEu/Nyiduxn+GOZncPuWnlopvjMNYnxfjRspXmf
	 F+76J5ea7AdXGHirFZ/nr3B0baYQtTr+zSxUPdqMjY7fzv2KTmPiDWCgCM0avYGmA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rE6d1fjh9gAYO1BJRk5cgo6jEJphiJR3e20EHTFc4lc=;
	b=McPdcPwV4ao2LO5+2CChzMpZnyYcfio7kQgzqNQlG6aILnw+Y91E/dmuusYjsUMU+9d8
	 tMasVOyX4qlj9U4tDvKTYomoFz1uiM0yBH7TTWGAwyEZoq6olFjyc7eAEvLdNPFr6tNt4
	 +HhvqE9qyl6V62iKtkfxIolzxcdD8BQxT29H/rete31BGJbyB6tf+Kfp2vScwX9AwsUu8
	 L8kcHiSNoSox/UygVED8QwcbR94200rxflEureDNe/F4Hgr7hPpJxnLzTet6ymZJfojbn
	 kGnXBj6qfH3IEegyBcblhsa5l4lOpCw33a+hb3G3lJIT6kR8nK/8TwgBR8XRYTqJe6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VE0I5Ks8;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF5606D807
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11FF5606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VE0I5Ks8
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e5378b281aso8062555ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833352; x=1794438152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rE6d1fjh9gAYO1BJRk5cgo6jEJphiJR3e20EHTFc4lc=;
        b=VE0I5Ks8TWUCC2H5RzqpApE8DnFyiyFk8puTN36ac3BkwBMguW8nJjoE+AU6pHfCGE
         iNU821fR8Z5A3iSRdMUTTgeiuuub6aWFFWjoImiBjNINZ4gyvsuzA09HhzycdKlJQY8Q
         /QgZFqotNfcf2k7M2ni0joz+jd3NGVNJJR33l1oE1xEA6yNGGdVWffVHTYoGfj1RZslV
         G2H/+1RHtZLsnI8OPHhZnfUq99cPOTeFpZqHzcwAQsIPF6ZR9q8Xm3iSCfdQa43cIILO
         W5SSW/RTON4SZccJy9HhVXZ9Qs5P7Ys5FEv6EK2JpF5hQKVrg4OjzVwAo0I+7c/ASUju
         BnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833352; x=1794438152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rE6d1fjh9gAYO1BJRk5cgo6jEJphiJR3e20EHTFc4lc=;
        b=J4jhrYfySakrs8qwtjdvVwWyOUkdwsq42Fx1fhaTM+bpT1SwzvAAlC0wCbYALERiQ9
         qyvfPLNVCGxaH4HoXuH3grinXc1aOpe+dkqJCmLnuaL98/kDSUpMJr/fNaX+y31HxyjC
         l7fYC8yfF2ffio+VYCS0wWsp9XJHLn629JCTZL9FuleYtjPHLlc71/H6nzm/bRix468Y
         HDEVojPxP2nEq7Re23nVMU7HFhCxTlO6G6aS2drf36VV/jDP7GCfIS1tJIOK4zVcBoQi
         UX2eNdvouSZ5j3q5fWLkjHRwPkTv/W1mU18Sq2hQt9T3HI0wL+/qzC3RROUEwVSlbweX
         iQuA==
X-Gm-Message-State: APuU4Z9eGm7ptLAMMvVvHz6VwDpRm6r9hYE4BUMdLmWv4q0kYEYoZOOD
	iTTddousXlefHeeCq2/PeMNmxFzN1s6Z7Uv1jl1wARaBaSyVajQ0I82pfugzkkDV
X-Gm-Gg: AYBFou28r656SA7S6WrkFsfAdQiy1viC/gvbf/C+LouAosj6e9pqbD0hJfn8Zg6YbzR
	RelIflkUVZitQr+rXXoUPlUqod+1sEhnBwq1Q7TUw6lc8BUvCCfcJcamHSuZJoE+cbgR7VnJC5s
	NvX4sCsYiMKc/CtvO/YirmW77Ho5EmOs8SHVeZMJaxaycRdxLjJn3ipE47BDetROYWod9e3CnAT
	uuJPpYcKz9tX0H5/UFIa+FckwpBuZ8o+DHThWvcUh7rS6KfatJTYTdBEy97NrcdflXe04CZWWwx
	vcGt4ykBfeTTJLB4Bw94tfqpp3tr5trJaNRgCrrnOMp+Ht+/bYQ6gogKK/C1gqckZo0EtkH5M4+
	6WMLgEnwMOXtLmGZknIik8ATc8d/zjfHexa4X6Wrjg+1wAFvjHPhV76geZHK3XBz90hkUABnDdi
	5WXJLJeODqUABPDlXn9tyrJzoax459GRmJKiEilS1Bd1kvdgXwoQFBlFPfhLst07vSCjHiXSxHI
	Dd3TPjKCDfUcRHPVc4nJEpOsOCzL+yEn1cMJuK1AOXEc9P88csvTxua/zr95/CKDJIYbo3rhWNT
	42F1fqM6qZ2CXQj9NSaDFitV6fQLdA==
X-Received: by 2002:a17:902:c945:b0:2ed:107a:4f5d with SMTP id d9443c01a7336-2ed107a508fmr25016345ad.1.1793833352240;
        Wed, 04 Nov 2026 15:02:32 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:02:31 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 01/14] cxl/core: Return endpoint decoder information from region search
Date: Thu,  5 Nov 2026 08:02:25 +0900
Message-ID: <20261104230445.66625-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
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

From: Ira Weiny <iweiny@kernel.org>

cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
The search involves finding the device endpoint decoder as well.

Dynamic capacity extent processing uses the endpoint decoder HPA
information to calculate the HPA offset.  In addition, well behaved
extents should be contained within an endpoint decoder.

Return the endpoint decoder found to be used in subsequent DCD code.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  8 ++++++--
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/memdev.c |  4 ++--
 drivers/cxl/core/region.c | 12 +++++++++++-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 79918fde1575..8a81be004d00 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -47,7 +47,8 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
@@ -61,8 +62,11 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
+	if (cxled)
+		*cxled = NULL;
 	return NULL;
 }
 static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 39485b6bcb97..13a68f5cef69 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -966,7 +966,7 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
-		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 		if (cxlr) {
 			u64 cache_size = cxlr->params.cache_size;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 787988e92965..81f1e0441787 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -309,7 +309,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		return rc;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(cxl_mbox->host,
 			      "poison inject dpa:%#llx region: %s\n", dpa,
@@ -378,7 +378,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (rc)
 		return rc;
 
-	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
 	if (cxlr)
 		dev_warn_once(cxl_mbox->host,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..f4a9839c73d2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3045,6 +3045,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 struct cxl_dpa_to_region_context {
 	struct cxl_region *cxlr;
 	u64 dpa;
+	struct cxl_endpoint_decoder *cxled;
 };
 
 static int __cxl_dpa_to_region(struct device *dev, void *arg)
@@ -3078,15 +3079,21 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 			dev_name(dev));
 
 	ctx->cxlr = cxlr;
+	ctx->cxled = cxled;
 
 	return 1;
 }
 
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+/* @cxled receives the decoder mapping @dpa, if any, even with no region. */
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
+				     struct cxl_endpoint_decoder **cxled)
 {
 	struct cxl_dpa_to_region_context ctx;
 	struct cxl_port *port = cxlmd->endpoint;
 
+	if (cxled)
+		*cxled = NULL;
+
 	if (!cxlmd->dev.driver)
 		return NULL;
 
@@ -3096,6 +3103,9 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	if (cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
+	if (cxled)
+		*cxled = ctx.cxled;
+
 	return ctx.cxlr;
 }
 
-- 
2.43.0

