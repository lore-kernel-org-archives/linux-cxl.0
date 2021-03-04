Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546BC433DB
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5976764EE1
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCDTq7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:46:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2619 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhCDTXu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Mar 2021 14:23:50 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ds0z143pvz67rtL;
        Fri,  5 Mar 2021 03:18:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 4 Mar 2021 20:23:08 +0100
Received: from localhost (10.47.94.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 4 Mar 2021
 19:23:08 +0000
Date:   Thu, 4 Mar 2021 19:21:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
Message-ID: <20210304192158.00004296@Huawei.com>
In-Reply-To: <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
        <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.223]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 9 Feb 2021 15:35:49 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

Hi Chris,

One more thing hit whilst debugging linux side of this.

> +static void pcie_doe_irq_assert(DOECap *doe_cap)
> +{
> +    PCIDevice *dev = doe_cap->doe->pdev;
> +
> +    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {


need something like

doe_cap->status.intr = 1;

I think or anyone checking the status register is going to think
this interrupt is spurious.

Otherwise all seems to work. I need to do a bit of tidying up on
kernel code but should be able to send out early next week.

> +        /* Interrupt notify */
> +        if (msix_enabled(dev)) {
> +            msix_notify(dev, doe_cap->cap.vec);
> +        } else if (msi_enabled(dev)) {
> +            msi_notify(dev, doe_cap->cap.vec);
> +        }
> +        /* Not support legacy IRQ */
> +    }
> +}
