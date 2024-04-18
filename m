Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FC2AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483012; cv=none; b=eEvb7n1oFOBkAIjJut+o0OEuykQZNTusBy7qS8seMxar3tT8g0B/xyzUoKbcYHp1vmyV4jTbHZBx1jsf7BeHHDhj2jqF+h4//L8WvnEUUO1CQz6/AgWe4fzaCQBgH4GhKLeImYs/qwEGupsksSY9T8MkPvcS2+mi6sY5Wf2oAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483012; c=relaxed/simple;
	bh=MbsEJu+P0LQqrL/fFPzA+QCKd0j/313kTt71hbsTn4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9+WXuY3K5pFnt8KCYr7xsv22hLpt9eGQ2xSrJg4xdRD4CrHqE20m+EfCcBZ17F7G/JTVBZ5Il+v/2a0rDOlxtMCLQXtD7JC2pPR7BpOAj5T/d1JTqsL9JlRK1iWtfoOS8PIF58Q5WUcfkofAZ6qKqwBaD4CKfSrn4AgLr+l6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvcVyyaZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvcVyyaZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1345016b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483010; x=1714087810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2honBLfLsYAJoSrWVd0jh7a+uzahn+825h2aAqTgw=;
        b=WvcVyyaZXnM7ZmDa5GKbK44M6JBu9r3a2+i87IhRhIOP+d/19qLVxKuoNhE/0OYz93
         rUxsL6QNeOngKck0xZhlDFX97YDBl75qKPT9dK0GYeS8YewBCkTQOsDQDk042QbCNyTE
         JeBSU5jGnHEkZCpx6V46v4viAArMpZRkWDK5pvlaYhkcDmGdIyssfqD+zSFdOYD36JAd
         pkfsgcY1hcrdCNR+hN8Fb/kcbJw5g0ttFnBM7B3sHfKQFlda+JVMbDuCyHc2KFVyjPCG
         uQdwUYgHTKoVz0oULac1zo2oOoVOz1UoXGag6uhc6u0+rwIX+xMejQaiYAWqcxH4Eb7a
         tpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483010; x=1714087810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow2honBLfLsYAJoSrWVd0jh7a+uzahn+825h2aAqTgw=;
        b=APoH6azm0WmQlQoJSO0Keyg5bwHNaBWptWT0x0a2C9J6lR2KvvnjWTbediiVB/SW3v
         /ysjDajG8uGTbmKfvDpVU/A8MQ3P4SZvH8IRQ8f4xeLbzGRJe35PZhxja2UmKd8SwJZ+
         9aa9ym2gbgA58xG/JASuCK8jeyLXINGZPJY9nkDVj9DyyvBPhGWby/xUYJYNCgV4fHdn
         CVieuUB/01yx8c0dJZht7v34AlL7C3Phx1oA2vA7/i8REIoO7s/KtSn+lgVRoOsqzLfJ
         lDjaSiRtnLNuKvVEoMI4UjAz+M3363TLusoSXGjsHDvGyP9t4v4OhQ0600yTxTaxqXaa
         xEsg==
X-Forwarded-Encrypted: i=1; AJvYcCUQx/J58cBJ55k+z8i2xMVs7Z3gSiMf9F2mdeSn5N8oINB2/aXSuvXpw9VJzSPVTUF9GrxqOzaGKw5go+nSlkhi1J+c+HImgFoH
X-Gm-Message-State: AOJu0Yyb+jOUep5TnljgN/9fltFV3m48fd1acVIg3og6VFISjFehEeaL
	jgxiQ0dDp++bPiAzFN8+0Ak/f6ancc5Xv2F+O0Rl4Vz1jJl7y7NE
X-Google-Smtp-Source: AGHT+IE94ylxUx/UWiEiedIHul63+PwBYMukWUa1qdA/55cOY8EAPLn5Al2VYu6orH+j7LErQAQ6vg==
X-Received: by 2002:a05:6a20:96ce:b0:1a7:61f0:9ca9 with SMTP id hq14-20020a056a2096ce00b001a761f09ca9mr647381pzc.58.1713483010243;
        Thu, 18 Apr 2024 16:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:09 -0700 (PDT)
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
Subject: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Thu, 18 Apr 2024 16:10:55 -0700
Message-ID: <20240418232902.583744-5-fan.ni@samsung.com>
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
 hw/mem/cxl_type3.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5d6d3ab87d..5ceed0ab4c 100644
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
@@ -635,6 +676,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->dc.num_regions > 0) {
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_setg(errp, "setup DC regions failed");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -931,6 +979,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

