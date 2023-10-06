Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4476FA8
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKpYqfzU"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0AED
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577201; x=1728113201;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWyu66MtmZiYjHq9JGEEwh3Ia+iv4XGWn3EsEjLoyBs=;
  b=QKpYqfzUDhsyqVSk2M8AWF/ZJC3xtfobGB9z6bp8XIqshoMkeLTbc3Ly
   +Y0teEB1bRydLEyW87Gt0rFc2Clnh4IauZu2unPN4tZDgI08e9RM0v5Qu
   8Vbo3HjpubJyNgAYVWQ8OE7OAtuRBnagZ0SifIW/cbehD2z76L7GIx2OU
   6zYzJgJEhWyRY2H0uRHvlsrNxOMeORzk4r1HOaMrytS4cSYfMCLAVQxqJ
   QAywc03DyU4O3r0GyhYQatuwNpU0FNBcchn1MRw1NCVnISLVDia6PGp8y
   OQRCd77bGr4qY/NbDk4UGfgKgsSImLOrE9eb0XR/DHQyZaYl/77Praq6q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450192254"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450192254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817923232"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817923232"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:40 -0700
Subject: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup locking
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Date: Fri, 06 Oct 2023 00:26:39 -0700
Message-ID: <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sanitize operation is destructive and the expectation is that the
device is unmapped while in progress. The current implementation does a
lockless check for decoders being active, but then does nothing to
prevent decoders from racing to be committed. Introduce state tracking
to resolve this race.

This incidentally cleans up unpriveleged userspace from triggering mmio
read cycles by spinning on reading the 'securiry/state' attribute. Which
at a minimum is a waste since the kernel state machine can cache the
completion result.

Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
original implementation, but an export was never required.

Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   |    1 +
 drivers/cxl/core/hdm.c    |   19 ++++++++++++++++
 drivers/cxl/core/mbox.c   |   55 +++++++++++++++++++++++++++++++++------------
 drivers/cxl/core/memdev.c |   43 +++++++++++++----------------------
 drivers/cxl/core/port.c   |    6 +++++
 drivers/cxl/core/region.c |    6 -----
 drivers/cxl/cxlmem.h      |    4 ++-
 drivers/cxl/pci.c         |    5 ++++
 8 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 45e7e044cf4a..8e5f3d84311e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -75,6 +75,7 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    enum cxl_rcrb which);
 
 extern struct rw_semaphore cxl_dpa_rwsem;
+extern struct rw_semaphore cxl_region_rwsem;
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..506c9e14cdf9 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -650,6 +650,25 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return -EBUSY;
 	}
 
+	/*
+	 * For endpoint decoders hosted on CXL memory devices that
+	 * support the sanitize operation, make sure sanitize is not in-flight.
+	 */
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_memdev_state *mds =
+			to_cxl_memdev_state(cxlmd->cxlds);
+
+		if (mds && mds->security.sanitize_active) {
+			dev_dbg(&cxlmd->dev,
+				"attempted to commit %s during sanitize\n",
+				dev_name(&cxld->dev));
+			return -EBUSY;
+		}
+	}
+
 	down_read(&cxl_dpa_rwsem);
 	/* common decoder settings */
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..67aec57cc12f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1125,20 +1125,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
-/**
- * cxl_mem_sanitize() - Send a sanitization command to the device.
- * @mds: The device data for the operation
- * @cmd: The specific sanitization command opcode
- *
- * Return: 0 if the command was executed successfully, regardless of
- * whether or not the actual security operation is done in the background,
- * such as for the Sanitize case.
- * Error return values can be the result of the mailbox command, -EINVAL
- * when security requirements are not met or invalid contexts.
- *
- * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.
- */
-int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
+static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 {
 	int rc;
 	u32 sec_out = 0;
@@ -1183,7 +1170,45 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
+
+
+/**
+ * cxl_mem_sanitize() - Send a sanitization command to the device.
+ * @mds: The device for the operation
+ * @cmd: The specific sanitization command opcode
+ *
+ * Return: 0 if the command was executed successfully, regardless of
+ * whether or not the actual security operation is done in the background,
+ * such as for the Sanitize case.
+ * Error return values can be the result of the mailbox command, -EINVAL
+ * when security requirements are not met or invalid contexts, or -EBUSY
+ * if the sanitize operation is already in flight.
+ *
+ * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.
+ */
+int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_port  *endpoint;
+	int rc;
+
+	/* synchronize with cxl_mem_probe() and decoder write operations */
+	device_lock(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	down_read(&cxl_region_rwsem);
+	/*
+	 * Require an endpoint to be safe otherwise the driver can not
+	 * be sure that the device is unmapped.
+	 */
+	if (endpoint && endpoint->commit_end == -1)
+		rc = __cxl_mem_sanitize(mds, cmd);
+	else
+		rc = -EBUSY;
+	up_read(&cxl_region_rwsem);
+	device_unlock(&cxlmd->dev);
+
+	return rc;
+}
 
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 4c2e24a1a89c..a02061028b71 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -125,13 +125,16 @@ static ssize_t security_state_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
-	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	unsigned long state = mds->security.state;
+	int rc = 0;
 
-	if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
-		return sysfs_emit(buf, "sanitize\n");
+	/* sync with latest submission state */
+	mutex_lock(&mds->mbox_mutex);
+	if (mds->security.sanitize_active)
+		rc = sysfs_emit(buf, "sanitize\n");
+	mutex_unlock(&mds->mbox_mutex);
+	if (rc)
+		return rc;
 
 	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
 		return sysfs_emit(buf, "disabled\n");
@@ -152,24 +155,17 @@ static ssize_t security_sanitize_store(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct cxl_port *port = cxlmd->endpoint;
 	bool sanitize;
 	ssize_t rc;
 
 	if (kstrtobool(buf, &sanitize) || !sanitize)
 		return -EINVAL;
 
-	if (!port || !is_cxl_endpoint(port))
-		return -EINVAL;
-
-	/* ensure no regions are mapped to this memdev */
-	if (port->commit_end != -1)
-		return -EBUSY;
-
-	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SANITIZE);
+	rc = cxl_mem_sanitize(cxlmd, CXL_MBOX_OP_SANITIZE);
+	if (rc)
+		return rc;
 
-	return rc ? rc : len;
+	return len;
 }
 static struct device_attribute dev_attr_security_sanitize =
 	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
