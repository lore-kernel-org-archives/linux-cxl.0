Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F03AE6E2
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523452; cv=none; b=I1U1YiJ3miNtfNJhxgvS6UzRqW21YA9I26wEW00kqxY5KZ3hE778nsB3/iWtO05pOG6OUqWWp4W2Pk/1JpvxBg+jtMdvmL2eVJuqqA7E9m/VOFfB/vamvOa74Gk9Tak8arV152ULOXbojShPIY/xb34WZp//cMYtxFQgLgh/6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523452; c=relaxed/simple;
	bh=Ze4F1z9ry7ojemdZSIU58bij9SFYoaojq29VZO7wp64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO8PY2t88d7ryMYyemoKLneZENBJmM5aUuzTqCJ4x4EELt7NATvE6chMa47fhv8+T3m5a8eef480di0H+2IHPntrafImp1amwM3Ff4vQ1VEP/UzXZBN4c6ZivZiB8mhMAdVb8Oy2RYcLjgTJwsYeptQ6T7192WWITh5ojxBMj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iNrGaXCh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iNrGaXCh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786523441; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xrltomKbJN+9tW/ENgBNHPtzKCPCpDI/VuZNxOHWuZo=;
	b=iNrGaXChbE6B23E+36zh+qHDZDFkpLLsrHjOkeT9kdkPtCVYgv4nDh1oxERFvHuCOoXKZV9K8Mw7r581VtMnqquQmS5E7U4bU0e1iJrkrUeA5QpwwOp881F9MDhCt6l+J3Ju/PWWZKGJqRwTK8DDRadzVRX1R19/iUApTrpOoEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qzHTt_1786523440;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qzHTt_1786523440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:30:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in bandwidth gathering
Date: Wed, 12 Aug 2026 16:30:34 +0800
Message-ID: <20260812083035.372308-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260812083035.372308-1-kanie@linux.alibaba.com>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
the stack - pci_coord, sw_coord and ep_coord - without initializing them,
and relies on its helpers to fill every member. None of them does.
cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
only read_bandwidth and write_bandwidth, and __cxl_coordinates_combine()
assigns an output bandwidth only when both input bandwidths are non-zero.
Every member a producer declines to set is read back as whatever was on the
stack. cxl_switch_gather_bandwidth() has the same defect in its coords
array, which it hands to cxl_pci_get_bandwidth() and then to
cxl_coordinates_combine().

Both cases occur on real topologies. The latency members are never written
by any of those producers, yet __cxl_coordinates_combine() sums them
unconditionally, so the latency reads are undefined on every call. And a
device whose CDAT DSLBIS reports no bandwidth for an access class leaves
perf->cdat_coord zero for that class, which is exactly the condition that
makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
the ep_coord entry untouched.

The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
into the per-upstream-port aggregate that is published through the region's
access coordinate sysfs attributes, so stack contents are reported to
userspace as a bandwidth figure. The latency sums are discarded by
cxl_bandwidth_add() rather than published, but they are still computed from
uninitialized memory.

Zero initialize the four arrays. Zero is already the value this code uses
for "not reported" - both the __cxl_coordinates_combine() guard and
coordinates_valid() test for it - so a member no producer sets now reads
back as unknown rather than as a plausible number.

Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/cdat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..df9261ba84e5 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
 	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
 	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
-	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
+	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
+	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
 {
 	struct xarray *res_xa __free(free_perf_xa) =
 		kzalloc_obj(*res_xa);
-	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
+	struct access_coordinate coords[ACCESS_COORDINATE_MAX] = { };
 	struct cxl_perf_ctx *ctx, *us_ctx;
 	unsigned long index, us_index;
 	int dev_count = 0;
-- 
2.43.7

