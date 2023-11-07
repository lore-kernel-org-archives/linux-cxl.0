Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3D358AB
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPszRS8I"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865CC0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc29f39e7aso40425255ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380620; x=1699985420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIc7H0VDI7Su5JGUvQgueNQKhCP3W7elx90e94K+TnQ=;
        b=lPszRS8IrvQFtVD2veIUnG6P7bB4AtrQewQ4GuOPtqPhGFZ1gKqkXQ9oXhY7HGX2VP
         W8tnFVvZUXtWaGLKn8LjMkrkLf0kQ2jD7jyWFQpepCUTx/nCOsHjv1Z9+Vx7kKwWcqbO
         VQ+WbVbfchb+6VcDSviD8d9wL7jqb2tP59Jbi/jTMU96pks3mcWXYWz2mVhWnDkDeBDw
         BjySNH/iePi+wAa2NiiYaA1DmP2dFdLyI1WFaHvapPt2OdvqXNmCBQNQy+rqp6xPY1tN
         KjYd649Erpzmqkc2M34pPKsLgl2C64pm90/vuOZXIVr3XBvyzv+BqTL/iYQ0ERgBkWQ3
         /BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380620; x=1699985420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIc7H0VDI7Su5JGUvQgueNQKhCP3W7elx90e94K+TnQ=;
        b=fba8gRBpew7pLH54BqwLktwt4VcMJDzoutudWCXNZ5dhQNvpevwi1IIhBIJ4yka07v
         wSGCm3gkj6xB5YpE8B7o+mbOxYTVqty1kZHshSxFeURD+M+4DT3oVTcE2M9sBfqVCyks
         WWn9EDA4Y/GquWj+5fZQczZbUV4lDNIqeN5ynpexqlzBGPEJl3RZSFUWiPNHR1SpIyXD
         VYLPUdvExqW72btGENbS9n/Z0/+PR9UVXEOEqa7TvkSCeZb5NhfHgjiDuWktWZ/E9Nyf
         vdmKtjxQKydxBaT7+DR7ttiMyLuYQjNxEuumbADbdYa8YJUXDMgUXbkQ6u1asOa6NGEn
         hrXA==
X-Gm-Message-State: AOJu0Ywg1QnJjdn/+lzXI3EO7rsKwZdFEmitfj/AtFypm0BUJ7uV2507
	h1XVCtDIVV+SqhJSxHawfLZBk7INwmU=
X-Google-Smtp-Source: AGHT+IHGNH7ZWpcEDNR+g0tlYCx5gQyhkoR95XBku5YzVtfRDOD5hxW6GKGgVBtcG5+1BC6GyRPz2w==
X-Received: by 2002:a17:902:a418:b0:1cc:2eda:bde6 with SMTP id p24-20020a170902a41800b001cc2edabde6mr26518551plq.34.1699380619857;
        Tue, 07 Nov 2023 10:10:19 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:19 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 4/9] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Tue,  7 Nov 2023 10:07:08 -0800
Message-ID: <20231107180907.553451-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
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
support as below:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 754c885cd1..2d67d2015c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -721,6 +721,36 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+static int cxl_create_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    uint64_t region_base = 0;
+    uint64_t region_len =  2 * GiB;
+    uint64_t decode_len = 8; /* 8*256MB */
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
+    return 0;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -789,6 +819,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (cxl_create_dc_regions(ct3d)) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1108,6 +1142,7 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.42.0

