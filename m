Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADF35CB6B
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720710; cv=none; b=sWYPu0IJv1KTu8T0eMMd8mh47DRbF2MG/ugyYXFZYDd/r7rJ4qFr94bVzHGWwplKfOqL7XpYIs3V0ZmzOzPOXxNqqPoRSGneABw3XJ0C/+KE/3gVoQb+pJYZbjBfTu4L6naqql9tfSOc6uv31lICWwgQaLZwC5d7g8OEebTUwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720710; c=relaxed/simple;
	bh=iBrRdDjjJNCNPe98g9cITjVy6s0GzL4YINvlGeB4imc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huaICWffwqtjunjUuFXnTuaNpG+AbBqe1rnS3uPg3hFtMNKfvZu19hiOPinVOvEUKm5kOEiEc2K5k6mpshKrGjRL6tlzkFXeQQhQd47gdqcOgA3DSOfcKY6ucoZhKA566UO+8k/HP1MOz9kjp02Cn744YxERDp42TANc5D/IQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OUKin7me; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OUKin7me"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a3d2f3299so16064106d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720703; x=1770325503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpgSTfoH6x9FkcQxT+wr5JUESeygPnLUnHeiLg7bHkA=;
        b=OUKin7mehiPc0J+MFPXJDEJ07nav+vz8WRu15f/bWbDd3TZxl2kjWxtA92vxD9AM0/
         VJcsTrSfMH/h7LrWf+2OR9vPUbqKILssoXvhD7g/dFAkvwI6Cos8ZgVC2Cg3ukwbeFF4
         LfF2uiNj5t6eyj7Ija1WV720htkSJGf9MJM61Hd11m60So97L4Ocn48yaOV/MfCilFkM
         EmLpxLLJfjgwBi6Ct/o3uVB4emRpCWf4MrgPB5tvZVbg+rV/wD1/mgM6eHGqd8kfzQ/b
         mvWMQQ+2d8XeTNdsbpxHuOt/hBBaha2i1kZEDcUhlPEg4PkjoPBXFe1Xy+JJlrL8h0SP
         8m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720703; x=1770325503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpgSTfoH6x9FkcQxT+wr5JUESeygPnLUnHeiLg7bHkA=;
        b=VCRHa3P1uzo4yWzHxR2qZOAQsF8Fg848kYUY2xcM3ty2nWcVuZiPcsK7IWeRyY/aS5
         5AKTAw7mzFMOkx4LGBuHtr1z/JYku0H2zTw/TWpkDdp2VO4G66trl8oq4eXpMjafw/e2
         flas2MuO9M6sqFSYmbDF50FhNZUXs0lPQHfSAuKD29cuItLQx9XI7k4sDz7PFWmqrvYv
         lQr3Sx1SW4/GL5h2rl4vgF/9wq2ZRNFjGoVDjH4CI6jE0IN6IQvMfM+MBS0ycdAsoWVg
         xBTVEfSeZaKDYY9M4mYmgkfNLbIqa15CfF3PaflJfGvEx3+NR6L637oyzEetR2uBDZTf
         TTPw==
X-Gm-Message-State: AOJu0Yzl7JUEl3vwHL3Iryo2uf+ZELLQgvzwcTU6goAVaXvptRO83FQK
	Y141atgH/a9vJJ13KxYZ2btVL/bbauycDtxYXBCa2iSGXfzN0YCWlsNDVmGMKJk9JfQ=
