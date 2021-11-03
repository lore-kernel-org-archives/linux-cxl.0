Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FC1C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 17:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745256109F
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhKCRSb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:18:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:12990 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKCRS3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 3 Nov 2021 13:18:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231800376"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="231800376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:05:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="667601110"
Received: from talinn-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.134.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:05:53 -0700
Date:   Wed, 3 Nov 2021 10:05:52 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 13/28] cxl: Flesh out register names
Message-ID: <20211103170552.55ae5u7uvurkync6@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-14-ben.widawsky@intel.com>
 <20211103155359.0000343d@Huawei.com>
 <20211103160336.5uctxskrrwcxdfyg@intel.com>
 <20211103164232.00004aff@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103164232.00004aff@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-03 16:42:32, Jonathan Cameron wrote:
> On Wed, 3 Nov 2021 09:03:36 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 21-11-03 15:53:59, Jonathan Cameron wrote:
> > > On Fri, 22 Oct 2021 11:36:54 -0700
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >   
> > 
> > [snip]
> > 
> > > > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > > > index 12fdcb1b14e5..fe2898b17736 100644
> > > > --- a/drivers/cxl/pci.h
> > > > +++ b/drivers/cxl/pci.h
> > > > @@ -7,17 +7,36 @@
> > > >  
> > > >  /*
> > > >   * See section 8.1 Configuration Space Registers in the CXL 2.0
> > > > - * Specification
> > > > + * Specification. Names are taken straight from the specification with "CXL" and
> > > > + * "DVSEC" redundancies removed.
> > > >   */
> > > >  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> > > >  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> > > > -#define PCI_DVSEC_ID_CXL		0x0
> > > >  
> > > > -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
> > > > -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> > > > +/* 8.1.3: PCIe DVSEC for CXL Device */
> > > > +#define CXL_DVSEC_PCIE_DEVICE					0
> > > >  
> > > > -/* BAR Indicator Register (BIR) */
> > > > -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> > > > +/* 8.1.4: Non-CXL Function Map DVSEC */
> > > > +#define CXL_DVSEC_FUNCTION_MAP					2
> > > > +
> > > > +/* 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> > > > +#define CXL_DVSEC_PORT_EXTENSIONS				3
> > > > +
> > > > +/* 8.1.6: GPF DVSEC for CXL Port */
> > > > +#define CXL_DVSEC_PORT_GPF					4
> > > > +
> > > > +/* 8.1.7: GPF DVSEC for CXL Device */
> > > > +#define CXL_DVSEC_DEVICE_GPF					5
> > > > +
> > > > +/* 8.1.8: PCIe DVSEC for Flex Bus Port */
> > > > +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> > > > +
> > > > +/* 8.1.9: Register Locator DVSEC */
> > > > +#define CXL_DVSEC_REGISTER_LOCATOR				8
> > > > +#define   DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET			0xC  
> > > 
> > > Hmm. I'm not particularly keen on not having CXL in the naming for the offset
> > > and fields.  They get used in places where, to the casual reader, they may look
> > > like generic PCI_DVSEC_ defintiions....  the do get very long though, but I'm not
> > > sure that's the right place to abbreviate. 
> > > 
> > > Agreed with your comment in the thread that it's really hard to
> > > get a good consistent model for what are near enough free form names
> > > in a spec (or seem like it when read long after they were defined).
> > >   
> > 
> > Hi Jonathan, thanks for looking.
> > 
> > Well for these in particular, I'd expect the actual register/DVSEC offset to
> > have been read a few lines above, so I'm not too worried about these ones
> > specifically. However, it's a good point as this grows it may become
> > problematic. Do you have a suggestion? My ideal would be for the CXL consortium
> > to publish header files for these things and then we can just grumble about how
> > silly they are and move along, but I'm not sure that will happen.
> 
> :)  You can propose it... - Can you imagine how long those calls would go on
> for??????
> 
> > 
> > Anyway... I really don't care what we choose as long as it's consistent. What
> > color would you like?
> 
> Blue, no yellow.... Ahhhhhhh!
> 
> I think a bit of flexibility on abbreviations is needed when they get insanely
> long...  Meh, we can always rename them all later when we decide the choice was
> wrong.

Two very good choices. Ack. I'll respin. Let me spell out though in case it
wasn't clear, my goal was to make something grepable, which abbreviations take
away from. This is because as the 3.0 spec goes through I'm noticing our chapter
references are no longer 100% accurate (annoying!).

> 
> > 
> > [snip]
> > 
> 
