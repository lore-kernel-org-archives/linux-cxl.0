Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B131C02
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393475; cv=none; b=G9PUgKFKALatAznwbq8bJDLoS93f3fI2hOT5hCwu9c5VRaSuF1uWe0iCaRKyrLbwmCG5336zWJlYBECINqW+x/OdhX2UQ9wLu8CHZoy+vdlwt0Ukpk3XwSQ20wAwFXNBsKI8W7uQMw20WHUDhGpLhucLZdZ6D0vohVZuI5KRaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393475; c=relaxed/simple;
	bh=ewkM/UJvE3/Pa35lnXVt+F2kW50k/hOnYaHAPl0Y2Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK+50VkBKWnndTXpbazyGPHFUMaq/e55TIbmE7mn/JrEFY0OJpRHGZ0dqA3bEN4WYBeM7+0756AZWUTmmMc4i7OJlOLS4oOAIW2BAnQPx82bDdVDMgauTnYdYIPMRlHDmTOtNYFLYqYc0IgiWzGtAD+b9+ZCg/HJzO5IFDYbiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYCvBsQk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYCvBsQk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so3883112b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393473; x=1711998273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SGocJmgk/sEnzEmc6Kt8P5rytGfU0O9oNlpZCxOq1A=;
        b=lYCvBsQkFHnJasovtW5wtcownys33xdl3DsaAHJKt4f08kKRXNznB9xgPEls8xpac1
         mlcXzyODsW5Smqatc6H1x55aB0se26BPZP3yEYSEuxUTqTA5EnxTwTktxEcjmZevIVXx
         iVil17auo1mPLi0abOKP2qR5LzH8cSwwYsxkQsuWpCnSU1wKK7H/lfHeGHRkyKmfYRMO
         /FI1snw5iQu2BKQtnEn4y4lWmVQmXh4uM5SnIvM1fVoGfM7dvfzM8ktLS/hh4W7+bMjW
         h5tZJaIQYVYMvDKYKu0n0rsH2wwMCETYZrlE7v3zxIz5MO+HJo+lQNSQvd+VQkyJ0gLs
         F8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393473; x=1711998273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SGocJmgk/sEnzEmc6Kt8P5rytGfU0O9oNlpZCxOq1A=;
        b=BotutRBW8ZEdsVT+QovQrfVj95MIPkPVMH7BBTsUU3fhhdbA0t5q4wx9quP50IWwKT
         PWe8SQtQfMcHvxEaC35Cua1guzBRfnpkqJpay+J+67aGr1815CevqkumVFYju57KutC3
         AFB9zxAzCwbP0W+ic1sa559dzHdq3nf+N19yd4wH4Hj8a1ovcprkPH8aHj0wQ6GLj4ol
         9OE0T1uc/j823Wd8ch8FJ593GmMDt7sJ8u+AAJzCSPuvumj2M4DRR9Hkv/giOGEMpyCf
         NS/3qg5gv/oUgqLTnD/B3OK1auBO35vlnqA1toIF8QFjF9PxRM5FMrm57ZQsP63N1fjt
         m09g==
X-Forwarded-Encrypted: i=1; AJvYcCXr5QM9yd/dducWjrfHnRMVbbl/oahpMMyS8tR2DTvnjiWSWKIPbll+tvauXNO7EhYSM5VgAr4Ev68hgCkYPV+qNP0JONJwmoDk
X-Gm-Message-State: AOJu0YwRICs60VqKUJ9mLoQJSWakFThihfTwg7vg74/CGb3ADSiT5fy7
	HfPZzfOcKtc5Ky/JsgHfiW15VwQhN4GXs6gYkHUTDX/d+BDgWCSZ
X-Google-Smtp-Source: AGHT+IEet4CYlBzXytxndehASjVoSA2KP6NMROyP4aaNMcrhbw2pxprA5/Xl3Yf4Gtwld70yD4SjtA==
X-Received: by 2002:a05:6a00:80d2:b0:6ea:ad01:3550 with SMTP id ei18-20020a056a0080d200b006eaad013550mr2813950pfb.18.1711393473264;
        Mon, 25 Mar 2024 12:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:32 -0700 (PDT)
From: nifan.cxl@gmail.com
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
Subject: [PATCH v6 04/12] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Mon, 25 Mar 2024 12:02:22 -0700
Message-ID: <20240325190339.696686-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

With the change, when setting up memory for type3 memory device, we can
create DC regions.
A property 'num-dc-regions' is added to ct3_props to allow users to pass the
number of DC regions to create. To make it easier, other region parameters
like region base, length, and block size are hard coded. If needed,
these parameters can be added easily.

With the change, we can create DC regions with proper kernel side
support like below:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0836e9135b..c83d6f8004 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,46 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+/*
+ * TODO: dc region configuration will be updated once host backend and address
+ * space support is added for DCD.
+ */
+static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
+{
+    int i;
+    uint64_t region_base = 0;
+    uint64_t region_len =  2 * GiB;
+    uint64_t decode_len = 2 * GiB;
+    uint64_t blk_size = 2 * MiB;
+    CXLDCRegion *region;
+    MemoryRegion *mr;
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        region_base += memory_region_size(mr);
+    }
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        region_base += memory_region_size(mr);
+    }
+    assert(region_base % CXL_CAPACITY_MULTIPLIER == 0);
+
+    for (i = 0, region = &ct3d->dc.regions[0];
+         i < ct3d->dc.num_regions;
+         i++, region++, region_base += region_len) {
+        *region = (CXLDCRegion) {
+            .base = region_base,
+            .decode_len = decode_len,
+            .len = region_len,
+            .block_size = blk_size,
+            /* dsmad_handle set when creating CDAT table entries */
+            .flags = 0,
+        };
+    }
+
+    return true;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -635,6 +676,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +976,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

