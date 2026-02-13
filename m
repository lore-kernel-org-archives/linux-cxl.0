Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906A2673AA
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022443; cv=none; b=JwPbnNbNdxBLSsDwm5Xq74AEDs3dopu5EV6X1MhO7oK0mysDTE0yWGdRK+esZidqTZu9dx50gf7nQIunT+gAaXQlwyYLxuGtoYpZk9GMeMQdCJ10DQhkCpYYe9kq5ZdAlPSLCe6JiaGpBpitWEJgscGVXZjxdXpZ9+cN6TbrcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022443; c=relaxed/simple;
	bh=WaPPF46VvJyMHjg9imMIP8hGIVdPsUrlrG2OcGuOaZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY4tEKrtMEp0luwSU0OGDgH9EPnRwLmFvN0/3HsjaLJ4EYYw1WJXQJFSdy9+sT4FT8TVKxEZzbJnITpxVcKGer0QV47T1vjF2IbBqXLNiPqif77BC9/1sg4tl5Mz05WoUX43du/y6esjNQ9TaGxxTIPpmUjm+hMnrx+ClSL1/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832CEC116C6;
	Fri, 13 Feb 2026 22:40:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 2/2] cxl: Fix race of nvdimm_bus object when creating nvdimm objects
Date: Fri, 13 Feb 2026 15:40:38 -0700
Message-ID: <20260213224038.549798-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213224038.549798-1-dave.jiang@intel.com>
References: <20260213224038.549798-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found issue during running of cxl-translate.sh unit test. Adding a 3s
sleep right before the test seems to make the issue reproduce fairly
consistently. The cxl_translate module has dependency on cxl_acpi and
causes orphaned nvdimm objects to reprobe after cxl_acpi is removed.
The nvdimm_bus object is registered by the cxl_nvb object when
cxl_acpi_probe() is called. With the nvdimm_bus object missing,
__nd_device_register() will trigger NULL pointer dereference when
accessing the dev->parent that points to &nvdimm_bus->dev.

[  192.884510] BUG: kernel NULL pointer dereference, address: 000000000000006c
[  192.895383] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-19.fc42 08/12/2025
[  192.897721] Workqueue: cxl_port cxl_bus_rescan_queue [cxl_core]
[  192.899459] RIP: 0010:kobject_get+0xc/0x90
[  192.924871] Call Trace:
[  192.925959]  <TASK>
[  192.926976]  ? pm_runtime_init+0xb9/0xe0
[  192.929712]  __nd_device_register.part.0+0x4d/0xc0 [libnvdimm]
[  192.933314]  __nvdimm_create+0x206/0x290 [libnvdimm]
[  192.936662]  cxl_nvdimm_probe+0x119/0x1d0 [cxl_pmem]
[  192.940245]  cxl_bus_probe+0x1a/0x60 [cxl_core]
[  192.943349]  really_probe+0xde/0x380

This patch also relies on the previous change where
devm_cxl_add_nvdimm_bridge() is called from drivers/cxl/pmem.c instead
of drivers/cxl/core.c to ensure the dependency of cxl_acpi on cxl_pmem.

1. Set probe_type of cxl_nvb to PROBE_FORCE_SYNCHRONOUS to ensure the
   driver is probed synchronously when add_device() is called.
2. Add a check in __devm_cxl_add_nvdimm_bridge() to ensure that the
   cxl_nvb driver is attached during cxl_acpi_probe().
3. Take the cxl_root uport_dev lock and the cxl_nvb->dev lock in
   devm_cxl_add_nvdimm() before checking nvdimm_bus is valid.
4. Set cxl_nvdimm flag to CXL_NVD_F_INVALIDATED so cxl_nvdimm_probe()
   will exit with -EBUSY.

