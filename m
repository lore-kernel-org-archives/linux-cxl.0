Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1C139D
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834027; cv=none; b=lc3PU5ZJgwlVDKB0L9c6E/7K/luUWeOmRjjP0xgrHcL2zKLUH9tvO9aOXbuCfyBCVPFXE60AebFjCGKORJiue34ReoIupDKFrfZW8un+n66yZUk/thw/cjIOT+A70Ewiv8aSRDv4yQWaB2bIpJIYFEEVg/AKSgc/i2LxsY/wPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834027; c=relaxed/simple;
	bh=JVg6WuJdpnrGYPBRN8h7I89sVuilX1TIZd3bOZQvQ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPit3D83OmYBRcwfIVGw4vY40jxV0J4coJQtbQsXFx0SfsVV1YiCO03Y5+UjM4C5K9w7IVnQp7BAwVQIjxe4LmPyu+YWUkvCc7xqnGayJ+k1yUhGLt+5rjUQJBjI4WxD61zqdaamXvagkkgJtvI7mXjZGFP6tpuGyRNkEpx9nSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ab5fd969aso55149797b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 22:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776834025; x=1777438825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hcov1izHTpncQzuxQpNFTuDzi6szui6lCG7Na0Ey9Hc=;
        b=Ou8SrtfNzLfyedHEthm+d0Z6kOneEj9yP3vZk2kAWpObVuqo80pJLw+q5UwT7T2SM4
         qpi768DUTJqkjirEbD+BhvZWkfjbWA9rwbPYfV2MvJZ03REzpBT65IOpES6bVlV16wGm
         c5kkIFm+NdRj6w4npCZCXW6WNunXWWvuGyMUzKhlpkyMeyskISGxumhFtfQmluBLKDJe
         IjGQ2sPLim0hXh8Bx4b2gGDR+5T3jRQgJdVJEGGLxhXO0V4BHY2dKwPDZdZ9aNikybzv
         7QUhWYehbvMLnox5gekm1O6uGEBXkXj3ww9T1mS3du+41RthO3CaXRxFNQ+eA5K1Wc41
         LOxw==
X-Forwarded-Encrypted: i=1; AFNElJ8v6oJoh1aYid82SObJbCVFg6Uy58eOsKYbg1U8F5srEL2Gzh/K9iE9oCMvjLl9CDgzEtNrhnu/3bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJNZlmppjE7ntljg4ZtQGfNXXtSkUoYpWanZAtK6lZ3/7/bM0
	H6Iqcc8IWgOxWZ8zOu8WFVFWMlSZ7cAnbIu2eP0/t29NIsdqUR+WilNw
X-Gm-Gg: AeBDieuHLRNT+tSVdphU+Cc6ce2bj5pjnnM1xc7nomRHUWKoVYj2XerHNk7HrUxyuRr
	vTtKNt17R3Cxg25H2+P3I1PBMtQ1DdAbwyGIDitAjTPasBWhc1n836c011WQipkVK4D/dYZbB2Q
	mOe/GP4nbFSgMt5n3NBcGnB3LTz9zSXhkZk9aKToSwpjIPRcY94pKMkWC/YgxmD/ao31mQo+HmG
	b/CuWdtEfYU1OBz2mTkuorDrutHu3/47gjEmslTsG7jBRkab4fGcRg7iw3Mb2wFcpWiQmce0mU7
	aUQMmxqxBh+HoAVIijT12jsiPyX5aSkNn4eaJ3CGwtrg2zLLft0V0Jz0wkxkBRWgB71dyVqNswS
	I9pI4/ZxJXTGhfKGDmk8EoWd/tsOqE58ncuDsQXwB68N0xVWwcsHaSih5tg6iAYBAi8yCOQeb2v
	xMbe+w/PEXx6nw0VaIOCswhaHkC85StGQ=
X-Received: by 2002:a05:690c:c4f9:b0:7b2:dad2:5e0d with SMTP id 00721157ae682-7b9ecfe760cmr207509197b3.33.1776834025393;
        Tue, 21 Apr 2026 22:00:25 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm33636607b3.21.2026.04.21.22.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 22:00:24 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cxl/region: Fix a race bug in delete_region_store
