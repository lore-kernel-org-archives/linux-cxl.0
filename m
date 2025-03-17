Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806E1AED5C
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229810; cv=none; b=O+m+3Dho5KpLd2Yqsuzv+ugjwgrB0BtUqCx64lCuTrezoCc6E5VayqRvzDOiIGKaSOkC3ny/uf12FdvHCmbXg9H0taVfcg4z7F8QJX89R4ctisjrlMAZbACrM3N4E+TTclxAhiXVldXsvVTOrylmViiMcxnkHt+rQkxmLNajktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229810; c=relaxed/simple;
	bh=V4IxtuAAh2wuDez/eYzVM5zKs+LDOcNjr2VpJB9ypO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzkJgooy3omLRysbb4ZyTNGrhi1zFS37oEL9uWouS+MscVzor3Q6WAYR2YDAChJ2RZnFTntBlVXZU0cI1bzm20Q8YOy1uiFU/ZtPEKmoDUSpu8MEBNzk8N5gZl/egQoLj7GEq8MbjkkrvwfS2u/Z5iuAaSOp8PdCwoHtW2BGUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OloEBJG+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OloEBJG+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224100e9a5cso89327725ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229808; x=1742834608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAaLVmqu9E16HyMGv9eV8vHzoQlr4XWZ3Yj3gmP1ZVU=;
        b=OloEBJG+60aG74VW1AebPI7cG5B9Ewid+OS5/m2lW4OPP/Jbq5x3lM0K7g/FKTIigh
         u+AUIDcpPz59BSIOQq6rVyzJBDKsZDCw86gL5IlnkPcVdyyT+NAYafoXTJgbOWN72qP8
         gJrL6TwrM2Ufcw2hGkdYIbtKY8Qg0ouc4uaKbpD5bTC6YIXtQZtJeZ27Rqw79vuFWz02
         EmqgSt0wJm6itckbMRj8y+gP24WCD0WTWnooPZiXgshGjxaVKpNvUvoSmCC4b+0APsJS
         a62KMTRYNnVzced2/dfP789O3Cx/dd6AlSYaCjaTJ0/uHn8p2mPSDTphSoEeLNACJb2N
         m4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229808; x=1742834608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAaLVmqu9E16HyMGv9eV8vHzoQlr4XWZ3Yj3gmP1ZVU=;
        b=lFZ5BFzw621cjnkXKGRn2oH+l2csLWHxXzr9arwZYvyVeZ1/mvmXw7b3OWKlyvdn3g
         b6GUAx3G4aCTGiUrC7ybd0BIwysOJHFkIyeu69EW+D+/QzHfFKuDoabSonkh0PXPQqjA
         Hi+oN7w/7i+XmJaf1hsmxVzRieRlCCRLsmPWoJG1723j4VFgBjo7KnGEYXT1ctsG49e3
         AnUuA1gk4ivo4PbV5Emvrx23H1vPuXxAc9KVonoDOoPrEKoSRVFj304r3CEKQLI4kS/R
         z0SU6hm13/qOyN3su3ihXrUC9ydmFu8JwU7z5YvVVO2o+tlj9PaD+asLfqyQKuScPXWr
         fzGw==
X-Forwarded-Encrypted: i=1; AJvYcCXPMdid6+bVg+/5a+zS+Vauyz8AM1AH5Q8VI6tVUGn5aVyPswID/gfKnkZe5HOA00gUgK12IoXN5CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTQNAeY0sdRVY5RQFI6NWZfqY+sfo0lDHHnSwmLhYULID3M1e
	XEceS9xvGYnG5rHCjsQXV8qs+dIi1Sl2quRoZ+HFMk8u9g1jjfd5O0b+mg==
X-Gm-Gg: ASbGncvJWGnYkkY1YQ/fjwZM3xABhbZUXwiPB/wluGJGxl9RWW9gfoxlDA2rdOxlmZd
	fCSZe+QokxGAhM8aSga4jfFPikwCTI4Td6VvK4p2Uf34mEUH76/vlihflMvuGz95KsF7/EDoHp2
	o35pmhm02gtOXAfvtABtnuuR4/N7NShXOZ2VmmgG5x6jcFTS0NCe9FPeo9BFnqIq+qzMy43XjJB
	uo4WZbcxSjBj7uKudND21Bgc1FXBJKp0KGzBUXr20Wji6TXe8ZweXRzxYIAybnY8Y6JJnL6dL3r
	iGhB7UWA6xOKbbnVVB5dBBKT9LY9Bnu2lOOjv1ykOVVg+qC2/ACK9WqU707llPn/FQ==
X-Google-Smtp-Source: AGHT+IGkTtuuqZhQdLdpoG9OkgJlR5lZTGZes5mG3fw6uc48OLBRxw/jQmjoTiuqAN7bv3zJRRROTA==
X-Received: by 2002:a17:902:7488:b0:224:826:277f with SMTP id d9443c01a7336-225e0af5bc8mr123722155ad.33.1742229808421;
        Mon, 17 Mar 2025 09:43:28 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:28 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to CXLDCRegion struct
Date: Mon, 17 Mar 2025 16:31:28 +0000
Message-ID: <20250317164204.2299371-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Add supported_blk_size field to CXLDCRegion struct in preparation for
next patch. It is needed by command 0x5600 Get DC Region Config.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 3 +++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..731497ebda 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..bebed04085 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2

