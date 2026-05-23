Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83B38756E
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529449; cv=none; b=RzMKMEb/mkSO4zYEIhvGmHEr4ZfcpSpn32qWDDWnuA9SJvlSJjp9gHPDsrFEFPE7EcNLnZcPqFxo9A6hjVr7B2w2SEXIbgVJLuhTZvzOKNayE2M+tdWuk2kmCUBQ428hTY4YQgLaEGipNIp0w0dFUZg9uvlian7YQNLjpLlMk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529449; c=relaxed/simple;
	bh=WjyLoGSIFNUpwvHMOZu5vAsTWSXjF5U+cHQ9JDs0GLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo3IdEyXWP/or906a06OKBfE2+w4Y7Xm1Jxp4BdslA/H4eLewXBziWIdBgXI+JU38LwGDsHJx4l7F04Y/CJCLoCxVtK6RXeBo9aVaiR7f2FdCpXpnx+6k0pVAmRWF3Zjy69lVGQonIahwLhxcGuwFG6gL4AFdErfUDxpJAQa+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2ODoJ6j; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2ODoJ6j"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1329fc4bf77so2963819c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529446; x=1780134246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm5D4zZV0MwCvac4jjfgUUR1LIZ7RrjaKcvPmfxl/f8=;
        b=V2ODoJ6jdKu1rCFh6vywf4VdKKfsWV8liyj7MLVt2na1qS7LuXyM45UyNNJxtxtfEp
         i6a26lLoJdg7ezf+mGfNgtWprsq+OE6ODreweYlPnYbJ9VT318tfu5SQlJh8UIu+pH3C
         ZPEuP77lUS6nI/EGWvB8ztnpsHF8wJpeNDcM4Yr6wLHwBwef2G2VV9f5BDLuMjNZHriH
         ZmLe1Gg3PtWl3S1tJAyzi+KlBca68eo97c35Khx7JGLqfVkJZTArfgKfPhqa1QIGrqKb
         uJMYCpSqzFmS2VVHsxh6vvxF0XFV+dVrsHrVOH20nItl9ovyxjaCirdpBvXd+PDRrRgO
         wPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529446; x=1780134246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zm5D4zZV0MwCvac4jjfgUUR1LIZ7RrjaKcvPmfxl/f8=;
        b=JNKgbaLrV71MPeGCmMUihWftK0AfUJCDfBS93V5aAhWNfCqL09GxFJuDqG7d2csGni
         ujay3WLAd9ZfSV5eLmymgDnn6swAip5A+hmdfuKsnPpLU/YHaUlrzo11EW1eCw9VscbA
         hYvXQOJXOjOGMWsdBlLiYxeoDKmFN0tQ7J3C9qUBXDoYTOokFHu/yCEKRJesaBzmZf77
         qI/s2cgEHbNHBjPcWNtSoZlUBYDfBHGqEJ+1vm/J1iPqD6IbPSMBbO+YntsC0EpUYgPf
         xDLNz5URb8zw2YBi5SDTJXAJUzjKyhDanjavg4xhD0lFThnE8mAuNZBYWYNM7dVPUhky
         wMvA==
X-Gm-Message-State: AOJu0YwPyEbqHb7iuijC4xxBxMfQV4rCGKBX0N3I6mnUFZJA6aX/ZJyw
	CzwMNQO0nzyxqhoXv6NvevP9LCdb+3TmwTJkO1FLNN2pvPCRySr5MBvmxD1ZUQ==
