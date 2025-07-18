Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5F21D3F3
	for <linux-cxl@vger.kernel.org>; Fri, 18 Jul 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873765; cv=none; b=QBzoOzWPYYopSKgUmI1CsZG5icGu23JnEYKP27YqnwsumsKzfsLPH7ZKHSm+bTmf4p1Lx6p4aSiqt9TnJe0JK7Rxbd9IdW5S/s2qQlBkEUuLnbA5eGQrXt2s+vGlqhoLKu9BonTanhejHKEwAafnuFoMk6qO2Eq4ZBr0maIXo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873765; c=relaxed/simple;
	bh=tSTrgPIpnpGNk9NG4NpmpQ1B9Z+0uOo8Jk7BbP98nVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mlc+8fvqRxVz+iGA4Xhvi8RqR5VYuCVoaJqcb/5xM7Xvo5tfNZSKqK736ETIX/avoWzDcAw8F1tOihjz/RdlIkrbUvfw5I/4SN/OyUFACzaBtVTQnuMX4OeLBVLucoiVcXDX2NBWgcEMh6DSWjybzhLpB+W7saW3+GUinJDyoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqHNJFJn; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqHNJFJn"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40a4de1753fso1515431b6e.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jul 2025 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873762; x=1753478562; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsvoKg06SgJJI9+VuR9QTODLjTqy09owpIVoI3UQeUs=;
        b=lqHNJFJnIAE/xDx7uJU9Te8OTDiojxRoiHqh5sQqne6FMIGj9JT8bOX4dH2Z1vvYdI
         GT/UVGi6zELgO9GJBP3+5XW8Jv08Z8hEWe0M5Lu4GPs/tKGRyGjraT2nGp48slJzRANA
         yf1ygijYkx6MqPVSWeDzV3Lkel0ZImZSqDdw7Ins5DjAtLEC2o3oJkNPbl9t7X2DuKa/
         B8ErO+Rv/uNw7/v1kiG4HgbwqQd94FejR6lwphwlJCkONVnd9yfo7RNSxzilxOIc/NWx
         wUPL+9ZKWgSKXbs384qiIs1MOXL3lU79gTQkm5Cxana/lCbq6JcVp6iJGo1haPXPmjin
         xz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873762; x=1753478562;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsvoKg06SgJJI9+VuR9QTODLjTqy09owpIVoI3UQeUs=;
        b=tJr/seuoROwqtvsg0ppOx1GsEHjIvLgJracgI8IE2w7fm7B/WBD2QFiOk+a/bkMYjT
         tp8erfK5lNEsIrUOlaHPSbOc/jrU2GvXNoeLDUAzqoBi70eu5EmB6yZ5ZjgXSeh/kWNA
         bt/38C3wl9qyiYUg33IQnzVUy3Bxkcf+FgakdhgTmGF+JeOLLwIHOcDdMjZ6vmNr3YAe
         ET1J/zqgDdrXVK8j9Up0A/4RDUgKef81EX22UvnsTJm+V+o9Ms8g0shjr1+T7qUImW+d
         C2gQn8N7mAxDN+GcBCvvlA1PyMzNFXiVdDCjMxFneBEGxS0SBNQBFd7i/pVWgUcri2c3
         m9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBH2z5xN+aNQJ4TUjOKKNEli5Oe92wFkd953i+5qU+H4ul144J7XeAzgsc3XgwG3GAJjFPt5ibot8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywga/bXUmM+e7BpEkhaPkXW/GzSECMfb7GzYd8fZwArse2nKXhl
	gj8UIKLQBYBYwZuHr1L2xjsie0LLljzewBkxbxExAYSIVGFDp8c8Kycpe6N5NH9xudQ=
X-Gm-Gg: ASbGncsrSD8DUQ7P4wakk/YI5wl8+osBLdN+ZZe62sSfv5AmwzielD4y3vfyA/rhPQu
	ZhAKc7Kcma57xrheGmJIPJoMD6ZLuf+8GSJMp+g4nFjis1AmTDPOft9t8Nw9PWz49we5FpXXX7Z
	Jm+u6aZ4O54kOOOjOgNXCtnA00uF+zRcmlDKqD2TqDNh+9TBiYqQdpdXRAeS1uGcQNq6xJdcqyL
	zmAyNOWUE0YjmqNQouBjr2UgjMKIui8SIEt6ETH/03MKhFk5sE295n5RNzRqA0qyjuHMREm3ZUQ
	L+dMA6nUlmJmARHiiJnVAV0u2lVENmhbE3JxK/mbyTkHwcCWJPOAn4YFB+MYYd/CP9005vLYvb8
	pDk4aO1xjLrE=
X-Google-Smtp-Source: AGHT+IGh7lU3JyUSFdh98iTvsA+uq1G9ywwnUkqJkNKmpyQmKR/YnU9/CQLlNROcG3cTeKKCoijI1Q==
X-Received: by 2002:a05:6808:2388:b0:406:6aa1:38d9 with SMTP id 5614622812f47-41e2ee52148mr6250832b6e.13.1752873762342;
        Fri, 18 Jul 2025 14:22:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd10c0ea6sm751747b6e.1.2025.07.18.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:22:41 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:22:40 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Robert Richter <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] cxl/region: Fix an ERR_PTR() vs NULL bug
Message-ID: <7def7da0-326a-410d-8c92-718c8963c0a2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __cxl_decoder_detach() function is expected to return NULL on error
but this error path accidentally returns an error pointer.  It could
potentially lead to an error pointer dereference in the caller.  Change
it to return NULL.

Fixes: b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f0765a0af845..71cc42d05248 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2108,7 +2108,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		if (pos >= p->interleave_ways) {
 			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
 				pos, p->interleave_ways);
-			return ERR_PTR(-ENXIO);
+			return NULL;
 		}
 
 		if (!p->targets[pos])
-- 
2.47.2

