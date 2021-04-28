Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B29C433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Apr 2021 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C1461159
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Apr 2021 11:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhD1LCG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Apr 2021 07:02:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2935 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhD1LCF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Apr 2021 07:02:05 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVbC10vSsz72f7M;
        Wed, 28 Apr 2021 18:55:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 13:01:18 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 12:01:17 +0100
Date:   Wed, 28 Apr 2021 11:59:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <mst@redhat.com>, <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <hchkuo@avery-design.com.tw>, <imammedo@redhat.com>,
        <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <tyshao@avery-design.com.tw>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v5 cxl2.0-v3-doe 2/6] include/hw/pci: headers for PCIe
 DOE
Message-ID: <20210428115944.00004ead@Huawei.com>
In-Reply-To: <1619457403-12901-1-git-send-email-cbrowy@avery-design.com>
References: <1619454964-10190-1-git-send-email-cbrowy@avery-design.com>
        <1619457403-12901-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 26 Apr 2021 13:16:43 -0400
Chris Browy <cbrowy@avery-design.com> wrote:

> From: hchkuo <hchkuo@avery-design.com.tw>
> 
> Macros for the vender ID of PCI-SIG and the size of PCIe Data Object
> Exchange.

The PCI SIG vendor ID is a little tricky to track down as it's only
called out indirectly in PCI specs.

In a similar fashion to what Bjorn asked for in the kernel code, perhaps
a reference to where it is in the DOE ECN would at least reassure people
that 0x0001 definitely is the PCI-SIG?

> 
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>
One comment inline.

Jonathan

> ---
>  include/hw/pci/pci_ids.h   | 2 ++
>  include/hw/pci/pcie_regs.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 95f92d98e9..471c915395 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -157,6 +157,8 @@
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
>  
> +#define PCI_VENDOR_ID_PCI_SIG            0x0001
> +
>  #define PCI_VENDOR_ID_LSI_LOGIC          0x1000
>  #define PCI_DEVICE_ID_LSI_53C810         0x0001
>  #define PCI_DEVICE_ID_LSI_53C895A        0x0012
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 1db86b0ec4..5ec7014211 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -179,4 +179,7 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_ACS_VER                     0x1
>  #define PCI_ACS_SIZEOF                  8
>  
> +/* DOE Capability Register Fields */
> +#define PCI_DOE_SIZEOF                  24
I wonder if we should do the same thing as for other cases above and also
have the PCI_DOE_VER defined here?

In theory the SIZEOF only refers to the current version of DOE - it might get
bigger in future...

Jonathan

> +
>  #endif /* QEMU_PCIE_REGS_H */

