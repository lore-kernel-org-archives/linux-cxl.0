Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609022324
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694193; cv=none; b=dGU2AixxGoMl/d7nf5Z39FvNudDyqGWQjRtHWTfTU+hXdzDqTbF/1eYwqSQbD5pHaCPU76hzuyS7IBW35CQQXwvcpYsMBYjlkCFTh/z8SqUyx7J2QhCA0esY6z/DCombZ2bILJcXX/8varqT2RYjtfyyTm/00cB2ghy0Y9NpmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694193; c=relaxed/simple;
	bh=wuhLrD6nDKASM1GZwEy/EhBT98EFm0ZU9lZPPyQH+DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAGIPcvYcNLhzIppWN0t1BttahptbrK9WvfmbWG3TUXuwzGodwKL7GwC2WmbE2ulBUk0kL6h8JvQEzR04TXplEohm+YBIVnwwkmJoNHPXm4upGm8f7cecHQCHgAaWnRk8M5F7mtgMQswiB/l8DhvhbSpfjCMzC+IbW7jjpxJtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iDeh5z2k; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iDeh5z2k"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694190; x=1743230190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuhLrD6nDKASM1GZwEy/EhBT98EFm0ZU9lZPPyQH+DE=;
  b=iDeh5z2ku7cxzuolBUqZIHDav99tBR6tFxlkcVTew7r+4YfEbyudphp1
   cK3K3bHzPh0RbWIMlBBAO/28heK9T3u14GaCL1Uqq9XWdgeKi2I2976oi
   e6YHo/DrhTW57foDVVHTnpjQg/V5j/hUHxL0nyNMxItucRzQx6b2PQ+N+
   cKJNX+1Dg408WTKAP3sU0QkZUa7KkL7qpPnFyIJXwP/8j31E+ycz8dxXw
   1KfSF/CFd3SXj9gfCM+pTnbCwaghpNIDx2bhpWNoVuwSJzST90IqP9IHw
   DuuNad2PppPReyiHhrT2g00iR8oN9OmLJSE/ggvy2YlPEg/ZqWQqmcXMf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="141726400"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="141726400"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:19 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 89C9DE967F
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B7438F923
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A233200A7F0C
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D019B1A006A;
	Fri, 29 Mar 2024 14:36:15 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 3/6] cxl/core: add report option for cxl_mem_get_poison()
Date: Fri, 29 Mar 2024 14:36:11 +0800
Message-Id: <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--9.462200-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiIJoDeiZ6YZhB1kSRHxj+Z5/OuUJVcMZhtdXeeZrNJbgiu5
	iQ9EM64EjZRdXn3Xp9M6uZyF2AGJsLVQ6XPWwtdyEXjPIvKd74BUENBIMyKD0cSiwizsgluQ9my
	Umu4fZeT7dV04rak8k5t7C5yK9FBjJBgtEIxUn4HfSQNpZkETVBgff28UuvITicvz9DxarMHQSo
	WMT37bqFIeZmiiCQMfIdXPCd0ceGWvvxILmKK/HBRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7qYgz
	NcfPy5s9/7GOwz/1iinIjtl5KwpMUvyE7CVOX4olExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The GMER only has "Physical Address" field, no such one indicates length.
So, when a poison event is received, we could use GET_POISON_LIST command
to get the poison list.  Now driver has cxl_mem_get_poison(), so
reuse it and add a parameter 'bool report', report poison record to MCE
if set true.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 8 ++++++--
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 ++++----
 drivers/cxl/cxlmem.h      | 2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 31b1b8711256..19b46fb06ed6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1309,7 +1309,7 @@ void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 EXPORT_SYMBOL_NS_GPL(cxl_mem_report_poison, CXL);
 
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+		       struct cxl_region *cxlr, bool report)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
@@ -1340,10 +1340,14 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		for (int i = 0; i < le16_to_cpu(po->count); i++)
+		for (int i = 0; i < le16_to_cpu(po->count); i++) {
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
+			if (report)
+				cxl_mem_report_poison(cxlmd, cxlr,
+						      &po->record[i]);
+		}
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d4e259f3a7e9..e976141ca4a9 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -200,14 +200,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 	if (resource_size(&cxlds->pmem_res)) {
 		offset = cxlds->pmem_res.start;
 		length = resource_size(&cxlds->pmem_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc)
 			return rc;
 	}
 	if (resource_size(&cxlds->ram_res)) {
 		offset = cxlds->ram_res.start;
 		length = resource_size(&cxlds->ram_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		/*
 		 * Invalid Physical Address is not an error for
 		 * volatile addresses. Device support is optional.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..e83c46cb4dea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2585,7 +2585,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	if (ctx->mode == CXL_DECODER_RAM) {
 		offset = ctx->offset;
 		length = resource_size(&cxlds->ram_res) - offset;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT)
 			rc = 0;
 		if (rc)
@@ -2603,7 +2603,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		return 0;
 	}
 
-	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 }
 
 static int poison_by_decoder(struct device *dev, void *arg)
@@ -2637,7 +2637,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 			rc = 0;
 		if (rc)
@@ -2646,7 +2646,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region, false);
 	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 		rc = 0;
 	if (rc)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 82f80eb381fb..1f03130b9d6a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -832,7 +832,7 @@ void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 			   struct cxl_region *cxlr,
 			   struct cxl_poison_record *poison);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr);
+		       struct cxl_region *cxlr, bool report);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.34.1

