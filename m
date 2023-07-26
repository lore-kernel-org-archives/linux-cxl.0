Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93990C0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGZRGl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRGk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 13:06:40 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD8E4F
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 10:06:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0C0A1501ED2;
        Wed, 26 Jul 2023 17:06:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EF1D2501D3C;
        Wed, 26 Jul 2023 17:06:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690391197; a=rsa-sha256;
        cv=none;
        b=6L5dHiuGIDHGQ3hJi7gtR3ekdnV1EQXJF+zBkZ/DL4riKfTGM+x5bbi+wP7Nhi2m+mDDq5
        1HnM/oewTFIk+7Z++clKFNjfcRDlJ+a7FPuSPZJaGJCfP4GMEfE6Sy1FloOWw5QpZ/fXnJ
        qnuvFyoGdtsHGPAFRgjBcDn2bkDqsiTXWGkDMkkhEk5ViOh7KUXeiPo+23VQg5elng64l/
        VjwHWk2FQerooWq/E/+MsiOO5ZJ94Nw1Nir+H2zReb6ezhqtjeSUGsfUpAqYPaAwtdYcug
        8rZzhktBPII2IBi0v9y70CvqgPE4EzGVI15F/x+hHVTApOnz4b1PsgN54FC23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690391197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xHyV7tW9JtA/KcTxIuEa82VfS5DG3UVVef1NeYp4Y0o=;
        b=UeN7No0BpaPjQVcj1p88xDDzzcyZEQuOoKYW8qeLkcSqxVQU07yZR8r4czq15XhI7mnfRM
        yhIVYgY8fFm1rFzQD+6MTVL2pWWpEFO2q8YneEqef3FOwySE5snqfO4jRzB0UynnwXVd38
        5yNrL0aIUNSpUbynHWjvmuuebrwTvAqV+DBXZogozVrzte0kGBQ19tx7JML9FSjpUdco/G
        j36GWuEO1GWFQ4l1n4gm3HaDnKg6weclOwirRHK+RKfcMdM/XehnRXtVbNpqsKqIxXTkiC
        F5izwnjnnrjzfQIn+PFfvvbhwC67/2kHU0mNPUUov/JrcWy/dzFHLFMQ6DQdtA==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-9ndqs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reign-Wipe: 67765e801ccca693_1690391197782_3415261363
X-MC-Loop-Signature: 1690391197782:3115655411
X-MC-Ingress-Time: 1690391197782
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.193.203 (trex/6.9.1);
        Wed, 26 Jul 2023 17:06:37 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RB0g00tg1z3d;
        Wed, 26 Jul 2023 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690391196;
        bh=xHyV7tW9JtA/KcTxIuEa82VfS5DG3UVVef1NeYp4Y0o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Koux/Ttdsb5F/rQDCVp2XBcW36wlP8Ekq7oUztT6xwvtemdAq/6b9NKfbKtDSgDmQ
         WJV1ARbEL8Y9XLBGHIIfkxynYT3tYtAhsRMePQs8mm0HDKVsBoAB7DP+3XH0qiC89E
         cFyvfU/sDO8e3ATW4oHwqMfLoZkPUXwJOHDWcgDZ2FjZGSCYSiSKtdZV+VLfYGgarb
         Ebld0HoFVBRObG1hEQq7gWSRfCEYAvEAbZX+IX0EoTl0NKrkbVEvb7JnfUod+3J7zs
         0on9/AKj4Vcfa1YtBWmMHhgViDxScpJpD+LanprfJUaUn8nZpnrENvgYD9gIU7YzPJ
         rX6TjXd3R5z3Q==
Date:   Wed, 26 Jul 2023 09:29:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com, Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, fan.ni@samsung.com,
        a.manzanares@samsung.com
