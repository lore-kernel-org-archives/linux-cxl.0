Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717426A08A
	for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260390; cv=none; b=ObBnK1E08L3DsFb5yjRIvqiaz3jQidbJVgZJ6F0tz8LkZ/x3x3tqZYWFj0xkkFsZ8261bzMEaHLPFh0rOsVWSUpmrqlGSW/clYqR9ifrOikmSOcndzJu9WOeH8hUvi5Q/B017Ufo0P3b/N70LJRURzzcDyX/9WO8NBKy44r54Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260390; c=relaxed/simple;
	bh=o9u/OwTZbv2Jmv7Yqa1UMp6K0xAH19Dqu+osE5o1Pkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFINLJLv1ysM8y/qSMzggCnHGUTq73VNkKQpLlXSfFrL+hHjg8gfazB9UXbt+q/U3mHuC+dj55G2AUACw22yBQVAuY8gdoBz+a19lE0bCxQ/00y32U6MW12hFPZBPXO5awAckhufFWvMuHf5O8SbuG3Tx+mE6DjieO9P3RPMX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-650775f427eso10185966d50.2
        for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 20:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260388; x=1777865188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5hxakvROgtrD8FVisml9LRgxf6CeSENy2gXMVuYHr4=;
        b=MYrlRv4TnDiCtLymbt5kkNYjwVt8AXwdbPlQX4n+z4Yyyq0GomY/HxBSn7OlAH2pVk
         zvXBKdZU8QoSrGyaW13DJtq1wTBKRdumljMrOP1I25Lk/WkJCTAYeh+ePIybEaY81MzE
         iMKTLCrD8gN1NuDQrfVwZ+mFPj9jbQ3HInIp6hp2sxJh/EfNv+F8xLrRaXCMCOk7peuY
         oiZ7pt1OIetqvsQk/HzSpYQ5Uscvik1w3/LYk0xisRTq80zlCk2vvAAO0rnksYIMkzjO
         nUSHGQ40lpalPWliCcXD/lVnHXWMaHUegZe/OAq+XRpGurJUQTq5CY1/fLT0QSvlSiPl
         w1yg==
X-Forwarded-Encrypted: i=1; AFNElJ+8U5kxzmOjE7Dyny1eQKrithadsjU+fwGTZvXzDN9NuUNNM+C+GNzrRZH1kf1x805iQ4FJstmLkls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0KwsZTtKfqZuK6gmL4d6jCh7bNtayuJNbln0dKHvriZAm0zI
	VFxPH60mTR3uoLZ4Kr0UNswjV1To+h3UY6EaQ7cCwTzvz8YLa74K4j49
X-Gm-Gg: AeBDiet881klMzaa2z2A3leygLzMj0mJVV2GFTSf/TPBN/x9/QJl1NbsdN7+kHitYSS
	wCWq0BS/8L+0r7OgblgCj8k24R2xT/XdL8HZm80jl8hyRsedo5VNsrK+hlVc/RkLl4Np0JI++Pc
	K3ctH7184xl1udXknHfYvW7atx9DKDEePga9X2r7R38/YktTihv8pB+zVu8uhwfiF65w+ghi/D2
	jFFotUS343u0eYbuKzIu1aLySMNT3BDVZkftAOculJY0dQAOFlznc25PV5c3LXcCQd1u2Tf6L8Z
	dlRqfN2cpi/KyOqnZ9RgQgMMcJnamKcQ/rf4chw794bl1r/Myhcyyyskss/wCWZbGfsfv3f3Lqj
	IZt5p6+P/84ork7dH5mI+yrfFkJ0OJbcfJQqNuHSZ990VBZngeW5lmmDwtW/7+hYmuUYKQtlAsb
	3NGZhIferKdWdl/XbXfWHK
X-Received: by 2002:a53:ea84:0:b0:651:8d82:acc5 with SMTP id 956f58d0204a3-653108c0224mr29243595d50.26.1777260387798;
        Sun, 26 Apr 2026 20:26:27 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-65314b26b56sm14087239d50.4.2026.04.26.20.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 20:26:26 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/region: serialize devm action removal via scheduled work
Date: Sun, 26 Apr 2026 23:20:09 -0400
Message-ID: <20260427032010.916681-4-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427032010.916681-2-iam@sung-woo.kim>
References: <20260427032010.916681-2-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_remove_action() must be called (1) only once and (2) only if the
device is still bound to a driver. However, several race conditions
allow multiple calls to devm_remove_action().

For example, delete_region_store() and devres_release_all() can race [1]:

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

To prevent this, this patch introduces a new function,
remove_devm_actions(), that safely performs devm_release_action().

remove_devm_actions() guarantees that devm_release_action() is called
only once by guarding with a flag. Also, it checks if the device is
still bound to a driver before calling devm_remove_action().

In order to check the binding, a device lock must be held. To do this,
Dan suggested [2] using a workqueue, since a new work has no prior lock
and is clean to acquire a device lock.

[1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@offworld/
[2] https://lore.kernel.org/linux-cxl/69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch/

Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/cxl/core/port.c   |  6 ++++++
 drivers/cxl/core/region.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  9 +++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..2f142cea7f26 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2305,6 +2305,12 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
 
+bool schedule_cxl_region_remove_devm_actions(struct cxl_region *cxlr)
+{
+	return queue_work(cxl_bus_wq, &cxlr->remove_work);
+}
+EXPORT_SYMBOL_NS_GPL(schedule_cxl_region_remove_devm_actions, "CXL");
+
 static void add_latency(struct access_coordinate *c, long latency)
 {
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..b086ae88b5bb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -39,6 +39,7 @@
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
 static struct cxl_region *to_cxl_region(struct device *dev);
+static void remove_devm_actions_work(struct work_struct *work);
 
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
@@ -2589,6 +2590,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	dev->type = &cxl_region_type;
 	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
 
+	INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
+
 	return cxlr;
 }
 
@@ -2831,6 +2834,30 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static bool remove_devm_actions(struct cxl_region *cxlr)
+{
+	return schedule_cxl_region_remove_devm_actions(cxlr);
+}
+
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
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..31ca4e6676ed 100644
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
@@ -733,6 +741,7 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
+bool schedule_cxl_region_remove_devm_actions(struct cxl_region *cxlr);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
-- 
2.47.3

