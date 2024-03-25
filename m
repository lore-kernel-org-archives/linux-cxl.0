Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37DDF55
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393479; cv=none; b=F66TGHYC03USpORD+oObh+Ho5wxxL3zf2oHE0Imdz90E+4QzfmcQovg/HydpdbG2F5auKw/AQLf8mlxXsapuEfExwFLIKdcb1D7uwj29UdEPohBoWSxYDu+v99kJfZFsNiVn4m/uCVkxUp/ML4gt6PMQpeaHAY5WV7LGN6PJI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393479; c=relaxed/simple;
	bh=mlfiT0e5J1VKDXSWHQx/SOiMufVP7Vqtegrajei8his=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ4P8bfWHzRARADHa5yyPuu4slpaXuhrXf6BJejo7CCnqVuqP7Zh5cT+c2lTw1dz1daWhXwnpsQyyDvHf30CQ8D1HeioZLjtg/wjl+L6h7twpSkJsgybnKwXRS47JtqLVx5Oi4tSTLkb/Z54MrvO+QIUsb17hL4Dm2Xz9tHuzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJq/1ZHk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJq/1ZHk"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so3279873b3a.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393477; x=1711998277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKnc16xzirIXrAZVe71LIxoKevlODpLkYCNSN1H5wx0=;
        b=RJq/1ZHkRM5ytUafJ3OpkMWHrJSBSyoc6g41myhie+hzSTSITVyop/gW52pEXRZmuB
         nOEHBcZ9BSWM6iD4PrifMvR36UFURIPUDpLbIiPNfKirbvege8UPdCD2J6e3ePZGQJ6s
         mmDOjS4/Abi5xKTLOorFes49U80Sps4bbbQlSKfRgqA3P0jzpcsATPVu+RH4xmkZvsvg
         kHPRve0+NzbYb1tqn4FurVcPXYm4r95MWySppsff5PDDJ2LslOpwuxV47sofIWSwi2vg
         +rDwARLK1hOJHG67yMedZYh1KQXgIZXWe9AUIS6sO8TSJg30C9M73FQ7gaj54UCcnr/r
         e8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393477; x=1711998277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKnc16xzirIXrAZVe71LIxoKevlODpLkYCNSN1H5wx0=;
        b=GQK4Yw2cJs/4j3LuEwB6VWXMLpar8eO/XU5dlW95kXCYloFqcglV3sBxLbOI3UcIAY
         d8/qjDsjgYtH4VsA+eJZ9Z1NZyEJ5WHrITuxZt5Cl8wZHCN0+3qIGuQfy9FSNAs30Buk
         X1TA/9s+jduIqn9OWU5DlXO+gUWkpiv+EOtUqJ3jvtcPsT54i/+CtLQIHbYQ/u5feeWl
         uWA82CkyCr49T6vakR3GJ20wCZIu2xXLuYxhIZs97bz/8lASLSQ9XXFSqhoIIrs+9wrT
         wb4y6oSxTFUvlTyXII3P3o8icJSWRnth5CMy6tBY7JUW7B7oi4Ua9ItM4cef5YZuYNA5
         6mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaGZFr6S80299zNMR8hIZ0kBGdQg7ompBDvW2a2yBrh3ZTt4cGoL1V18sY40WzkLPKlB+sV1CrJ8lOox6UgI84F+n7QGvGBZYW
X-Gm-Message-State: AOJu0YzonBhLOpf0ypAm77MnaBasXgZSc86Ze3i/Ugd/gbyLB/3Cx6ev
	ZCJsDqbG1q8W+IE8CUsvjeLb+/hT/CiiHHsVDrmhmUU9NV/7VbIL
X-Google-Smtp-Source: AGHT+IGUNI8lrtdXnyQikcaBV7W7iMTI9ww/WxghqB3THSxV9ohDmqqaQaFdUnjSqcZVFPjmyDpBqQ==
X-Received: by 2002:a05:6a20:158c:b0:1a3:68ff:5805 with SMTP id h12-20020a056a20158c00b001a368ff5805mr7672803pzj.44.1711393477474;
        Mon, 25 Mar 2024 12:04:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:37 -0700 (PDT)
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
Subject: [PATCH v6 05/12] hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Date: Mon, 25 Mar 2024 12:02:23 -0700
Message-ID: <20240325190339.696686-6-nifan.cxl@gmail.com>
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c83d6f8004..a9e8bdc436 100644
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