X-Gm-Gg: AZuq6aJD6Eep1K0/CFdZTJhX1MPxc1fzm0USL7AGL68tJLqvYWZxVNg6KAZG4OY2FFy
	QmPU6Gt7yKaBTxzUZDxtE9Q5d0VrpyPDYQTSR3bySRF8kJfWxzRho3wZsTZIHBfkbUglK5qxBJ+
	a6Fs2+2X+tuWraAOwkLQTq/YFqTP/V5o12n2OZABWYCtuwBZxkECSgDhpuofiYm6QFPz6+zJ7xj
	jf8zDpUpDIVB0WLKVtVC90LL3P1EU0pfMCCLydT6qfOfUfdZHYH3v1/9CJuny8X1KhJ9zEQKYwU
	0XK//arB++qJpzreBBI0GtS28q8NBvNP180pUB+zf78v8/rY5g+CSLU8Kb9PHTtQ2XoVdLwJE8B
	YJrM6cEy2k8hIHDSjo8ojZ201/1MzvSgUWWMsQElV8ZSRK1x2poTcS14/yEwuyIEJQRKpBuOzUZ
	3KVZJkh80pnhwlQ/6A2Xv88TsDUR3SWIBoNdA/uH3J7XEO6+FjA850VULDJWtZG763C9vzrCE1b
	tM=
X-Received: by 2002:ad4:5aa2:0:b0:894:78e4:27cc with SMTP id 6a1803df08f44-894ea026eeemr11955076d6.38.1769720703415;
        Thu, 29 Jan 2026 13:05:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:03 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 7/9] cxl/core: add cxl_devdax_region driver for explicit userland region binding
Date: Thu, 29 Jan 2026 16:04:40 -0500
Message-ID: <20260129210442.3951412-8-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new cxl_devdax_region driver that probes CXL regions in device
dax mode and creates dax_region devices. This allows explicit binding to
the device_dax dax driver instead of the kmem driver.

Exports to_cxl_region() to core.h so it can be used by the driver.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h       |  2 ++
 drivers/cxl/core/dax_region.c | 16 ++++++++++++++++
 drivers/cxl/core/region.c     | 21 +++++++++++++++++----
 drivers/cxl/cxl.h             |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 217dd708a2a6..ea4df8abc2ad 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -46,6 +46,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
+extern struct cxl_driver cxl_devdax_region_driver;
+
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
index 0602db5f7248..391d51e5ec37 100644
--- a/drivers/cxl/core/dax_region.c
+++ b/drivers/cxl/core/dax_region.c
@@ -111,3 +111,19 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr,
 	put_device(dev);
 	return rc;
 }
+
+static int cxl_devdax_region_driver_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (cxlr->mode != CXL_PARTMODE_RAM)
+		return -ENODEV;
+
+	return devm_cxl_add_dax_region(cxlr, DAXDRV_DEVICE_TYPE);
+}
+
+struct cxl_driver cxl_devdax_region_driver = {
+	.name = "cxl_devdax_region",
+	.probe = cxl_devdax_region_driver_probe,
+	.id = CXL_DEVICE_REGION,
+};
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 61ec939c1462..6200ca1cc2dd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -39,8 +39,6 @@
  */
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
-static struct cxl_region *to_cxl_region(struct device *dev);
-
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
 	.show	= _name##_access##_level##_show,			\
@@ -2430,7 +2428,7 @@ bool is_cxl_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
 
-static struct cxl_region *to_cxl_region(struct device *dev)
+struct cxl_region *to_cxl_region(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
 			  "not a cxl_region device\n"))
@@ -3726,11 +3724,26 @@ static struct cxl_driver cxl_region_driver = {
 
 int cxl_region_init(void)
 {
-	return cxl_driver_register(&cxl_region_driver);
+	int rc;
+
+	rc = cxl_driver_register(&cxl_region_driver);
+	if (rc)
+		return rc;
+
+	rc = cxl_driver_register(&cxl_devdax_region_driver);
+	if (rc)
+		goto err_dax;
+
+	return 0;
+
+err_dax:
+	cxl_driver_unregister(&cxl_region_driver);
+	return rc;
 }
 
 void cxl_region_exit(void)
 {
+	cxl_driver_unregister(&cxl_devdax_region_driver);
 	cxl_driver_unregister(&cxl_region_driver);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c06a239c0008..674d5f870c70 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -859,6 +859,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
+struct cxl_region *to_cxl_region(struct device *dev);
 
 extern const struct bus_type cxl_bus_type;
 
-- 
2.52.0

