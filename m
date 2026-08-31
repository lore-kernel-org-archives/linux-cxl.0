Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668673CCFAF
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168152; cv=none; b=WMMSnWgA2MY/4N87RAeYO2F7Eo2P7Tmqv+oSgXtpuYW/H6mA7dmtJ9997ECh2uiEi7TWqqB85Ki1F+RF9x3hDOCc4wfT06WD0MErFI+SlC0tIFMd2bj68IXRYcN+5ZFqtl3ighXmT8IzKSNjxUr8b1Yu+TXgwBxszyQGGgotnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168152; c=relaxed/simple;
	bh=igkrDLFvpnSMBviuSvfFz+qRLcW5Ih4fDNWbBLOUtvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy17rfUA1LcfEH3vfRVp8Upgolcvgg5TjAC9QViQIoiLNq7mtNqljZgq6H52auVfIeSZK9xkYpXFWsoKGRCO2j178S7+XCnjFFsPkBjQM0lcJrV/SjxUPuu+xd4dA9Ya8Ado2hFCGMJMQgp7Sd1r05rmLgzgp4HeOoQSGZSB1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uUJUjueJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uUJUjueJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788168146; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ob0Mny59Biv+GEBipm+6kZnWac+F+77spDhqkdHpaLo=;
	b=uUJUjueJx+KgiIY+EGVM0PHkfsGrp+fq0tUVKmIkrZXmQk3iNW8Zyd0b8gPBck/cEk4yDliYBy2SuSeY/Lks56M+mC5RNq9lGlNw7k29Nd3Mk7TT2PKl49Q1HYEG9KpfaKBwOrTnKQWdoWcbT7kD17LIePcNP1AcmtgM40Ki2ec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9vzLDW_1788168145;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9vzLDW_1788168145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 17:22:25 +0800
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
Subject: [PATCH v4 1/2] cxl/cdat: Fix uninitialized stack use in bandwidth gathering
Date: Mon, 31 Aug 2026 17:22:15 +0800
Message-ID: <20260831092216.540644-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260831092216.540644-1-kanie@linux.alibaba.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_gather_bandwidth() and cxl_switch_gather_bandwidth() declare
access_coordinate arrays on the stack and rely on their helpers to fill
them. The helpers assign only the bandwidth members, and the combine step
assigns even those only when both inputs are non-zero. The latency members
are summed from stack residue on every call, and the bandwidth members
keep that residue into the region access coordinate sysfs attributes when
the endpoint CDAT reports no bandwidth.

Zero initialize the arrays. Zero is the value this code already uses for
"not reported", so an unset member now reads back as unknown rather than as
a plausible number.

Found by code inspection. Tested on a QEMU CXL topology with two endpoints
sharing a switch upstream link and HMAT generic-port coordinates for the
host bridge, which the calculation requires to run at all: with temporary
printk at the combine sites, the unpatched kernel summed 0xfefefefe, the
CONFIG_INIT_STACK_ALL_PATTERN stack filler, into the latency members, while
the patched kernel reports the CDAT latency values there.

Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
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

