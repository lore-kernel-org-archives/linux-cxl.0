Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833375;
	b=Um4nk7f5sidPx18K7s+9O0SctDQqD+fFGknllOF+6sPjT0Ruz6TylbepK2xnW+1wlQl8
	 Dvdr2mam7gU8wd1E8suTygYm8TT3RPGgCP8eAiip0ujAgdkMv2ecloJWGP+wnPiVe0YIp
	 sKXHlTmsQVEysVZAY6IDpUppllO7EZVIqJ9ufLaTTiZ3ax1LQBrG1590CkAbzj6uIK1va
	 SiQ3RzOqKF9qg8ee90FJ+3UbSERXuL0bDZTl+cfhNBuhgQf2KB5jGZs5eRUZNXxmKHCKt
	 Y3v+daIXYfpKl8okBVabQ7PW2s/xJcefxZ38oa+Fd6d/fa/t4ydzS8SBCNiR9ICk/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JjAyaGZls9f5VsEm6NTVGb8BE0iRo4CKaOU62Z44t6A=;
	b=NyJyGi0pUUYOhnILIEE/ZPXHT4IGW0RCXQn9aSq4f5DNeVbvbK8v3rq9uaxn03JNPVHt
	 XXBsN35k2lDEXtliJw7FL8q+QkZo/9/WNCTVK888j27hSw69qIoAb7y/2Jg9lMdudnmyq
	 8Iw+sWwIAKGi1Rd/LRtd1g1ixHF1LeCHVIZZ/zmXrbg7NRTsFujSWpTuChUB5YhgZjXvA
	 3X9A8huY56kaGXQm2XCuTLQNjVwS5Q1xhhbRDLlsgbaI3eAYUk/e4pXz35S3hW87RTDln
	 6cyQfaQNAzNcJiY5ISA6zv8/8GdmCm0cRp7+TLfA0QYr+wz/FqmOJDsDrTD4Felp5HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gYnjC+CX;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D56082BDA
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3D56082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gYnjC+CX
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9ae391a05so607135ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833374; x=1794438174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JjAyaGZls9f5VsEm6NTVGb8BE0iRo4CKaOU62Z44t6A=;
        b=gYnjC+CXhc+JXwhfT/dJwOR141ZEGR3clsXJn50txpneu12AMqKHEeAjwiNzXGTO8x
         erByi5GTT4hXfIgiXzGjUrjkz/kuduoC4CSkDQDAU7hWCH0jpnt2NDuIrF1LqgX0tAF0
         wp7jwcufhFlmMgHpzUvyeCJX0MvmKp47XyespZQLIvpjziUI+9gNTxikG5TZyaCW1VVz
         dkoAwJSaiJ4PrVeON0bMGnfm28FzvWFL5AN+pqBE2V6CJ/PjDC7SmehM/pgPaegi+j8O
         OuBfMq1boUGEiWbkTEZmligJEX7kJsaMrwur57IxM6HPpShFMcTaG6f1imKWgubnU8EX
         OdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833374; x=1794438174;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjAyaGZls9f5VsEm6NTVGb8BE0iRo4CKaOU62Z44t6A=;
        b=iYBz7kVeN8ROtmWnPRh2ub10rZC5vVCnfthgMHCQs3VWsFbzmSIOBn/4q12OxnNMg+
         N/fhirqspN+RWFLy9T+rdLUhMmVoqhWR8uRmEqm70PGmEIWvP6E2fs2r0aix24zB+kIr
         /o09brcEl+/TvUhjvy7Kj/DIsaMYkgBqHGr4QYjalei2ygbjfg5b0Ko353yGvPBT2k1L
         aFOol9dTVLFXfbPAYkMcQHJH9z8ZdTVniOrjfEejFnpBR0vxHlfGqJNAgwqjDvLFrZeN
         xYKqKWJ0cuvHUQ1f+WUdVsQz09f3JIF726L34KJNJJUAkWqkiD+dH8Dgs+IUZMcdNxjR
         cYjg==
