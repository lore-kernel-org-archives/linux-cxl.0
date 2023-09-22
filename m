Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4EEE6FE22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjIVNDO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjIVNDN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 09:03:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72210C6
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 06:03:06 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922130304epoutp023892c1dc20d614957b5e8b6b268ed181~HOjUkyiMK3063930639epoutp02L
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:03:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922130304epoutp023892c1dc20d614957b5e8b6b268ed181~HOjUkyiMK3063930639epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695387784;
        bh=Q0W4WImgD5N0ejljQDCcQVqwjZekZLjePm+XCw/tJDQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iXSE2OrII1thMxmOBvouIXoeb9u4H2xkRde+iZ+3edu1jIOjMOq6dkLUvNZUKo+Re
         41eGOAdjdaowookogfjBWUaet+jGHDlXpFa7QeaWROvsNK4GoX9zJdTJfuqv0ZvgCa
         rdabAxT5D7zPr/Nq/SHW8NocGhHlnwNs+16/DILw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230922130303epcas2p48d4bc5c04fe295271024a35709fbf7ac~HOjTqImAy0828508285epcas2p4o;
        Fri, 22 Sep 2023 13:03:03 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RsXWC0zclz4x9Pp; Fri, 22 Sep
        2023 13:03:03 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.65.09693.6809D056; Fri, 22 Sep 2023 22:03:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230922130302epcas2p3911ef4d46327ed8bb2ae990f933e9ad3~HOjSkbMTK0781807818epcas2p3F;
        Fri, 22 Sep 2023 13:03:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922130302epsmtrp11f94801fa7282e2f724211c08c1171e6~HOjSjb3RI3196931969epsmtrp1v;
        Fri, 22 Sep 2023 13:03:02 +0000 (GMT)
X-AuditID: b6c32a45-abbfd700000025dd-46-650d90863694
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.9A.18916.6809D056; Fri, 22 Sep 2023 22:03:02 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922130302epsmtip17e95514d9e215c751826df58df7e5d0f~HOjSR2C8b2258922589epsmtip18;
        Fri, 22 Sep 2023 13:03:02 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [RFC PATCH 1/3] cxl: Modify background cmd handling for the others
Date:   Fri, 22 Sep 2023 22:05:48 +0900
Message-Id: <20230922130548.3476202-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmhW7bBN5Ug2/LrCzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5jsziy9iqTxeKjM5gt
        ju7hsDg/6xSLxa0Jx5gsNt5/x+Yg4LFz1l12j5Yjb1k9Fu95yeSxaVUnm0ffllWMHlNn13t8
        3iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDI
        FKgwITvj3vbbLAWXvSsm77zL2sA42a6LkZNDQsBE4sWDvexdjFwcQgI7GCUa2x4wQjifGCV6
        l99gBakCcz4fUIXpuPa9H6poJ6PEs9VXmCCcP4wSt65uZgSpYhPQkpg+swGsW0RAVqJ53QOw
        ImaBqywSk05dZAJJCAt4S2xo3gHWwCKgKvHmRjtYA6+AtcT/np2MEOvkJfYfPMsMEReUODnz
        CQuIzQwUb946mxlkqITATA6Jv8f3QzW4SDz//JcdwhaWeHV8C5QtJfGyv40doqGZUeL18yss
        EE4Lo8S62zugqowl3t18DnQGB9AKTYn1u/RBTAkBZYkjt6AW80l0HAaZDxLmlehoE4JoVJKY
        t3QeM4QtIXFp7hYo20NiX2sbI0i5kECsxNZbuhMY5Wch+WYWkm9mIaxdwMi8ilEstaA4Nz21
        2KjAEB6ryfm5mxjB6VfLdQfj5Lcf9A4xMnEwHmKU4GBWEuFN/sSVKsSbklhZlVqUH19UmpNa
        fIjRFBi+E5mlRJPzgRkgryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYO
        TqkGpn03bPf6mb02UM21n//oWW3dovasY1rdgnKfTnhd8b6zltfTdQbHB+MnG5e/UKladXvO
        /v9Hjbi33FQV3jrNMk3+yLqK4lwXkaini0Lfn3/6XGFJzA/TBV3fD3uEbT278GXYV5PFx5cu
        cxNdeCUtpmLbedlLjo8mu9rZXWzVetDupzRdzPGL7GRTVtc8RuXSAuPT/HGz/f7nz1f+eiZR
        YmtLltXONM8by08/0OCIPnuPs7pw+taZFbv4d7oJ9BXyWUkwZKut3Pq+y/Sap7n5v+j/XVlf
        OFbt6LkuXeuzhzMpnNvB2HsTj0rqMu5lvKFLa3wtI5e2Gm6TNr79x/kbz7/AL/c92ZfIVxlP
        W5o9RYmlOCPRUIu5qDgRAHCz5ZNIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG7bBN5UgxN3xSzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5jsziy9iqTxeKjM5gt
        ju7hsDg/6xSLxa0Jx5gsNt5/x+Yg4LFz1l12j5Yjb1k9Fu95yeSxaVUnm0ffllWMHlNn13t8
        3iQXwB7FZZOSmpNZllqkb5fAlXFv+22WgsveFZN33mVtYJxs18XIySEhYCJx7Xs/YxcjF4eQ
        wHZGidU7lrNAJCQklm94wQRhC0vcbznCClH0i1Fiyc+PbCAJNgEtiekzG1hBbBEBWYnmdQ+Y
        QIqYBR6ySGy7/YERJCEs4C2xoXkHmM0ioCrx5kY7WAOvgLXE/56djBAb5CX2HzzLDBEXlDg5
        8wnYFcxA8eats5knMPLNQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwLGgF
        7WBctv6v3iFGJg7GQ4wSHMxKIrzJn7hShXhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmk
        J5akZqemFqQWwWSZODilGpj0xWIWtwlo+zXPEY2dJl6e/sfkm/jpU2zbPuprBlwLnfFg/tHL
        tYwveR1chBrv7L1mfOrN4+ISizd3tvyY0un78uhS+9k3726cmXb27oP/cXt5fy+supadu84s
        8ffOa0urrx47crUi78DWfb9kd9Xecua56P1ogs2tGNdN5yekMR5sEp3M/t/j9spN+7cFq7Ge
        sk2LX/Cr9YTpSp1l1xI+8n/LMN7pXNS01HRBoP2apUeXPOrYdvGPcHnL1ru+M651yl27sVek
        xHuiTe2iZTdUVwfxLSjUl37IxXxYWj5fkGdFYTi/XHjvUqOGyvPzeKbyV+25xPBo0YoFUbMY
        ogSDV5QLNS7I0N9u6my28/ezF0osxRmJhlrMRcWJAA+6jcT0AgAA
