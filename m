Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7564EB64DA
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Jul 2023 08:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGSIp3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGSIp1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 04:45:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D21724
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 01:45:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R5Tpx562lz6J6nK;
        Wed, 19 Jul 2023 16:42:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 09:45:22 +0100
Date:   Wed, 19 Jul 2023 09:45:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux@huawei.com>
Subject: Re: [RFC PATCH v3 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <20230719094521.00003a8a@Huawei.com>
In-Reply-To: <20230717162557.8625-5-Jonathan.Cameron@huawei.com>
References: <20230717162557.8625-1-Jonathan.Cameron@huawei.com>
        <20230717162557.8625-5-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 17 Jul 2023 17:25:57 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> CXL 3.0 defines a mailbox PCI function independent of any other CXL
> components. The intent is that instances of this mailbox will be found
> as additional PCI functions of upstream CXL switch ports.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm a muppet - this is missing files (there is some stuff in core that
we might move out but would require exposing a few functions that are
currently not exported.)

Jonathan


> ---
>  drivers/cxl/Kconfig          |  14 +++
>  drivers/cxl/Makefile         |   2 +
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/core.h      |   1 +
>  drivers/cxl/core/mbox.c      |   6 ++
>  drivers/cxl/core/port.c      |   4 +
>  drivers/cxl/cxlmem.h         |  15 +++
>  drivers/cxl/switch-cci.c     | 182 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |   4 +
>  9 files changed, 229 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index fcbf8295fde3..9a304ab60692 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -152,5 +152,19 @@ config CXL_PMU
>  	  Say 'y/m' to enable a driver that will attach to performance
>  	  monitoring units and provide standard perf based interfaces.
>  
> +	  If unsure say 'm'.
> +
> +config CXL_SWITCH
> +	tristate "CXL switch mailbox access"
> +	help
> +	  The CXL r3.0 specification defines a "CXL switch CCI" sub-class in the
> +	  PCI "Serial" base class of devices. Device's identified by
> +	  this class code provide a mailbox interface to allow control of CXL
> +	  switch configuration over inband PCI.
> +
> +	  Say 'y/m' to enable a driver that will attach to CXL Switch CCI
> +	  devices enumerated by the CXL switch CCI class code for configuration
> +	  and management primarily via the mailbox interface.
> +
>  	  If unsure say 'm'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index db321f48ba52..1e5f5b8b4d73 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_SWITCH) += cxl_switch_cci.o
>  
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_port-y := port.o
> +cxl_switch_cci-y := switch-cci.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1f66b5d4d935..d8a0ffa0f8cc 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -13,5 +13,6 @@ cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
> +cxl_core-y += switch-cci.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5491d3a3c095..23d21d290db5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -80,6 +80,7 @@ extern struct rw_semaphore cxl_dpa_rwsem;
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> +int cxl_switch_cci_init(void);
>  
>  enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_LIST,
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index eb6123b54f0a..c77b8ffb6ea8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -8,6 +8,7 @@
>  #include <cxlmbox.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include <cxl.h>
>  
>  #include "core.h"
> @@ -55,6 +56,8 @@ static bool cxl_raw_allow_all;
>   * 0, and the user passed in 1, it is an error.
>   */
>  static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> +	CXL_CMD(INFO_STAT_IDENTIFY, 0, 0x12, 0),
> +	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),
>  	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
>  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
>  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> @@ -72,6 +75,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),
> +	CXL_CMD(TUNNEL_MANAGEMENT_COMMAND, CXL_VARIABLE_PAYLOAD,
> +		CXL_VARIABLE_PAYLOAD, 0),
>  };
>  
>  /*
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..ce3fb0d406d7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2020,6 +2020,10 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_switch_cci_init();
> +	if (rc)
> +		return rc;
> +
>  	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
>  	if (!cxl_bus_wq) {
>  		rc = -ENOMEM;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index edc173715814..b0e7fbdbcfb3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -456,6 +456,17 @@ struct cxl_memdev_state {
>  	struct cxl_fw_state fw;
>  };
>  
> +struct cxl_swdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_mbox mbox;
> +	struct cxl_dev_state cxlds;
> +	int id;
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct device *parent);
> +void cxl_swdev_shutdown(struct cxl_swdev *cxlswd);
> +
>  static inline struct cxl_memdev_state *
>  to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  {
> @@ -466,6 +477,8 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
> +	CXL_MBOX_OP_INFO_STAT_IDENTIFY	= 0x0001,
> +	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> @@ -501,6 +514,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	= 0x5100,
> +	CXL_MBOX_OP_TUNNEL_MANAGEMENT_COMMAND	= 0x5300,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> diff --git a/drivers/cxl/switch-cci.c b/drivers/cxl/switch-cci.c
> new file mode 100644
> index 000000000000..80a4a3724f26
> --- /dev/null
> +++ b/drivers/cxl/switch-cci.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright(c) Huawei Technologies
> + * Based on cxl/pci.c Copyright(c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/moduleparam.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/sizes.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include "cxlmem.h"
> +#include "cxlpci.h"
> +#include "cxlswitch.h"
> +#include "cxl.h"
> +
> +static irqreturn_t cxl_swmbcci_mbox_irq(int irq, void *d)
> +{
> +	return cxl_mbox_irq(irq, d);
> +}
> +
> +static int cxl_swmbcci_setup_mailbox(struct cxl_mbox *mbox)
> +{
> +	const int cap = readl(mbox->mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +
> +	/*
> +	 * A command may be in flight from a previous driver instance,
> +	 * think kexec, do one doorbell wait so that
> +	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
> +	 * source for future doorbell busy events.
> +	 */
> +	if (cxl_pci_mbox_wait_for_doorbell(mbox) != 0) {
> +		u64 md_status = 0;
> +
> +		if (mbox->get_status)
> +			md_status = mbox->get_status(mbox);
> +		cxl_err(mbox->dev, md_status, "timeout awaiting mailbox idle");
> +
> +		return -ETIMEDOUT;
> +	}
> +
> +	mbox->payload_size =
> +		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
> +
> +	/*
> +	 * CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register
> +	 *
> +	 * If the size is too small, mandatory commands will not work and so
> +	 * there's no point in going forward. If the size is too large, there's
> +	 * no harm is soft limiting it.
> +	 */
> +	mbox->payload_size = min_t(size_t, mbox->payload_size, SZ_1M);
> +	if (mbox->payload_size < 256) {
> +		dev_err(mbox->dev, "Mailbox is too small (%zub)",
> +			mbox->payload_size);
> +		return -ENXIO;
> +	}
> +
> +	dev_dbg(mbox->dev, "Mailbox payload sized %zu", mbox->payload_size);
> +
> +	rcuwait_init(&mbox->mbox_wait);
> +
> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> +		u32 ctrl;
> +		int irq, msgnum, rc;
> +		struct pci_dev *pdev = to_pci_dev(mbox->dev);
> +
> +		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +		irq = pci_irq_vector(pdev, msgnum);
> +		if (irq < 0)
> +			goto mbox_poll;
> +
> +		rc = devm_request_threaded_irq(mbox->dev, irq, cxl_swmbcci_mbox_irq,
> +					       NULL, IRQF_SHARED | IRQF_ONESHOT,
> +					       NULL, mbox);
> +		if (rc)
> +			goto mbox_poll;
> +
> +		/* enable background command mbox irq support */
> +		ctrl = readl(mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> +		writel(ctrl, mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +		return 0;
> +	}
> +
> +mbox_poll:
> +	if (mbox->special_init_poll)
> +		mbox->special_init_poll(mbox);
> +
> +	dev_dbg(mbox->dev, "Mailbox interrupts are unsupported");
> +	return 0;
> +}
> +
> +
> +static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct cxl_register_map map;
> +	struct cxl_swdev *cxlswd;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	cxlswd = cxl_swdev_alloc(&pdev->dev);
> +	if (IS_ERR(cxlswd))
> +		return PTR_ERR(cxlswd);
> +
> +	mutex_init(&cxlswd->mbox.mbox_mutex);
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_device_regs(&map, &cxlswd->cxlds.regs.device_regs);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox);
> +	if (rc)
> +		return rc;
> +
> +	cxlswd->mbox.status = cxlswd->cxlds.regs.status;
> +	cxlswd->mbox.dev = &pdev->dev;
> +
> +	rc = cxl_swmbcci_setup_mailbox(&cxlswd->mbox);
> +	if (rc)
> +		return rc;
> +
> +
> +	pci_set_drvdata(pdev, cxlswd);
> +
> +	rc = cxl_enumerate_cmds(&cxlswd->mbox);
> +	if (rc)
> +		goto error_put_device;
> +
> +	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
> +	if (rc)
> +		goto error_put_device;
> +
> +	return 0;
> +
> +error_put_device:
> +	cxl_swdev_shutdown(cxlswd);
> +	put_device(&cxlswd->dev);
> +	return rc;
> +}
> +
> +static void cxl_swbmcci_remove(struct pci_dev *pdev)
> +{
> +	struct cxl_swdev *cxlswd = pci_get_drvdata(pdev);
> +	struct device *dev = &cxlswd->dev;
> +
> +	cxl_swdev_shutdown(cxlswd);
> +	cdev_device_del(&cxlswd->cdev, dev);
> +	put_device(&cxlswd->dev);
> +}
> +
> +static const struct pci_device_id cxl_swmbcci_pci_tbl[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_CXL_SWITCH_CCI, ~0) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, cxl_swmbcci_pci_tbl);
> +
> +static struct pci_driver cxl_swmbcci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = cxl_swmbcci_pci_tbl,
> +	.probe = cxl_swmbcci_probe,
> +	.remove = cxl_swbmcci_remove,
> +};
> +
> +module_pci_driver(cxl_swmbcci_driver);
> +MODULE_DESCRIPTION("CXL Switch CCI mailbox access driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 14bc6e742148..b62aeba9d5c6 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -46,6 +46,10 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>  	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> +	___C(INFO_STAT_IDENTIFY, "Get Information"),			  \
> +	___C(GET_BG_CMD_STATUS, "Background Command Status"),	\
> +	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),		\
> +	___C(TUNNEL_MANAGEMENT_COMMAND, "Tunnel Management Command"),     \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

