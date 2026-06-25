Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B83DB32A
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386931; cv=none; b=mzV2Ph4XXax/b6I0RvQlMuo2LOqvYnhvH6RpYAYpC5xNRw8VK+k+ok2KN60aZCogYWAKoHdlPxS3tlCvtO28kmqWrRtCgP3RUQocw1DmjHXszZaean/EP9dnE/G7a7+ht1NPEB9oO0PyU8YQnSQZgnjgVwqUdepzYIoSnkr+K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386931; c=relaxed/simple;
	bh=IXDugotFWJ037YWrPcTKOkqIsc2DQseGutfKgWc9iZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It2NmZ7TX8plPM0+a/j7fVC+SIIacM2dFE5N+c+uAwjWMxCVJje7fUs9bC8fRwkGN41ZBiG12kPnjeXzOe6K4bEPYcJSbHT9zC6VeOWnFYMTBsO1JgwI+LLgmxqy85M6gKwQdIoRfThiyh50wyr7PT5NYZ9eWl2wwOVOU/snaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR7W5kC/; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR7W5kC/"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3100014eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386929; x=1782991729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYLI7SpEOi9lLbLlJZViwohpLtIvOa38YASL+E8l91g=;
        b=gR7W5kC/lW8N+AWjM/zxQGa1xg9P5Z74zzimv9PNzmm0tkKn4JkNTVbMSGAbGhKXYW
         cNqAVipkyGFVgzSkups2EL80RBDbNhdYG1r7NqGKlDcIDs9bC0yEDDRwVnpdzUJlbug6
         s7XIvCDrR1sXJR9asdwW1GkS2IiNbkMdrLUjtyM4fcyPbnm+r7FGLr+NsUOifzJ3RAD7
         tMqfwNxmW1VgNbXCnQks7RdJQZs21D2dAbkK4/Ubr5H7h9qrFoPYP0BrQDxyA583CNus
         HQ1XutTRL+Rjh5vka8gv4V6BJl8kcv8vzCgO49psVZjqs0G10lDX+jO3K0Sw51CnRZaS
         cplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386929; x=1782991729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYLI7SpEOi9lLbLlJZViwohpLtIvOa38YASL+E8l91g=;
        b=bzn7d3aUok++T0lMsYhoDg0Cy62xRHZeuFIRbWvN9QilMhbqgvuSrHFIeblTqrUV/Z
         FC2xg7RFWb7DJ6GxAf6jPlXjCAdLcE1GX0QZp/EnX1A5jfEXCeRTBzaVCR1eiDuMKbd7
         EOyn9CbfJ0vpb502PNTr3rEvG4wnAGVQiGUJzFjCscy3HY/QDe4ZzV3Pkn5OpcKz9eyx
         69Lwf7bloHQTmBI+qm3mwPyHz37q1YS0nyg6h7inWk830lfTAFvYCEsB5fqZmWddv3T1
         fNSCuujzeK57F7LBIcbG6C9fOwH1pRofC9oVp2yvjOUjZ1uN3PwqBQCYDzdB40CPEwhW
         Z27Q==
X-Gm-Message-State: AOJu0YwHu+5t0gzAarebZuQmePU6xLc7I6a0HCnD5Vi2Gv05bbGHH/a/
	lBGrigXz1BWXQ2fU8SBzhfVgX91qGXsHcGDF6OR22mrEvGauNfh1mwsAv4PTvw==
X-Gm-Gg: AfdE7ckpo1XG59VUcTDhn75oISvK+LUPg9P04sIVzSfwLtF5nufJ1A1kFh80gjTG7r2
	BgcnH1W8eQLMbj2XztVs6cRtOWnXAcHkRRr0i2/IDsgcfwwxScMlldCR06duWI4ht6ZT8Q2lusI
	adct4Byq0DDo6yI0F+xWgTgit8eQX8ULcaW8MHMOidJdc9YHg6ns2TELc5HB0GyyQ/YR1pxW8oO
	Qb1C5Rki0OE13xhldHsoC8A3jrWLz4zLj32XeFhwPHI/DhgrE4LdlL5Kcf1uGNTisSz+fDEaU6k
	CNY4/4Gs3EkfpYgasQcdmoJkdZvsvsmF3Hu2rerF2C4nVXCe0E6Af+ZwqKcXCU9wr5FksEImYrE
	OnVxrc0OHxJVgrDAwsdbixeM2kBvXx+1ZECh8MoqgCNoxaV23yQ50vXpHoDvptQIf1hOV/5Q0e7
	ymjtH+1a1NdDE09e4y+wbdKuCFpf5bN6MG9GpXIA7rj+uLz1rbz0xu0I81sRReDBJbBLgZaAjgr
	Gcdi8k=
