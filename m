Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06F7995B
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581455; cv=none; b=BSL4szSruN+ZC70rPHHriSKukoiDjrqFF56rc+JcAOYhaqTKEqmEOjENXfriweur3RxmMtpIABZ+HQK796MAab7ENqozR/9AxDPQo9i7yZjQvu1knVT3C+ol/g2MYltAmE81/0zBRSzZEQMtGs46MJc+bAFjwk51VaBa0OfwBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581455; c=relaxed/simple;
	bh=KV5t5EDxM1Twm6IkWpgwsiNgnIc9JtxZq0y8ve0PU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwir5YI+YLfTB4daFEO+Al7Rp1kzTecX6yzlrr5JpEVSy4myObMxOhgBXgeE7ZBBCj2+FRyhDd85YMx2OjRJJMW/ROwEjyvlnyERxm2aWhmHFzTqD0iIJICj+DQv98TLEBOs0DpTkCDKN0Gt5sXQRaOCUJpUE7qe5b6LQKAyt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC66557p; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC66557p"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6093e067220so44616507b3.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581453; x=1710186253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbOcnbLy9moWsSBbE+Q42MVGWhpKJBtzuH2spFlbBIc=;
        b=ZC66557plN4KI5GYtb/H7cOuYa1qV3/K7V/NEHlSZo3lI0Fq88Cn6tnifBmZu6FKoa
         TYfjbKREyr5+Hfvs8mMcx/l5f7wNBRuoEPbhtpZxy2NheoCzzOZcdvbmLbnrUcRStIKS
         lFd6VFkjs3pZXodY1RT2VGEDjyZgFvuUBpzcu+Su7/tamnRmhJgIFZ9ER9eZvKLVtnOx
         r2all6cCEml/ZyJwu69zbXQLTxSIgLCMoudrgIi53eyp14qmnDXeqZxLz2/UESMfqn1f
         uFDpNj5xYlokDVhQgqqfJbT+j2Esecs2avP6yXgJSqs5dQhFi+4IpRgcVYz1EAt4TYCO
         4knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581453; x=1710186253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbOcnbLy9moWsSBbE+Q42MVGWhpKJBtzuH2spFlbBIc=;
        b=SD65PmLenlJ7WWc/ezXNkTSZRJigVOkdJJNs55H0kbkRPR9ro04Pg2H/gt+8adWYol
         vwIvHCgRZnKNMnyJmpB7Jm3J840AVHZzLzlXpEwKner+oiWvahLj//XmqVVxx9nJLTh+
         GWj33IV/1wNvF9W8pTZqGXJ5+QLLuG6742KCxxTxDrsmeAY3KKnbGgVsu29XKPd6fcr7
         EmFr6q0dEfRMy2QFpwGni4Wf57S0rbbMMFr9pphmfLbJLdH+wqXe/jpXXsZp6Uj94p1P
         3BjEcDxywkP+9Pcgpg/DAzJWmMfkMUDI+BPegKI+Yv8I/QGwJvzMEVVBFrF1oTVIRh9A
         bmRA==
X-Forwarded-Encrypted: i=1; AJvYcCU1tfMC2R1iPbjU2y4AWRCi7APeF/ifIIYeXmce/Mjl6sse9aVwHUZsVRo8bLVr156wvOtaJp3r3izGd7JQDivbKtpBsTL5Yr0O
X-Gm-Message-State: AOJu0YypOkt5MsG5wqdlM7QQftBTAYgJigJJtszHbWdjUA68WINeKLR4
	Q0Na3yVmuyx0NPwXOEvmHvlfXLvsruQ2SLuR9g4wgVXE4wA1QNLj
X-Google-Smtp-Source: AGHT+IFj/6AKOb01CS8iZ0cx8I6hTpu+7AdNBUdow4ScUYPauwu6XEYgtcZPPXwXUBAP+6x/56QZMw==
X-Received: by 2002:a25:9d88:0:b0:dcb:aa26:50fe with SMTP id v8-20020a259d88000000b00dcbaa2650femr6868080ybp.15.1709581452753;
        Mon, 04 Mar 2024 11:44:12 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:12 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 04/13] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date: Mon,  4 Mar 2024 11:33:59 -0800
Message-ID: <20240304194331.1586191-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
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

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 244d2b5fd5..a191211009 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,45 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
@@ -635,6 +675,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +975,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