The removal of cxl_nvdimm devices should prevent any orphaned devices
from probing once the nvdimm_bus is gone.

Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- squash patch 2 and 3 (Dan)
- Remove nvdimm_bus check from cxl_nvdimm driver (Dan)
- Set an invalidated flag for cxl_nvdimm when nvdimm_bus is released. (Dan)
- Create a helper to see if driver is attached. (Dan)
---
 drivers/cxl/core/pmem.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  5 +++++
 drivers/cxl/pmem.c      |  8 +++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 7c78344acc6d..375948ec5fed 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -115,6 +115,15 @@ static void unregister_nvb(void *_cxl_nvb)
 	device_unregister(&cxl_nvb->dev);
 }
 
+static bool cxl_nvdimm_bridge_failed_attach(struct cxl_nvdimm_bridge *cxl_nvb)
+{
+	struct device *dev = &cxl_nvb->dev;
+
+	guard(device)(dev);
+	/* If the device has no driver, then it failed to attach. */
+	return dev->driver == NULL;
+}
+
 struct cxl_nvdimm_bridge *__devm_cxl_add_nvdimm_bridge(struct device *host,
 						       struct cxl_port *port)
 {
@@ -138,6 +147,11 @@ struct cxl_nvdimm_bridge *__devm_cxl_add_nvdimm_bridge(struct device *host,
 	if (rc)
 		goto err;
 
+	if (cxl_nvdimm_bridge_failed_attach(cxl_nvb)) {
+		unregister_nvb(cxl_nvb);
+		return ERR_PTR(-ENODEV);
+	}
+
 	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
 	if (rc)
 		return ERR_PTR(rc);
@@ -248,6 +262,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
 	if (!cxl_nvb)
 		return -ENODEV;
 
+	/*
+	 * Take the uport_dev lock to guard against race of nvdimm_bus object.
+	 * cxl_acpi_probe() registers the nvdimm_bus and is done under the
+	 * root port uport_dev lock.
+	 *
+	 * Take the cxl_nvb device lock to ensure that cxl_nvb driver is in a
+	 * consistent state. And the driver registers nvdimm_bus.
+	 */
+	guard(device)(cxl_nvb->port->uport_dev);
+	guard(device)(&cxl_nvb->dev);
+	if (!cxl_nvb->nvdimm_bus)
+		return -ENODEV;
+
 	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
 	if (IS_ERR(cxl_nvd)) {
 		rc = PTR_ERR(cxl_nvd);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f5850800f400..9b947286eb9b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -574,11 +574,16 @@ struct cxl_nvdimm_bridge {
 
 #define CXL_DEV_ID_LEN 19
 
+enum {
+	CXL_NVD_F_INVALIDATED = 0,
+};
+
 struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
 	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
 	u64 dirty_shutdowns;
+	unsigned long flags;
 };
 
 struct cxl_pmem_region_mapping {
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 714beaf1704b..61f7a0b352aa 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -143,6 +143,9 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
+	if (test_bit(CXL_NVD_F_INVALIDATED, &cxl_nvd->flags))
+		return -EBUSY;
+
 	set_exclusive_cxl_commands(mds, exclusive_cmds);
 	rc = devm_add_action_or_reset(dev, clear_exclusive, mds);
 	if (rc)
@@ -323,8 +326,10 @@ static int detach_nvdimm(struct device *dev, void *data)
 	scoped_guard(device, dev) {
 		if (dev->driver) {
 			cxl_nvd = to_cxl_nvdimm(dev);
-			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
+			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data) {
 				release = true;
+				set_bit(CXL_NVD_F_INVALIDATED, &cxl_nvd->flags);
+			}
 		}
 	}
 	if (release)
@@ -367,6 +372,7 @@ static struct cxl_driver cxl_nvdimm_bridge_driver = {
 	.probe = cxl_nvdimm_bridge_probe,
 	.id = CXL_DEVICE_NVDIMM_BRIDGE,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.suppress_bind_attrs = true,
 	},
 };
-- 
2.53.0