X-CMS-MailID: 20230922130302epcas2p3911ef4d46327ed8bb2ae990f933e9ad3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130302epcas2p3911ef4d46327ed8bb2ae990f933e9ad3
References: <CGME20230922130302epcas2p3911ef4d46327ed8bb2ae990f933e9ad3@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch modifies sanitize command handling to support background-capable
commands asynchronously also. Much of the implementation follows the approach
of the sanitize command implementation, with the addition of 'bgmode' to
cxl_mbox_cmd explicitly could choose how each command is handled. However,
even if you want asynchronous processing via irq, it will fallback to poll
based if the device doesn't support it. Added a new cxl_bgcmd_state by
moving the necessary data structures from cxl_security_state.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 drivers/cxl/core/memdev.c |  8 ++---
 drivers/cxl/cxlmem.h      | 33 +++++++++++++++++---
 drivers/cxl/pci.c         | 65 +++++++++++++++++++--------------------
 3 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..8d1692231767 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -537,13 +537,13 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
-static void cxl_memdev_security_shutdown(struct device *dev)
+static void cxl_memdev_bgcmd_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (mds->security.poll)
-		cancel_delayed_work_sync(&mds->security.poll_dwork);
+	if (mds->bgcmd.poll)
+		cancel_delayed_work_sync(&mds->bgcmd.poll_dwork);
 }
 
 static void cxl_memdev_shutdown(struct device *dev)
@@ -551,7 +551,7 @@ static void cxl_memdev_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
-	cxl_memdev_security_shutdown(dev);
+	cxl_memdev_bgcmd_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..879903a8c822 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -100,6 +100,13 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
 }
 
+enum cxl_bg_cmd_mode {
+#define CXL_BG_CMD_ASYNC	BIT_MASK(0)
+	CXL_BG_CMD_SYNC		= 0x00,
+	CXL_BG_CMD_ASYNC_POLL	= 0x01,
+	CXL_BG_CMD_ASYNC_INT	= 0x03
+};
+
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
  * @opcode: (input) The command set and command submitted to hardware.
@@ -113,6 +120,8 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @bg_mode: (input) The processing mode of a background command. It will be
+ *	     valid only when the background command started successfully.
  * @poll_count: (input) Number of timeouts to attempt.
  * @poll_interval_ms: (input) Time between mailbox background command polling
  *                    interval timeouts.
@@ -131,6 +140,7 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	int bg_mode;
 	int poll_count;
 	int poll_interval_ms;
 	u16 return_code;
