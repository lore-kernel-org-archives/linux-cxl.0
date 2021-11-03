Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF45C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2048561073
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhKCQpU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:45:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4059 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhKCQpT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 12:45:19 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HkstD46CBz67tvX;
        Thu,  4 Nov 2021 00:39:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 17:42:40 +0100
Received: from localhost (10.52.126.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 16:42:38 +0000
Date:   Wed, 3 Nov 2021 16:42:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 13/28] cxl: Flesh out register names
Message-ID: <20211103164232.00004aff@Huawei.com>
In-Reply-To: <20211103160336.5uctxskrrwcxdfyg@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-14-ben.widawsky@intel.com>
        <20211103155359.0000343d@Huawei.com>
        <20211103160336.5uctxskrrwcxdfyg@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.31]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 3 Nov 2021 09:03:36 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-11-03 15:53:59, Jonathan Cameron wrote:
> > On Fri, 22 Oct 2021 11:36:54 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> 
> [snip]
> 
> > > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > > index 12fdcb1b14e5..fe2898b17736 100644
> > > --- a/drivers/cxl/pci.h
> > > +++ b/drivers/cxl/pci.h
> > > @@ -7,17 +7,36 @@
> > >  
> > >  /*
> > >   * See section 8.1 Configuration Space Registers in the CXL 2.0
> > > - * Specification
> > > + * Specification. Names are taken straight from the specification with "CXL" and
> > > + * "DVSEC" redundancies removed.
> > >   */
> > >  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> > >  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> > > -#define PCI_DVSEC_ID_CXL		0x0
> > >  
> > > -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
> > > -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> > > +/* 8.1.3: PCIe DVSEC for CXL Device */
> > > +#define CXL_DVSEC_PCIE_DEVICE					0
> > >  
> > > -/* BAR Indicator Register (BIR) */
> > > -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> > > +/* 8.1.4: Non-CXL Function Map DVSEC */
> > > +#define CXL_DVSEC_FUNCTION_MAP					2
> > > +
> > > +/* 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> > > +#define CXL_DVSEC_PORT_EXTENSIONS				3
> > > +
> > > +/* 8.1.6: GPF DVSEC for CXL Port */
> > > +#define CXL_DVSEC_PORT_GPF					4
> > > +
> > > +/* 8.1.7: GPF DVSEC for CXL Device */
> > > +#define CXL_DVSEC_DEVICE_GPF					5
> > > +
> > > +/* 8.1.8: PCIe DVSEC for Flex Bus Port */
> > > +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> > > +
> > > +/* 8.1.9: Register Locator DVSEC */
> > > +#define CXL_DVSEC_REGISTER_LOCATOR				8
> > > +#define   DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET			0xC  
> > 
> > Hmm. I'm not particularly keen on not having CXL in the naming for the offset
> > and fields.  They get used in places where, to the casual reader, they may look
> > like generic PCI_DVSEC_ defintiions....  the do get very long though, but I'm not
> > sure that's the right place to abbreviate. 
> > 
> > Agreed with your comment in the thread that it's really hard to
> > get a good consistent model for what are near enough free form names
> > in a spec (or seem like it when read long after they were defined).
> >   
> 
> Hi Jonathan, thanks for looking.
> 
> Well for these in particular, I'd expect the actual register/DVSEC offset to
> have been read a few lines above, so I'm not too worried about these ones
> specifically. However, it's a good point as this grows it may become
> problematic. Do you have a suggestion? My ideal would be for the CXL consortium
> to publish header files for these things and then we can just grumble about how
> silly they are and move along, but I'm not sure that will happen.

:)  You can propose it... - Can you imagine how long those calls would go on
for??????

> 
> Anyway... I really don't care what we choose as long as it's consistent. What
> color would you like?

Blue, no yellow.... Ahhhhhhh!

I think a bit of flexibility on abbreviations is needed when they get insanely
long...  Meh, we can always rename them all later when we decide the choice was
wrong.

> 
> [snip]
> 

