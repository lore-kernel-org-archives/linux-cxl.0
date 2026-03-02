Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB32DF12F
	for <linux-cxl@vger.kernel.org>; Mon,  2 Mar 2026 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481876; cv=none; b=mLcyGInUPj7iK0Q1/oeg/jD6VA+ZlyZJskKEi3JAotkS4uPeOU2N5cLilBfLr/bet5qmYIm/wWK5lSbqibDu9z6h8NInZ5oWv2Yx3pWBJYsjgXOCFq9gbNU6UPM2VPbF8N6oIDQ7Giou4+DQ2efbHVM0OSO4GuXxOrUh0w7jnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481876; c=relaxed/simple;
	bh=utvSQT+CD876dWtO/rYeq0KvioAFMUKDbiWIBTyjCJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAX7eqqgR9OZkAVvoBfda4OBdKFoFejkHfw+mvS8klPBqvvh3jLHe5klVsqBMv5G7xmun5MoRHbEGwzTfGnY84onguHIhHoxnhgc532OdyjcOXUhmTuyDrFFwp4s2lFgL+LaFZ3cZ51XLEHHMTHyz2s036VeZYv5J7SVWl4bygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ua6Tp8zN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ua6Tp8zN"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a297c14bso43750541cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Mar 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772481874; x=1773086674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DwHuUppa6SUbjaq5sts8sylTJtYfwzEq1GPQR1viLM=;
        b=ua6Tp8zN8afYajBVTkhJMd9GOwokzgJ1+jPSqx3QRC/EntMWbJl7oA2+UWRFwKCrwO
         ZTGyS7sX9smsv61syDnKyqMPg+dzD/MSXSXKuZM+cn2Q0G9m/Zqwb7tYOV09pL2ELSD3
         pUF4tczTp6s+V3kbDsDoJwV88Vb5zE42K3ePwg+dSOKABhHuGZHhDxaeLzf/aOifavxr
         66Vryfd0L29Mg0hmz9UEUXKwojdwzBKQ7VGYxNOUF/uBO4zq6WtgHACtRT44I2o4JiMf
         X4twmEnHKXR+8F1eI76fUueb8o1lMK3qMwRebm8SXpx/9p0I/NLI+bRD3T2SOcm7SPE0
         WMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481874; x=1773086674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DwHuUppa6SUbjaq5sts8sylTJtYfwzEq1GPQR1viLM=;
        b=Y8Bl6rLxaKf5OWoxxiXoCmPJVEpAxoL+ZNTJ20lD+D1dY07IAj/IV+C52tPzywlT/L
         3IUnui+kkg5rFF5geAZDcR00l6XsjqkvBR75As7Q+8XEFFu+mg1rqhVcC/LG/ZmFf+g/
         qMcNqpm62YHz9Qj9GqRWTZMWEteDsFQUenTnHafAdgmpfxkBISaTvAJKDj4+PGxDsxAn
         nbmMmVCoA+Su14ptAJS7C92v1ZzROUH7enec2z716yoCBQYLtZYa/ch1qr/BgAqd8w53
         GINsE5HYWYo3dk/KinY8mLGtcoZ1RWOBUhXkcXxUkD6oiATk5hXIVhco3jvuJtDC6JhZ
         6xUQ==
X-Gm-Message-State: AOJu0YyFi46NxwknMVIxdCf9gR9NLibRoZjJwy/LC7XDHAE/6f2mskvC
	WK1YxhEaMxJ1jTrMjKLVpCKPojl9l1B+jwZf1t7Sz0ycIbx39FeY1J5tiYBM6+cRQP8WmnHxXxD
	+kXY7
X-Gm-Gg: ATEYQzyV62bXJBZYu2qP+9OUdnU/Pq99z7s/uA9alHRTXXzw0AS6/oz67B0ufvtf5k8
	y/UqC7KChWwfROvkpE9uyXMRnhBnUgbwButeCL/DlE7D1KksN3ApHgHoRTg5OQjDfQsR/qvOLz9
	wH9jnM/KRjsCQXAyXbK/PRMRLzxc5VeQnM999TwCs/3wqEpYFycHed9kEHv3C4Le84hn72qXHT8
	c8WC8zb0Q9Ju0KcZGoRT9RpjjI4VkbzEB240xmLOSOhzWWX9RXscASrMk/wEysMcXdBaGme/C6E
	6K3SlB9+PqDEoEacDdcA8MyVQ2KdnNP2i2EWB3qMDsJ25c0nsYcidOnszoxlAjLSSj/A/Ij9FHo
	6PUKaetJCF/HIAgYPyYlVJkVk89jM6rJKOUIBFIEOqvmC9SPm01SkakZoi+GG8JsUTfV8CHZjin
	jKIYuReAsuJETf5If8eTM1DQYWKrO12y6RXLgF1wQUYMTmrrWLSRAJXOHiQGm9Axxvq9A0ZApJa
	VqgqXIlU3AyBVFezADCJ9x9Gg==
X-Received: by 2002:a05:622a:1387:b0:4f4:e6b7:df20 with SMTP id d75a77b69052e-507528deb18mr192396701cf.32.1772481873860;
        Mon, 02 Mar 2026 12:04:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ebb09772sm52419146d6.12.2026.03.02.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:04:33 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
Date: Mon,  2 Mar 2026 15:04:29 -0500
Message-ID: <20260302200429.803417-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.

When CXL_ACPI=y and CXL_PMEM=m, the built-in cxl_acpi attempts to
link against a non-built-in cxl_pmem, which the linker cannot resolve.

CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=m constrains CXL_PMEM to
at most =m.

Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
built-in caller references a modular target, preventing the link error.

The result is if the pmem/nvdimm symbols are not reachable at build
time, then at runtime it will always return -ENODEV.

Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..7065413eda9f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
+	if (IS_REACHABLE(CONFIG_CXL_PMEM))
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
 	if (rc < 0)
-- 
2.53.0

