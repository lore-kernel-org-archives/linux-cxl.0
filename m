Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB7131BDD
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995461; cv=none; b=h7dps+KwZk1Q2djdOfFGEdhQVrKo+XmTN1/OVjkt70Fg9PH2RBxamkohOxKod7rAy1wtsUyBOGM1pVhLmX6wF5an5+aKHrjmTTLR0v+kd3NVTlr2ret1wFaWohRa8N4ww42TqcT2KDGbvpP+EfuYBsWsVvd5qMjdjZFBRO1zJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995461; c=relaxed/simple;
	bh=Y4rDUf52JWPZ9MeShgIRd+f9mgpzSlHQnn1AWb2aU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dx0bSISlvuIkwGCqN2pKmEKdQf7h07mnRLKjtL7XNhLLfj4s/9ft9VvVDkyORTn2z/9FzTYMxfuMg/h2YdTCvIZfb8VqGKqkA1OVupKKKCF57fvr31BAOD18U9pIlf1dU6L4eEYZuMxUFgifAFOcmIOgSP6LyRRKrkXgDmyQLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCJFGlJN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCJFGlJN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42565670e20so2144505e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Jul 2024 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995458; x=1720600258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2Vordpgq08V3AOsjjIdK4cHDDX5qouIu99HjhhGPw8=;
        b=yCJFGlJN+iE6+tlmIJk9CIpYuBd+9FWiXdq6E2YtUWQbbAftWB2EonVhXNzNdUap9H
         Zm/KPktlsg9Y9qBE25y2/N0mxTKGKth40QiSjozEiuGvlJMZgofvlW0+npmP9mkYTQNf
         ntN3JQnWSpwnxtR+ZHvFpCFk6CrmJ/Jiz5BeapIlcMUVDhoDTFvhn96AdIESPvLMAvIB
         b54qu6+fplj/HvuLmChhor2fJv7/QRpEEcWrHTW/td5xYgA5tZv4oMypnCRQdEZkxUJ1
         N+ZgfXsP6MI+zQZ8Z5zqirxl3zW//X2jB0NUjioE7S0EtPKZnX1uhlNjX/TDgUJrJw/G
         hEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995458; x=1720600258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2Vordpgq08V3AOsjjIdK4cHDDX5qouIu99HjhhGPw8=;
        b=GrJ1llvjuq5dylWacJAQF4BSw+FAwDdILz+7GsUP7aTJoQQyy4gtxovb7d8M3ZJAzO
         RuU7qZ7hPjtBh8m14y6ppJKz3HUSlUNHU1Y0l4DiSs7FT1Zv1xBrpUrIbzJwosMuSKoY
         teKflKCP0hSWIt+cGYyQJ1/bvNPMTxrlQ5Yg8c1ErNvqFLUW48sZRcDUttVjvABt0e7P
         k9dmLkcIE74sa2In6/30Ybk0GkUC7u6fN8PquoHB+6PwLlsI6xWq48RHr89IWf4lx836
         PKcio5dQM2BLfWcEbG05cDr1Kt7wNvUDRhyo3IBRolPRZ4wEvhndcDo6tqmtIoD+SVhR
         2dag==
X-Forwarded-Encrypted: i=1; AJvYcCVrgbUqLu5PbWsr7nWwzAndbe4MMFcBh4Z+ffEIef0WdTBMXbwjTTgRmQl9GTJEyDG8jRnhz/bMqrk1/WNwXODKUwysCQK5ZkxX
X-Gm-Message-State: AOJu0Yx1kHuLPr7ovEWjx3wCOYSysBCazruiXP2R9GwcLj+CtwLaTOnQ
	Cj2MOJtRqPdaLOZ/QeK0o7ZioyweXKZztwmjS95mrK0Giwh1BKOZ/7E2fW7yDZU=
X-Google-Smtp-Source: AGHT+IEO0qOMucq0/Dkxhbd3FQ73eQMSmyuAD2YjjnYf5q6PoaQe0ZZMFP4WVE2UsDcDNDtS+2Ienw==
X-Received: by 2002:adf:f202:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-367947b319fmr762548f8f.28.1719995458595;
        Wed, 03 Jul 2024 01:30:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm15302768f8f.16.2024.07.03.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:30:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cxl/acpi: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 10:30:55 +0200
Message-ID: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'return_ptr' helper for returning a pointer without cleanup for
shorter code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..1e4bed8a933e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -339,7 +339,7 @@ static struct resource *alloc_cxl_resource(resource_size_t base,
 	if (!res->name)
 		return NULL;
 
-	return no_free_ptr(res);
+	return_ptr(res);
 }
 
 static int add_or_reset_cxl_resource(struct resource *parent, struct resource *res)
-- 
2.43.0

