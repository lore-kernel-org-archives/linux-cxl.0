Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724458119
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483043; cv=none; b=dw5JnZCx8ebiaVBzwUR5n/EWUjPtJiGwGrMPbBEkNsz8kWvymenttOosl4Tj+EOJUp1kRDXncSidgikD4JObKtTlZ/6omgrj24R2h34gJZJ/Y6p/rz4jXUVW+lp31UqT+FnqLaf7itLBTh5zTE5T5txPPf3s21XsleFPlCz8rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483043; c=relaxed/simple;
	bh=4/sZTtNVoOLJvZFPx0uxL1WcMwdkqpnwinTIQ7phZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNxmnxqaQd9bfMHSLndAUy6k5UItWevKA+xwH7Z9zyTktvW4IiMmfVkS6but15BtOE7w/ugT2R7l31bGpxf+4K4yc8lZMwbtidoil6jPwnc0Qr9VyrWhrDkcriHFt6LU9oo0XMkI1Yt23126Nh6/W93NDYUqJi4cYOaMEuy91rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvcjjcVs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvcjjcVs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso1299522b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483042; x=1714087842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdtJQ2//BvaL+ED8X5UWARoz6dYMy43pJ3SbcFIRv9I=;
        b=hvcjjcVs2YTt54+OCs6Uxwri44NHTleh/Q1kN5CoiB+5xfeqb1uA+XWogHK0YxUszi
         MUp8CZAN07KE5PNgSzNcvMXsHpIt4NtFbhyRjXK5P2Xg1/En7SdX2YAdcGVPDzC1eQ2p
         jg7vv8POG0kvyR//asQ+qdBv5PB1p8nwWOJ8BJlCZErN729lJSHdikjTCukHgvVx2dOQ
         LHt89b9F/i5HDmZgJXGWUGdG5WPjV2ptEv4QOhwZMa6zrdZ9TjCQouI9ojnAzj07eem5
         0KdG6SHVHaA3iJUW4jDPHpZVNoP4QYb51iJTkifNFG7G4SYh1F6OKRYs43tRHcqWlJ0v
         u4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483042; x=1714087842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdtJQ2//BvaL+ED8X5UWARoz6dYMy43pJ3SbcFIRv9I=;
        b=O14JzshS229a33ajFMHyybCVMsNwc4TIJxigTyBNuH2i14cstWxqKfHmwNX2HA3Z3B
         RXlWgq6rGIJLradiPTCyUUYOM6wkSrL5UpD6o0L0E1k1Nf2EHZII9+AwLuitvDHajbzX
         pjQWIGYfknLKdQRfJkgghBldLK7mR13rqysxxs5arQ0Vw0Pp9uSh8/vl2erzikVZLjJ3
         ekryqPyCiQxpDm+xNZo/Ly9zc7wnPlFRP0ZY/roL30jhIlraznuB4kaGIDmjtD9o5u4E
         6+ckO8sx49bQh2DcRpWPC9URB2pWzjBK52wrwZF9QcKgdpE+0Ts8u/6+4Oa1sQIp0lah
         iJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVlrmRnTXXUcuR8IQiOdLc6hfezsV/nEm6IfOvxTvU+1N1+BMbj4pLny1PpoyMno0klZjyu8D7iQU2yqvD8Ax2KiFeT5HLGHdso
X-Gm-Message-State: AOJu0YwnIySCL7oKS9x2W731g2JvZqEOaRSKWTbxGrAKAZvuUI096v4a
	e+f3ZMiC6/9zar3t4K4P3Cl0TKkmpuW8iVZcx9dbpwllVrtlQfVM6YkcCg==
X-Google-Smtp-Source: AGHT+IHGuUAdd1A/hFHKB74AL5T6aGZ9tFOxeEB/HZhO5eI3UqC99l2TIAslMMUB9EHdcx6813y6bg==
X-Received: by 2002:a62:81c6:0:b0:6f0:c78f:75e1 with SMTP id t189-20020a6281c6000000b006f0c78f75e1mr498855pfd.0.1713483041813;
        Thu, 18 Apr 2024 16:30:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:41 -0700 (PDT)
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
Subject: [PATCH v7 12/12] hw/mem/cxl_type3: Allow to release extent superset in QMP interface
Date: Thu, 18 Apr 2024 16:11:03 -0700
Message-ID: <20240418232902.583744-13-fan.ni@samsung.com>
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

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a3e1a5de25..9e725647f1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1941,7 +1941,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0

