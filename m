Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70B3DA7E3
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386948; cv=none; b=oxYBA8vPJPbEID8/CAGKgQyaQVcNHmIJU8GwSFX+QY4iN9MlLtcUiAYjohWjEriR7aRKpHNtPE4N2ZHRXrKGh2zI1TVUEUdsGnUJXd4oqxOwxJmzZc3TzsDdE8qIY4r76U5O/v3QMeqwimdW8omPN5+zsOpxN3zzP6cVsRpnynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386948; c=relaxed/simple;
	bh=LEZC3MO/WaZS4jxS6iD0aTZN8ESV1qwkkQ7dY3zbDro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7LyeknAGncx+hqvBI9DpF1TmnISAO5Kc4fGIe3MIL7p+DGZ9wkHzirPZPrx1YjzWH2tssjaqYzFwaBja5XgaKqR5yKmN65JAeQJEnO3ZdS+mF3JMJoT3UPWqWzUcOgHwDYfjYdEDjPR3ks5ewP58NTb86L6b4xPSdC/SeseGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXDrNrhM; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXDrNrhM"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30b9e755555so4752298eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386946; x=1782991746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eqixxHBzWgy8N3ss1BGp04bdky8Wf/e/gb6jXQ7BSI=;
        b=EXDrNrhMSxbUvUONMqp1cUokreh4KRzaq5fJwN1FNBxc2/Xn5QlTx+YCzTvd0sA3wk
         M7ahoI4Tho1BJR3VjPDPicFjpUTETXAyiBT6nSGqciEGgXUg+fdtTjM2GtteSYC9PZT+
         4w6U/yelS5ZDQM4AsYAisASU1jlVmnK8/HE+vk1lKlpmmT43ZsGLoYPNA8i5lsRcuA6A
         XY3plGcM/TTufG+iombXcMIPGfMssAvqp+2HkP4gw5i8K4HBDhCJCQllOrhb/z9WTBYh
         L5ex00rroTsgoQrLuVF3XIUCj5LpKCMr1hJlQhDIyBdCq9XAqSW8JN/XXgDPMYUHdfxW
         HAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386946; x=1782991746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eqixxHBzWgy8N3ss1BGp04bdky8Wf/e/gb6jXQ7BSI=;
        b=kvpp2eviF2f3rb1SU5n1VtshCkBCSx7wWYcIhooHtcPGv+iGJttn5c0DlONanTmCIy
         l/NSTeJIU7YOFdVEU215Bixy10Yh9BdknKj/ab84ze9pO63sEioIWkmwQNy70lJbO0LS
         Q0YrRU11HUJNhIN9npjCo8f9bwf8BJr0pWoOPZtBesW743QtdmRmEWET2unPRnzpktWf
         X/Yozfsnp+REzbTiK/1Cv5BqahIae1fUSBkmVlN19kSOxLC5Xy6FU6BsxnAV7YT7rNrM
         GIZkgO8EryQjjEyRKtLraVL0esC2dM8ZpMV8U+OiSuJENy0al4ch8/TKkJBClCfl730P
         DhVA==
X-Gm-Message-State: AOJu0Yzc9dQw2U3vJooAvE+WJD3fDOAnu84+OP6KL3hJ9cRtFszeRliu
	MvUVwEjTVaROM/YejY4UTtRbOsyDA9my5M7gM6myIzFvdWFzZ8oVYDTSrD1Dqw==
X-Gm-Gg: AfdE7clAT6DYShUdVzidfCBcTWpNvadU9q7AEXNqLSFJrNnbGMY7mtbJNg7UeIAzID6
	N/4aitSQs8VoPFL0pdaXtnDKg8YufqdeYcXs1ykmhmjs6R++BHZVoXdMSXtAo+Fiv5TGnVKsVUq
	oNj/npHU2PgN6Ohlxt0Yak+tclzMJtteAdNp51iJjNI2Ifx/AIHAcaod+2JqFUnCVvcx3jDG49+
	ePbRERC9AN7VYGtBDQDI04Jl3nXf1kNNkemhXf5jsZBAMADiI2zcpPtbhcbAKMf5xx5QtIma43j
	EZiv+gHTAPHhZk4CmFpSTxBka3r/a1WqJlabrHQNICb0FyKmKh5N44eoEag84hKXML+x/zBiMP4
	z9fd7oPLc1i+nRSduenWMDa5wD0iGzY/YNZc5gN5/Q3ISPhCWAKeP4iJ7YqxoXSMrwA2YlG4rGQ
	1aM0gLRpsBDkDzsf9YDgyVc6w9DkrJONJAYhlDRXIyYHycAQDbaSz+nSLK/W7O7B2KoIvnuaa5q
	8R25Qo=