X-Gm-Gg: Acq92OEGpZ1LC+FQu3PnBYFOPkli2mTbpRiNEGXs2Eevn2TgVCM7ETSU555ZgCbFDM9
	fGoRzzFkpiueZMxrk1PxILglX0uKk/eqRuPQmn7hlQFUaEod0o/VUmTxs9AELmCsRAKkMMWjaiJ
	HQVmurpzYl1jwxwcJDMU6PhuVh/hJt6GepRI/WmKRaYGA9A3Rob6UKIUFuMRVI8RpqkKFXEXipd
	NEjbGnyWmtFKidAA7EXJaC+X7w+cmCum5xsxVhjzVUF1j6xhCKQNdpfZA0dp0WncXH2Q2D4VtsS
	gdeLfrkr8ZMOvbOUgMW/2txuIZ8TG2W298SdGTzOoVMX1RR+ms2D4i8sCg2Dco8p1qGTOdVqghg
	R3itGV4QGbrv/ixMTktU0UXXzBpEemTVy8ZiXAReBBLdrHVEfFyPJTRzc+Ctde2UENQPDiQ4546
	2DuZYl30XZLWbjJqYroVUCLwr8Gs9VHxYrimpwfZ1aWOi1tjaZFVgRb5CoeJzVY2w/stP6AgOH9
	2EQ58fBtECaizTY2Q==
X-Received: by 2002:a05:7022:1286:b0:11a:e426:911a with SMTP id a92af1059eb24-1365f821ccbmr3116310c88.15.1779529446232;
        Sat, 23 May 2026 02:44:06 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:05 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 15/31] cxl/mem: Drop misaligned DCD extent groups
Date: Sat, 23 May 2026 02:43:09 -0700
Message-ID: <60e23199f7ef7dd3008bb3275c40d242334275c9.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an alignment gate to cxl_add_pending(): every extent in a tag group
must have its start_dpa and length aligned to CXL_DCD_EXTENT_ALIGN (SZ_2M,
the minimum device-dax mapping granularity on every architecture that
enables CXL DCD).  A misaligned extent makes the resulting dax device
unusable, so drop the whole group rather than accept a partial allocation
that would surface a broken dax_resource.

Based on patches by John Groves.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Groves <John@Groves.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: split out as a separate validation step]
---
 drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5edc3975e8f..421bd716a273 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -7,6 +7,7 @@
 #include <linux/unaligned.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/sizes.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1280,6 +1281,24 @@ static int add_to_pending_list(struct list_head *pending_list,
 	return 0;
 }
 
+/*
+ * Device-dax requires extent boundaries aligned to its mapping granularity.
+ * Use SZ_2M as a conservative default; a tighter check that queries the
+ * cxl_dax_region / cxl_endpoint_decoder for its actual alignment would be
+ * strictly more correct, but SZ_2M is the minimum device-dax supports on
+ * every architecture that enables CXL DCD today.
+ */
+#define CXL_DCD_EXTENT_ALIGN	SZ_2M
+
+static bool cxl_extent_dcd_aligned(const struct cxl_extent *extent)
+{
+	u64 start = le64_to_cpu(extent->start_dpa);
+	u64 len = le64_to_cpu(extent->length);
+
+	return IS_ALIGNED(start, CXL_DCD_EXTENT_ALIGN) &&
+	       IS_ALIGNED(len, CXL_DCD_EXTENT_ALIGN);
+}
+
 /*
  * Compare two extents by shared_extn_seq (ascending).  list_sort is
  * stable so when shared_extn_seq is 0 for every entry (non-sharable
@@ -1352,6 +1371,26 @@ static int cxl_add_pending(struct cxl_memdev_state *mds)
 		extract_tag_group(pending, &tag, &group);
 		list_sort(NULL, &group, extent_seq_compare);
 
+		/* Alignment gate — abort the group if any member fails */
+		bool aligned = true;
+		list_for_each_entry(pos, &group, list) {
+			if (!cxl_extent_dcd_aligned(pos->extent)) {
+				dev_warn(dev,
+					 "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %u-aligned\n",
+					 &tag,
+					 le64_to_cpu(pos->extent->start_dpa),
+					 le64_to_cpu(pos->extent->length),
+					 CXL_DCD_EXTENT_ALIGN);
+				aligned = false;
+				break;
+			}
+		}
+		if (!aligned) {
+			list_for_each_entry_safe(pos, tmp, &group, list)
+				delete_extent_node(pos);
+			continue;
+		}
+
 		u16 logical_seq = 1;
 		list_for_each_entry_safe(pos, tmp, &group, list) {
 			u16 raw = le16_to_cpu(pos->extent->shared_extn_seq);
-- 
2.43.0

