Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5052D5C95
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976638; cv=none; b=ZURVbet+zHjPAeoFZ6JQgCbvcoYlVB/R3ADForTnc3AQZd0+UEP1bhV9e4zdGJ8Ns3aSFolzRLPrDmmsE4n6MQYSmicJOKA+s1N69GZqSj1x49UCqoaW+QiumAuI+YpRSnAHMHlS8peRPPKVsF+4jR+QhEI3X5Zt6hqTpxst020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976638; c=relaxed/simple;
	bh=lvNFPRwpFkBdQTQroDXyu6PVWfHSextKgYkc2Y4dh7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnqWy0yBcj8nM4tEStSgXAfRmaAqgeZWPHzdxgR9YUWhkKBVWiIXfUAhUV5tlnSxTFYLcXCxNjxYVoGux+J/1O87M5EAMxgUTFTFKQmRmUjM+IflOprR4juA01nMVEVuV7gqQwzUtxuJ4XBXkMBxNxJfJ90zn3wv1O8EcXFWlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XPucGO2+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XPucGO2+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so5092135e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 04 Sep 2025 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756976634; x=1757581434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ket4UsQ6Z/YwRPFuqUWOeMjQ+dAqjpKyTO3B6gKLcrM=;
        b=XPucGO2+0WE2b3WqCBV9LvYijCx6+8Oy5lkL8jkdwkyL6uCGTyITqDBAbSN+Jc/hH7
         Ak0Ml6GnnFghXPwkFWdChgVbwELzd/UEW9PNF7RymIl4o7FY19lkeIwXz0ouwgSe1UVc
         BoYaREx16EuSlqrjKgzoOudq2eSvnSBmPJuM9qxc88T60hmMjKHSbwJVKS2GOrNXqvX+
         M6M6UoVYsAsat7zy5GQMzSgV458kzJjwrsrcWDz+edUPhIGMHbFnM/UdnrnfzMXTy6UQ
         A1jVO0vOvqECmU8G0vS507I5bGmn9E6rtALoNHMsE6GpxwWcM7qtaXd6SewS6TUlmV+2
         HX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976634; x=1757581434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ket4UsQ6Z/YwRPFuqUWOeMjQ+dAqjpKyTO3B6gKLcrM=;
        b=n4VzekpdYMZsrIJg8i10KG6VTd/U/ia66SjS/TCCYiq0LGchJ+9Yl7hKYAMxazipNt
         wSCo+tTVwULcJk0NendRvKQpT4VgcWHy4UnZ5XJQUYlsKJnASAEjodtOOt1rBvm8CASb
         Rj09atqxPS59tOyvyvPkMPXSPadly4jRMVkBVUnqsAw8sDYo+6x6WW31Dhg0gdg031cr
         vltFj5XjwJWxhxRd4AzXev9slKBaqQ1s+DHHontz8ldjEe+bxB7guYUbvzBJ+EPelhA9
         oRp7hHAbAtSzJBRZ76/2YKhARGkm4hiAaOz4iF8/237iS3uuZTe9rZ+TwBgETY6vmCay
         LyhA==
X-Gm-Message-State: AOJu0YyoyY7nXUB7o2SDeK3JpZuZaoUR1nJk5hdPQI9L3pGEGf3wAO0b
	ylCsPIKvGKI4VSrYkTcZhI2M0CLiFfpW15D73kiJJ2sQvohazaMBFGufQA6nm6nN
X-Gm-Gg: ASbGnctHlJx6zmdYlEJDKvOST3bYzXKyJ7pb82tCUWohq0NxlOdhZGpyAxHlRbnrcIZ
	9yKBCXvfJ6RLYbFxGmE86Np+T9tQPMxRW5Et7fbVa6sSMpQwx4rZt/JXn2OKpAM3dums3R+iyct
	lduSb7so4xb/iDp2esUHz2dwo78XSsKgdgDJ/8g9DZiOY/TLzcpfZ5NRNigEe7KFqHwR50taXHL
	ZklcZcmhv/LI4tXe9MsYfYz+5gqUer6RL9THt/y3DSkd5suh44Q1ekIluUIdeRObyvbp8RFmFnr
	72pMeo3s+I2pm7mNKo3o5Zr1j7IBcZGC+Ue08uazLPMBqcKKBtIRl2eidk5LUnqRwheYrknTUK7
	HDTMi6rL/0ie36KqvJthp38jU1xK1MWAi4wKi2F4MTbpI3tVjF4K+HkQ7
X-Google-Smtp-Source: AGHT+IE4eWTSlZgoHyNN9ZVDyCIWCT0x7x7lnPLl+ePB5d6DpdQkrAZssZS81c3u3JKMl1HbwwXjmQ==
X-Received: by 2002:a05:600c:4f0c:b0:45c:b6d3:a106 with SMTP id 5b1f17b1804b1-45cb6d3a2afmr40779365e9.11.1756976634340;
        Thu, 04 Sep 2025 02:03:54 -0700 (PDT)
Received: from node1.manccluster.local ([130.88.198.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm359579605e9.1.2025.09.04.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:03:54 -0700 (PDT)
From: Joshua Lant <joshualant@googlemail.com>
X-Google-Original-From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU- PATCH 1/1] cxl_type3: fix segfault in cxl_destroy_dc_regions
Date: Thu,  4 Sep 2025 10:02:22 +0100
Message-ID: <20250904090346.884649-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250904090346.884649-1-joshualant@gmail.com>
References: <20250904090346.884649-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL_TYPE3_CLASS() should be CXL_TYPE3_GET_CLASS() given object (CXLType3Dev)
input. Leads to segfault in object_class_dynamic_cast.

Fixes: ef730035567

signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c4658e0955..14cb09d9fe 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -919,7 +919,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
-    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     int i;
     CXLDCRegion *region;
 
-- 
2.43.7

