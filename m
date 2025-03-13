Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902931531C1;
	Thu, 13 Mar 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892895; cv=none; b=cYxUyKUDP119N7qI66uKs0xhstGGDBfDSVrVZchigfnvrTG9BLXaLY+0T9ZxGYVJTJowr6b6BTkIQ5scxeJOByk63oktBuo0dTkeQXFHiI0jVu+3/GVMdeZ476FceXSYZahBavI6EG7Wv2CR3V895j1o/ibOvxoJq6j+jaGt11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892895; c=relaxed/simple;
	bh=nm0Ya04Vg82w2RGUGMDU1iYfl4yIv2Kv4S5DHdr6bAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwqVEyGpk3qLip6Gq9KLMjMs/hoBjATua+Wc0r0A9mp1KEOA7nSfSPI1DZlpUfMxHGD7S0r+HrUgdauJQTshh6czi/lpkzKKcr6CXxxBuklvwOs7y7dahzXk8NZc7cEJXeytjnMrdqvM5QAXb8GYRJkgIn6xD2m2VkQBP13GQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm8m0jmk; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm8m0jmk"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3e04b0b0cso5093485a.0;
        Thu, 13 Mar 2025 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892892; x=1742497692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjP1jqzw3aFfI1W891IJ2foRzLCTmZUncr4EWC31DvM=;
        b=jm8m0jmkIkZRIWtOwNCcNw42OFw5by6pBe13bYXJyj0a19iPVdAGAnRr28I62tHm3r
         OMqrlKMxQzPlAMhnRJVYDZpoL0iP/HD4WXRqk3vUjxdnhrttmEzBV88nRKMslJZ3a9In
         y+l/twUTZOhY5RQpBzFWDOuGu2L8kDG5BB81Tn5Iv46HVy7S2qwSgQLy4wdJ/xLh1Dw/
         v8OGFFrHE3G6OVaLc1a8hr1+zsK1ixN8Z25n4dlCnwbUVgZOYvkdde4xWEkztE9Bioz0
         w7zoMGb1mVB1up/GEkQ8cNaEKMiF/RZdRfg/ePjUkRALtZWsp2830SOTGWu5Ng4/1k8l
         U7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892892; x=1742497692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjP1jqzw3aFfI1W891IJ2foRzLCTmZUncr4EWC31DvM=;
        b=v2J+cqWrp4CTkeu1Gux8w1ILCMWiudMAL8dFOPKyc7pWDWNG1M0RC5r3K+0GOXakYo
         QHNm0TnzqwNMckHTjnShZ1BIenPgSKfWcegENWdXrOkN1j0MB1WUcXO6HFqWNLDFaOte
         hl9g6z0/quIsM406FIMGgRZS5D0iw/YFWxykh89YON25u/0/0KSSp68ZIRGHwVnRYhz9
         E8qX5yFSsUSy6GGqzxqNtndtKxi3uTPMhcdlo7mh+3IX5yuGoU4bkrsMHpcYyAV1ADBq
         FZFrTOBmNHr28VSsM5UmBvEDxiNs3Ergk9BF3ZgMCF5Y9S8WQtT1xpDjRPlA1EoELSk6
         Xx5g==
X-Forwarded-Encrypted: i=1; AJvYcCX9k6v3IBYbTfZWA63NsC0ODfS1gsHahZ8j7sPYhSIAiD4T9qZkpLkQCgW5257AXDtoGh/YneUpTLLX14E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQW9xyDVrIgOSEKJy5cbvJx+Oc9rcetpYiKD2t1yINgOgSfQO
	5/EWwuZMa4Jq1+vOr5XPSqb+KX6pNWxVqpGXOGi5tjucV3HTwME=
X-Gm-Gg: ASbGncvOIKUZUGTvUBDlSstxvpQlfmHZwtfBSbGQrSNyW9pHA/6e39F+zId4DzSgwTi
	XSJgWkkvFJ3Laf42GHGbplbbKPPNBrZH3XNdQszLnIKTbMCRywQ7X7zm7CJqKvn3OfzkcA71zqv
	5a1NNSbGOoGBBlt6n1p2qcJPtdUC5fpO16lhnrpw2r6A1N2R8dNrD4yztZPVpQU7KUFzxZKpBNT
	9Rk//LMG0jNdU9cvLK9WeUuNNhek5RLyR6q/NujyjW5WNbucwX8QoyxQXretEXFFIqpC5H42BSK
	sx5cZmUaVnNmpZIu+d6gvOYhrsySXu3pJDrBCeJDRA==
X-Google-Smtp-Source: AGHT+IHd6yq6pRWlKC88GyuQ5iVSYeVB96w7LvHh3l1vdqqVE0zMKBYVkgQ+qgg/Jdpm+QZKJzclXw==
X-Received: by 2002:a05:620a:410b:b0:7c0:bd67:7dd9 with SMTP id af79cd13be357-7c55e90a7cfmr693357285a.11.1741892892295;
        Thu, 13 Mar 2025 12:08:12 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fb61sm131540885a.73.2025.03.13.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:08:11 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] cxl/acpi: Add Null check for adev
Date: Thu, 13 Mar 2025 14:07:53 -0500
Message-Id: <20250313190753.450546-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all devices have an ACPI companion fwnode, so adev might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in cxl_acpi_probe().

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/cxl/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..9195001db3c1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -823,6 +823,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
+	if (!adev)
+		return -ENODEV;
+
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
 				      &pdev->dev);
-- 
2.34.1

