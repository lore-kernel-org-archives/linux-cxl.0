Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B12AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483015; cv=none; b=HKcX7TNDWoUAsDEzq8h4nAGQHujjYe9armeUt7ukncORSZBSnmyGe8wdxWlaiLVBKRxuncrXZYVWnubx60mrd1N2S6pXr4vPmeQlFhr/aAP9O52181U166KVS8FgZtiuHYKs/g9IbTYi/JilIIpQeDqAstSKUQft82BryXBdzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483015; c=relaxed/simple;
	bh=ELAMW9qBwsov19JxnPsdJJPxtz0H+kXe0UPqPUDCjxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPDzKiWtz1g6C2tAL4PhVPSdRMA9igaTSZAWa7W3s3TZhQkiaCO25XCCQ1R2UPVGP1VwMXXnc1gCsv9kVn+7b56t1NrZgtv/6OJ4h6ZA9eDNdNIVFizSk+uyqE1KGqckJib29KboXIrM3vEG1qgCL557QqWESj01baD+/uF5Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYCIApV4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYCIApV4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed112c64beso1325136b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483013; x=1714087813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggrpoa55J+CuYa6WaJVJnd/Z1hpjsnV4FDGSfq86nOQ=;
        b=JYCIApV4zspdbip9o46hzxqpglLTL0AuaL7GZM4aGLHCkvfVRfobZO1QJQs71MBhL+
         uz9Kqsh/AmKn1dNS/pLofG2Qc+2D/sCt9rtyTWDk+gpNXdiNJ+yVcptUP7b0ixEdDrzF
         bOIdHdtBQ08Usa3BHDoaSedNoZj+VZY0mN4i82b7TQGyl8BJApQhqaPIjVd0NR7ztClg
         ECNZxYk/J1lwuvM6pW7gv/dwQQGs6nj+iDFKdtop7TWjp5Bvfm7zArq8gAGWh8ZF5UDs
         PYy/EoUhP7Qxw0ssAqNEWOj7NwLom5CLoEf0miI6BPDMfnZMtkh4J39w2Jily7mal4qR
         gBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483013; x=1714087813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ggrpoa55J+CuYa6WaJVJnd/Z1hpjsnV4FDGSfq86nOQ=;
        b=X5TMyDzOY5YA/MKatsHGVktKMi/XShELXrfz/953/N488IsTXid7HeuTEC+uU3Hpcy
         GRvDtRXO426nfvXU4MrXFO+yc26r8HjT6YgsDUIKKgWlAnHCoXRxFY1qgK/0SJuEzmgJ
         rBIzPArmN/2e2ECJE73f2pwgyRKsL59EWuNwuDvtBCC53aUY7DvY2qPYkj80ssq1iBDR
         PjSMuNqveTmqyJEEerUZ0GIFhRriKnEBgaUWHgBI1r1xB6Jzb9GcR90RMXlAbLqchWj4
         0s4dMHbaRRV/oyYBmTqBS0CvhLayZvfNjOL0DNYShR8GfNNSy3ugRAMwwhZLaDFYtUI8
         2U5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKDqfdQHAoj4XdhzzwFuDKdeOazl+KzT8LNDRnXys2TX4U2xTXLVj+Ktogert/f5Q+ELN4ljBmjkxUCGIE0wiYIBUABwn8TN/K
X-Gm-Message-State: AOJu0Yydc2hzmWCqM5JeNo57bpmfa1ObY0O5CqJkMGiK21S05Mlnwn2X
	IMO1aNeiu2IGVA52KBZkvuLA35X6PWGiO+cCFMDmoWGMK6VE387+
X-Google-Smtp-Source: AGHT+IFzgF73P2kI4foReYX74Mh4RfoG1oX0kH4u/p06dPT/Tbq0J7QDVqdIYlKQaXMV/Vaon1Tgtg==
X-Received: by 2002:a05:6a00:27a0:b0:6ea:7981:d40b with SMTP id bd32-20020a056a0027a000b006ea7981d40bmr713005pfb.16.1713483012793;
        Thu, 18 Apr 2024 16:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:12 -0700 (PDT)
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
Subject: [PATCH v7 05/12] hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Date: Thu, 18 Apr 2024 16:10:56 -0700
Message-ID: <20240418232902.583744-6-fan.ni@samsung.com>
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5ceed0ab4c..a1fe268560 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -44,7 +44,7 @@ enum {
 };
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                          int dsmad_handle, MemoryRegion *mr,
+                                          int dsmad_handle, uint64_t size,
                                           bool is_pmem, uint64_t dpa_base)
 {
     CDATDsmas *dsmas;
@@ -63,7 +63,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -132,7 +132,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -149,6 +149,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
@@ -163,6 +164,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -171,21 +173,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = memory_region_size(nonvolatile_mr);
     }
 
     table = g_malloc0(len * sizeof(*table));
 
     /* Now fill them in */
     if (volatile_mr) {
-        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
                                       false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
-        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
+        uint64_t base = vmr_size;
         ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                      nonvolatile_mr, true, base);
+                                      pmr_size, true, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
     assert(len == cur_ent);
-- 
2.43.0

