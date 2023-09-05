Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04459CA0FE2
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjIEQqI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354407AbjIEQ3n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 12:29:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A560113
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 09:22:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg9jN3fjrz6K5lX;
        Wed,  6 Sep 2023 00:20:56 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 17:21:03 +0100
Date:   Tue, 5 Sep 2023 17:21:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Message-ID: <20230905172102.00006736@huawei.com>
In-Reply-To: <20230905045849-mutt-send-email-mst@kernel.org>
References: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
        <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
        <20230905045849-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 5 Sep 2023 05:02:47 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Sep 05, 2023 at 10:48:54AM +0200, Philippe Mathieu-Daudé wrote:
> > Hi Jonathan,
> > 
> > On 4/9/23 19:57, Jonathan Cameron wrote:  
> > > Will be needed so there is a defined serial number for
> > > information queries via the Switch CCI.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > No ordering dependencies wrt to other CXL patch sets.
> > > 
> > > Whilst we 'need' it for the Switch CCI set it is valid without
> > > it and aligns with existing EP serial number support. Seems sensible
> > > to upstream this first and reduce my out of tree backlog a little!
> > > 
> > >   hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
> > >   1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > > index 2b9cf0cc97..15c4d84a56 100644
> > > --- a/hw/pci-bridge/cxl_upstream.c
> > > +++ b/hw/pci-bridge/cxl_upstream.c
> > > @@ -14,6 +14,11 @@
> > >   #include "hw/pci/msi.h"
> > >   #include "hw/pci/pcie.h"
> > >   #include "hw/pci/pcie_port.h"
> > > +/*
> > > + * Null value of all Fs suggested by IEEE RA guidelines for use of
> > > + * EU, OUI and CID
> > > + */
> > > +#define UI64_NULL (~0ULL)  
> > 
> > Already defined in hw/mem/cxl_type3.c, can we move it to some common
> > CXL header? Or include/qemu/units.h?  
> 
> not the last one I think - this is a cxl specific hack to detect that
> user has changed the property.

The chosen default is also the one that the relevant specifications says
means 'NULL' for a EUI64 code so is at least a valid hack...
https://standards.ieee.org/wp-content/uploads/import/documents/tutorials/eui.pdf
"Unassigned and NULL EUI values"
specifically recommend NULL values in that section.

However, it's obscure enough that we probably don't want it in a generic
header.

> 
> 
> I think we really should have a variant of DEFINE_PROP_XXX that sets a
> flag allowing us to detect whether a property has been set manually.
> This would be a generalization of DEFINE_PROP_ON_OFF_AUTO.

Agreed that would be generally useful but here there is a reasonable
default value so I don't think we need this.

> 
> 
> > >   #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
> > > @@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
> > >       /*< public >*/
> > >       CXLComponentState cxl_cstate;
> > >       DOECap doe_cdat;
> > > +    uint64_t sn;
> > >   } CXLUpstreamPort;
> > >   CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
> > > @@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
> > >       if (rc) {
> > >           goto err_cap;
> > >       }
> > > -
> > > -    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > > +    if (usp->sn != UI64_NULL) {
> > > +        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
> > > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;  
> > 
> > Could it be clearer to have:
> > 
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > @@ -23,2 +23,2 @@
> > -#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
> > -    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> > +#define CXL_UPSTREAM_PORT_DVSEC_OFFSET(offset) \
> > +    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF + offset)
> > 
> > ?
> >   
> > > +    } else {
> > > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > > +    }
> > >       cxl_cstate->pdev = d;
> > >       build_dvsecs(cxl_cstate);
> > >       cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> > > @@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
> > >   }
> > >   static Property cxl_upstream_props[] = {
> > > +    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
> > >       DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
> > >       DEFINE_PROP_END_OF_LIST()
> > >   };  
> 

