Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B732860F
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529860; cv=none; b=mr/xcXPpKBtAWgGqElJ2wNgSddP7p70YWgcW8iY7BepxfWPDFb30eeDgXTkfXFgH3FSn+BZomjNjISzUIQhfmfy3NxImYlvf/QE/Ex1W3Khzx4mt6WZGshxvvJiXzea2fDhi850waddgOmDYxty3T/k//eNeJn6DsvWcbRgcxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529860; c=relaxed/simple;
	bh=6YH0VSg8z29bgT7vuC21hIpLnKsIOMZukMbTGDrmXbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6vGN92eFXXODGDvFySwoVjjXnwChBJL6oqq03zmzGFHuaCv3tBrlULUJ5nK5jpQRW979uSHt532vyn81LLcNE1kkq8mVzZr5R0uQji9vKJVsYi2LFz0GH7dvCivdflFPkk10pz8NBpHVbHoMvaVuIV/G4Grg/eMsHw9G1a6A78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go+mJMkO; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go+mJMkO"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30455f77e0eso1450570eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529858; x=1780134658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSuhJuhrWfLqNYKOHdVj5Qj8f5x9bU9bPIIaF+njKdY=;
        b=Go+mJMkOGj8Ud80gVWVRJkHKKmN93yNikkfLQODzVWvCHzSAVWfWUXYkTU9TTY0I7n
         2uhnXL8DkKoW7XLR2cU4tAueHIyDI8unh6I1FvPoCr8+f0G7VRA7o5KI+pqKDlU1x0tC
         k/rogrfmvqe4I0R2gjoR0BV074OJBz1Ezcf182ShaD/SpLmbb6HkIPZfDRToijS9QY59
         o88w0hv9pCJ/5JtIW41qyLfoxsIo3mPpTt3wRKDE+58v8WnfrrtDG7whVgFSKilwgqW6
         WvzoyWjut+bIattzM92G79FrdnBymxOn7o0KtvqoMtWixKSkxX76XAvphEx48BAf3roO
         9nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529858; x=1780134658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSuhJuhrWfLqNYKOHdVj5Qj8f5x9bU9bPIIaF+njKdY=;
        b=rV440gJJ8ByeQxWN0KAA5evpF2+0/8K6rX8bkJwmqoR4aEVRQdxbskarY45mjQ5M7v
         ywK5IjlegF5g3ToUQuk9LsKzNVSNeyBOdBZv7LZV8/lltu8FW9JjkVwqJD8PWyRXS7dM
         7aXCcL1FfApLmmUJTnUtsZ6MUzB7bnOB6HRMrlzb5SqDRuWIO3wipdcTTR2TLSfOcBX9
         Bj/8i+qbVyvwI9niFCTQ/n03Lq0Wl+z5Fg0DCKGU5hnpwiVEcFvLMOmovr7JYGwdSzuY
         qzP9j1Rf+sDVUxgQ36w3hibwUbMTFjkLlva8D3AzJ8BfTeRRnhTvxOs34cniOHFgyd0S
         XN0A==
X-Gm-Message-State: AOJu0YwnXYwtFYrlFkKNx8N534490Ju9MU1UKP/SerwYZbEZp78hSemK
	/8vRriAKHqhZbGUzRGkI2Xm35vZSq/AjMJ98KbX9YUgAwTd4d06rJNnz3Vqr7g==
X-Gm-Gg: Acq92OHr2x2KH5unk98QOnIvSiz0TTMYiC/1mEgMCLUwN+3t5bPjKQaJo9a+oW3tqEP
	x/dQRdEML5gcLGMF/OFMmpClmUwfMyDsHlvskxi5TVe6JRlzGFmyyg2HgLXC9Bz7h9GUnfueRTF
	kHgKBCva8SHYFNFMEb57GRr/4x2EGmeX2/0On60XRvsdERrPROiLRwJALagomU46CrdwMVeckg4
	DS79wLLllS7DNdieB+u4aMz0tcTy0zxftUtqfTnwNMg5YQm0YA65eESQbKRwxjwVXeqly9DKfJU
	hOSLBMdxbWBFZVlPXhemjrmZcEqWT3XYejNkhAloT64yJqZqxKuSqXoA8H7bx7TcoMUa3dlxmZx
	fJgPyuK4u7piG0PAx5y+avwUM7rnwTGp0TwJvtsKXvjjnfePjeJqBBo+jgCkp8DVAFHEj/SyapJ
	lFf6+NH0aaaqBTscXSX+KyG5Y2akUnltL2pln6moDT06RbIE2xZAjRRRitWF9S0L/ENvw/W3s+I
	RFpohg=
X-Received: by 2002:a05:7300:cb86:b0:2ed:e12:3773 with SMTP id 5a478bee46e88-304491faf02mr3957866eec.35.1779529858372;
        Sat, 23 May 2026 02:50:58 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045225b7b6sm4595756eec.25.2026.05.23.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:50:56 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v6 3/7] cxl/region: Add cxl-cli support for dynamic RAM A
Date: Sat, 23 May 2026 02:50:38 -0700
Message-ID: <20260523095043.471098-4-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523095043.471098-1-anisa.su@samsung.com>
References: <20260523095043.471098-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

A singular Dynamic RAM partition is exposed via the kernel.

Use this partition in cxl-cli.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: New patch for decoder_ram_a]
---
 cxl/json.c   | 20 ++++++++++++++++++++
 cxl/memdev.c |  4 +++-
 cxl/region.c | 27 ++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index a925488..e94c809 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -620,6 +620,20 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		}
 	}
 
