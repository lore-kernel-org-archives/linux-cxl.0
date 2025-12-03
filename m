Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A732BF019
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794168; cv=none; b=dvJKpTl3X7dcAJ+B6CMqmLNs8eQLG9ZWc+0pLT7T24rgOOlDBMbf+sGvyWS0/Qrqk5GKLB/gukAMZZN+PJRqT36kIdjQf5gR7vwfN15s2G4LKOjKmSzVf2mgGqeWC1V8IxfkE4FYlckbJTmU2btHygxorjq3ckm1E8892i3PqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794168; c=relaxed/simple;
	bh=FO216o8xJXGraxxbWEQ44LsZgfMJ8osSHBQaNcM0Zo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ82Ca6DwNLhQBlck0KYsMK2l8RIogZHGBM5PcjF3ZfeFWJRixY6+Hlk2OPFPY0zKAx3aLBqxp5czKzzh+F6RIeRpJzfNRkL59Sq03ASuF85uA5oGlt1CfrSxGmXnkFHlfn9/bdjAJ3WS/E5FMo0ZFw7icyA+pz9PBMFQVsWj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbBGVZFn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbBGVZFn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343806688c5so99328a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764794166; x=1765398966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3k28YGfI6fWkQjpb1Y0AMIgfzWAj0D32XXxuiqOOaE=;
        b=IbBGVZFnbyMnoDHCVvNDkMbUZqugCXW45YAFYc+guLNzi3pSsr8Kf4xH57i13K5BD9
         5LL1hA+wjHDfV6WMy4XIGzKTHPbFkR7Ye9VuFIMayWA6+Qbr+IYB3NwHmALt5E8zP8cd
         QkHN07MoSWzHbEo0KSQabkUzKCLJ9jZyClXcmHKS74hXXCt75gEo2NaFEv6KItILRjlu
         wGqFuXh6zHDFn6WRfwJIdZ9Lw2cAVWzdv88ypJ3tDeVXla+EOK7LEa+gRl+mQXhBVlch
         c8aBFto3RIpaHtGOxM6LBgki5AOPnTN+USsMy40ptPyD5jNXy00ixb/xPrK90XmVYAMS
         1mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764794166; x=1765398966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3k28YGfI6fWkQjpb1Y0AMIgfzWAj0D32XXxuiqOOaE=;
        b=r61hH80CcqIBERwa/7Um+xzCz24YotbV9DMaRFslZNiTDqD0xhCFA20k3ucOkSxRNy
         Ef849SMIbrubuoosunTOfmr8KVwbwrVwg9zt3dQTlaQ60tlGPM67ClONtukHL2nzdtHb
         tWhpiC9asJfNeSFennhw7ssw/UA2xosrS8k3q/RRQnfhTIoNvQmr0tt6/QlncvyPXcOO
         jf/Ln7QXBjA9knowgvYPJ3KU8HWx7IyeE1zbJn6jyJ+UTzTe6M2dTKkq/1fiHMJTo0/4
         cZ2d/MI5rE79CGAQM2Ivwd5AJzKavLez+cbKa2T6Zii0LwivgCx229pNEvUJPoshgQ85
         LaeA==
X-Forwarded-Encrypted: i=1; AJvYcCVjgD7IhkerwrOuR4GqFeZHUXxs2vdU+enUC3hUQPjJYcb5FaIwe+8XzgU/8mCekik0sagymSMyJjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2NoY1HL8Y1OUCDLEYzwj3Corsav/v+LEwda6pUSNAZ0AMdb9
	h6Zgyu6+avKSAuRY5hFiDdP50RvwEe5MGyK2bOAkHHLngssLjuqILjyX69XYLg==
X-Gm-Gg: ASbGncs1VNwjjUI4ARFm3UxfgeKGY1YmkGybkVsrzwFHdi2Dqc7LdhwRLv5lcNuVVCR
	5f7YpFjzCr6c+13z/mQOxTQJxDHuRFXnkj+9DcBbYRMJa3tFKNuoZm7M9I1aPrzci5wu3R/f1Yi
	Ff6vkE6dG8TB24jeJ08IsLOXScoXGyHQHXNU7AffaFUS/+PT0EmnOzPrkxLYiQ4CdShRFHcs0SK
	iFrud0AOEGmomKB5OkCWiu8Agpi89/fJSohQ1rDq5Iv7mY9mzaoHDZxfAASEPoZf11d/ovmn7vv
	4EOtOtoPJQa0c67G9SrDNy/6juuakqP1aHP2U/8JxZUtrlCm7rVzXyoKd+OYGaO1IDhHdTxEhuQ
	YbAtSZI7b0J9wrs7Z/v3gIIQ7cNEg7bi9MY+OtI7jESI5ofAT484gbW0qG9e75VNpmrNKpJ2ITJ
	i6gg+Oz93SWDa/fy3OvCA5e+T7Pe+a/U/3
