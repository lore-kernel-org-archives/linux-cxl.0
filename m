Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AB405F7
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250601; cv=none; b=B2rM4jy2BRNSuvMH7dwA1hdZQ3I0qq7mtqkci5AqD6jmyMF2JqcWlR4ap970NxIVjFMYI3633/xTmrK556tHzy3LdzjJuCIc00dyXLfyFn5qKWTQFDBkBrWr9UEJW5cywcKHSV664z7qxHjLHctiodVIeSsjlSzOLPsKUWFSqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250601; c=relaxed/simple;
	bh=7VfoK4Br8bCL5zf4wBv0CV2raKOKR+77m9vuBqU6UhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4DVU4FkMaVK+8ooYxbpMwQ8nD7eMir238vxsrX3eQ3fXDvbKMY/CUCyd1kD1DAsTLGmCTzMhWeTHLo9iWqEg125v3QujFIZdSQJDMHv5uNT37CIIVIBkfn2LL+iimcil0wgN018kzfMX2eJxl/7ruCYG5jQpInS80CvjMWy2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8BEC4CEF7;
	Thu,  5 Feb 2026 00:16:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 2/2] cxl: Fix race of nvdimm_bus for the nvdimm_bridge object
Date: Wed,  4 Feb 2026 17:16:33 -0700
Message-ID: <20260205001633.1813643-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205001633.1813643-1-dave.jiang@intel.com>
References: <20260205001633.1813643-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running cxl_test regression tests will occasionally trip over this race
below. Move registration of nvdimm_bus to devm_cxl_add_nvdimm_bridge()
to ensure that nvdimm_bus is always present when nvdimm_bridge is created.
With the move, the nvdimm bridge driver is no longer needed and can be
removed.

Most of the code is moved as is from pmem.c to core/pmem.c. Scoped
based resource cleanup is added to devm_cxl_add_nvdimm_bridge() to ease
code maintainability.

[  192.884510] BUG: kernel NULL pointer dereference, address: 000000000000006c
[  192.886373] #PF: supervisor read access in kernel mode
[  192.887854] #PF: error_code(0x0000) - not-present page
[  192.889427] PGD 0 P4D 0
[  192.890357] Oops: Oops: 0000 [#1] SMP NOPTI
[  192.891568] CPU: 0 UID: 0 PID: 12 Comm: kworker/u32:0 Tainted: G           O        6.19.0-rc5+ #125 PREEMPT(voluntary)
[  192.894277] Tainted: [O]=OOT_MODULE
[  192.895383] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-19.fc42 08/12/2025
[  192.897721] Workqueue: cxl_port cxl_bus_rescan_queue [cxl_core]
[  192.899459] RIP: 0010:kobject_get+0xc/0x90
[  192.900720] Code: cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 85 ff 48 89 f8 74 48 48 83 ec 08 <f6> 47 3c 01 74 22 48 8d 78 38 ba 01 00 00 00 f0 0f c1 50 38 85 d2
[  192.905383] RSP: 0018:ffffc900000cfc28 EFLAGS: 00010296
[  192.906949] RAX: 0000000000000030 RBX: ffff888217275c18 RCX: 0000000000000000
[  192.908891] RDX: ffffffff83aa5b10 RSI: 0000000000000001 RDI: 0000000000000030
[  192.910980] RBP: 0000000000000001 R08: ffffffff81d6d3a0 R09: ffff8880f9ecc000
[  192.912868] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
[  192.914866] R13: 0000000000000001 R14: 0000000000000070 R15: ffff888217276c00
[  192.916721] FS:  0000000000000000(0000) GS:ffff8880f9ecc000(0000) knlGS:0000000000000000
[  192.919610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  192.921703] CR2: 000000000000006c CR3: 0000000003c32001 CR4: 0000000000770ef0
[  192.923680] PKRU: 55555554
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

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 8fdcb1704f61 ("cxl/pmem: Add initial infrastructure for pmem support")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pmem.c | 236 +++++++++++++++++++++++++++++++++++++---
 drivers/cxl/pmem.c      | 199 +--------------------------------
 2 files changed, 220 insertions(+), 215 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 8853415c106a..9b823f4e4770 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
+#include <uapi/linux/ndctl.h>
+#include <linux/unaligned.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -115,6 +117,209 @@ static void unregister_nvb(void *_cxl_nvb)
 	device_unregister(&cxl_nvb->dev);
 }
 
