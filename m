Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2A2E64F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479737; cv=none; b=hB7c+dpTVGB8hcg/vxasQkXK0LuZPU0m0tvIQr5w7dmH2s/fcW+QDWTJ80VW6AtmHxBCeTpDxUfNA4cCTzmIdf5TMKmKqWcQ73YdR0Log2rK9cnkWEK+NN1Jw7OqJss263/sc+qKv1l9Y168tICbmNH9LHzR+Tx6brTnCFHfBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479737; c=relaxed/simple;
	bh=Dd68uTGB7iPzp9l3yUK2O0dGF5QgWSOWWKlkuSfj+PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i29g5ahSSz9bUkaxneu/RUMseOVSTHnKxeEjuKj02UveO13eMWFnE5Hci0wF3ikYWxoZe/lAB5wgcS3cZOnwJbboS4DYCkPrKXmlyGO8f9n5/vOFWVWOtjh9s/HgA6w7PHu5e8h30nBKCrG5fzlYsyd+fJS88HKrnFMc3QV3Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HZWHkkSC; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HZWHkkSC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479735; x=1739015735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dd68uTGB7iPzp9l3yUK2O0dGF5QgWSOWWKlkuSfj+PQ=;
  b=HZWHkkSCGb+gr7+03JjTUMLJxamfZ7X6/+PctNgHusxp9WJQrechi+M4
   AqLKAGDV1CksfwaABGp2qKtHUlHJxTZR5G0vcA69M0D9fB0hT7bldbwK9
   uwkVQlGb3WL6iZKM0WmcVFVWbz7H1h+JURSp3PPx+DcfFITJUD2s8eSSQ
   ltXeaOd3QN2Li3xGr0zup7TBoMH+5W5HTODexBIAf3ejxmuvmpHZmRRI0
   ZpCJQ4vGF4OBwcKoRK5bj8rBW0y997WNCQDUFri2mtno0QJ+gqikLbzTG
   THqhWPxyQKWWCaP05TXUsJlf/LK2gL3he3pUkNdY8aiTwpXTZ8jITCliX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="148928808"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="148928808"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:23 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 47C0A14A255
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C4F321A884
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EFCED20097CF1
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 937301A006A;
	Fri,  9 Feb 2024 19:54:19 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 4/5] cxl/core: add report option for cxl_mem_get_poison()
Date: Fri,  9 Feb 2024 19:54:16 +0800
Message-Id: <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--10.285100-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2sJoDeiZ6YZhB1kSRHxj+Z5/OuUJVcMZhtdXeeZrNJbgiu5
	iQ9EM64EjZRdXn3Xp9M6uZyF2AGJsLVQ6XPWwtdyEXjPIvKd74BMkOX0UoduuR+GgVvXmL4ONE6
	mRLCupPjovSNS3Zhlaq9YGVc6ZwjYP7A6mmzUskBKzjuZtPtIBMMKxxeacM3vnhD4vcFcha6N3H
	kV2EiaA9TrK+6tlqkXumMCMwce1mUfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPBSuOQCfu1OIEDum
	0PDABnfH5DUKb843LaYU+MayamLEm3qeHSd7sch
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When a poison event is received, driver uses GET_POISON_LIST command
to get the poison list.  Now driver has cxl_mem_get_poison(), so
reuse it and add a parameter 'bool report', report poison record to MCE
if set true.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 7 +++++--
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 ++++----
 drivers/cxl/cxlmem.h      | 2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f9b6f50fbe80..e1c67159acc4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1324,7 +1324,7 @@ static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 }
 
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+		       struct cxl_region *cxlr, bool report)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
@@ -1355,10 +1355,13 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		for (int i = 0; i < le16_to_cpu(po->count); i++)
+		for (int i = 0; i < le16_to_cpu(po->count); i++) {
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
+			if (report)
+				cxl_mem_report_poison(cxlmd, &po->record[i]);
+		}
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c304e709ef0e..320bcb8af5b0 100644
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
index ce0e2d82bb2b..b008c7e13560 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2386,7 +2386,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	if (ctx->mode == CXL_DECODER_RAM) {
 		offset = ctx->offset;
 		length = resource_size(&cxlds->ram_res) - offset;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT)
 			rc = 0;
 		if (rc)
@@ -2404,7 +2404,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		return 0;
 	}
 
-	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 }
 
 static int poison_by_decoder(struct device *dev, void *arg)
@@ -2438,7 +2438,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 			rc = 0;
 		if (rc)
@@ -2447,7 +2447,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region, false);
 	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 		rc = 0;
 	if (rc)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 97ddab421e63..f0877f055f53 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -831,7 +831,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr);
+		       struct cxl_region *cxlr, bool report);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.34.1

