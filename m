Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659C3BB55
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694254; cv=none; b=AhFG2h4BoRZ80qnvilFqR9vCJd85vQGLmpRmls5ZZ38WFYLvPIzxhIfGLSHjoYxApWMwlfLxn+ru+Bq7COTgy+jArHrD+jGBbBa+zJcBkUYYkiHrAeXXcctdviKZ6CUsSbrpTPHbqEv0VxL4C6n+WhkyAcbD3c5/rAPu5A305rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694254; c=relaxed/simple;
	bh=WjXkq8DjQjakIlilkVzxIex2qly8t8WwbQWxANAhOWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tkns41soawHuhjomhc59AyGj/M9zCeECyYYmpB/iZC5rIsf13C1zed0V81N01IBNCvppCdlMcBMz9g0fi+lJOvqm0QvCND0P83jXG7rgurGTbATl/DhqMORgmBCnb0wqfAerpcyRPVNZZmKALGvPAcYuSAhfanJZKZ063To9YgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=StmxCTx1; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="StmxCTx1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694252; x=1743230252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WjXkq8DjQjakIlilkVzxIex2qly8t8WwbQWxANAhOWU=;
  b=StmxCTx1IvQKLfsPOYdZWMxMFQBHPM4G07QbHIsT1gPuH+TC+Z5hMHo6
   PjwL7aYsxncgniGW3fmqa7hdVc/+7MWvIcXE091PGkQZ6SmssKWns1Xus
   qtbcOSBK0HXFhoACVtQb1LupRYmHxo6J6CpFaF2n4d/7qA7sLxYggDtxJ
   0Za0IAh7iU4BSVQEMddfm6z7L9mgX/xioImsVmJSR/91EFvcQL0nuFzRt
   IWOcPHs5SpeVBqlZ8WO6MMnMl48kp2y7XdyuzWMIGp0oIai17R+iRTqBZ
   BMM6GQbniMO9+4DDn0XR/dy9r+xsimlsVg5ngvXYX749Fql3qwq/9gbBm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="133107774"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="133107774"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:20 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 41CA1E967A
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A675D624D
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 006452288EB
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 86FCE1A006E;
	Fri, 29 Mar 2024 14:36:15 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 2/6] cxl/core: introduce cxl_mem_report_poison()
Date: Fri, 29 Mar 2024 14:36:10 +0800
Message-Id: <20240329063614.362763-3-ruansy.fnst@fujitsu.com>
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
X-TMASE-Result: 10--4.197900-10.000000
X-TMASE-MatchedRID: 53aa+u+VJBkM5CG8CYBPxRhvfWx0TE/bQR7lWMXPA1uWGhlHXorXXRZa
	DvoiUT/Mg1jj+Zp5wfm12HagvbwDji/7QU2czuUNA9lly13c/gEgltMEWVygJifJTn+dmnFQcHj
	giTON9jJvu+EAUOCx01Q+BXcIki7EZEHJCRAt0NqeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
	vEGAbTDo3PgYtyDuTWI3WPpm6ecjdp0YLTMI01adj70x37BoN8/h4BuZEnt4Io/4nN6pA2LIkSU
	kMsH+K04A1LMJVhA4LWGNvCCott3luMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

If poison is detected(reported from cxl memdev), OS should be notified to
handle it. So, introduce this helper function for later use:
  1. translate DPA to HPA;
  2. enqueue records into memory_failure's work queue;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---

Currently poison injection from debugfs always create a 64-bytes-length
record, which is fine.  But the injection from qemu's QMP API:
qmp_cxl_inject_poison() could create a poison record contains big length,
which may cause many many times of calling memory_failure_queue().
Though the MEMORY_FAILURE_FIFO_SIZE is 1 << 4, it seems not enougth.

---
 drivers/cxl/core/mbox.c | 18 ++++++++++++++++++
 drivers/cxl/cxlmem.h    |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..31b1b8711256 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1290,6 +1290,24 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+			   struct cxl_region *cxlr,
+			   struct cxl_poison_record *poison)
+{
+	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
+	u64 len = PAGE_ALIGN(le32_to_cpu(poison->length) * CXL_POISON_LEN_MULT);
+	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+	unsigned long pfn = PHYS_PFN(hpa);
+	unsigned long pfn_end = pfn + len / PAGE_SIZE - 1;
+
+	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		return;
+
+	for (; pfn <= pfn_end; pfn++)
+		memory_failure_queue(pfn, MF_ACTION_REQUIRED);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_report_poison, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..82f80eb381fb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -828,6 +828,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
+void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+			   struct cxl_region *cxlr,
+			   struct cxl_poison_record *poison);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
-- 
2.34.1