X-Gm-Message-State: APuU4Z/Gh29VYNHNdwDyYqr/MBP54SmdM9OXtIsSE+NMR7vNf/pjLGCN
	jKrPDwRHuZEXVxsMmdB9EfQkuHcbUnCTfGLKcEQHP9XkaPVIJ7T+H8eFlApw49+J
X-Gm-Gg: AYBFou0wUfSXjGXNJKsWQxjNUfUUPDhwwtYKhRJVocetQfNzMbJkxH4woSZwIFuRzEP
	WqykXUsmvwmawVIQEjHaYpbKOPN04VCcATsHZUFT+oBXqkETdTcFqcju0bUzDVQnRyboUqy/FuV
	Yz6vDkRtmTvfNdPaDmqV/crMfjkLUwv5vyyo/B1dGkv/muJzsNl4x71ovoo99IlZMdY97jKauTF
	S26vs/o7IG91JTzzxRkyVNl0gGDTWBqy9mhw18nAt0NMP1c5FqRf0Nydc3yG9/hBH1VtDFGuPBW
	UvoyNd6AUQNkV4Gq5Sd/bjzfbtIrnziyIb0oPUCUTQ3mI7LOCEyaTWpzoZW/YNM+Me8JlBntasg
	S/eW4L166okxa9GG48WF/wpVbXCNAb5c2IpzLNWynbYmn3vI1f0xopnS1JRQNGyVP9h0OHo/Cg7
	QGmv9mV0FqcRUgbXTlFYcXrWqO8yyrudHhkBS5IXulwLtA1Xu0VIeFiMpPOAWSmOgmt1Ny0T2y/
	c0/ndLSdkGS+G1FQa5TOx5Olu9t4kJVYk6RlJ0x8SSMhKzyWeqDT7xThGwOCd+StBcSU8bXVriN
	qIMptJVCV+RMxa/W/Ic5Advh48YLnQ==
X-Received: by 2002:a17:902:eb8b:b0:2e9:6333:fba8 with SMTP id d9443c01a7336-2ed23ef99d9mr5080245ad.16.1793833374462;
        Wed, 04 Nov 2026 15:02:54 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:02:53 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 07/14] cxl/mem: Drop misaligned DCD extent groups
Date: Thu,  5 Nov 2026 08:02:31 +0900
Message-ID: <20261104230445.66625-8-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Add an alignment gate, cxl_validate_group(), that cxl_add_pending() runs
before realizing a tag group: every extent in the group must have its
start_dpa and length aligned to the dax region's mapping granularity.
A misaligned extent makes the resulting dax device unusable, so drop
the whole group rather than accept a partial allocation that would
surface a broken dax_resource.

Based on patches by John Groves.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: John Groves <John@Groves.net>
Signed-off-by: John Groves <John@Groves.net>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 drivers/cxl/core/mbox.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 18044f216de5..a605ffc4c64f 100644
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
@@ -1395,6 +1397,19 @@ static int stage_pending_extent(struct list_head *pending,
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
@@ -1497,6 +1512,32 @@ static int cxl_realize_group(struct cxl_memdev_state *mds, const uuid_t *tag,
 	return rc;
 }
 
+/*
+ * Validate a tag @group before realizing it.  Returns 0 if the group may be
+ * added, or a negative errno if it must be dropped.
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
+			dev_warn_ratelimited(dev,
+					     "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %#llx-aligned\n",
+					     tag,
+					     le64_to_cpu(pos->extent->start_dpa),
+					     le64_to_cpu(pos->extent->length),
+					     (u64)PMD_SIZE);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Drive the pending Add-Capacity records through cxl_realize_group() one
  * tag group at a time, moving each group that realizes onto the accepted
@@ -1541,6 +1582,11 @@ static int cxl_add_pending(struct cxl_memdev_state *mds,
 		 */
 		list_sort(NULL, &group, extent_seq_compare);
 
+		if (cxl_validate_group(mds, &tag, &group)) {
+			drop_extent_group(&group);
+			continue;
+		}
+
 		cnt = cxl_realize_group(mds, &tag, &group);
 		if (cnt < 0) {
 			drop_extent_group(&group);
-- 
2.43.0

