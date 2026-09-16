Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8863FADFD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560241; cv=none; b=b7zv0DWI5fO9Tc46Dw/3tml0CE4108bYPtCBydGiAEpr6Oqvappm0ei4gcptZm/ArJQNU5b3J5cy0xCefaOWuJGFFklRLPNzUxiRZrfa3hc8zzjnve31cg4HyIzvo2D6Tfg5uMudTfI64TaLqkg9xDxfnDw0BdoGtM87NAfcsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560241; c=relaxed/simple;
	bh=oWbRLfxona66u3hedA3YUn2CkofIiuO9rALDzcPwn/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7zorpihsaMrws/ouYLtgzqqKWfS8UOBuXK9G4KvDZHqYjVFZDsyP9OUpwrS6nNRlUZ0Hjb7Cw784LSvprI4qd204MCeof85DhHWKn57oYCNNMW15TI4Ql6NUapkcxkZnwn0H5tTAWPRLFzu5ob4sqqGoPreaBBC4idy+xsOa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A6OomCO6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A6OomCO6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789560224; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=El46v76TaTP9ODyoui1DpRwnLeVsD/zCO2K2Z39H+SE=;
	b=A6OomCO65CyOBbnh0zSKudSfJCAPptMoxmehCrdurqcoAoaouyBuBVhTy8SchqQ9Aygm9L8yUhqCCxQTsSt1G0o+wvaorhUnBEh5V1fgTxIpzuTMfX2zXyKCPmmH9v2fnQG6eveYsFDG3F7IbFnZ8Z3KHBDbSMT7Iv0dLfd5bGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB4yiGz_1789560223;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB4yiGz_1789560223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 20:03:43 +0800
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
Subject: [PATCH] cxl/region: Create node access attributes for CFMWS-only NUMA nodes
Date: Wed, 16 Sep 2026 20:03:38 +0800
Message-ID: <20260916120338.369436-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NUMA node that only backs a CXL fixed memory window and is not
enumerated by SRAT has no memory_target in the HMAT code. When the
first memory of such a node comes online, hmat_callback() exits early
at find_mem_target() without creating anything, and
node_update_perf_attrs() only updates attributes that already exist,
so the node never gets its accessN sysfs attributes at all:
/sys/devices/system/node/nodeX/accessN/initiators/* stays missing even
though the region's own sysfs reports the coordinates.

Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
by SRAT") handled this by having the CXL region notifier call
node_set_perf_attrs() directly for such nodes, but

  commit 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates
  directly instead of through HMAT")

replaced that call with node_update_perf_attrs() on the assumption
that the HMAT callback has already created the attributes. That
assumption does not hold for CFMWS-only nodes.

Restore the distinction: when the node is not backed by a real SRAT
pxm, create the attributes with node_set_perf_attrs() instead of
only trying to update them.

Tested on a QEMU CXL topology with a CFMWS window whose memory is not
described by SRAT or HMAT: after the region's first memory block comes
online, node1 has no accessN directory before this patch; with it,
node1/access0/initiators/{read,write}_{bandwidth,latency} appear with
the calculated coordinates.

Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
checkpatch reports one "Prefer a maximum 75 chars per line" warning:
the 2e454fb8056d reference line above is 84 columns because checkpatch
requires the quoted title to match the git subject exactly, and that
subject is 62 characters long. Wrapping it instead produces a
GIT_COMMIT_ID error, so the long line is the lesser evil.
 drivers/cxl/core/cdat.c   | 5 +++++
 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/region.c | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)
---
 drivers/cxl/core/cdat.c   | 5 +++++
 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/region.c | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..e28c40159d94 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
 	}
 }
+
+bool cxl_need_node_perf_attrs_update(int nid)
+{
+	return !acpi_node_backed_by_real_pxm(nid);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..19a5b8edbfda 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -229,4 +229,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+bool cxl_need_node_perf_attrs_update(int nid);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..636435733754 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2630,7 +2630,10 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
-			node_update_perf_attrs(nid, &cxlr->coord[i], i);
+			if (cxl_need_node_perf_attrs_update(nid))
+				node_set_perf_attrs(nid, &cxlr->coord[i], i);
+			else
+				node_update_perf_attrs(nid, &cxlr->coord[i], i);
 			cset++;
 		}
 	}
-- 
2.43.7

