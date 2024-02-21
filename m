Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FE8562D
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539679; cv=none; b=n8v+/6BXAFGrKZl8iyL2+TAJ3sEf2XVxGZts14/LthRbAc2MCDtH3QswFrhmeaB7FlcUr941jcrOIOCvW7yZ+lG+02QWD6330LpdVhD9/0oyPrwjOxb818lTb+ecLHlI5maODm5waATYVvx47AxJnt9VfcAqlLAF6KKfek5D8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539679; c=relaxed/simple;
	bh=zTqh34z/H70305+jtLk6lO1wrIbIYiaObLrOdQdgXzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC0cVmFfTZlfKLyRJ4w5rhKq+cm7dyt18aHOnHJ4Z6v2oj0jhtSFa1LjK3/zkIxDRhT42eo4PZ8uqXHBuYXCP1mDiJfxKBfO6he1Z+oa1LiHYq7oy0wf0rEV7Klykkc3S1o3feJKOyO34Edgx8BhwC/Cc7iIhvs27gL1AckbgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhdwHJ7d; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhdwHJ7d"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4774670a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539677; x=1709144477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiSoVZJtjOJJ7IGlGmk8cRI2lGtWO4AhdMc312mNoV4=;
        b=PhdwHJ7d2neAPfJineKejxQM3yl9BznaP7zCWTOrFpDyPG+yglSG9Fe8bXzgfwwhH/
         IIPRc/bcprZwjvYdADRQvkeYVRHFDzixRQACFPCkk9P+OuKjTn/6yjPBQBAgcSyuRD+A
         VElTvkiws8M6rs3cyQOMmKW1viPzZji1wQfKAbN0e8sZP8rxxaDOFSeT7DRwHsuO6QOH
         yesW8ku2MCUtmv7+Wi0ITpiN+bjUHjTkzH0HYBOsFjFM0URadTdffF75/A0xh8UmRxtB
         ZXgRm5kk0mpiOLkfxu4X2BRnl0TmNjv/bfbgkVBzuHA3WlMsHiKIa7ibCdVxlexloLOL
         IXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539677; x=1709144477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiSoVZJtjOJJ7IGlGmk8cRI2lGtWO4AhdMc312mNoV4=;
        b=HOXDtZ01S0WBjGyjZv9lY/b8DXHC1FKjm/QyfsMBZemeo8lsg08Ehd3wcglFtIQmhQ
         88sRfL5hwcqyZm9+0a6IGt0e32jHoaxdFNtUCkoU0AJ/fToVlxeaJ4sheXdgFV3EhQAZ
         2KbG1fkgemGHSpMKa05dBqG3fYi/hHvrTfTRbM/5Ip4pmtJ3Ky3uczEx0hHIPD6JTD6U
         kUUAiNqG5kpegcTKnAU7q1yDsp3ZyDdEsUCdwAlGI713M2jjIHxp7bkKUnZnJKpnb4Aj
         sTTVlyXgTnaTQu29NSQ+mf7oJSg0d7Wj3xUhk7mPvDofx1z9rUD1kixFFd+Rom5PYash
         EsBw==
X-Forwarded-Encrypted: i=1; AJvYcCXkLXtOJfe9C+0Kci41jEyr/fgRItMEpfYOaNUYGGJ9ULWoAKqVDkZAdtXjxuC6bK+nGXdJYvOq0Xx2lNsapGqkP+l31QF4mew7
X-Gm-Message-State: AOJu0Yy9VVyg9ZEKZl9FjvQR9znpFUQrZ9YFXpjuTH5uy4LAro8cxkyM
	gJZbob1We1AyMrxoGMjvnk9kJ2axzK8Ldjy2x9w0Ml6X7BKxFDQj
X-Google-Smtp-Source: AGHT+IGAk48olbaYcijRDumKRKOL973AAWX5mM+93KfBcG5wDx9QsekZGw40m+D/x9wD0JEaDPXDfg==
X-Received: by 2002:a17:90a:cc9:b0:297:24da:887e with SMTP id 9-20020a17090a0cc900b0029724da887emr15889680pjt.18.1708539676735;
        Wed, 21 Feb 2024 10:21:16 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:16 -0800 (PST)
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
Subject: [PATCH v4 05/10] hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size insead of mr as argument
Date: Wed, 21 Feb 2024 10:15:58 -0800
Message-ID: <20240221182020.1086096-6-nifan.cxl@gmail.com>
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c61cd2b5ac..6e5f908fb1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -43,7 +43,7 @@ enum {
 };
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                          int dsmad_handle, MemoryRegion *mr,
+                                          int dsmad_handle, uint64_t size,
                                           bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
@@ -62,7 +62,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -131,7 +131,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -148,6 +148,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
@@ -162,6 +163,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -170,21 +172,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
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

