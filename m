Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34292C001E0
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jul 2023 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjG0Juq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jul 2023 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjG0Ju1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jul 2023 05:50:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDFE77
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jul 2023 02:50:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RBQpt3N15z6GDGR;
        Thu, 27 Jul 2023 17:44:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:49:17 +0100
Date:   Thu, 27 Jul 2023 10:49:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Shesha Bhushan Sreenivasamurthy" <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v4 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <20230727104916.00007a21@Huawei.com>
In-Reply-To: <r7djcwxcuzsvqcwbct3iiyljdhpsobvgjwuxjmlew3cuo52lcg@xkrkc4srqzju>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
        <20230719091931.27799-5-Jonathan.Cameron@huawei.com>
        <r7djcwxcuzsvqcwbct3iiyljdhpsobvgjwuxjmlew3cuo52lcg@xkrkc4srqzju>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Jul 2023 13:00:31 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 19 Jul 2023, Jonathan Cameron wrote:
> 
> >+static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >+{
> >+	struct cxl_register_map map;
> >+	struct cxl_swdev *cxlswd;
> >+	int rc;
> >+
> >+	rc = pcim_enable_device(pdev);
> >+	if (rc)
> >+		return rc;
> >+
> >+	cxlswd = cxl_swdev_alloc(&pdev->dev);
> >+	if (IS_ERR(cxlswd))
> >+		return PTR_ERR(cxlswd);
> >+
> >+	mutex_init(&cxlswd->mbox.mbox_mutex);
> >+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> >+	if (rc)
> >+		return rc;
> >+	rc = cxl_setup_regs(&map);
> >+	if (rc)
> >+		return rc;
> >+
> >+	rc = cxl_map_device_regs(&map, &cxlswd->cxlds.regs.device_regs);
> >+	if (rc)
> >+		return rc;
> >+
> >+	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox);
> >+	if (rc)
> >+		return rc;
> >+
> >+	cxlswd->mbox.status = cxlswd->cxlds.regs.status;
> >+	cxlswd->mbox.dev = &pdev->dev;
> >+
> >+	rc = cxl_swmbcci_setup_mailbox(&cxlswd->mbox);
> >+	if (rc)
> >+		return rc;
> >+
> >+
> >+	pci_set_drvdata(pdev, cxlswd);
> >+
> >+	rc = cxl_enumerate_cmds(&cxlswd->mbox);  
> 
> Making the whole mbox more generically available makes me wonder if
> we want to start using Get Supported Logs Sub-List instead of the current
> gsl? The spec is pretty explicit about this:
> 
> ""
> It is strongly recommended that the Get Supported Logs Sub-List (see
> Section 8.2.9.5.6) is supported by Components and used by software instead of Get
> Supported Logs so that requestors may control the output payload size, as needed.
> Type 3 Devices that implement support for the Get Supported Logs opcode on an
> MCTP-based CCI shall also support the Get Supported Logs Sub-List opcode.
> ""

Agreed - it would be good to make that move on any devices that support
the command.  Patches welcome :)


Jonathan

> 
> Thanks,
> Davidlohr
> 
> >+	if (rc)
> >+		goto error_put_device;
> >+
> >+	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
> >+	if (rc)
> >+		goto error_put_device;
> >+
> >+	return 0;
> >+
> >+error_put_device:
> >+	cxl_swdev_shutdown(cxlswd);
> >+	put_device(&cxlswd->dev);
> >+	return rc;
> >+}  

