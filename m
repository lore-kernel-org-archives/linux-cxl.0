Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC031B3B2F;
	Mon,  9 Sep 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873661; cv=none; b=gTZKtE0wawTNSQzKJt85hEHyYFPHqzpcD8s1L9m95zsP4BRHD8go69u0OKVXCa+h01cCrcK9FH+YINLf79oEbO/Db9+qBn0NBy5hAFbgWu8+UK/X/1EeSYzp+GXXLT5hVGgWjc+Cpo1Q2fJyjO1mA9tymbUfpBLPfbepkxmSyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873661; c=relaxed/simple;
	bh=TJq1nvR0rf3j+JkErKdsYvqOcBWi6G4yVRoLRKv6cV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gd7zWAZ8VVymF/p5zt3gzH2zyM/bRpCZBthLJy8o4+UOQmSPfmNwAOLtGj5Tw5QBMX8V0AabizA4c5/ZP7Uv3/y/Zca09ZA80lzkykrM7pcGGCy5jKoZauISHQkoaxGgIceVZzJSTrQKluOKTKIwBJ8QvODV/CpiNfL7Wd6R4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIZrgtIx; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIZrgtIx"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20573eb852aso33979145ad.1;
        Mon, 09 Sep 2024 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873659; x=1726478459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8oJcgmLJj/vtZTNDCjHyX3EWWzSoBqFkOBi+RgnpsA=;
        b=FIZrgtIx4IYROxwGj/eRL+88mDQ4xAE31ZqIBdTvdTCeSSEgEutez9Umu2qAOSoaiU
         QWhVW/tteEJm0DpD/f906iCuGa4e6zLSV7C58nXPE5kmCbog5tZWgGqYy0GRE0jKShX0
         nyfGnzFC5sGKUnraWZd11ky4r5qQLjUuPxIMFgjLDofWtw7kzKMdLZMCbocJwWP1HOdj
         PwRmx8uOKPRcbuR29BbAHfAay0B4qXEqesYXAHiexIFAkJrduZWwxVyd+sr5GksLfXsy
         LpcOUi+3LvtO54fGVnQYzgphHsl+Xa1vMyMP1DoBooWnCzliYSz0c0GtBA2R+TnV7Ljq
         /HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873659; x=1726478459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8oJcgmLJj/vtZTNDCjHyX3EWWzSoBqFkOBi+RgnpsA=;
        b=dPmpN75cSQ0QIp6rRQgTwlh5JsZxoeE8w1WPZLoA+cBNB4B801+wzISAIe8bkLMqLZ
         FUM2jhr6wic9QmqLcckFVxDf4OMS5nf2JodcqSDYuJKA6ihmJj5B5TyHVWCFaUR6Ar/P
         O4U/umeNIFsa0Tczv3phqkVVW6p7KR98lhLyxngH29tTHGbsdCwWDoczmCRoAv6d10bO
         etK9t6RTbq9aABZ2alp9VRzpH5HtIQoGfUbW69QXsm8jcG3heWjaIiNCpwGexexbrDZb
         2QInzhRZcRalYrOBDYYkjKmeycK9DWmteuveIrLzWk9PZuSXfwogC9lOmlCEOw8Yqj9e
         uSdA==
X-Forwarded-Encrypted: i=1; AJvYcCWiYuSShI9uINiG+bAAcLNUjrzsV6V5tLXk9VQUSvnCzWbJJ7pEBCg/oDwrreK6Hd8k9Hy7ySo+RURjLos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5ZuwwfsI6j5hgAy7bWEQsQjzLpTQbDF/L3nyLfN4jfNdma6F
	6lPf2qhFWiD2HYWnkJ9GT8Lt6KGTTIxntyZoUzRldBSlCVHTfzD+zevp0MtxKWrPWw==
X-Google-Smtp-Source: AGHT+IHSLSuKhFpOhxjR4Jw7h+UXkXnwGndUpE57b1vk6Nt2lt3ZBV77mon2JQgxoq8gN08E/K+Keg==
X-Received: by 2002:a17:903:22ca:b0:205:5a3f:76b2 with SMTP id d9443c01a7336-206b848994fmr251370545ad.29.1725873658471;
        Mon, 09 Sep 2024 02:20:58 -0700 (PDT)
Received: from localhost.localdomain ([223.104.134.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241be93asm3589403a12.42.2024.09.09.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:20:58 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] test: add cxl region test template
Date: Mon,  9 Sep 2024 17:19:38 +0800
Message-Id: <20240909091938.27647-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL2.0 support dynamic provisioning of new memory region,
add cxl region test template

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
---
 MAINTAINERS                         | 1 +
 tools/testing/cxl/Kbuild            | 6 ++++++
 tools/testing/cxl/cxl_region_test.c | 6 ++++++
 tools/testing/cxl/test/cxl.c        | 1 +
 4 files changed, 14 insertions(+)
 create mode 100644 tools/testing/cxl/cxl_region_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10430778c998..708407d34584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5616,6 +5616,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
+M:	luzhixing12345 <luzhixing12345@gmail.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3d1ca9e38b1f..8b430274a1ad 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -67,6 +67,12 @@ cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
 
+obj-m += cxl_region.o
+
+cxl_region-y += $(CXL_CORE_SRC)/region.o
+cxl_region-y += config_check.o
+cxl_region-y += cxl_region_test.o
+
 KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
 
 obj-m += test/
diff --git a/tools/testing/cxl/cxl_region_test.c b/tools/testing/cxl/cxl_region_test.c
new file mode 100644
index 000000000000..c5859a96e35b
--- /dev/null
+++ b/tools/testing/cxl/cxl_region_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_region);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..320aaed2df17 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1304,6 +1304,7 @@ static __init int cxl_test_init(void)
 	cxl_mem_test();
 	cxl_pmem_test();
 	cxl_port_test();
+	cxl_region_test();
 
 	register_cxl_mock_ops(&cxl_mock_ops);
 
-- 
2.34.1

