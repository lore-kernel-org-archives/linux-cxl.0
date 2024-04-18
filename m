Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7C2AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483005; cv=none; b=XYiIXWTius49AUFOuQjfDgzHcEzwkrxl7eZ9EcBPQyxih/WKVKT5FAnxv8BG/+qZdZU4Pn8/2DijoQ8+Z6o2L0fUnoTsYbvAhpnnl2eBvoP+TF98Ydi7T0drt2w9gJc95g2h9FPWK4mYaMRAiXgOt28jfTumLETvfwM/kS0Ez7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483005; c=relaxed/simple;
	bh=wy6mbTMBMsYfurZCiVtXv16F+h19N9tY2TYxi6DUmjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS7S2zaTGcQgFuABenvfoboNJ3Xw2tFd0OG6kwKKgRPJL3eIgEYyMDgHgyxTKhFSeZ3rtGqouAlBfZAN2q9DjVk6xiBj3l3eMB7+1n/vuxNDOxvoWW4mWnRd27jXOb4njt+0mM43wQUza3MKecaRpFM8zGtW5VwsTWO8CfmOUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m75j+bkA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m75j+bkA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso1299187b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483003; x=1714087803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
        b=m75j+bkAJnVAXiSudvMa1VXhH19h81difEXKoU+T3PTfYGjFH/Pq16BsGieTSVSI48
         manV73aavhNqQr44sr4ezk8CHaHH4qHSsNZpE0QqLpQ2WVDy+D8FrO5qMYrPOeZ1UVw0
         YRO5n5/QJrWGEXhwbf6J6GakylEiLC33l3CKi+vKimJ+q39gy8Oq5oo2fRVosx+5y8ke
         b2GHtVpBNKgQi8gUnRMSAxMccthGhQKIiv94/UihaLxr/cwtYm8+NLv5BsH+KVkqn7J+
         HsK8GXJWEDQKPt+bqrG51km8mIZBNy2Tt9wMAv5bjdQ66hW/WvKJK7eh4+yD6Bo6bvJc
         pnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483003; x=1714087803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
        b=q2x6eLavZSWkN4PU7Zh3+dZDT1fgweXxz6rdAD26DWL4AxW/X4Zl1po3ZF4mtU1Bhh
         MrYdmGwZ9y185kHfhKz+PQbZ5NKs5dz/0uoh5dbq61O1R4y6KMgwgWOGyN12bZYoJukz
         ybYByCPszOaXLzC7Kq2vqoJRwz+kSip/sw6XLLJdDnLSRND8F/Jm76+ReJLHeECDk7M6
         cbxuu79+6IZ8RqPCL9eRBWGje4OP/QeHKEjpf5bR14t/MIWFoT59auHInPdU9z43GEWu
         eU+ecJPosSloINgWnpkk0LvRN7atr7cGjxMuBFAKBjyFApxVZimKoQjW0DWDBjhIpqEE
         DjfA==
X-Forwarded-Encrypted: i=1; AJvYcCXNbROYqdYC0YwQWrVag0RBFFze41s3mm5f+NX8c9tnt7jDAdpB5sHZwiezWd6ORpwDVwjMbIdLOgRf7Kt82RW3Eyy7wKTyHXJr
X-Gm-Message-State: AOJu0YwZib0JYYtNrREZ4yS3zrDAs0UcTjINi5cTZLOkzTWmx3uOQFri
	YgmJOzYSXSKz5e4oJ0RKacPAdB7DDTHvMdFVEBM3ylhnSiLAPUPs
X-Google-Smtp-Source: AGHT+IFTdEgcMmuT3whZaWUvTVxWchLBAzKu3B7PBQT8Sr326EKv/JjWOH3PFNWfM1ggd3BO+9oIvw==
X-Received: by 2002:a05:6a00:8c9:b0:6ea:bdbc:6a4 with SMTP id s9-20020a056a0008c900b006eabdbc06a4mr770808pfu.13.1713483002795;
        Thu, 18 Apr 2024 16:30:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:02 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 01/12] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Thu, 18 Apr 2024 16:10:52 -0700
Message-ID: <20240418232902.583744-2-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bcd727f4c..ba1d9901df 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.43.0

