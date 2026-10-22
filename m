Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698981;
	b=IPYDlmM4h0RJmNmFGMbTF9F14qaf2gRgz9agwgh4xRdWvmSE/vjWq4DlELqz2Mmn3fYd
	 VqNY+V4T+u+6Y0hYA9nZJAh7jsHerCPQsQpc2X9MSUx/noL0MxhgzqVfaDl2hiotdLspe
	 aY4UzTkpGwLUvW32G89x4d9O32tgkPz2NO6765iGODiZPMHdcGd0G+HvjODKN7p3zpSjv
	 xpkUuyau6GlADQP8XsEloDCgN9n4l8GspFUzDiDNe3+GfDphe5yR7B7+O0CfWrsNUo04V
	 vKMm5RomjacuL4fs6GbxthevdrwfoSCdl8QVcyrJB8vGBUf4RzmHvvlnxqIGdkumN7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698981;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VCcl/HYnCwHmpJGyXY7hNoTt27osOIu6zxBGaq/VIw4=;
	b=fiK3p1t6L1OF2kwnvKTKdaNhSUVONakCwPlE5tU7zp+hKA7jwzddZPPJcjoC09slGarj
	 8uowAhMFL4GTccv7GbWO/LBPXNrJNeJI7cp43I1HstRBKxtzLAv2MmUIDQ0N6iqS8olRX
	 spp0Sp8k7PuZvEzRmheG7Yd0Fh04xXL/n9z6Qt0dSNR7U13ACPxTr56/EPe4i2REGRRVJ
	 eK/CrpozS1sT4w55saApKZYU3cc4D1NUEFGcbVLRV8/meQPEH/LKaawZAo7aZLHDkDPvi
	 WX2/FhJFrIFqEdorAZIK1z4DzHKguTytP0Xttp4Hz7jDLpGE+fE5V3HwsHxIyfFoe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mT8oezb/";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D29606A322
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 19:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D29606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mT8oezb/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792698980; x=1824234980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KopajrRM1T8jMSl3Dj4YuVFtbspqWdSeiZJiPQc+VZ0=;
  b=mT8oezb//JNKzjrMGx7dQtxQDRUATcay2uC471wvmfa1O9cY+buXOJxq
   hCd04uuc/JzmcZnJIemlDBMXif+ytyZvOZCz+JmQco2jYLv52jGmvz0uG
   S0hsA6ZGykObLb1IS9RL9Aj8d9Nwhv5ZyCY8550J1OlHsFi+ORFr0Wsnd
   d77CO7t/a5Z6LnVrXz6QR3LvVtWR1OnPchGNC3wFRL4GhZrX/JzWIYaSn
   bsP72lxT9oPfz3rev/VqSuJ5jaZjgItfH2fjqQ5+qjEWarU+qChHGCgKA
   nnWDfou+bIoj6EEesu1XJiiWuBV3m6oei2AyDfIwoKu5nJdcwCwZbezHt
   A==;
X-CSE-ConnectionGUID: gClR1adzR5Cdb8hgAksE4Q==
X-CSE-MsgGUID: VpmRdtu3S4aK7/9whbrthg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1356733"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1356733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:18 -0700
X-CSE-ConnectionGUID: 4V4ngkMrRQe92HwAmb69+Q==
X-CSE-MsgGUID: CCF1i54hR1WN+OPXjZNHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3839582"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/4] libdaxctl: tie mapping cache lifetime to the device
Date: Thu, 22 Oct 2026 12:56:11 -0700
Message-ID: <6b3b42e253c4aca3f4c080d0a7698a09ef24465e.1792695259.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
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

Cached mappings are not freed when a device is destroyed or invalidated
when its ranges change. This leaks memory and can leave callers using
obsolete physical address ranges, potentially operating on memory blocks
that no longer belong to the device.

Free mappings on device destruction and invalidate the cache when device
ranges may have changed.

Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
Fixes: 52a2653098a5 ("libdaxctl: add daxctl_dev_set_mapping()")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 daxctl/lib/libdaxctl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index f630f4791f59..f7cbf3fa12e7 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -241,6 +241,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 	free(dev->dev_buf);
 	free(dev->dev_path);
 	free_mem(dev);
+	free_mappings(dev);
 	free(dev);
 }
 
@@ -593,14 +594,15 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	else
 		dev->target_node = -1;
 
+	dev->num_mappings = -1;
+	list_head_init(&dev->mappings);
+
 	daxctl_dev_foreach(region, dev_dup)
 		if (dev_dup->id == dev->id) {
 			free_dev(dev, NULL);
 			free(path);
 			return dev_dup;
 		}
-	dev->num_mappings = -1;
-	list_head_init(&dev->mappings);
 	list_add(&region->devices, &dev->list);
 	free(path);
 	return dev;
@@ -1186,6 +1188,7 @@ DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long
 	}
 
 	sprintf(buf, "%#llx\n", size);
+	free_mappings(dev);
 	if (sysfs_write_attr(ctx, path, buf) < 0) {
 		err(ctx, "%s: failed to set size\n",
 				daxctl_dev_get_devname(dev));
@@ -1242,6 +1245,7 @@ DAXCTL_EXPORT int daxctl_dev_set_mapping(struct daxctl_dev *dev,
 	}
 
 	sprintf(buf, "%#llx-%#llx\n", start, end);
+	free_mappings(dev);
 	if (sysfs_write_attr(ctx, path, buf) < 0) {
 		err(ctx, "%s: failed to set mapping\n",
 				daxctl_dev_get_devname(dev));
-- 
2.37.3