Date: Wed, 22 Apr 2026 00:56:36 -0400
Message-ID: <20260422045637.3048249-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_release_action() cannot find a matching entry in the following two
race scenarios.

scenario 1: delete two same regions concurrently

CPU 0                     CPU 1
======                    ======
delete_region_store()
  cxlr = cxl_find_region_by_name()
                          delete_region_store()
                            cxlr = cxl_find_region_by_name()
  devm_release_action()
                            devm_release_action()
                            // cannot find the action, WARN_ON()

scenario 2: delete parent and child concurrently [1]

CPU0                                    CPU1
devres_release_all()
   // take devres_lock
   remove_nodes(devres_head) // mv to local todo
   // drop devres_lock                   delete_region_store()
                                           cxlr = cxl_find_region_by_name()  // success
                                           devm_release_action(unregister_region)
                                             devres_release()
                                               devres_remove()
                                                 // hold devres_lock
                                                 find_dr(devres_head) // does not find it
                                             WARN_ON(-ENOENT)
   release_nodes() // drain todo
     unregister_region(cxlr) // release() cb
       device_del()

To fix scenario 1, delete_region_store() directly calls
unregister_region() with a test_and_set_bit(CXL_REGION_F_UNREGISTER).
Also, replace devm_release_action() to devm_remove_action() as
unregister_region() is now called directly.

To fix scenario 2, delete_region_store() removes actions only if the
driver is still attached. To ensure this, scoped_guard(device,
port->uport_dev) is required to check port->uport_dev->driver.
To hold this lock, a workqueue is required for a clean context.

Splat:

WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589

[1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@offworld/

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo.kim/
V1->V2:
- Made devm_remove_action() asynchronous.
- Made unregister_region() idempotent.
- Addressed Dan's comments and added the suggested-by tag.

 drivers/cxl/core/region.c | 45 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h         |  8 +++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..64db0d332c13 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -39,6 +39,7 @@
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
 static struct cxl_region *to_cxl_region(struct device *dev);
+static void remove_devm_actions_work(struct work_struct *work);
 
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
@@ -2543,6 +2544,9 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
+		return;
+
 	device_del(&cxlr->dev);
 
 	/*
@@ -2589,6 +2593,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	dev->type = &cxl_region_type;
 	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
 
+	INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
+
 	return cxlr;
 }
 
@@ -2831,20 +2837,53 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void remove_devm_actions_work(struct work_struct *work)
+{
+	struct cxl_region *cxlr = container_of(work, typeof(*cxlr), remove_work);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+
+	if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
+		put_device(&cxlr->dev);
+		return;
+	}
+
+	scoped_guard(device, port->uport_dev) {
+		if (port->uport_dev->driver)
+			devm_remove_action(port->uport_dev, unregister_region, cxlr);
+	}
+
+	put_device(&cxlr->dev);
+}
+
+static int remove_devm_actions(struct cxl_region *cxlr)
+{
+	if (!schedule_work(&cxlr->remove_work))
+		return -EBUSY;
+
+	return 0;
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
+	int rc;
 
+	/* remove_devm_actions_work() will put cxlr->dev. */
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
+	unregister_region(cxlr);
+
+	rc = remove_devm_actions(cxlr);
+	if (rc) {
+		put_device(&cxlr->dev);
+		return rc;
+	}
 
 	return len;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..75ec292a9f42 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -447,6 +447,12 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
 
+/* Indicate that this region is being unregistered to prevent a race. */
+#define CXL_REGION_F_UNREGISTER 4
+
+/* Indicate that this region called devm_remove_action. */
+#define CXL_REGION_F_DEVM_REMOVE 5
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
@@ -462,6 +468,7 @@ struct cxl_region_params {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @remove_work: trigger the remove action in a safe context to acquire locks
  */
 struct cxl_region {
 	struct device dev;
@@ -477,6 +484,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct work_struct remove_work;
 };
 
 struct cxl_nvdimm_bridge {
-- 
2.47.3