X-Received: by 2002:a05:7300:7242:b0:304:dd1c:737e with SMTP id 5a478bee46e88-30c84d0e939mr2525531eec.16.1782386928578;
        Thu, 25 Jun 2026 04:28:48 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:48 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 15/31] cxl/mem: Drop misaligned DCD extent groups
Date: Thu, 25 Jun 2026 04:04:52 -0700
Message-ID: <20260625112638.550691-16-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Add an alignment gate to cxl_add_pending(): every extent in a tag group
must have its start_dpa and length aligned to the dax region's mapping
granularity.  A misaligned extent makes the resulting dax device unusable,
so drop the whole group rather than accept a partial allocation that would
surface a broken dax_resource.

Based on patches by John Groves.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: John Groves <John@Groves.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: gate on the dax region's actual mapping alignment (PMD_SIZE)
	instead of a hardcoded SZ_2M]
---
 drivers/cxl/core/mbox.c | 51 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 08f51b8807c0..14ba263044f0 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -7,6 +7,8 @@
 #include <linux/unaligned.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/pgtable.h>
+#include <linux/sizes.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1295,6 +1297,19 @@ static int add_to_pending_list(struct list_head *pending_list,
 	return 0;
 }
 
+/*
+ * Extents need to be aligned to dax region's mapping granularity.
+ * Use PMD_SIZE, since cxl_dax_region_probe() calls alloc_dax_region with
+ * PMD_SIZE for the 'align' parameter.
+ */
+static bool cxl_extent_dcd_aligned(const struct cxl_extent *extent)
+{
+	u64 start = le64_to_cpu(extent->start_dpa);
+	u64 len = le64_to_cpu(extent->length);
+
+	return IS_ALIGNED(start, PMD_SIZE) && IS_ALIGNED(len, PMD_SIZE);
+}
+
 /*
  * Compare two extents by shared_extn_seq (ascending).  list_sort is
  * stable, so extents with equal keys keep their arrival order from
@@ -1395,11 +1410,38 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 	return group_cnt;
 }
 
+/*
+ * Validate a tag @group before realizing it.  Returns 0 if the group may be
+ * added, or a negative errno if it must be dropped.  Further gates layer in
+ * here in later commits.
+ */
+static int cxl_validate_group(struct cxl_memdev_state *mds, const uuid_t *tag,
+			      struct list_head *group)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_extent_list_node *pos;
+
+	/* Alignment gate — drop the group if any member fails */
+	list_for_each_entry(pos, group, list) {
+		if (!cxl_extent_dcd_aligned(pos->extent)) {
+			dev_warn(dev,
+				 "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %#llx-aligned\n",
+				 tag,
+				 le64_to_cpu(pos->extent->start_dpa),
+				 le64_to_cpu(pos->extent->length),
+				 (u64)PMD_SIZE);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Drive the pending Add-Capacity records through cxl_realize_group(),
  * grouped by tag.  Per group: extract from pending, stable-sort by
- * shared_extn_seq, realize the group, and on success move it onto the
- * accepted list.  Validation gates layer onto this loop in later commits.
+ * shared_extn_seq, validate, realize the group, and on success move it onto
+ * the accepted list.
  */
 static int cxl_add_pending(struct cxl_memdev_state *mds, bool existing)
 {
@@ -1425,6 +1467,11 @@ static int cxl_add_pending(struct cxl_memdev_state *mds, bool existing)
 		 */
 		list_sort(NULL, &group, extent_seq_compare);
 
+		if (cxl_validate_group(mds, &tag, &group)) {
+			drop_extent_group(&group);
+			continue;
+		}
+
 		cnt = cxl_realize_group(mds, &tag, &group, existing);
 		if (cnt < 0) {
 			drop_extent_group(&group);
-- 
2.43.0