@@ -179,24 +175,17 @@ static ssize_t security_erase_store(struct device *dev,
 				    const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct cxl_port *port = cxlmd->endpoint;
 	ssize_t rc;
 	bool erase;
 
 	if (kstrtobool(buf, &erase) || !erase)
 		return -EINVAL;
 
-	if (!port || !is_cxl_endpoint(port))
-		return -EINVAL;
-
-	/* ensure no regions are mapped to this memdev */
-	if (port->commit_end != -1)
-		return -EBUSY;
-
-	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SECURE_ERASE);
+	rc = cxl_mem_sanitize(cxlmd, CXL_MBOX_OP_SECURE_ERASE);
+	if (rc)
+		return rc;
 
-	return rc ? rc : len;
+	return len;
 }
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7ca01a834e18..5ba606c6e03f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -28,6 +28,12 @@
  * instantiated by the core.
  */
 
+/*
+ * All changes to the interleave configuration occur with this lock held
+ * for write.
+ */
+DECLARE_RWSEM(cxl_region_rwsem);
+
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d63b8798c29..d74bf1b664b6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -28,12 +28,6 @@
  * 3. Decoder targets
  */
 
-/*
- * All changes to the interleave configuration occur with this lock held
- * for write.
- */
-static DECLARE_RWSEM(cxl_region_rwsem);
-
 static struct cxl_region *to_cxl_region(struct device *dev);
 
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fbdee1d63717..6933bc20e76b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -364,6 +364,7 @@ struct cxl_fw_state {
  * @state: state of last security operation
  * @enabled_cmds: All security commands enabled in the CEL
  * @poll_tmo_secs: polling timeout
+ * @sanitize_active: sanitize completion pending
  * @poll_dwork: polling work item
  * @sanitize_node: sanitation sysfs file to notify
  */
@@ -371,6 +372,7 @@ struct cxl_security_state {
 	unsigned long state;
 	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
 	int poll_tmo_secs;
+	bool sanitize_active;
 	struct delayed_work poll_dwork;
 	struct kernfs_node *sanitize_node;
 };
@@ -884,7 +886,7 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
-int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
+int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 
 struct cxl_hdm {
 	struct cxl_component_regs regs;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9955871e9ec1..06fafe59c054 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -154,6 +154,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		mds->security.poll_tmo_secs = 0;
 		if (mds->security.sanitize_node)
 			sysfs_notify_dirent(mds->security.sanitize_node);
+		mds->security.sanitize_active = false;
 
 		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
 	} else {
@@ -292,9 +293,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 * and allow userspace to poll(2) for completion.
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
+			if (mds->security.sanitize_active)
+				return -EBUSY;
+
 			/* give first timeout a second */
 			timeout = 1;
 			mds->security.poll_tmo_secs = timeout;
+			mds->security.sanitize_active = true;
 			schedule_delayed_work(&mds->security.poll_dwork,
 					      timeout * HZ);
 			dev_dbg(dev, "Sanitization operation started\n");