X-Google-Smtp-Source: AGHT+IEAQrnyXJ95h61Dunf79D0vuNVEhk5bkOnWnqoJBTcpcIU8n4hyBEkbNR/ib4NbMsaXqtexsw==
X-Received: by 2002:a05:7022:1b02:b0:11d:f0d3:c5da with SMTP id a92af1059eb24-11df64a5e77mr320373c88.43.1764794166231;
        Wed, 03 Dec 2025 12:36:06 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb04a07bsm88257115c88.7.2025.12.03.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:36:05 -0800 (PST)
From: anisa.su887@gmail.com
To: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Cc: nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	Fan Ni <fan.ni@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC PATCH 2/3] dax/cxl: add existing dc extents when probing dax region
Date: Wed,  3 Dec 2025 20:29:12 +0000
Message-ID: <20251203203540.1091827-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203203540.1091827-1-anisa.su887@gmail.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Add existing dc extents on the device before probing dax region will
cause the creation of the dax device fail as resource cannot present
when driver is bound to the device as shown in really_probe().

We delay the processing of existing dc extents to cxl region driver
probe.

Question: the guard() in cxlr_notify_extent() will cause lock issue,
removed it. Not sure whether it will cause issue or not although no
issue is observed during test.

Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
Tested-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 drivers/cxl/core/extent.c |  2 +-
 drivers/cxl/core/region.c |  8 ++------
 drivers/cxl/cxl.h         |  5 +++++
 drivers/dax/cxl.c         | 24 +++++++-----------------
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 3e7295d3e5e2..3b0e4d72d4ac 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -285,7 +285,7 @@ static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
 	dev_dbg(dev, "Trying notify: type %d HPA %pra\n", event,
 		&region_extent->hpa_range);
 
-	guard(device)(dev);
+	// guard(device)(dev);
 
 	/*
 	 * The lack of a driver indicates a notification has failed.  No user
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index adab1f338ee9..da3ea3cf8585 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3232,7 +3232,7 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int cxlr_add_existing_extents(struct cxl_region *cxlr)
+int cxlr_add_existing_extents(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int i, latched_rc = 0;
@@ -3251,6 +3251,7 @@ static int cxlr_add_existing_extents(struct cxl_region *cxlr)
 
 	return latched_rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxlr_add_existing_extents, "CXL");
 
 static void cxlr_dax_unregister(void *_cxlr_dax)
 {
@@ -3287,11 +3288,6 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
-		if (cxlr_add_existing_extents(cxlr))
-			dev_err(&cxlr->dev, "Existing extent processing failed %d\n",
-				rc);
-
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
 					cxlr_dax);
 err:
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d22fe5e50647..3e400dd4f08b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -926,6 +926,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+int cxlr_add_existing_extents(struct cxl_region *cxlr);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -948,6 +949,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+int cxlr_add_existing_extents(struct cxl_region *cxlr)
+{
+	return 0;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 011bd1dc7691..15fc2de63185 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -18,21 +18,6 @@ static int __cxl_dax_add_resource(struct dax_region *dax_region,
 	return dax_region_add_resource(dax_region, dev, start, length);
 }
 
-static int cxl_dax_add_resource(struct device *dev, void *data)
-{
-	struct dax_region *dax_region = data;
-	struct region_extent *region_extent;
-
-	region_extent = to_region_extent(dev);
-	if (!region_extent)
-		return 0;
-
-	dev_dbg(dax_region->dev, "Adding resource HPA %pra\n",
-		&region_extent->hpa_range);
-
-	return __cxl_dax_add_resource(dax_region, region_extent);
-}
-
 static int cxl_dax_region_notify(struct device *dev,
 				 struct cxl_notify_data *notify_data)
 {
@@ -66,6 +51,7 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct dev_dax_data data;
 	resource_size_t dev_size;
 	unsigned long flags;
+	int rc;
 
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
@@ -80,8 +66,12 @@ static int cxl_dax_region_probe(struct device *dev)
 		return -ENOMEM;
 
 	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A) {
-		device_for_each_child(&cxlr_dax->dev, dax_region,
-				      cxl_dax_add_resource);
+		rc = cxlr_add_existing_extents(cxlr);
+		/* If adding existing extents fails, continue with only an error
+		 * message ?? */
+		if (rc)
+			dev_err(&cxlr->dev, "Existing extent processing failed %d\n",
+				rc);
 		/* Add empty seed dax device */
 		dev_size = 0;
 	} else {
-- 
2.51.0

