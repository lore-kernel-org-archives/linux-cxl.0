Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3EC77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 17:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjELRFy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjELRFx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 13:05:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE9E61
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 10:05:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHw665HZpz6J76l;
        Sat, 13 May 2023 01:01:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 18:05:49 +0100
Date:   Fri, 12 May 2023 18:05:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <20230512180548.00006f64@Huawei.com>
In-Reply-To: <yfcfwpnbag3jd3zhpafdxlzy4rabxf3e2l6l6ldearkwtx36gk@jbvjy5bnfl53>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-3-dave@stgolabs.net>
        <20230511152330.00001eac@Huawei.com>
        <yfcfwpnbag3jd3zhpafdxlzy4rabxf3e2l6l6ldearkwtx36gk@jbvjy5bnfl53>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> >  
> >>   * @return_code: (output) Error code returned from hardware.
> >>   *
> >>   * This is the primary mechanism used to send commands to the hardware.
> >> @@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
> >>	size_t size_in;
> >>	size_t size_out;
> >>	size_t min_out;
> >> +	int poll_count;
> >> +	int poll_interval;
> >>	u16 return_code;
> >>  };
> >>
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index 39b829a29f6c..aa1bb74a52a1 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -51,6 +51,7 @@
> >>  static unsigned short mbox_ready_timeout = 60;
> >>  module_param(mbox_ready_timeout, ushort, 0644);
> >>  MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
> >> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);  
> >
> >I see in discussion you are moving to a per device approach so I won't review
> >that bit on this version.  
> 
> Right, fyi the latest vesion is here:
> 

> https://lore.kernel.org/linux-cxl/gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn/
I'll pretend I'll look at that :)
(81 more emails to read on CXL alone.. sigh


> >  
> >>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
> >>			cxl_mbox_cmd_rc2str(mbox_cmd));
> >>		return 0; /* completed but caller must check return_code */
> >> @@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >>	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> >>	unsigned long timeout;
> >>	u64 md_status;
> >> +	int rc, irq;
> >>
> >>	timeout = jiffies + mbox_ready_timeout * HZ;
> >>	do {
> >> @@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >>	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
> >>		cxlds->payload_size);
> >>
> >> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> >> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> >> +
> >> +		irq = pci_irq_vector(pdev,
> >> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
> >> +		if (irq < 0)
> >> +			goto mbox_poll;
> >> +
> >> +		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> >> +				      IRQF_SHARED, "mailbox", cxlds);
> >> +		if (rc)
> >> +			goto mbox_poll;  
> >
> >Hmm. The old argument of whether to carry on when something unexpected happens.  
> 
> Well yes and no. The reason I am very tolerant upon errors here is that the
> background cmd polling will be done regardless of the device's interrupt
> capability. So I find it way too harsh to just fail the probe altogether
> when effectively no harm is done.

We'll never teach people to do things right if their broken config works anyway! :)

