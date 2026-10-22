Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698980;
	b=cTh7BLkQvQrqSLpW5NbrlFbkSUuViP7SaDL4lU3yzyU+n7PtUTQn50nrMrfK3Uma3Ddm
	 2a3fAGz0qNjAFqOnmeQ3786YOhvZyPZ5E9H58W0R/fLer8CULK46sYknLXYomVZy5FtM8
	 VBUl/5MEru8gPYaFEHul03mhp2rgRMu/5vNUkypA7jF6NljPUSSajkJcTJ+5r5IYkDtY8
	 TnHWPi4IDSTGwKAFvbj4NPeyyubSlx+EC4a/usSOe87exSmX2hjzR3H0plvWRtfdhghbS
	 V2a98Sf8XonUfi7WyfexwtmI39NDZ8uS5/7xjDcMli8sx4XCGdkiK6BTiqyrRBlH1Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698980;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eRlZ30MErUrrYp7KJsOo9bltSNBptuKVzevsMaVYvpI=;
	b=a1u9wPyeAEmTDWq4VBWGzN8Fn0W1kMhWXD1G0afocv4sMXKyMbcWO9exFXqwEI9Z2Y/d
	 jRj+PhOtrhCyRzRw4eOb3027JJaYG78M0rjHiw4D2c+ZdrANCBlkispeqj+6BkbZ2lnsK
	 NXEkLluYVIBumC7AQ9b9+iSDi3WSOsyea4lY+l0F2eCyIQe+MQrTqrajeQxlr11Y/7OEu
	 4p9iwjroyiBjGBNZO52nL0rH1X4HYFjjwWwcTOCB5YSKdvJCgI3vjROVU2I9VKdeU5GBy
	 NbahY3g/+H9L6zdTVn9PPqiYlMhylfEZ8qFst4+Od+VoBXFT4a4ANnk+QER5lwPxi5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2giLO55;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60E606A31D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 19:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB60E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2giLO55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792698979; x=1824234979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFoXRrHqBCoo0n/nI+HwpEka6Kpj51gw9tTamZUwwhY=;
  b=g2giLO55kxtmO37ppzHBp0Yh/dIM2GvY46elNqKj3vaFyH/MrupeB8Bj
   9J4LDkdfvdP6ZbSyFtTjYM+eTifUAl2w/QWYDgam+Jtm7IxdmXI4uBv0O
   VWBWGX7AYtU3/mnP0zS5Dx1SFxtZv8qakJ5aNOEs+Yd0LDV/gfwjqm+Y8
   i0cT7vkzghTgHZUIthwAfslSoa6PsBNqa4HnZO6ZAH74r3UHFidMx105K
   o7yW7EbhqByuxZXtXm6jOV5H9NmT4iRXGZIsCbxwURYXkiYCmCpAG0Vv4
   uKH7vr3kVFCrbxJWfZF2UG/yeijbfpFMVwu7uuS+2SCVY0IsA2DP3zwHR
   w==;
X-CSE-ConnectionGUID: x/WYEQVDQICxSKOLDAXriQ==
X-CSE-MsgGUID: s8EToXn0TIyaXoD+zhF+AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1356729"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1356729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:18 -0700
X-CSE-ConnectionGUID: Lug5Mt6cS6uSghyFwVSang==
X-CSE-MsgGUID: D8oZ8tJPQQKKCUCKpsU24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3839573"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 1/4] libdaxctl: handle mapping initialization failures
Date: Thu, 22 Oct 2026 12:56:10 -0700
Message-ID: <7737e1406eb60677979d3b6b090d52ee124ebaa7.1792695259.git.alison.schofield@intel.com>
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

A failed sysfs read can silently truncate a device's mapping list, leaving
callers with incomplete range information and potentially incorrect memory
block accounting. An allocation failure also causes an infinite loop,
hanging the caller.

Distinguish the end of the mapping list from read failures, reject
incomplete lists, and discard partial results on error. The mappings
describe the device's constituent ranges, so validate that their combined
size matches the device size. Return -ENOMEM on allocation failure.

Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
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

