Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A30763F2
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486529; cv=none; b=fsoxzCNi8Z3+NJxEWedCRSx4EISnRNmuFwBMnSnCVW4ZjWIYIj/Ej3qqripu4eKRjjTpdH8p1vMY65SgENvBlBwm0wJYM7byEB4jtJeQBjoQZPB+JgsT6UjduARgVU0dhBdMtA8ZpUFfqwy9BxS5s80HD7btGtvI5sE2SmgVKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486529; c=relaxed/simple;
	bh=AudXTLgz8bl9Gq87YovyqDTZ5cXlK+WyCITTn2tCqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhSEz6hpYiy1+5mh0Y7y6kT9CzXSAFr31TU89RgnWJlOZlioORyVoICQbzcZYlNeNrr9qhsS8ChyJkDVhyrIXoxWYFA46mtPWEvz+v+eZZQD79g6MD7UiNzBPxfUTQRESa8bOhbvjac7lx89fh7lhBKfkuQUhF3k4p/KFq0Lg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMEKY0DL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMEKY0DL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f32b1b5429so13119025ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486527; x=1717091327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP+37HoAbnRWxYkSxU+Q255kuctQLJ4X/JRVMf9ilwE=;
        b=XMEKY0DLrokqEJdu6YcQHdip2rBbRrASTse424raosA6D5EkQp6ps3rXfwq80MmDUN
         ZZb9tvqQGYyBXdwsDwwSIszBiqkZXLwUEVsZn065afZjFHFlusakDajKUtq1kQScbVvr
         uSaZJK8nxr43n6BW/GnwObzkM2tgRCFtpx+eTL6REOpC7lJZmQo3g2OfcIcAqlm6cacI
         ctj8dOgSdVYbFc6Dkzjvn+Zyqfm4AZ5phr8Lp0hx2d5fUArmUZA0zJcN07CS/baGLGMw
         HAhqtwF+pCmzM6nOruf33VeWadYMpH87kG5qgeLQsWEAVcLBMBxf7v45/tMnQel+XUn5
         r6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486527; x=1717091327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP+37HoAbnRWxYkSxU+Q255kuctQLJ4X/JRVMf9ilwE=;
        b=DOIkN/AyYbD8vy+86SxuE+azsWUIH2qbNh+4Tj1pFHZ+5jjDuh9pBxtERULWk87TiL
         PWWKKFyM+8N/vjfwPcrpZGo5BkmCfPZi62zq3tuW1L5HCG0LpO97ljX8/sdKuhlSUv9+
         H9pylkuL7d5zkD2roAnQfgDqXDzw1y0esKvpuN+vPNpJ4c7PTaSAA3H+ZI/eLXINaaQJ
         GTSzu0DkPGfUN6D02ZFEIfGM5R7HxIaoxiPEnjHbsmG8D5tJCE8h8XMUCPWqYzOBAsgB
         yBOPNXzTUFl2gq1qK6D9+UZcBP45w48WyTSPyVjz7PNn/ohbCWZKKIGq3iwOutdW/giN
         U4pA==
X-Forwarded-Encrypted: i=1; AJvYcCX+iy8Zx1KUMMOhj28fnGnjkJ2sfA0T4ECYqaHj1nVua7qcJaiipep6N6qFbsrvO4QZINMniOliJY6Po89VN8Apv6C+hHORrGrj
X-Gm-Message-State: AOJu0YwR7pkvW7pAG2WUMx9o4BN75Te7pt7+9rD/sLH4OpHT3ckJZtvL
	rbM+8bSX2m6lrGPu4l/nLjqBuVhpKdDnI1FUljn5r4uADfgujUFe
X-Google-Smtp-Source: AGHT+IEe0mgnI5pXbKqlTk1fSEV++VaFM84jJggzb34ACdBzCaJNjvCav9SzhD1YF00KP+e8DzZwqw==
X-Received: by 2002:a17:902:f549:b0:1f0:98f2:7cc6 with SMTP id d9443c01a7336-1f4497df612mr317095ad.45.1716486527371;
        Thu, 23 May 2024 10:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:47 -0700 (PDT)
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
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 06/14] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Thu, 23 May 2024 10:44:46 -0700
Message-ID: <20240523174651.1089554-7-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
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

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7194c8f902..06c6f9bb78 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,50 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
+    if (region_base % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region base not aligned to 0x%lx",
+                   CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
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
@@ -635,6 +680,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->dc.num_regions > 0) {
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_append_hint(errp, "setup DC regions failed");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -930,6 +982,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

