Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21A2FF672
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339943; cv=none; b=EewtEESi8R+n3Kyi4hpXOagi7oTJRXEDXyRo/qUJrynK992jOp8bS4QIqr/vytwmMAFueaMiYVflI0/e9r+UyQXJpUniCOKX/1lzZwnYwkQhOiFXO6ln8oxyxJRILZZ/41OGR/EC1eaHN09gZ+ZhpYWgdseiP26nHnVPJSbgwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339943; c=relaxed/simple;
	bh=67f2l8+Y5bz8I4g91AcfEcd5o3gZzXNDXTeDSIIu4z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXLy49ChJb1qiIJ56H8KDa5EsKJyki24JU+s1LulaGclD0gLWm8X0MNy0ZfJyQGZV6nciYFALODJj5uAL+mPjonzUmb1PF6vA0HctouKeIgdzhC5pI/pXsFqBZgAr79eU0qKevCR/JDLcwp46jV1qcGYIHlfUwf11sTf2WIM3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/KEgKVa; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/KEgKVa"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so279423066b.3
        for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339940; x=1761944740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqJFC+NNQsYqMZ+tK6g4G5+TIVlZWFt0dur9F2fI5/g=;
        b=o/KEgKVaaDEL5auxmnfxd5IXA4cfPb/znd6RhPQVH68OAIPe1CblEGLD9Ne5P0ihr0
         kOHcE8qh+jmFufI/mDvKWfnG+URdE2VfRZ3OIfgKbIbBZC0sYwiYE+dsl+EZJV9PzhHG
         59qlxxwv2OsNA5mkqKu6SgVSvh7hJ3eC4c+xklExmgWIHpf2PzaO1EnB9yehGvyWmhM7
         QKBdBvHBaSnzYF/KOibzXgesGtG5iJdQFXP6V56GKssHkGTdnbmW4+3n7tD3g0C3nH30
         i5fAWCwTDO0K9+9MTCklROoc/dKqzPGWoK8YyS9T/S1cHkTbFO0dOIKXGnhyZHIVjqnQ
         kgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339940; x=1761944740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqJFC+NNQsYqMZ+tK6g4G5+TIVlZWFt0dur9F2fI5/g=;
        b=mZgRjLURsI0rmUivUUHk/v8sy5lD+8e9Ps3V4V2+IbpxK8aU9CgXH/D/oH/2Bcr9ka
         pdKAPwUCwRUu9agdKbeLyGtYwW9X+g/isDrJGjegFRV9OCHEYg/oiMWS9nW976RNNd1N
         cONgVUdiAOAEVkAnSbK+05WFcPBimg9XN77f0UCpc9M3Lh+SU62NqH+jloiHgdqL8pYC
         Na2OnEXhhaptcR/HXZibFrW6sw+C+JKlGpJR2hBSOgHPUdKmDhLOeAR2RVHg3EscXPyo
         V+1C5WTY4vdZ3B6UP1vg1garYcNrozp//1rA4+YA/9nyX3fE71QX++2K2Bk33HkZI077
         +k1A==
X-Forwarded-Encrypted: i=1; AJvYcCUqzFsvMiixnXsccsQ9wWfztWEwIcehEE8Gfgj0zPu5ingVu0HDZcRvQxOa+8mm7NwkJy0hK+JHzzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn15kbeHsLbmDk4tUpl4rEygjwovXHATO7y/G0BBa/EyjIniXa
	V23bhc7kNftPO4s76Vn5mPOPfpgtyAKiBcAYBzRBr9ioFIbfJtAbWUQubqf5SseKEXxLsfQcOMH
	c/tCyTn50DpbfaZ93m8BeXg==
X-Google-Smtp-Source: AGHT+IFUkFD/7WIScjIdXAKYJxfPtGhIYSnvomOS/iycesQViHbcTTslx/oSa9Wf4TQ1/V2dND2DFoK462c8uo3K
X-Received: from ejzd26.prod.google.com ([2002:a17:906:c21a:b0:b6d:5f9b:1ec2])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7e88:b0:b6d:4034:8d11 with SMTP id a640c23a62f3a-b6d40348deemr870312266b.62.1761339940332;
 Fri, 24 Oct 2025 14:05:40 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:16 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-4-mclapinski@google.com>
Subject: [PATCH v3 3/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the cxl driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/cxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..90734ddbd369 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -38,6 +38,7 @@ static struct cxl_driver cxl_dax_region_driver = {
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.51.1.821.gb6fe4d2222-goog

