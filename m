Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828D78664
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581456; cv=none; b=CtAJMoKxHOFgTWXZVax8um3JL5odbRaqooeSyqO7NEAGU9nvcMpajB32W40XEDYsQjmzNjnuIpOd7WedOPZNjJh/gr5AckuIL6VqV5Jn/bflKZiSyqLYKVZb5ncWviXDcBlubtKcA1PnLdIGyByy9ADv3gjQvMu79OBZdKnQuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581456; c=relaxed/simple;
	bh=fSXXGXgXBdC7tFiMMXx33MQFn1N/OaZS7IeVp70U0gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpKo0slPpQc3qMAfdzj2wl0b7GUfnIt9wFVtODa/EJv0z1im/Dor70l6Jw9vYvUjHM0+BTRBkeDs+kQGHwOEtz5CaxpwioUOJqywRfLPIEgnas47ufaFPfOLE8UCOQjln2OKOmy9ZiB99zQruHzTPXLP6MJoQLUd2WpBS/K7bXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOVLUA9A; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOVLUA9A"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4614019276.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581454; x=1710186254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOJjP1Hc+ZaCeqP1kL3i8IBpTTnk/Z2dT1K8zGM/Ls8=;
        b=KOVLUA9ADB3bG0jCL5N7lLkNQl5jOS7kFJvT+nQBSFXnO8gpHwGbYFhAGpCKaowuQ6
         4ufjrjBDfA93YgG1Bf4Hr64q/5LQS696Ny4834E36jyTKJ4U3h9r0yoBmRtTgKbn7K+f
         zoE4c6ft9L6Y4CjmqAXRstriHB1Enf+LHexPJTU0kdiWKurbX5cTnmGQd8IpvEkiewA5
         MFY7rTGwgE0Ly42ry6ROTjLPgHriB6lfclomYc1i5tLg3cr1dOg2NdghmHDb28cu3W/o
         KMHs1kJ3u6oXxkNhEqcWvSY75M9X2pIG9FVO9YBwT2e3NB+MlbVJQSODDplK1BXM8Qmr
         yG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581454; x=1710186254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOJjP1Hc+ZaCeqP1kL3i8IBpTTnk/Z2dT1K8zGM/Ls8=;
        b=jnHpehSGSTCJDmEsi9258iWFLh80oVuzF+yfPPh6ITOCkOqbVgzSkt+ucNK2zXbRuo
         X9d35oW6HP6v2eBjvrdPVTKMPREVxTGUhAG6cuN5bPs6cm3x76JhjhY0Sa3vT4GTBSaY
         8uRh4bIS28pMaInEO9tmKiT0P7K68JWyI/q4H1N9otEYTRZT+C4sqQ7Hz/vy9raJSYFE
         wksR2Ix40BJ1RSSYV3SNPomuqzIVEFY3npkMeZlnrjTbz798NVrFwT3KZSBydHLyqBwa
         pGuptO1TLk2EmyTK5kgPVhrUWyN1K2lwpm69wDIdIdy4j+VcrVqXYtL8U0VFiHLmlue1
         jk0w==
X-Forwarded-Encrypted: i=1; AJvYcCVGxwig3JRDC51n8/FDeCUiw3QB6aPzEjqwIxYT2PtZZybZKbIDlXS0DSC2bZljMd7gGFYs2qObBBFDV8lEwGDiKZFI+6ttAZ+q
X-Gm-Message-State: AOJu0Ywwb4Cz4CpVHgD1UtjoWWulzagrh0JD5AxbevLtUVeHzx+h/wOi
	TRXRlUB/XLXSafBxjE1MxUm9etuaib3J1VS81SMWqlJGTwvueS/h
X-Google-Smtp-Source: AGHT+IFL7lKbuf/q1X2xmA0sVMudvhJVA07sf4CQSydEOjZZtUETHFFOZl201CiddOHVU9PW/PCFSQ==
X-Received: by 2002:a05:6902:2306:b0:dc7:496e:42e1 with SMTP id do6-20020a056902230600b00dc7496e42e1mr7811375ybb.51.1709581454151;
        Mon, 04 Mar 2024 11:44:14 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:13 -0800 (PST)
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
Subject: [PATCH v5 05/13] hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size insead of mr as argument
Date: Mon,  4 Mar 2024 11:34:00 -0800
Message-ID: <20240304194331.1586191-6-nifan.cxl@gmail.com>
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a191211009..c045fee32d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -44,7 +44,7 @@ enum {
 };
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                          int dsmad_handle, MemoryRegion *mr,
+                                          int dsmad_handle, uint64_t size,
                                           bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
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

