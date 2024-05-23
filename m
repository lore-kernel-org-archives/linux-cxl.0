Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2717C77
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486531; cv=none; b=IgaNrAEjeRWDea6HUVxpdRMxNaQCfia3vnBmh6knvrastd7FY79BHk3QTFyVrlhnJkOWWKA4+r8Ri+/df+OyNF+hnTZumAUQOFFxY5NMlxVXHy7io0NK6Qg57bbq6ZzCz1engOBkSL2+Pna0GCcgYTeBOnDyXry/5jboi1HSaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486531; c=relaxed/simple;
	bh=mCIT3Osr/CeVAHqGQbFpdYgvI3fwKwfBa2P4sjJEixk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Ke4MXHI105oXJEhRSXl/iCL140O4BV+bIjiNY33eH6IbqWuiZsgIccpNqavGSkUEumEH1OTFZGbAqgu0QBOdAITaORSRBWYR0kVu4EcdfKmATdVeDQJ7e4Br4lrIKIJlbXcbZIyTVymTaHKkZXD6oiYISAAWHHLdWCdDH1hq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+UCs4kO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+UCs4kO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f333e7a669so14323425ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486529; x=1717091329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocPCyo8rhL+lFVIKpLa8nzkC2tFA2ADDZSvrzw2Bp6k=;
        b=T+UCs4kOcxnz4pEtnV3zmib840JIxTAEllC92ZEPX5IgytoSSYjJxQ84q880EcX1qN
         g0KiBSg5peZPoGqCZSWMsBxMSo8O+bUn1xRHXwiKKnSbU4IUWYhIQpNxCAoB2cz6D0Nx
         aUBLEZPpHFiS7AZMqlIc0mk8Bm0VdzQtfND9VS4mmuiMaTzKPDSNZjoSqiZvzEHCmRc3
         HUz3KiUcIIqXZnVLMmjQry9q/UR4KxOEwliUI8CZQiAPVIysrT2J0OFfBRo3ZsPr8GV7
         dyDKclC9cB24fEhPDyTIWqWM6jCNYCqIGOasE5XrcZ+h3zkSoivWMt6T0Ms+E+EQHwpN
         T96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486529; x=1717091329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocPCyo8rhL+lFVIKpLa8nzkC2tFA2ADDZSvrzw2Bp6k=;
        b=eRrE8tDMbudRqsXKEXNrJMFbY+6JAu29jBFpg11+OQWvceCwxLZbXCsfbfyJZIGbEN
         ceVwk6g4aIQIJaqMn0Fk5vqwE99BuEqtOic9PXvqD1Rd/Ca+YTqIMPMgeIdsDvlZSE/n
         MuZiGlaDjHETz1AU62z2mP63eXrwQtGWCICp9E08xH4gtdDNO3f6s1pkjtoaLzj4aqPC
         Gqtqnzmjcs/ft4ezBXf3dAjAso+NtBl1ytiptYOn76Thy+mjvz1E2uuL9/zunumPbs3T
         YVjaGK/XApbQTwDjseqNiyicE7Jrjo2nurefEG69H4ym/GL+so5omyHKIWnGy+9/KmBM
         CJQg==
X-Forwarded-Encrypted: i=1; AJvYcCX1aKAMJfaNYuUL6LKHr2sfWwBI511YywhW2YbSuBG9L6Xyd5JS2po5bqX5s+53tR0ooyleT/yULPjkoowVpMgUqr7AC5ohf9pz
X-Gm-Message-State: AOJu0Yznwje2lJWlJbZF0UosV19cAT3Q9KAGma6utqjlBCWxxSw1pv2V
	b6sv52W5PhPVESe6zNORH+p43fL+DSmJvhlis2zBn21RgslNy4bU
X-Google-Smtp-Source: AGHT+IFswUc2pHV2hG9gPI1WJGwqcncOm/fJ4wA/eCxhF++49CLYGicqoq3D94ExiC3uMcz2ax5Ugw==
X-Received: by 2002:a17:902:f54c:b0:1e4:8eb3:26f5 with SMTP id d9443c01a7336-1f44883b0a7mr569065ad.38.1716486529000;
        Thu, 23 May 2024 10:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:48 -0700 (PDT)
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
Subject: [PATCH v8 07/14] hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Date: Thu, 23 May 2024 10:44:47 -0700
Message-ID: <20240523174651.1089554-8-nifan.cxl@gmail.com>
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 06c6f9bb78..51be50ce87 100644
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

