Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317464;
	b=YR8PfdF5fv9rxXfAtTPVRv4uujSYV5rZyMA/+39C6aJ59blbTKLVqZznBLBpzQnfjlHA
	 paGZ9mh/fwmrZzHTQCWIqNZrd7u1sSpFEOJhQDO/NfZX2SKpgCNXZDdVhHOv4JsU136vg
	 aprIO1WStvylGtKkj74kLWxI9hqJb7roFq/jrQcM/h8IyXPyW32QCTBiNOenWBeAUmj8N
	 h1c3aG4EGtI4ExGeS/pgbMwpLB5A1uC/1m6IO5shg9Phx1DkvPWsrWh/XFHHp0kas9xsa
	 tOCCdjiD33zCCvaMkzSa+K/rin8+MOkiS4E5vRL4XkDL1Fau5V3VUd5ye0rDEaV8mIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317464;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YJGwxRgkkxgvwREvcnIaj6EEooacXRGwt8bgxSyGYdU=;
	b=W/N0AJKnyyU/XPtPh/Am58OQCnP8EraOdzyxdSeaDOJXMTc/E9snwsTwQ0HpypKqH+4A
	 +T1kRYZgjx/zeQn3lJsJ1O2fv4GyCrNFe4+djqcMem6Gt3ra2XAmvnrm5jTwREa6Xm6P7
	 0Rnld6lBdMy3rUZAfEhk32n0CW3lzGRg/Ee4hR5TjCmV3eTIncmTHZilv05d1MpDU2ZQo
	 UYT2A1xklQ+gG8ppLOXvznwA16CsGnNN69/V//6aAmgEvoHXlNTmlelmvAWrpjzjTpVt6
	 hoxQ9GFZAKBbliWLaub3Tc3Zx3M4iYP0LYkIbtc7FpSvM7FiAEPssFtdVEIRWkhD9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=(null) smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OsprY4Px;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7A606A31E
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C7A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OsprY4Px
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793317450; x=1824853450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvC/Pqv3Fd2Mxa5Fh6O6lL6FaLLmjedW2OZsP9Y/MwU=;
  b=OsprY4Px9pzsflzLZvBWLWgNAFcy4IAHf6POT4ldivbleJX/1yaQSQSq
   GyijH78uhBVvogNpJtRtrcNvwlXYWmqRS+jyZkAqxEfERgGWSCEZ2YFBH
   TLJUcIUwP+gnN7VbgS9WjCjRZNplCgkO8KdUPRd9muvRT+7Y59tRXAiJ8
   arll2SEZIugAikBeyWH1W41FOsmsDX0NYISXTbEG1h/CHBLkBxlzbN4Lp
   muCidpJAOVuonloOBja0j4uNOwjF/b80iIoDjD3YJwslFP7axv5ksfBH/
   mA4IXjTkPhLxBMBd61D11nwSd3gziPKEBqNRvcBqPCpUJBnkh/vkiyqXv
   w==;
X-CSE-ConnectionGUID: aDNG8ZGUT1WtgISiDD3ppA==
X-CSE-MsgGUID: WPAfW6+LRbeLyQCJAf14Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2100439"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2100439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:08 -0700
X-CSE-ConnectionGUID: 3jGfJZawRy64JwA9pOnfsg==
X-CSE-MsgGUID: 1uczc6svTTiOSjfMN38Lng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5385214"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v2 1/4] libdaxctl: handle mapping initialization failures
Date: Thu, 29 Oct 2026 16:44:00 -0700
Message-ID: <e1c1f0e96ed705bc7b400b84c98077071a9e9db5.1793315621.git.alison.schofield@intel.com>
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

A failed sysfs read can silently truncate a device's mapping list, leaving
callers with incomplete range information and potentially incorrect memory
block accounting. An allocation failure also causes an infinite loop,
hanging the caller.

Distinguish the end of the mapping list from read failures, reject
incomplete lists, and discard partial results on error. The mappings
describe the device's constituent ranges, so validate that their combined
size matches the device size. Return -ENOMEM on allocation failure.

Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 daxctl/lib/libdaxctl.c | 70 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 5b47c770bd15..f630f4791f59 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -222,6 +222,17 @@ static void free_mem(struct daxctl_dev *dev)
 	}
 }
 