Subject: Re: [RFC PATCH v4 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <u4a5twhwly5pmwvblf5sh3ljsz3lrgaejae3aq3pd5cogwwzo4@5yybsts4tswr>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
 <20230719091931.27799-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719091931.27799-5-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Jul 2023, Jonathan Cameron wrote:

>CXL 3.0 defines a mailbox PCI function independent of any other CXL
>components. The intent is that instances of this mailbox will be found
>as additional PCI functions of upstream CXL switch ports.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>---
> drivers/cxl/Kconfig           |  14 +++
> drivers/cxl/Makefile          |   2 +
> drivers/cxl/core/Makefile     |   1 +
> drivers/cxl/core/core.h       |   1 +
> drivers/cxl/core/mbox.c       |   6 ++
> drivers/cxl/core/port.c       |   4 +
> drivers/cxl/core/switch-cci.c | 144 +++++++++++++++++++++++++++
> drivers/cxl/cxlmem.h          |  15 +++
> drivers/cxl/switch-cci.c      | 181 ++++++++++++++++++++++++++++++++++
> include/uapi/linux/cxl_mem.h  |   4 +
> 10 files changed, 372 insertions(+)
>
>diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>index fcbf8295fde3..9a304ab60692 100644
>--- a/drivers/cxl/Kconfig
>+++ b/drivers/cxl/Kconfig
>@@ -152,5 +152,19 @@ config CXL_PMU
>	  Say 'y/m' to enable a driver that will attach to performance
>	  monitoring units and provide standard perf based interfaces.
>
>+	  If unsure say 'm'.
>+
>+config CXL_SWITCH
>+	tristate "CXL switch mailbox access"
>+	help
>+	  The CXL r3.0 specification defines a "CXL switch CCI" sub-class in the
>+	  PCI "Serial" base class of devices. Device's identified by
>+	  this class code provide a mailbox interface to allow control of CXL
>+	  switch configuration over inband PCI.
>+
>+	  Say 'y/m' to enable a driver that will attach to CXL Switch CCI
>+	  devices enumerated by the CXL switch CCI class code for configuration
>+	  and management primarily via the mailbox interface.
>+
>	  If unsure say 'm'.
> endif
>diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
>index db321f48ba52..1e5f5b8b4d73 100644
>--- a/drivers/cxl/Makefile
>+++ b/drivers/cxl/Makefile
>@@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> obj-$(CONFIG_CXL_PORT) += cxl_port.o
>+obj-$(CONFIG_CXL_SWITCH) += cxl_switch_cci.o
>
> cxl_mem-y := mem.o
> cxl_pci-y := pci.o
> cxl_acpi-y := acpi.o
> cxl_pmem-y := pmem.o security.o
> cxl_port-y := port.o
>+cxl_switch_cci-y := switch-cci.o
>diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>index 1f66b5d4d935..d8a0ffa0f8cc 100644
>--- a/drivers/cxl/core/Makefile
>+++ b/drivers/cxl/core/Makefile
>@@ -13,5 +13,6 @@ cxl_core-y += mbox.o
> cxl_core-y += pci.o
> cxl_core-y += hdm.o
> cxl_core-y += pmu.o
>+cxl_core-y += switch-cci.o
> cxl_core-$(CONFIG_TRACING) += trace.o
> cxl_core-$(CONFIG_CXL_REGION) += region.o
>diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>index 5491d3a3c095..23d21d290db5 100644
>--- a/drivers/cxl/core/core.h
>+++ b/drivers/cxl/core/core.h
>@@ -80,6 +80,7 @@ extern struct rw_semaphore cxl_dpa_rwsem;
> int cxl_memdev_init(void);
> void cxl_memdev_exit(void);
> void cxl_mbox_init(void);
>+int cxl_switch_cci_init(void);
>
> enum cxl_poison_trace_type {
>	CXL_POISON_TRACE_LIST,
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 5ee6ecfb572d..378f345fdee6 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -9,6 +9,7 @@
> #include <cxlmbox.h>
> #include <cxlpci.h>
> #include <cxlmem.h>
>+#include <cxlpci.h>
> #include <cxl.h>
>
> #include "core.h"
>@@ -56,6 +57,8 @@ static bool cxl_raw_allow_all;
>  * 0, and the user passed in 1, it is an error.
>  */
> static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>+	CXL_CMD(INFO_STAT_IDENTIFY, 0, 0x12, 0),
>+	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),
>	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
> #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
>	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
>@@ -73,6 +76,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>+	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),
>+	CXL_CMD(TUNNEL_MANAGEMENT_COMMAND, CXL_VARIABLE_PAYLOAD,
>+		CXL_VARIABLE_PAYLOAD, 0),
> };
>
> /*
>diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>index 724be8448eb4..ce3fb0d406d7 100644
>--- a/drivers/cxl/core/port.c
>+++ b/drivers/cxl/core/port.c
>@@ -2020,6 +2020,10 @@ static __init int cxl_core_init(void)
>	if (rc)
>		return rc;
>
>+	rc = cxl_switch_cci_init();
>+	if (rc)
>+		return rc;
>+
>	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
>	if (!cxl_bus_wq) {
>		rc = -ENOMEM;
>diff --git a/drivers/cxl/core/switch-cci.c b/drivers/cxl/core/switch-cci.c
>new file mode 100644
>index 000000000000..874622d8e952
>--- /dev/null
>+++ b/drivers/cxl/core/switch-cci.c
>@@ -0,0 +1,144 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+#include "cxlmem.h" /* For now to get the cxl_device_state */
>+#include "cxlpci.h"
>+#include "core.h"
>+
>+static int cxl_sw_major;
>+static DEFINE_IDA(cxl_swdev_ida);
>+static DECLARE_RWSEM(cxl_swdev_rwsem);
>+
>+static inline struct cxl_swdev *to_cxl_swdev(struct device *dev)
>+{
>+	return container_of(dev, struct cxl_swdev, dev);
>+}
>+
>+static char *cxl_swdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
>+			kgid_t *gid)
>+{
>+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
>+}
>+
>+static long __cxl_swdev_ioctl(struct cxl_swdev *cxlswd, unsigned int cmd,
>+			       unsigned long arg)
>+{
>+	switch (cmd) {
>+	case CXL_MEM_SEND_COMMAND:
>+		return cxl_send_cmd(&cxlswd->mbox, (void __user *)arg);
>+	default:
>+		return -ENOTTY;
>+	}
>+}
>+
>+static long cxl_swdev_ioctl(struct file *file, unsigned int cmd,
>+			    unsigned long arg)
>+{
>+	struct cxl_swdev *cxlswd = file->private_data;
>+	int rc = -ENXIO;
>+
>+	down_read(&cxl_swdev_rwsem);
>+	rc = __cxl_swdev_ioctl(cxlswd, cmd, arg);
>+	up_read(&cxl_swdev_rwsem);
>+
>+	return rc;
>+}
>+
>+static int cxl_swdev_open(struct inode *inode, struct file *file)
>+{
>+	struct cxl_memdev *cxlswd =
>+		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
>+
>+	get_device(&cxlswd->dev);
>+	file->private_data = cxlswd;
>+
>+	return 0;
>+}
>+
>+static int cxl_swdev_release_file(struct inode *inode, struct file *file)
>+{
>+	struct cxl_swdev *cxlswd =
>+		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
>+
>+	put_device(&cxlswd->dev);
>+
>+	return 0;
>+}
>+
>+static const struct file_operations cxl_swdev_fops = {
>+	.owner = THIS_MODULE,
>+	.unlocked_ioctl = cxl_swdev_ioctl,
>+	.open = cxl_swdev_open,
>+	.release = cxl_swdev_release_file,
>+	.compat_ioctl = compat_ptr_ioctl,
>+	.llseek = noop_llseek,
>+};
>+
>+void cxl_swdev_shutdown(struct cxl_swdev *cxlswd)
>+{
>+	down_write(&cxl_swdev_rwsem);
>+	up_write(&cxl_swdev_rwsem);
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_swdev_shutdown, CXL);
>+
>+static void cxl_swdev_release(struct device *dev)
>+{
>+	struct cxl_swdev *cxlswd = to_cxl_swdev(dev);
>+
>+	ida_free(&cxl_swdev_ida, cxlswd->id);
>+	kfree(cxlswd);
>+}
>+
>+static const struct device_type cxl_swdev_type = {
>+	.name = "cxl_swdev",
>+	.release = cxl_swdev_release,
>+	.devnode = cxl_swdev_devnode,
>+};
>+
>+struct cxl_swdev *cxl_swdev_alloc(struct device *parent)
>+{
>+	struct cxl_swdev *cxlswd;
>+	struct device *dev;
>+	struct cdev *cdev;
>+	int rc;
>+
>+	cxlswd = kzalloc(sizeof(*cxlswd), GFP_KERNEL);
>+	if (!cxlswd)
>+		return ERR_PTR(-ENOMEM);
>+
>+	rc = ida_alloc_range(&cxl_swdev_ida, 0, 10, GFP_KERNEL);
>+	if (rc < 0) {
>+		kfree(cxlswd);
>+		return ERR_PTR(rc);
>+	}
>+
>+	cxlswd->id = rc;
>+	dev = &cxlswd->dev;
>+	device_initialize(dev);
>+	dev->bus = &cxl_bus_type;
>+	dev->parent = parent;
>+	dev->devt = MKDEV(cxl_sw_major, cxlswd->id);
>+	dev->type = &cxl_swdev_type;
>+	device_set_pm_not_required(dev);
>+	cdev = &cxlswd->cdev;
>+	cdev_init(cdev, &cxl_swdev_fops);
>+	rc = dev_set_name(dev, "swcci%d", cxlswd->id);
>+	if (rc) {
>+		put_device(dev);
>+		return ERR_PTR(rc);
>+	}
>+
>+	return cxlswd;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);
>+
>+__init int cxl_switch_cci_init(void)
>+{
>+	dev_t devt;
>+	int rc;
>+
>+	rc = alloc_chrdev_region(&devt, 0, 10, "cxlsw");
>+	if (rc)
>+		return rc;
>+	cxl_sw_major = MAJOR(devt);
>+
>+	return 0;
>+}
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index edc173715814..b0e7fbdbcfb3 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -456,6 +456,17 @@ struct cxl_memdev_state {
>	struct cxl_fw_state fw;
> };
>
>+struct cxl_swdev {
>+	struct device dev;
>+	struct cdev cdev;
>+	struct cxl_mbox mbox;
>+	struct cxl_dev_state cxlds;
>+	int id;
>+};
>+
>+struct cxl_swdev *cxl_swdev_alloc(struct device *parent);
>+void cxl_swdev_shutdown(struct cxl_swdev *cxlswd);
>+
> static inline struct cxl_memdev_state *
> to_cxl_memdev_state(struct cxl_dev_state *cxlds)
> {
>@@ -466,6 +477,8 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>
> enum cxl_opcode {
>	CXL_MBOX_OP_INVALID		= 0x0000,
>+	CXL_MBOX_OP_INFO_STAT_IDENTIFY	= 0x0001,
>+	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
>	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>@@ -501,6 +514,8 @@ enum cxl_opcode {
>	CXL_MBOX_OP_UNLOCK		= 0x4503,
>	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
>+	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	= 0x5100,
>+	CXL_MBOX_OP_TUNNEL_MANAGEMENT_COMMAND	= 0x5300,
>	CXL_MBOX_OP_MAX			= 0x10000
> };
>
>diff --git a/drivers/cxl/switch-cci.c b/drivers/cxl/switch-cci.c
>new file mode 100644
>index 000000000000..a8c5ea8f4436
>--- /dev/null
>+++ b/drivers/cxl/switch-cci.c
>@@ -0,0 +1,181 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Copyright(c) Huawei Technologies
>+ * Based on cxl/pci.c Copyright(c) 2020 Intel Corporation. All rights reserved.
>+ */
>+
>+#include <linux/io-64-nonatomic-lo-hi.h>
>+#include <linux/moduleparam.h>
>+#include <linux/module.h>
>+#include <linux/delay.h>
>+#include <linux/sizes.h>
>+#include <linux/mutex.h>
>+#include <linux/list.h>
>+#include <linux/pci.h>
>+#include <linux/io.h>
>+#include "cxlmem.h"
>+#include "cxlpci.h"
>+#include "cxl.h"
>+
>+static irqreturn_t cxl_swmbcci_mbox_irq(int irq, void *d)
>+{
>+	return cxl_mbox_irq(irq, d);
>+}
>+
>+static int cxl_swmbcci_setup_mailbox(struct cxl_mbox *mbox)
>+{
>+	const int cap = readl(mbox->mbox + CXLDEV_MBOX_CAPS_OFFSET);
>+
>+	/*
>+	 * A command may be in flight from a previous driver instance,
>+	 * think kexec, do one doorbell wait so that
>+	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
>+	 * source for future doorbell busy events.
>+	 */
>+	if (cxl_pci_mbox_wait_for_doorbell(mbox) != 0) {
>+		u64 md_status = 0;
>+
>+		if (mbox->get_status)
>+			md_status = mbox->get_status(mbox);
>+		cxl_err(mbox->dev, md_status, "timeout awaiting mailbox idle");
>+
>+		return -ETIMEDOUT;
>+	}
>+
>+	mbox->payload_size =
>+		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>+
>+	/*
>+	 * CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register
>+	 *
>+	 * If the size is too small, mandatory commands will not work and so
>+	 * there's no point in going forward. If the size is too large, there's
>+	 * no harm is soft limiting it.
>+	 */
>+	mbox->payload_size = min_t(size_t, mbox->payload_size, SZ_1M);
>+	if (mbox->payload_size < 256) {
>+		dev_err(mbox->dev, "Mailbox is too small (%zub)",
>+			mbox->payload_size);
>+		return -ENXIO;
>+	}
>+
>+	dev_dbg(mbox->dev, "Mailbox payload sized %zu", mbox->payload_size);
>+
>+	rcuwait_init(&mbox->mbox_wait);
>+
>+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
>+		u32 ctrl;
>+		int irq, msgnum, rc;
>+		struct pci_dev *pdev = to_pci_dev(mbox->dev);
>+
>+		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>+		irq = pci_irq_vector(pdev, msgnum);
>+		if (irq < 0)
>+			goto mbox_poll;
>+
>+		rc = devm_request_threaded_irq(mbox->dev, irq, cxl_swmbcci_mbox_irq,
>+					       NULL, IRQF_SHARED | IRQF_ONESHOT,
>+					       NULL, mbox);
>+		if (rc)
>+			goto mbox_poll;
>+
>+		/* enable background command mbox irq support */
>+		ctrl = readl(mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
>+		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
>+		writel(ctrl, mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
>+
>+		return 0;
>+	}
>+
>+mbox_poll:
>+	if (mbox->special_init_poll)
>+		mbox->special_init_poll(mbox);
>+
>+	dev_dbg(mbox->dev, "Mailbox interrupts are unsupported");
>+	return 0;
>+}
>+
>+
>+static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>+{
>+	struct cxl_register_map map;
>+	struct cxl_swdev *cxlswd;
>+	int rc;
>+
>+	rc = pcim_enable_device(pdev);
>+	if (rc)
>+		return rc;
>+
>+	cxlswd = cxl_swdev_alloc(&pdev->dev);
>+	if (IS_ERR(cxlswd))
>+		return PTR_ERR(cxlswd);
>+
>+	mutex_init(&cxlswd->mbox.mbox_mutex);
>+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>+	if (rc)
>+		return rc;
>+	rc = cxl_setup_regs(&map);
>+	if (rc)
>+		return rc;
>+
>+	rc = cxl_map_device_regs(&map, &cxlswd->cxlds.regs.device_regs);
>+	if (rc)
>+		return rc;
>+
>+	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox);
>+	if (rc)
>+		return rc;
>+
>+	cxlswd->mbox.status = cxlswd->cxlds.regs.status;
>+	cxlswd->mbox.dev = &pdev->dev;
>+
>+	rc = cxl_swmbcci_setup_mailbox(&cxlswd->mbox);
>+	if (rc)
>+		return rc;
>+
>+
>+	pci_set_drvdata(pdev, cxlswd);
>+
>+	rc = cxl_enumerate_cmds(&cxlswd->mbox);
>+	if (rc)
>+		goto error_put_device;
>+
>+	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
>+	if (rc)
>+		goto error_put_device;
>+
>+	return 0;
>+
>+error_put_device:
>+	cxl_swdev_shutdown(cxlswd);
>+	put_device(&cxlswd->dev);
>+	return rc;
>+}
>+
>+static void cxl_swbmcci_remove(struct pci_dev *pdev)
>+{
>+	struct cxl_swdev *cxlswd = pci_get_drvdata(pdev);
>+	struct device *dev = &cxlswd->dev;
>+
>+	cxl_swdev_shutdown(cxlswd);
>+	cdev_device_del(&cxlswd->cdev, dev);
>+	put_device(&cxlswd->dev);
>+}
>+
>+static const struct pci_device_id cxl_swmbcci_pci_tbl[] = {
>+	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_CXL_SWITCH_CCI, ~0) },
>+	{}
>+};
>+MODULE_DEVICE_TABLE(pci, cxl_swmbcci_pci_tbl);
>+
>+static struct pci_driver cxl_swmbcci_driver = {
>+	.name = KBUILD_MODNAME,
>+	.id_table = cxl_swmbcci_pci_tbl,
>+	.probe = cxl_swmbcci_probe,
>+	.remove = cxl_swbmcci_remove,
>+};
>+
>+module_pci_driver(cxl_swmbcci_driver);
>+MODULE_DESCRIPTION("CXL Switch CCI mailbox access driver");
>+MODULE_LICENSE("GPL");
>+MODULE_IMPORT_NS(CXL);
>diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>index 14bc6e742148..b62aeba9d5c6 100644
>--- a/include/uapi/linux/cxl_mem.h
>+++ b/include/uapi/linux/cxl_mem.h
>@@ -46,6 +46,10 @@
>	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
>+	___C(INFO_STAT_IDENTIFY, "Get Information"),			  \
>+	___C(GET_BG_CMD_STATUS, "Background Command Status"),	\

There has been concerns in the past about exposing this and the fact
that it's conceptually broken for userspace.

https://lore.kernel.org/all/6397d1d288fed_b05d1294b4@dwillia2-xfh.jf.intel.com.notmuch/

Thanks,
Davidlohr

>+	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),		\
>+	___C(TUNNEL_MANAGEMENT_COMMAND, "Tunnel Management Command"),     \
>	___C(MAX, "invalid / last command")
>
> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>--
>2.39.2
>
