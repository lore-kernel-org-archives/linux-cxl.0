Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66334C433E9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA664DBA
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhBBTr5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:47:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2479 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhBBNwP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 08:52:15 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVR026ZkDz67h9N;
        Tue,  2 Feb 2021 21:45:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 14:51:33 +0100
Received: from localhost (10.47.79.68) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:51:32 +0000
Date:   Tue, 2 Feb 2021 13:50:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Da?= =?ISO-8859-1?Q?ud=E9?= 
        <f4bug@amsat.org>, Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 10/31] hw/pxb: Use a type for realizing expanders
Message-ID: <20210202135046.000017ca@Huawei.com>
In-Reply-To: <20210202005948.241655-11-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-11-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.68]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 1 Feb 2021 16:59:27 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> This opens up the possibility for more types of expanders (other than
> PCI and PCIe). We'll need this to create a CXL expander.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Minor suggestion inline but nothing important if you don't want to change it.

Jonathan

> ---
>  hw/pci-bridge/pci_expander_bridge.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index aedded1064..232b7ce305 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -24,6 +24,8 @@
>  #include "hw/boards.h"
>  #include "qom/object.h"
>  
> +enum BusType { PCI, PCIE };
> +
>  #define TYPE_PXB_BUS "pxb-bus"
>  typedef struct PXBBus PXBBus;
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
> @@ -214,7 +216,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
>             0;
>  }
>  
> -static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
> +static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
> +                                   Error **errp)
>  {
>      PXBDev *pxb = convert_to_pxb(dev);
>      DeviceState *ds, *bds = NULL;
> @@ -239,7 +242,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
>      }
>  
>      ds = qdev_new(TYPE_PXB_HOST);
> -    if (pcie) {
> +    if (type == PCIE) {

I'd make this a switch statement now given we are about to the 3 entries and may well
get more in the future.

>          bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
>      } else {
>          bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
> @@ -287,7 +290,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
>          return;
>      }
>  
> -    pxb_dev_realize_common(dev, false, errp);
> +    pxb_dev_realize_common(dev, PCI, errp);
>  }
>  
>  static void pxb_dev_exitfn(PCIDevice *pci_dev)
> @@ -339,7 +342,7 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
>          return;
>      }
>  
> -    pxb_dev_realize_common(dev, true, errp);
> +    pxb_dev_realize_common(dev, PCIE, errp);
>  }
>  
>  static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)

