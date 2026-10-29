Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317477;
	b=RvRD72Giv9zqZ87hmmxKlAT7VAmwO408svJukTwqGnYJn6svf0gS0t57GMana70Oa32z
	 jOcRDEaCDR3fA3/6GY8SxLVOhaL23NovOIKjtHLVYYEDlC64fmdhaBZTouELy2Y0KrP3B
	 +K0q30qPvo7K8TdImQXdPzBi6pZZ1BxSk5tc2Ydk96B/9tik4lx1P9i8dMJPcRPN+fOv4
	 bf0snhtvQg1O3Dx3lD1fXiWi8Pc0ZmahiIUXr8ZkuTvrDVUPmJYBhhGAqdVXXlDgmxRQs
	 z/P4GGH0a9HK/2ZhRvVDEzVQNchezH2i7KjzSBN8w0nb59PvB7oEYUrO4K2SOa9Uy9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317477;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pnVdStuzeGiuIN6mBumR4hQgiifKPnyGTRHYM+nZWIo=;
	b=vdiMpxC8BJnanQd1AshBdcMmapxqDsHFWX7yPInuMZ3N/2/s5AkCDOXl+jitPFa3Mp1u
	 Rcr5Eq+tXmLwvb1oVh0L2gcd68IQ3FFvDgc3fEfbC6oT33cEfqRJ7EHRlganTiJ+qptmF
	 oaOs5kkPLLFxMmNzDPuGW8plW/R+FdIrRNF5nZ/2zhapcDhQv6xzsNR57fAeBcE931XeA
	 0Ld7CE7KxjZEBmcmPx+gyRd0yfoT1wJ+VjSnrJlzrhuzl2Bw7j2X7HnSXc/alkTeI0bdE
	 eheQTLMIuD673GLu6gzn8TcULM1o2snemKbpswA1SifVpvnp5ka/2EacsToudJaa16w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=(null) smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aqDVPryK;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9D606A324
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE9D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aqDVPryK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793317461; x=1824853461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omgZUOo2o5cGHTfPHJBu2iWioierPTJnZe7x50Ay9Zc=;
  b=aqDVPryKAvB6/etXDrCVNaetppaDVqV2x+nXLf8HuMnKcV3wrPWg+gqU
   8U1sHdksWo6RQxmO81WzoxguzC1zf6SOUqcQjPB5kuJmEeuu4PDQ5+W/E
   GPqRJm27sQx4A3vWG0YHXPZYsxqY1mZFXS1JmH0cnqTLz4spHwVLhtZkH
   IQ44B29PEgOWkMbAyXFcNFCEX/uVlwey4MVp5mVpQApYXDUWEZI7RAX65
   wz4VE3EWei1n3/iMwtl8beAByfxEDJpksJTd2kCcuNvH3vtSxXdb2t+/A
   d0mrNrhzVG7sOLcdfnjxaqOHCBzv41b2Sduo+DeP2QD5WE1EOlpqv8Hz0
   A==;
X-CSE-ConnectionGUID: txzrzRC9SYaxn6g1FY7FfQ==
X-CSE-MsgGUID: dewfFI6uToCsDE3Ed73C6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2100446"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2100446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:10 -0700
X-CSE-ConnectionGUID: c8QVLyE3SMqiJolxfhfqnQ==
X-CSE-MsgGUID: 2TOfG918QX+gGhLKJ5bUqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5385223"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v2 3/4] libdaxctl: match memory blocks against each dax device mapping
Date: Thu, 29 Oct 2026 16:44:02 -0700
Message-ID: <730b33a1a2d7b4e6b3f319f459bf36f5fd901906.1793315621.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793315621.git.alison.schofield@intel.com>
References: <cover.1793315621.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_in_dev() treats a DAX device as one contiguous physical address
range, even when the device has multiple ranges separated by gaps. This
misses blocks in later ranges and may incorrectly include blocks belonging
to another device.

Memory block counts and per-block online/offline operations use this
lookup, so daxctl may operate on memory outside the requested device.

Match blocks against each individual mapping, retaining the single-range
fallback for older kernels. Reset errno before each readdir() so a stale
ENOENT from the mapping lookup is not reported as a directory read error.

Fixes: e8bf803e359b ("libdaxctl: add a 'daxctl_memory' object for memory based operations")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 daxctl/lib/libdaxctl.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index f7cbf3fa12e7..1327a2d0afe2 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1615,6 +1615,7 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	int rc, path_len = mem->buf_len;
+	struct daxctl_mapping *mapping;
 	unsigned long memblock_size;
 	char buf[SYSFS_ATTR_SIZE];
 	unsigned long phys_index;
@@ -1654,8 +1655,18 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 	}
 	memblock_res = phys_index * memblock_size;
 
-	if (memblock_res >= dev_start && memblock_res <= dev_end)
-		return 1;
+	rc = mappings_init(dev);
+	if (rc < 0)
+		return rc;
+
+	/* kernels without mappingN report a single range */
+	if (list_empty(&dev->mappings))
+		return memblock_res >= dev_start && memblock_res <= dev_end;
+
+	daxctl_mapping_foreach(dev, mapping)
+		if (memblock_res >= mapping->start &&
+		    memblock_res <= mapping->end)
+			return 1;
 
 	return 0;
 }
@@ -1716,8 +1727,8 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 	if (!node_dir)
 		return -errno;
 
-	errno = 0;
-	while ((de = readdir(node_dir)) != NULL) {
+	/* Helpers may leave errno set even when a block is skipped. */
+	for (errno = 0; (de = readdir(node_dir)) != NULL; errno = 0) {
 		if (strncmp(de->d_name, "memory", 6) == 0) {
 			if (strncmp(de->d_name, "memory_", 7) == 0)
 				continue;
@@ -1734,7 +1745,6 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 			if (rc == 0)
 				count++;
 		}
-		errno = 0;
 	}
 
 	if (status_flags & MEM_ST_ZONE_INCONSISTENT)
-- 
2.37.3