+static int detach_nvdimm(struct device *dev, void *data)
+{
+	struct cxl_nvdimm *cxl_nvd;
+	bool release = false;
+
+	if (!is_cxl_nvdimm(dev))
+		return 0;
+
+	scoped_guard(device, dev) {
+		if (dev->driver) {
+			cxl_nvd = to_cxl_nvdimm(dev);
+			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
+				release = true;
+		}
+	}
+	if (release)
+		device_release_driver(dev);
+	return 0;
+}
+
+static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
+				    struct nd_cmd_set_config_hdr *cmd,
+				    unsigned int buf_len)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_set_lsa *set_lsa;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+
+	/* 4-byte status follows the input data in the payload */
+	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)
+		return -EINVAL;
+
+	set_lsa =
+		kvzalloc(struct_size(set_lsa, data, cmd->in_length), GFP_KERNEL);
+	if (!set_lsa)
+		return -ENOMEM;
+
+	*set_lsa = (struct cxl_mbox_set_lsa) {
+		.offset = cpu_to_le32(cmd->in_offset),
+	};
+	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_LSA,
+		.payload_in = set_lsa,
+		.size_in = struct_size(set_lsa, data, cmd->in_length),
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+
+	/*
+	 * Set "firmware" status (4-packed bytes at the end of the input
+	 * payload.
+	 */
+	put_unaligned(0, (u32 *) &cmd->in_buf[cmd->in_length]);
+	kvfree(set_lsa);
+
+	return rc;
+}
+
+static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
+				    struct nd_cmd_get_config_size *cmd,
+				    unsigned int buf_len)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+
+	*cmd = (struct nd_cmd_get_config_size){
+		.config_size = mds->lsa_size,
+		.max_xfer =
+			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
+	};
+
+	return 0;
+}
+
+static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
+				    struct nd_cmd_get_config_data_hdr *cmd,
+				    unsigned int buf_len)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_get_lsa get_lsa;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+	if (struct_size(cmd, out_buf, cmd->in_length) > buf_len)
+		return -EINVAL;
+
+	get_lsa = (struct cxl_mbox_get_lsa) {
+		.offset = cpu_to_le32(cmd->in_offset),
+		.length = cpu_to_le32(cmd->in_length),
+	};
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_LSA,
+		.payload_in = &get_lsa,
+		.size_in = sizeof(get_lsa),
+		.size_out = cmd->in_length,
+		.payload_out = cmd->out_buf,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	cmd->status = 0;
+
+	return rc;
+}
+
+static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
+			       void *buf, unsigned int buf_len)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (!test_bit(cmd, &cmd_mask))
+		return -ENOTTY;
+
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		return cxl_pmem_get_config_size(mds, buf, buf_len);
+	case ND_CMD_GET_CONFIG_DATA:
+		return cxl_pmem_get_config_data(mds, buf, buf_len);
+	case ND_CMD_SET_CONFIG_DATA:
+		return cxl_pmem_set_config_data(mds, buf, buf_len);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
+			struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+			unsigned int buf_len, int *cmd_rc)
+{
+	/*
+	 * No firmware response to translate, let the transport error
+	 * code take precedence.
+	 */
+	*cmd_rc = 0;
+
+	if (!nvdimm)
+		return -ENOTTY;
+	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
+}
+
+static void unregister_nvdimm_bus(void *_cxl_nvb)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
+	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
+
+	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
+
+	cxl_nvb->nvdimm_bus = NULL;
+	nvdimm_bus_unregister(nvdimm_bus);
+}
+
+DEFINE_FREE(put_cxl_nvb, struct cxl_nvdimm_bridge *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+static struct cxl_nvdimm_bridge *
+__devm_cxl_add_nvdimm_bridge(struct device *host, struct cxl_port *port)
+{
+	struct device *dev;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_CXL_PMEM))
+		return ERR_PTR(-ENXIO);
+
+	struct cxl_nvdimm_bridge *cxl_nvb __free(put_cxl_nvb) =
+		cxl_nvdimm_bridge_alloc(port);
+	if (IS_ERR(cxl_nvb))
+		return cxl_nvb;
+
+	dev = &cxl_nvb->dev;
+	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
+	if (rc) {
+		retain_and_null_ptr(cxl_nvb);
+		return ERR_PTR(rc);
+	}
+
+	return no_free_ptr(cxl_nvb);
+}
+
+static void release_nvb(void *_cxl_nvb)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
+
+	devm_release_action(&cxl_nvb->dev, unregister_nvb, cxl_nvb);
+}
+
+DEFINE_FREE(release_cxl_nvb, struct cxl_nvdimm_bridge *, if (!IS_ERR_OR_NULL(_T)) release_nvb(_T))
 /**
  * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
  * @host: platform firmware root device
@@ -125,36 +330,33 @@ static void unregister_nvb(void *_cxl_nvb)
 struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct device *dev;
 	int rc;
 
-	if (!IS_ENABLED(CONFIG_CXL_PMEM))
-		return ERR_PTR(-ENXIO);
-
-	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
+	struct cxl_nvdimm_bridge *cxl_nvb __free(release_cxl_nvb) =
+		__devm_cxl_add_nvdimm_bridge(host, port);
 	if (IS_ERR(cxl_nvb))
 		return cxl_nvb;
 
 	dev = &cxl_nvb->dev;
-	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
-	if (rc)
-		goto err;
+	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
+		.provider_name = dev_name(dev->parent->parent),
+		.module = THIS_MODULE,
+		.ndctl = cxl_pmem_ctl,
+	};
 
-	rc = device_add(dev);
-	if (rc)
-		goto err;
+	cxl_nvb->nvdimm_bus =
+		nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
+	if (!cxl_nvb->nvdimm_bus)
+		return ERR_PTR(-ENOMEM);
 
-	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
+	rc = devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
 	if (rc)
 		return ERR_PTR(rc);
 
-	return cxl_nvb;
-
-err:
-	put_device(dev);
-	return ERR_PTR(rc);
+	return no_free_ptr(cxl_nvb);
 }
+
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, "CXL");
 
 static void cxl_nvdimm_release(struct device *dev)
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 45486a9d23a5..49f6ab7c4fe1 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -167,196 +167,6 @@ static struct cxl_driver cxl_nvdimm_driver = {
 	},
 };
 
-static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
-				    struct nd_cmd_get_config_size *cmd,
-				    unsigned int buf_len)
-{
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-
-	if (sizeof(*cmd) > buf_len)
-		return -EINVAL;
-
-	*cmd = (struct nd_cmd_get_config_size){
-		.config_size = mds->lsa_size,
-		.max_xfer =
-			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
-	};
-
-	return 0;
-}
-
-static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
-				    struct nd_cmd_get_config_data_hdr *cmd,
-				    unsigned int buf_len)
-{
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_get_lsa get_lsa;
-	struct cxl_mbox_cmd mbox_cmd;
-	int rc;
-
-	if (sizeof(*cmd) > buf_len)
-		return -EINVAL;
-	if (struct_size(cmd, out_buf, cmd->in_length) > buf_len)
-		return -EINVAL;
-
-	get_lsa = (struct cxl_mbox_get_lsa) {
-		.offset = cpu_to_le32(cmd->in_offset),
-		.length = cpu_to_le32(cmd->in_length),
-	};
-	mbox_cmd = (struct cxl_mbox_cmd) {
-		.opcode = CXL_MBOX_OP_GET_LSA,
-		.payload_in = &get_lsa,
-		.size_in = sizeof(get_lsa),
-		.size_out = cmd->in_length,
-		.payload_out = cmd->out_buf,
-	};
-
-	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-	cmd->status = 0;
-
-	return rc;
-}
-
-static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
-				    struct nd_cmd_set_config_hdr *cmd,
-				    unsigned int buf_len)
-{
-	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_set_lsa *set_lsa;
-	struct cxl_mbox_cmd mbox_cmd;
-	int rc;
-
-	if (sizeof(*cmd) > buf_len)
-		return -EINVAL;
-
-	/* 4-byte status follows the input data in the payload */
-	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)
-		return -EINVAL;
-
-	set_lsa =
-		kvzalloc(struct_size(set_lsa, data, cmd->in_length), GFP_KERNEL);
-	if (!set_lsa)
-		return -ENOMEM;
-
-	*set_lsa = (struct cxl_mbox_set_lsa) {
-		.offset = cpu_to_le32(cmd->in_offset),
-	};
-	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
-	mbox_cmd = (struct cxl_mbox_cmd) {
-		.opcode = CXL_MBOX_OP_SET_LSA,
-		.payload_in = set_lsa,
-		.size_in = struct_size(set_lsa, data, cmd->in_length),
-	};
-
-	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-
-	/*
-	 * Set "firmware" status (4-packed bytes at the end of the input
-	 * payload.
-	 */
-	put_unaligned(0, (u32 *) &cmd->in_buf[cmd->in_length]);
-	kvfree(set_lsa);
-
-	return rc;
-}
-
-static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
-			       void *buf, unsigned int buf_len)
-{
-	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
-	unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
-	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-
-	if (!test_bit(cmd, &cmd_mask))
-		return -ENOTTY;
-
-	switch (cmd) {
-	case ND_CMD_GET_CONFIG_SIZE:
-		return cxl_pmem_get_config_size(mds, buf, buf_len);
-	case ND_CMD_GET_CONFIG_DATA:
-		return cxl_pmem_get_config_data(mds, buf, buf_len);
-	case ND_CMD_SET_CONFIG_DATA:
-		return cxl_pmem_set_config_data(mds, buf, buf_len);
-	default:
-		return -ENOTTY;
-	}
-}
-
-static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
-			struct nvdimm *nvdimm, unsigned int cmd, void *buf,
-			unsigned int buf_len, int *cmd_rc)
-{
-	/*
-	 * No firmware response to translate, let the transport error
-	 * code take precedence.
-	 */
-	*cmd_rc = 0;
-
-	if (!nvdimm)
-		return -ENOTTY;
-	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
-}
-
-static int detach_nvdimm(struct device *dev, void *data)
-{
-	struct cxl_nvdimm *cxl_nvd;
-	bool release = false;
-
-	if (!is_cxl_nvdimm(dev))
-		return 0;
-
-	scoped_guard(device, dev) {
-		if (dev->driver) {
-			cxl_nvd = to_cxl_nvdimm(dev);
-			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
-				release = true;
-		}
-	}
-	if (release)
-		device_release_driver(dev);
-	return 0;
-}
-
-static void unregister_nvdimm_bus(void *_cxl_nvb)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
-	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
-
-	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
-
-	cxl_nvb->nvdimm_bus = NULL;
-	nvdimm_bus_unregister(nvdimm_bus);
-}
-
-static int cxl_nvdimm_bridge_probe(struct device *dev)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
-
-	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
-		.provider_name = dev_name(dev->parent->parent),
-		.module = THIS_MODULE,
-		.ndctl = cxl_pmem_ctl,
-	};
-
-	cxl_nvb->nvdimm_bus =
-		nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
-
-	if (!cxl_nvb->nvdimm_bus)
-		return -ENOMEM;
-
-	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
-}
-
-static struct cxl_driver cxl_nvdimm_bridge_driver = {
-	.name = "cxl_nvdimm_bridge",
-	.probe = cxl_nvdimm_bridge_probe,
-	.id = CXL_DEVICE_NVDIMM_BRIDGE,
-	.drv = {
-		.suppress_bind_attrs = true,
-	},
-};
-
 static void unregister_nvdimm_region(void *nd_region)
 {
 	nvdimm_region_delete(nd_region);
@@ -504,13 +314,9 @@ static __init int cxl_pmem_init(void)
 	set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
 
-	rc = cxl_driver_register(&cxl_nvdimm_bridge_driver);
-	if (rc)
-		return rc;
-
 	rc = cxl_driver_register(&cxl_nvdimm_driver);
 	if (rc)
-		goto err_nvdimm;
+		return rc;
 
 	rc = cxl_driver_register(&cxl_pmem_region_driver);
 	if (rc)
@@ -520,8 +326,6 @@ static __init int cxl_pmem_init(void)
 
 err_region:
 	cxl_driver_unregister(&cxl_nvdimm_driver);
-err_nvdimm:
-	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
 	return rc;
 }
 
@@ -529,7 +333,6 @@ static __exit void cxl_pmem_exit(void)
 {
 	cxl_driver_unregister(&cxl_pmem_region_driver);
 	cxl_driver_unregister(&cxl_nvdimm_driver);
-	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
 }
 
 MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
-- 
2.52.0