+	size = cxl_memdev_get_dynamic_ram_a_size(memdev);
+	if (size) {
+		jobj = util_json_object_size(size, flags);
+		if (jobj)
+			json_object_object_add(jdev, "dynamic_ram_a_size", jobj);
+
+		qos_class = cxl_memdev_get_dynamic_ram_a_qos_class(memdev);
+		if (qos_class != CXL_QOS_CLASS_NONE) {
+			jobj = json_object_new_int(qos_class);
+			if (jobj)
+				json_object_object_add(jdev, "dynamic_ram_a_qos_class", jobj);
+		}
+	}
+
 	if (flags & UTIL_JSON_HEALTH) {
 		jobj = util_cxl_memdev_health_to_json(memdev, flags);
 		if (jobj)
@@ -917,6 +931,12 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 				json_object_object_add(
 					jdecoder, "volatile_capable", jobj);
 		}
+		if (cxl_decoder_is_dynamic_ram_a_capable(decoder)) {
+			jobj = json_object_new_boolean(true);
+			if (jobj)
+				json_object_object_add(
+					jdecoder, "dynamic_ram_a_capable", jobj);
+		}
 	}
 
 	if (cxl_port_is_root(port) &&
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 6e44d15..bdcb008 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -269,8 +269,10 @@ static int __reserve_dpa(struct cxl_memdev *memdev,
 
 	if (mode == CXL_DECODER_MODE_RAM)
 		avail_dpa = cxl_memdev_get_ram_size(memdev);
-	else
+	else if (mode == CXL_DECODER_MODE_PMEM)
 		avail_dpa = cxl_memdev_get_pmem_size(memdev);
+	else
+		avail_dpa = cxl_memdev_get_dynamic_ram_a_size(memdev);
 
 	cxl_decoder_foreach(port, decoder) {
 		size = cxl_decoder_get_dpa_size(decoder);
diff --git a/cxl/region.c b/cxl/region.c
index 85d4d9b..3c935bf 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -303,7 +303,8 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 
 	if (param.type) {
 		p->mode = cxl_decoder_mode_from_ident(param.type);
-		if (p->mode == CXL_DECODER_MODE_RAM && param.uuid) {
+		if ((p->mode == CXL_DECODER_MODE_RAM ||
+		     p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_A) && param.uuid) {
 			log_err(&rl,
 				"can't set UUID for ram / volatile regions");
 			goto err;
@@ -417,6 +418,9 @@ static void collect_minsize(struct cxl_ctx *ctx, struct parsed_params *p)
 		case CXL_DECODER_MODE_PMEM:
 			size = cxl_memdev_get_pmem_size(memdev);
 			break;
+		case CXL_DECODER_MODE_DYNAMIC_RAM_A:
+			size = cxl_memdev_get_dynamic_ram_a_size(memdev);
+			break;
 		default:
 			/* Shouldn't ever get here */ ;
 		}
@@ -448,8 +452,10 @@ static int create_region_validate_qos_class(struct parsed_params *p)
 
 		if (p->mode == CXL_DECODER_MODE_RAM)
 			qos_class = cxl_memdev_get_ram_qos_class(memdev);
-		else
+		else if (p->mode == CXL_DECODER_MODE_PMEM)
 			qos_class = cxl_memdev_get_pmem_qos_class(memdev);
+		else
+			qos_class = cxl_memdev_get_dynamic_ram_a_qos_class(memdev);
 
 		/* No qos_class entries. Possibly no kernel support */
 		if (qos_class == CXL_QOS_CLASS_NONE)
@@ -488,6 +494,12 @@ static int validate_decoder(struct cxl_decoder *decoder,
 			return -EINVAL;
 		}
 		break;
+	case CXL_DECODER_MODE_DYNAMIC_RAM_A:
+		if (!cxl_decoder_is_dynamic_ram_a_capable(decoder)) {
+			log_err(&rl, "%s is not dynamic_ram_a capable\n", devname);
+			return -EINVAL;
+		}
+		break;
 	default:
 		log_err(&rl, "unknown type: %s\n", param.type);
 		return -EINVAL;
@@ -509,9 +521,11 @@ static void set_type_from_decoder(struct cxl_ctx *ctx, struct parsed_params *p)
 		return;
 
 	/*
-	 * default to pmem if both types are set, otherwise the single
+	 * default to pmem if all types are set, otherwise the single
 	 * capability dominates.
 	 */
+	if (cxl_decoder_is_dynamic_ram_a_capable(p->root_decoder))
+		p->mode = CXL_DECODER_MODE_DYNAMIC_RAM_A;
 	if (cxl_decoder_is_volatile_capable(p->root_decoder))
 		p->mode = CXL_DECODER_MODE_RAM;
 	if (cxl_decoder_is_pmem_capable(p->root_decoder))
@@ -699,6 +713,13 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 				param.root_decoder);
 			return -ENXIO;
 		}
+	} else if (p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_A) {
+		region = cxl_decoder_create_dynamic_ram_a_region(p->root_decoder);
+		if (!region) {
+			log_err(&rl, "failed to create region under %s\n",
+				param.root_decoder);
+			return -ENXIO;
+		}
 	} else {
 		log_err(&rl, "region type '%s' is not supported\n",
 			param.type);
-- 
2.43.0

