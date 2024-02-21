Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB085299
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539677; cv=none; b=bG8IFU5aAIwFFhY0RP/hmO6QOrjRxZQnIqUoAfSIwYYmpeVLNgPuq11rk6oqqrhKTi7BtMDcbotBYaMd+Y69jifMALiBr4n13RlLpn1KBvj4raqy5h8YBp8SKWMhn2wVQxOBeRoYmKmWPfTGwRwvIWzWC5ieojwBr9qAnGWMKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539677; c=relaxed/simple;
	bh=XhwQLCsT4y4NxoCTZskeCpEF4H1oP/DoZP3twHS5YYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0vm8Y/x/3Bw+FefHv5iwu0vtMkRy9cZEaPtsIjRITKIRvPr7Rgrhoo92UkvioyMlzEmLUgg0hCyUJaMkFfnQnByIoGzio149T8fKKMaw091w7Dcxcoji4HcK7KvL5IDxMtb/Gb1CnCJYyvcTaRmLhZBQaf8Ojg3ByON+O8wY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXxDEHPX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXxDEHPX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so1688680a91.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539675; x=1709144475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJqQjnlAGwd774HUXqTHZfBD58qfYj95z3AiQp1cluE=;
        b=VXxDEHPXVox+Y2ULGfSJ4PIgnLT+ZkbXY00ccgzGxWjpERBk/5Vr5YxQbFe/9Lx4Rn
         J+7T7c5W/TbupP9DbY1SLH8sxp5HBpudG+OkXGpWEMmtBxS6eU5kXtIiu/MKUGJLAbcG
         KaekOGRC8DF3PAb5UTjx69Dc6R1ZFZtTcDm43ur4s+zB39JUWsf0AF6hITsiYqefEt+v
         8YXVp1D8lI3HwmEfkqvFxbDksIp6ntj8OIq6MaxDLJSLyQ2rC01keeW2iR+UNTgdA9Sl
         WepTNBgfy7t3Bqe30c1gOASvs17Fuixs/1jrkQ2ezlSOH8sU/Von6MG6VStRvV0qLlq/
         QrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539675; x=1709144475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJqQjnlAGwd774HUXqTHZfBD58qfYj95z3AiQp1cluE=;
        b=OgKJL+Vk6dRksiE5Z304Cxow59fVPIzRkYkltLp+TRbCspHabK0ZgxDX9Sf55pxb/x
         NRtDrPSJcc+tqIDaJDZ+DIZi92ucHvhbUdGRGiX4Dn5GWNe7QwlR6mxadi8ZnmjcSXNp
         5AKldgbScbpxjulAobLvY2MLnWUEx2SmdukSU7qLyNyinng7S9zWG/E1cJcGcoQvQo73
         iC3ReoMKTwcZFzRbqTyGesAi1+ClKnH8UvR06BdOrMmsyr+5isOx2Vx0LLtKa4ZqPfgS
         qNhel0EDg2k1pLbFR6Euvi28u7wmC4uIybpBn40wbmC5MsyNDYtxOZd/vxlRdxaOcD1B
         936A==
X-Forwarded-Encrypted: i=1; AJvYcCXv6Y70uA5muS06asD5YpoAVj5sTZnI9MBVWglUeQxFrbwV+sFnHL9yrq9r4156K59wi7nseCS8ga+BPDEbZS2rk7wvgcOyYJ5x
X-Gm-Message-State: AOJu0YzbgUcxeKBSz+MfO5T50E6u7KuSL9kIdAjWwwf5WNakgG4ECWXH
	Lw34uu3xD5JFv4iiPMokOPfbos5DtzF8zh4DwRS1gMHUM9GROXTW
X-Google-Smtp-Source: AGHT+IGIpQfawDAr7HNOdT8nJf9XYpRgVO5h7M9s1ju3JADRvCiD6h78Yzt+I16QV7f+Bfep1X3C2g==
X-Received: by 2002:a17:90a:fa0c:b0:299:2ed1:d462 with SMTP id cm12-20020a17090afa0c00b002992ed1d462mr13082477pjb.6.1708539675466;
        Wed, 21 Feb 2024 10:21:15 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:15 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Wed, 21 Feb 2024 10:15:57 -0800
Message-ID: <20240221182020.1086096-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
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

However, we cannot really read/write to the DC regions due to lack of
1. host backend and address space setup for DC regions;
2. mailbox command support for adding/releasing DC extents.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 244d2b5fd5..c61cd2b5ac 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -567,6 +567,40 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
+    CXLDCDRegion *region;
+
+    if (ct3d->hostvmem) {
+        region_base += ct3d->hostvmem->size;
+    }
+    if (ct3d->hostpmem) {
+        region_base += ct3d->hostpmem->size;
+    }
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        region->base = region_base;
+        region->decode_len = decode_len;
+        region->len = region_len;
+        region->block_size = blk_size;
+        /* dsmad_handle is set when creating cdat table entries */
+        region->flags = 0;
+
+        region_base += region->len;
+    }
+
+    return true;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -635,6 +669,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +969,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

