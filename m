Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC30C433B4
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Apr 2021 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A5F610E5
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Apr 2021 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIP24 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:28:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2830 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIP24 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Apr 2021 11:28:56 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FH20d0B6vz6864T;
        Fri,  9 Apr 2021 23:21:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 17:28:41 +0200
Received: from localhost (10.47.90.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 16:28:40 +0100
Date:   Fri, 9 Apr 2021 16:27:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <mst@redhat.com>, <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <hchkuo@avery-design.com.tw>, <imammedo@redhat.com>,
        <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <tyshao@avery-design.com.tw>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4 cxl-2.0-doe 3/3] PCIe standard header for DOE
Message-ID: <20210409162716.0000491c@Huawei.com>
In-Reply-To: <1617208628-3594-1-git-send-email-cbrowy@avery-design.com>
References: <1617207125-1138-1-git-send-email-cbrowy@avery-design.com>
        <1617208628-3594-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.233]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 31 Mar 2021 12:37:08 -0400
Chris Browy <cbrowy@avery-design.com> wrote:

> From: hchkuo <hchkuo@avery-design.com.tw>
> 
> Signed-off-by: hchkuo <hchkuo@avery-design.com.tw>
Code must build after each patch, so this needs to go first in the series,
not last.  git rebase -i HEAD~3 and reorder the patches should be an easy
way to do it.

+ add a note to say standard-headers at least should come via scripts
(break that one out to a separate patch to make life easier)

Jonathan

> ---
>  include/hw/pci/pci_ids.h                  | 2 ++
>  include/hw/pci/pcie_regs.h                | 3 +++
>  include/standard-headers/linux/pci_regs.h | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 95f92d9..471c915 100644
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
> index 1db86b0..5ec7014 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -179,4 +179,7 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_ACS_VER                     0x1
>  #define PCI_ACS_SIZEOF                  8
>  
> +/* DOE Capability Register Fields */
> +#define PCI_DOE_SIZEOF                  24
> +
>  #endif /* QEMU_PCIE_REGS_H */
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index e709ae8..2a8df63 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -730,7 +730,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40

