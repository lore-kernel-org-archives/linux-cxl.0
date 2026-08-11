Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DB43B3D9
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448187; cv=none; b=gsiCCD51qkosG8rYNmEDa69Mwlz5+3lGBktTCZeSv84xFAEmybyaId+IjHAGA/+lA52X6SEpHXrmmFscjPQ+ISK1IGcuz+69OZ77ktH1aAk2mrbXnJyieYiu0eoyWmLCaHy2/PQbbgmPv11Snn0H0D1FtHZLsQ5vYY0OMkxub2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448187; c=relaxed/simple;
	bh=G0SYWwxHFvDXLGcy1atWymmczyV8I6EW2NYJsaEcunw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn5tldP6Pq0euVBu7QXO7u5miENKwYKnyQeynr7+cnF9TD+7+L+E7Phj5YpfH1DzurY/HhWVvmPYREa/DdT4PXg8HW+YLDBjJAnRHu7FSBq1LoiRC7lLV+wZPOEUhEpjtKSnDzORZ1CQuP2WRAxkXKs9U/ABHFWDO3Fswr1GFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lsjMLSoz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lsjMLSoz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448183; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ozvsfTjo0i7g/xCnAIRJclI2uIF92+RwcfsgGKRLjUQ=;
	b=lsjMLSozhLgrTOaZB+AYDHOYwsTuT0K7NKX6L4mk2a9/fyPDcOhDw/dXJPnyHm2if4ELgnD0Ulk51FbmT3XHoCLZKHuSoXatIqO24HFap0xgBOaICMNqWRQS+O0mjELKtwm/8mMAlr8tQNFJ+kqY9EOUL+Rpqe4ZOtBlBaK+44I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oKJ-w_1786448181;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oKJ-w_1786448181 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 7/8] cxl/mce: Validate the memdev and endpoint before use
Date: Tue, 11 Aug 2026 19:36:07 +0800
Message-ID: <20260811113608.2815625-8-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_handle_mce() dereferences mds->cxlds.cxlmd and treats cxlmd->endpoint
as a plain pointer. Neither holds at all times:

- The notifier is registered by cxl_memdev_state_create() from
  cxl_pci_probe(), while cxlds->cxlmd is only published later by
  devm_cxl_add_memdev(). An MCE delivered in that window dereferences a
  NULL cxlmd.

- cxl_memdev_alloc() initialises cxlmd->endpoint to ERR_PTR(-ENXIO). It
  stays that way until the cxl_mem driver adds the endpoint port in a
  separate probe, and forever if that probe never runs or fails before
  then. The existing "if (!endpoint)" test lets the error pointer
  through, and cxl_port_get_spa_cache_alias() only guards against NULL
  as well before walking endpoint->regions.

Check cxlmd for NULL before dereferencing it, and use IS_ERR_OR_NULL() on
the endpoint. delete_endpoint() stores a plain NULL, so the existing test
is only wrong about the error pointer.

Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/mce.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index ff8d078c6ca1..47566015eb00 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -13,7 +13,7 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
 						    mce_notifier);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_port *endpoint;
 	struct mce *mce = data;
 	u64 spa, spa_alias;
 	unsigned long pfn;
@@ -21,7 +21,11 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
 
-	if (!endpoint)
+	if (!cxlmd)
+		return NOTIFY_DONE;
+
+	endpoint = cxlmd->endpoint;
+	if (IS_ERR_OR_NULL(endpoint))
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;
-- 
2.43.7