X-Received: by 2002:a05:7300:5351:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-30c848aca17mr3109849eec.0.1782386945523;
        Thu, 25 Jun 2026 04:29:05 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:29:05 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 25/31] dax/bus: Reject resize on DC dax devices and enforce 0-size creation
Date: Thu, 25 Jun 2026 04:05:02 -0700
Message-ID: <20260625112638.550691-26-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

A DC dax device's size is determined by the extents that back it, not by
the user.  DCD extents are all-or-nothing, so partial shrink is just as
illegal as growing.  Enforce that on the size and creation paths:

  * size_store: any non-zero resize on a DC region returns -EOPNOTSUPP.
    The sole exception is size=0, which daxctl destroy-device writes to
    return every claimed extent to the region's available pool before
    the device's name is written to the region's 'delete' attribute.
  * __devm_create_dev_dax: a DC dax device must be created at size 0.
    Non-zero data->size on a DC region returns -EINVAL with a clear
    message.

To prepare the shrink path for DC, dev_dax_resize_static() is renamed
__dev_dax_resize() and gains an explicit @parent resource plus an
optional @dax_resource; a thin dev_dax_resize_static() wrapper passes
the region resource and NULL, so static behaviour is unchanged.  The
path that walks a per-extent dax_resource->res parent (so shrink-to-0
releases each extent's child resource rather than the region's) is
wired up by the tag-aware uuid claim in a later commit.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dax/bus.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index f61309a6f934..f086ad27d507 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1181,7 +1181,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 	int i;
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
-		struct range *range = &dev_dax->ranges[i].range;
+		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+		struct range *range = &dev_range->range;
 		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
@@ -1197,6 +1198,10 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 			continue;
 		}
 
+		/*
+		 * Partial shrink: forbidden on DC regions, so dev_range
+		 * here must belong to a static device.
+		 */
 		for_each_dax_region_resource(dax_region, res)
 			if (strcmp(res->name, dev_name(dev)) == 0
 					&& res->start == range->start) {
@@ -1240,19 +1245,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 }
 
 /**
- * dev_dax_resize_static - Expand the device into the unused portion of the
- * region. This may involve adjusting the end of an existing resource, or
- * allocating a new resource.
+ * __dev_dax_resize - Expand the device into the unused portion of the region.
+ * This may involve adjusting the end of an existing resource, or allocating a
+ * new resource.
  *
  * @parent: parent resource to allocate this range in
  * @dev_dax: DAX device to be expanded
  * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ * @dax_resource: if dc; the parent resource
  *
  * Return the amount of space allocated or -ERRNO on failure
  */
-static ssize_t dev_dax_resize_static(struct resource *parent,
-				     struct dev_dax *dev_dax,
-				     resource_size_t to_alloc)
+static ssize_t __dev_dax_resize(struct resource *parent,
+				struct dev_dax *dev_dax,
+				resource_size_t to_alloc,
+				struct dax_resource *dax_resource)
 {
 	struct resource *res, *first;
 	int rc;
@@ -1260,7 +1267,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	first = parent->child;
 	if (!first) {
 		rc = alloc_dev_dax_range(parent, dev_dax,
-					   parent->start, to_alloc, NULL);
+					   parent->start, to_alloc,
+					   dax_resource);
 		if (rc)
 			return rc;
 		return to_alloc;
@@ -1274,7 +1282,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 		if (res == first && res->start > parent->start) {
 			alloc = min(res->start - parent->start, to_alloc);
 			rc = alloc_dev_dax_range(parent, dev_dax,
-						 parent->start, alloc, NULL);
+						 parent->start, alloc,
+						 dax_resource);
 			if (rc)
 				return rc;
 			return alloc;
@@ -1298,7 +1307,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 				return rc;
 			return alloc;
 		}
-		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc, NULL);
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
+					 dax_resource);
 		if (rc)
 			return rc;
 		return alloc;
@@ -1309,6 +1319,13 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	return 0;
 }
 
+static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
@@ -1322,6 +1339,8 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return -EBUSY;
 	if (size == dev_size)
 		return 0;
+	if (size != 0 && is_dynamic(dax_region))
+		return -EOPNOTSUPP;
 	if (size > dev_size && size - dev_size > avail)
 		return -ENOSPC;
 	if (size < dev_size)
@@ -1333,7 +1352,7 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return -ENXIO;
 
 retry:
-	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	alloc = dev_dax_resize_static(dax_region, dev_dax, to_alloc);
 	if (alloc < 0)
 		return alloc;
 	if (alloc == 0)
@@ -1717,6 +1736,11 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	struct device *dev;
 	int rc;
 
+	if (is_dynamic(dax_region) && data->size) {
+		dev_err(parent, "DC DAX region devices must be created initially with 0 size\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	dev_dax = kzalloc_obj(*dev_dax);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0

