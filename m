Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482BFC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A160EB6
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 19:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhINTE4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:04:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:33748 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232475AbhINTEz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 14 Sep 2021 15:04:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="202277600"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="202277600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:03:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="508263390"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:03:09 -0700
Subject: [PATCH v5 14/21] cxl/mbox: Add exclusive kernel command support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, nvdimm@lists.linux.dev,
        Jonathan.Cameron@huawei.com
Date:   Tue, 14 Sep 2021 12:03:04 -0700
Message-ID: <163164579468.2830966.6980053377428474263.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL_PMEM driver expects exclusive control of the label storage area
space. Similar to the LIBNVDIMM expectation that the label storage area
is only writable from userspace when the corresponding memory device is
not active in any region, the expectation is the native CXL_PCI UAPI
path is disabled while the cxl_nvdimm for a given cxl_memdev device is
active in LIBNVDIMM.

Add the ability to toggle the availability of a given command for the
UAPI path. Use that new capability to shutdown changes to partitions and
the label storage area while the cxl_nvdimm device is actively proxying
commands for LIBNVDIMM.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- improve the kdoc for set_exclusive_cxl_commands() (Jonathan)
- drop the cleverness in cxl_nvdimm_probe() to make the patch more
  readable (Jonathan)

 drivers/cxl/core/mbox.c   |    5 +++++
 drivers/cxl/core/memdev.c |   32 ++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |    4 ++++
 drivers/cxl/pmem.c        |   29 ++++++++++++++++++++++++++---
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 422999740649..82e79da195fa 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -221,6 +221,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
  *  * %-EINVAL	- Reserved fields or invalid values were used.
  *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
  *  * %-EPERM	- Attempted to use a protected command.
+ *  * %-EBUSY	- Kernel has claimed exclusive access to this opcode
  *
  * The result of this command is a fully validated command in @out_cmd that is
  * safe to send to the hardware.
@@ -296,6 +297,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	if (!test_bit(info->id, cxlm->enabled_cmds))
 		return -ENOTTY;
 
+	/* Check that the command is not claimed for exclusive kernel use */
+	if (test_bit(info->id, cxlm->exclusive_cmds))
+		return -EBUSY;
+
 	/* Check the input buffer is the expected size */
 	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
 		return -ENOMEM;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index df2ba87238c2..bf1b04d00ff4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -134,6 +134,38 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+/**
+ * set_exclusive_cxl_commands() - atomically disable user cxl commands
+ * @cxlm: cxl_mem instance to modify
+ * @cmds: bitmap of commands to mark exclusive
+ *
+ * Grab the cxl_memdev_rwsem in write mode to flush in-flight
+ * invocations of the ioctl path and then disable future execution of
+ * commands with the command ids set in @cmds.
+ */
+void set_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds)
+{
+	down_write(&cxl_memdev_rwsem);
+	bitmap_or(cxlm->exclusive_cmds, cxlm->exclusive_cmds, cmds,
+		  CXL_MEM_COMMAND_ID_MAX);
+	up_write(&cxl_memdev_rwsem);
+}
+EXPORT_SYMBOL_GPL(set_exclusive_cxl_commands);
+
+/**
+ * clear_exclusive_cxl_commands() - atomically enable user cxl commands
+ * @cxlm: cxl_mem instance to modify
+ * @cmds: bitmap of commands to mark available for userspace
+ */
+void clear_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds)
+{
+	down_write(&cxl_memdev_rwsem);
+	bitmap_andnot(cxlm->exclusive_cmds, cxlm->exclusive_cmds, cmds,
+		      CXL_MEM_COMMAND_ID_MAX);
+	up_write(&cxl_memdev_rwsem);
+}
+EXPORT_SYMBOL_GPL(clear_exclusive_cxl_commands);
+
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8f59a89a0aab..373add570ef6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -101,6 +101,7 @@ struct cxl_mbox_cmd {
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
+ * @exclusive_cmds: Commands that are kernel-internal only
  * @pmem_range: Active Persistent memory capacity configuration
  * @ram_range: Active Volatile memory capacity configuration
  * @total_bytes: sum of all possible capacities
@@ -127,6 +128,7 @@ struct cxl_mem {
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
 	struct range pmem_range;
 	struct range ram_range;
@@ -200,4 +202,6 @@ int cxl_mem_identify(struct cxl_mem *cxlm);
 int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm);
 int cxl_mem_create_range_info(struct cxl_mem *cxlm);
 struct cxl_mem *cxl_mem_create(struct device *dev);
+void set_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds);
+void clear_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 9652c3ee41e7..5629289939af 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -16,6 +16,13 @@
  */
 static struct workqueue_struct *cxl_pmem_wq;
 
+static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+
+static void clear_exclusive(void *cxlm)
+{
+	clear_exclusive_cxl_commands(cxlm, exclusive_cmds);
+}
+
 static void unregister_nvdimm(void *nvdimm)
 {
 	nvdimm_delete(nvdimm);
@@ -39,25 +46,37 @@ static struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(void)
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_mem *cxlm = cxlmd->cxlm;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	unsigned long flags = 0;
 	struct nvdimm *nvdimm;
-	int rc = -ENXIO;
+	int rc;
 
 	cxl_nvb = cxl_find_nvdimm_bridge();
 	if (!cxl_nvb)
 		return -ENXIO;
 
 	device_lock(&cxl_nvb->dev);
-	if (!cxl_nvb->nvdimm_bus)
+	if (!cxl_nvb->nvdimm_bus) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	set_exclusive_cxl_commands(cxlm, exclusive_cmds);
+	rc = devm_add_action_or_reset(dev, clear_exclusive, cxlm);
+	if (rc)
 		goto out;
 
 	set_bit(NDD_LABELING, &flags);
 	nvdimm = nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags, 0, 0,
 			       NULL);
-	if (!nvdimm)
+	if (!nvdimm) {
+		rc = -ENOMEM;
 		goto out;
+	}
 
+	dev_set_drvdata(dev, nvdimm);
 	rc = devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
 out:
 	device_unlock(&cxl_nvb->dev);
@@ -194,6 +213,10 @@ static __init int cxl_pmem_init(void)
 {
 	int rc;
 
+	set_bit(CXL_MEM_COMMAND_ID_SET_PARTITION_INFO, exclusive_cmds);
+	set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
+	set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
+
 	cxl_pmem_wq = alloc_ordered_workqueue("cxl_pmem", 0);
 	if (!cxl_pmem_wq)
 		return -ENXIO;

