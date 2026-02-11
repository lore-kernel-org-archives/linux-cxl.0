Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F02FF661
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852400; cv=none; b=BypJJsG4zPwGdadKs29fGHXbQIx9LWAphvaPCCvhcCL+Xo+FZ1hLNqQJzapIR2WNqzJ/kd3eYy7a2anB8mYiCZEP+GlnNpjxYk7mstNONcHACKrUNSe1QPWurLksKd+ER/i/Q7+F6NlnG6Ch0t39ZsGOC8xMrhd5dvVN9/fSPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852400; c=relaxed/simple;
	bh=ehNWpS5HB5OGppvaUrN43yyGdQo83PmmwhceoYLbNPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ+5ouTYnBc2r7KgWSvnmZAp6AMvOskBqbzX0Co0UckfGCFI4wKmoy8ozK/RzI2c98rLklK149VtyngmdFYw/THqvSRqAYspqQCrSeqG8DAyU9+ro8SeQwedf5BQtZXuHX5gk7C+KsPyjRbBHAK7eNBHmmxf/VgfrIh4gTEcPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE9AC4CEF7;
	Wed, 11 Feb 2026 23:26:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 2/3] cxl: Fix race of nvdimm_bus object when creating nvdimm objects
Date: Wed, 11 Feb 2026 16:26:29 -0700
Message-ID: <20260211232630.480509-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211232630.480509-1-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
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
[  192.945614]  ? _raw_spin_unlock_irq+0x18/0x40
[  192.948402]  ? __pfx___device_attach_driver+0x10/0x10
[  192.951407]  __driver_probe_device+0xc0/0x150
[  192.953997]  driver_probe_device+0x1f/0xa0
[  192.956456]  __device_attach_driver+0x85/0x130
[  192.959231]  ? _raw_spin_unlock+0x12/0x30
[  192.961615]  bus_for_each_drv+0x6c/0xb0
[  192.963935]  __device_attach+0xad/0x1c0
[  192.966213]  ? __pfx_cxl_rescan_attach+0x10/0x10 [cxl_core]
[  192.969350]  cxl_rescan_attach+0xa/0x20 [cxl_core]
[  192.972063]  bus_for_each_dev+0x63/0xa0
[  192.974367]  process_one_work+0x166/0x340
[  192.976758]  worker_thread+0x258/0x3a0
[  192.979011]  ? __pfx_worker_thread+0x10/0x10
[  192.981487]  kthread+0x108/0x220
[  192.983503]  ? __pfx_kthread+0x10/0x10
[  192.985335]  ? __pfx_kthread+0x10/0x10
[  192.986148]  ret_from_fork+0x246/0x280
[  192.987018]  ? __pfx_kthread+0x10/0x10
[  192.987891]  ret_from_fork_asm+0x1a/0x30
[  192.988768]  </TASK>
[  192.989359] Modules linked in: cxl_pmem(O) cxl_acpi(O-) kmem device_dax dax_cxl dax_pmem nd_pmem nd_btt cxl_mock_mem(O) dax_hmem cxl_pci nd_e820 nfit cxl_mem(O) cxl_port(O) cxl_mock(O) libnvdimm cxl_core(O) fwctl [last unloaded: cxl_translate(O)]
[  192.993533] CR2: 000000000000006c
[  192.994417] ---[ end trace 0000000000000000 ]---

1. Set probe_type of cxl_nvb to PROBE_FORCE_SYNCHRONOUS to ensure the
   driver is probed synchronously when add_device() is called.
2. Add a check after add_device() for cxl_nvb to ensure the driver is
   bound, which also means the nvdimm_bus object is registered.
3. Add a check in __nd_device_register() to avoid NULL pointer
   dereference when nvdimm_bus is not registered. Hold the uport_dev
   lock of the cxl rootport to sychronize between cxl_acpi_probe() and
   cxl_devm_cxl_add_nvdimm(). Also hold the cxl_nvb->dev lock to ensure
   a consistent state of if the driver is bound (or not).
4. Add a check for nvdimm_bus in cxl_nvdimm_probe() to avoid accessing
   without nvdimm_bus for unbound nvdimm object reprobes.

This fix also requies the commit that moves devm_cxl_add_nvdimm_bridge()
from core/pmem.c to pmem.c.

Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pmem.c | 13 +++++++++++++
 drivers/cxl/pmem.c      | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 50557d71a45f..f7f784047450 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -175,6 +175,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
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
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 6f010b3cce44..0b200be1fd36 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -85,6 +85,15 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 	if (rc)
 		goto err;
 
+	/* Ensure that cxl_nvb driver has been bound since it is synchronous. */
+	device_lock(dev);
+	if (!dev->driver) {
+		device_unlock(dev);
+		unregister_nvb(cxl_nvb);
+		return ERR_PTR(-ENODEV);
+	}
+	device_unlock(dev);
+
 	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
 	if (rc)
 		return ERR_PTR(rc);
@@ -213,6 +222,9 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
+	if (!cxl_nvb->nvdimm_bus)
+		return -ENODEV;
+
 	set_exclusive_cxl_commands(mds, exclusive_cmds);
 	rc = devm_add_action_or_reset(dev, clear_exclusive, mds);
 	if (rc)
@@ -437,6 +449,7 @@ static struct cxl_driver cxl_nvdimm_bridge_driver = {
 	.probe = cxl_nvdimm_bridge_probe,
 	.id = CXL_DEVICE_NVDIMM_BRIDGE,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.suppress_bind_attrs = true,
 	},
 };
-- 
2.52.0

