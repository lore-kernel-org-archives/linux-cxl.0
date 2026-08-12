Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380F21CC71
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514965; cv=none; b=CVCONJ6avd1kAuYicW2ptY29qnZBatpwPc2NpDQWyL8BAa+p377KpboXTglnaACFf7ig/k3a9+PkKAQ90m6rTEaBNqRAwFaReGQV5xOf/rdijwG8sqOcCJ0RWEQNLnRnfvjJDnRfHcVmJQR0ap3ZYkiSfzLkVMNfjgeqA77TEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514965; c=relaxed/simple;
	bh=rH9G0G0Vk9XsIll2eOLQDjw2JP7q9knXTZavG9+pl4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8c4eLYdv2e+HuCiz2PnWHYtCslCquA39PvXotE6/2uWKJ1Vpvt/TbEA96EUTP3kiyCBKJLMU/VOCcyN5yLg6ijwNF/JT44yJuKEvHliBO/ysTVEBY+8h0MRFE0CP1WXt8pMkto7BmyJFcozaqI1JQYqKZLM0L2U0Wh/BeXV2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LoKhXCXj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LoKhXCXj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786514958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2HgZCSeOeM0BIF+upbxzALRjJXdnHLnIJmDEE+zgGHw=;
	b=LoKhXCXjeE3w8cnLJcFfYzL5RDUkDs1sr+LFSRw/LyfolIYacNrObHydzMFGRXZqmXxH6QMwVvqueE0ttfyY26Fu4xS6Z7shN6Pd0YSjHtn3i+y8BIaZcFBu7JRuwHBNPcC3JfSwl81xN4/bJ/1aTwimqR+BevVEQY8Pi2VyMEI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qhwnP_1786514957;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qhwnP_1786514957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:09:17 +0800
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
Subject: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
Date: Wed, 12 Aug 2026 14:09:12 +0800
Message-ID: <20260812060912.54932-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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
only read_bandwidth and write_bandwidth, and
__cxl_coordinates_combine() assigns an output bandwidth only when both
input bandwidths are non-zero. Every member a producer declines to set is
read back as whatever was on the stack.

Both cases occur on real topologies. The latency members of pci_coord and
sw_coord are never written, yet __cxl_coordinates_combine() sums them
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

Zero initialize the three arrays. Zero is already the value this code uses
for "not reported" - both the __cxl_coordinates_combine() guard and
coordinates_valid() test for it - so a member no producer sets now reads
back as unknown rather than as a plausible number.

Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 6/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead. Patches 1, 2 and 7 of the series are dropped, as those
issues are already fixed in cxl/next.

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

 drivers/cxl/core/cdat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..3c6a1537f89b 100644
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

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