@@ -346,17 +356,31 @@ struct cxl_fw_state {
  * struct cxl_security_state - Device security state
  *
  * @state: state of last security operation
- * @poll: polling for sanitization is enabled, device has no mbox irq support
- * @poll_tmo_secs: polling timeout
- * @poll_dwork: polling work item
  * @sanitize_node: sanitation sysfs file to notify
  */
 struct cxl_security_state {
 	unsigned long state;
+	struct kernfs_node *sanitize_node;
+};
+
+/**
+ * struct cxl_bgcmd_state - Device background command state
+ *
+ * @poll: polling for background command completion, device has no mbox
+ *        irq support
+ * @poll_tmo_secs: polling timeout
+ * @poll_dwork: polling work item
+ * @opcode: The background command submitted to hardware
+ * @mode: The background command submitted to hardware
+ * @complete_node: background command completion file to notify
+ */
+struct cxl_bgcmd_state {
 	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
-	struct kernfs_node *sanitize_node;
+	u16 opcode;
+	int mode;
+	struct kernfs_node *complete_node;
 };
 
 /*
@@ -460,6 +484,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct cxl_bgcmd_state bgcmd;
 
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..570fca24ab12 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -116,8 +116,6 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 {
-	u64 reg;
-	u16 opcode;
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
@@ -125,13 +123,12 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	if (!cxl_mbox_background_complete(cxlds))
 		return IRQ_NONE;
 
-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
-	if (opcode == CXL_MBOX_OP_SANITIZE) {
-		if (mds->security.sanitize_node)
-			sysfs_notify_dirent(mds->security.sanitize_node);
+	if (mds->bgcmd.mode & CXL_BG_CMD_ASYNC) {
+		if (mds->bgcmd.complete_node)
+			sysfs_notify_dirent(mds->bgcmd.complete_node);
 
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
+		dev_dbg(cxlds->dev, "Mailbox background operation (0x%04x) ended\n",
+			mds->bgcmd.opcode);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
 		rcuwait_wake_up(&mds->mbox_wait);
@@ -141,28 +138,29 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 }
 
 /*
- * Sanitization operation polling mode.
+ * Background operation polling mode.
  */
-static void cxl_mbox_sanitize_work(struct work_struct *work)
+static void cxl_mbox_bg_work(struct work_struct *work)
 {
 	struct cxl_memdev_state *mds =
-		container_of(work, typeof(*mds), security.poll_dwork.work);
+		container_of(work, typeof(*mds), bgcmd.poll_dwork.work);
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 
 	mutex_lock(&mds->mbox_mutex);
 	if (cxl_mbox_background_complete(cxlds)) {
-		mds->security.poll_tmo_secs = 0;
+		mds->bgcmd.poll_tmo_secs = 0;
 		put_device(cxlds->dev);
 
-		if (mds->security.sanitize_node)
-			sysfs_notify_dirent(mds->security.sanitize_node);
+		if (mds->bgcmd.complete_node)
+			sysfs_notify_dirent(mds->bgcmd.complete_node);
 
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
+		dev_dbg(cxlds->dev, "Mailbox background operation (0x%04x) ended\n",
+			mds->bgcmd.opcode);
 	} else {
-		int timeout = mds->security.poll_tmo_secs + 10;
+		int timeout = mds->bgcmd.poll_tmo_secs + 10;
 
-		mds->security.poll_tmo_secs = min(15 * 60, timeout);
-		queue_delayed_work(system_wq, &mds->security.poll_dwork,
+		mds->bgcmd.poll_tmo_secs = min(15 * 60, timeout);
+		queue_delayed_work(system_wq, &mds->bgcmd.poll_dwork,
 				   timeout * HZ);
 	}
 	mutex_unlock(&mds->mbox_mutex);
@@ -234,7 +232,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	 * not be in sync. Ensure no new command comes in until so. Keep the
 	 * hardware semantics and only allow device health status.
 	 */
-	if (mds->security.poll_tmo_secs > 0) {
+	if (mds->bgcmd.poll_tmo_secs > 0 &&
+			mds->bgcmd.opcode == CXL_MBOX_OP_SANITIZE) {
 		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
 			return -EBUSY;
 	}
@@ -289,31 +288,29 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		u64 bg_status_reg;
 		int i, timeout;
 
-		/*
-		 * Sanitization is a special case which monopolizes the device
-		 * and cannot be timesliced. Handle asynchronously instead,
-		 * and allow userspace to poll(2) for completion.
-		 */
-		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.poll) {
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		mds->bgcmd.opcode = mbox_cmd->opcode;
+		mds->bgcmd.mode = mbox_cmd->bg_mode;
+
+		if (mbox_cmd->bg_mode & CXL_BG_CMD_ASYNC) {
+			if (mbox_cmd->bg_mode == CXL_BG_CMD_ASYNC_POLL ||
+					mds->bgcmd.poll) {
 				/* hold the device throughout */
 				get_device(cxlds->dev);
 
 				/* give first timeout a second */
 				timeout = 1;
-				mds->security.poll_tmo_secs = timeout;
+				mds->bgcmd.poll_tmo_secs = timeout;
 				queue_delayed_work(system_wq,
-						   &mds->security.poll_dwork,
+						   &mds->bgcmd.poll_dwork,
 						   timeout * HZ);
 			}
 
-			dev_dbg(dev, "Sanitization operation started\n");
 			goto success;
 		}
 
-		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
-			mbox_cmd->opcode);
-
 		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
 			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
@@ -460,8 +457,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	}
 
 mbox_poll:
-	mds->security.poll = true;
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
+	mds->bgcmd.poll = true;
+	INIT_DELAYED_WORK(&mds->bgcmd.poll_dwork, cxl_mbox_bg_work);
 
 	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
-- 
2.34.1