+static void free_mappings(struct daxctl_dev *dev)
+{
+	struct daxctl_mapping *mapping, *_m;
+
+	list_for_each_safe(&dev->mappings, mapping, _m, list) {
+		list_del_from(&dev->mappings, &mapping->list);
+		free(mapping);
+	}
+	dev->num_mappings = -1;
+}
+
 static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 {
 	if (head)
@@ -1269,15 +1280,17 @@ DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *m
 	return mem->block_size;
 }
 
-static void mappings_init(struct daxctl_dev *dev)
+static int mappings_init(struct daxctl_dev *dev)
 {
+	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	unsigned long long size = 0;
 	char buf[SYSFS_ATTR_SIZE];
 	char *path = dev->dev_buf;
-	int i;
+	int i, rc;
 
 	if (dev->num_mappings != -1)
-		return;
+		return 0;
 
 	dev->num_mappings = 0;
 	for (;;) {
@@ -1285,31 +1298,43 @@ static void mappings_init(struct daxctl_dev *dev)
 		unsigned long long pgoff, start, end;
 
 		i = dev->num_mappings;
+		sprintf(path, "%s/mapping%d", dev->dev_path, i);
+		if (access(path, F_OK) < 0) {
+			if (errno == ENOENT)
+				break;
+			rc = -errno;
+			err(ctx, "%s: Unable to access mapping%d: %s\n",
+				devname, i, strerror(-rc));
+			goto out;
+		}
+
 		mapping = calloc(1, sizeof(*mapping));
 		if (!mapping) {
-			err(ctx, "%s: mapping%u allocation failure\n",
-				daxctl_dev_get_devname(dev), i);
-			continue;
+			rc = -ENOMEM;
+			goto err;
 		}
 
 		sprintf(path, "%s/mapping%d/start", dev->dev_path, i);
-		if (sysfs_read_attr(ctx, path, buf) < 0) {
+		rc = sysfs_read_attr(ctx, path, buf);
+		if (rc < 0) {
 			free(mapping);
-			break;
+			goto err;
 		}
 		start = strtoull(buf, NULL, 0);
 
 		sprintf(path, "%s/mapping%d/end", dev->dev_path, i);
-		if (sysfs_read_attr(ctx, path, buf) < 0) {
+		rc = sysfs_read_attr(ctx, path, buf);
+		if (rc < 0) {
 			free(mapping);
-			break;
+			goto err;
 		}
 		end = strtoull(buf, NULL, 0);
 
 		sprintf(path, "%s/mapping%d/page_offset", dev->dev_path, i);
-		if (sysfs_read_attr(ctx, path, buf) < 0) {
+		rc = sysfs_read_attr(ctx, path, buf);
+		if (rc < 0) {
 			free(mapping);
-			break;
+			goto err;
 		}
 		pgoff = strtoull(buf, NULL, 0);
 
@@ -1320,9 +1345,30 @@ static void mappings_init(struct daxctl_dev *dev)
 
 		dev->num_mappings++;
 		list_add(&dev->mappings, &mapping->list);
+		size += end - start + 1;
 	}
+
+	/* each of the device's ranges has a mappingN */
+	if (dev->num_mappings && size != dev->size) {
+		err(ctx, "%s: mappings total %#llx, device size %#llx\n",
+			devname, size, dev->size);
+		rc = -ENXIO;
+		goto out;
+	}
+
+	return 0;
+
+err:
+	/* sysfs_read_attr() already logged these */
+	if (rc != -EACCES && rc != -EPERM)
+		err(ctx, "%s: Unable to read mapping%d: %s\n", devname, i,
+			strerror(-rc));
+out:
+	free_mappings(dev);
+	return rc;
 }
 
+/* NULL means either no mappings or a failure to read them */
 DAXCTL_EXPORT struct daxctl_mapping *daxctl_mapping_get_first(struct daxctl_dev *dev)
 {
 	mappings_init(dev);
-- 
2.37.3

