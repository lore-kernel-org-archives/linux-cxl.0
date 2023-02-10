Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65003C636CD
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Feb 2023 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjBJM36 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 07:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBJM36 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 07:29:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246EF33456
        for <linux-cxl@vger.kernel.org>; Fri, 10 Feb 2023 04:29:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCtHX2DnYz67lD7;
        Fri, 10 Feb 2023 20:25:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 12:29:53 +0000
Date:   Fri, 10 Feb 2023 12:29:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Stefan Roese <sr@denx.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <20230210122952.00006999@Huawei.com>
In-Reply-To: <63e5fb533f304_13244829412@iweiny-mobl.notmuch>
References: <20230105163127.00005ae2@huawei.com>
        <20230105165406.GA1150163@bhelgaas>
        <20230106112605.00006cf6@Huawei.com>
        <63e5fb533f304_13244829412@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Feb 2023 00:07:47 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 5 Jan 2023 10:54:06 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > On Thu, Jan 05, 2023 at 04:31:27PM +0000, Jonathan Cameron wrote:  
> > > > On Thu, 29 Dec 2022 11:27:31 -0600
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:    
> > > > > On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:    
> > >   
> > > > > > I realized that adding this patch still only enables error because I
> > > > > > didn't check the PCIe spec when writing the QEMU emulation. I had
> > > > > > changed the value of  "Correctable Internal Error Mask" to default
> > > > > > to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> > > > > > I thought these masks were impdef (should have checked ;)      
> > > > > 
> > > > > I assume you refer to the AER "Corrected Internal Error Mask" bit
> > > > > (PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
> > > > > bit is implemented.    
> > > > 
> > > > Spot on.  I keep confusing the correctable / corrected stuff in PCIe.
> > > > Made more confusing by the CXL stuff layered on top.    
> > > 
> > > Great, it wasn't confusing enough already, so CXL rectified that
> > > problem :)
> > >   
> > > > > We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > > > > native"), which turns on error reporting in Device Control for all
> > > > > devices at enumeration-time when the OS has control of AER.  But this
> > > > > is only the generic device-level control; it doesn't configure any
> > > > > *AER* registers.
> > > > > 
> > > > > I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
> > > > > some mips and powerpc arch-specific code and a few individual drivers.
> > > > > It seems like maybe pci_aer_init() should do some more configuration
> > > > > of the AER mask and severity registers.    
> > > > 
> > > > Sounds good.  Any thoughts on where to get the policy from?
> > > > Feels like an administrator thing rather than a kernel config one
> > > > to me, so maybe pci_aer_init() is too early or we'd benefit from
> > > > a nice easy per device interface to tweak a default?    
> > > 
> > > If we get a solid system-level policy in place and still end up
> > > needing some kind of administrative control, that might be OK.  But we
> > > don't have that solid system policy yet, so I'd like to push on that
> > > before adding admin interfaces.  
> > 
> > I guess next step is a straw man proposal for people to test / shoot at.
> > I'll send out an RFC that enables the lot as defined in PCI r6.0
> > as that will be most useful for identifying quirks we need to handle.
> > 
> > My assumption being people will push back on some of them / we'll need
> > to quirk others.  
> 
> Jonathan,
> 
> Did you send something along these lines? 

Oops. I forgot about it :(

> I was testing the AER trace
> point output while cleaning up the trace points a bit.[1]  And I ran
> across the need to set up these PCIe registers.  Because I did not see
> anything from you I was thinking of taking a crack at fixing this.

Great. I can forget about it again ;)

> 
> To me, it is pretty straight forward that if a driver enables error
> reporting then it would want to include internal errors both correctable
> and uncorrectable.  This allows for CXL to further control the CXL
> registers as an overlay.  I'm not so sure about the other PCIe AER errors
> which are default masked.

I think the concern may be around devices that are rather over chatty wrt
things that are fairly trivial.

> 
> PCI v6.0 defaults to a fatal uncorrectable error.  I think it is probably
> a good default to make these non-fatal when enabling the _reporting_ of
> the errors.  If a driver wants them to be fatal then another call could be
> added later.  (or the driver should be doing that on their own now.)

Interesting point.  I'm not sure what to do about severity.  Definitely a
question for an RFC posting.

> 
> If I understand this thread, the CXL spec, the PCI spec, and all the code; it
> seems like unmasking the internal correctable and uncorrectable errors in
> pci_enable_pcie_error_reporting() are a good system default.  With the
> addition of making uncorrectable non-fatal.[2]
> 
> That said, there are approximately 51 drivers which enable error reporting
> with this call.  I'm a bit concerned with such a global change.  But
> perhaps it seems ok if it is only enabling then internal errors as
> non-fatal.  So at worse this would simply spam logs on bad devices?

Yes, this isn't risk free, but we probably want device drivers for problem
devices to opt out of this with the defaults as you describe.
I'm sure we'll get a bunch of reports of new log messages appearing but if
they are false positives (odd things happen during device init perhaps) then
the drivers in question ought to work around that locally.

> 
> Ira
> 
> [1] https://lore.kernel.org/all/20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com/
> [2]
> 
> commit 30e6a0bf308e7b8c68b4da33b505fa967f6bbf34 (HEAD -> cxl-pci-aer)
> Author: Ira Weiny <ira.weiny@intel.com>
> Date:   Thu Feb 9 22:26:05 2023 -0800
> 
>     PCI/AER: Enable internal AER errors by default
>     
>     The CXL driver expects internal error reporting to be enabled via
>     pci_enable_pcie_error_reporting().  It is likely other drivers expect
>     the same thing.
>     
>     PCIe v6.0 Uncorrectable Mask Register (7.8.4.3) and Correctable Mask
>     Register (7.8.4.6) default to masking internal errors.  The
>     Uncorrectable Error Severity Register (7.8.4.4) defaults internal errors
>     as fatal.
>     
>     Change pci_enable_pcie_error_reporting() to enable both types of
>     internal errors.  Ensure uncorrectable errors are set non-fatal to limit
>     any impact to other drivers.
>     
>     Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>     Cc: Bjorn Helgaas <helgaas@kernel.org>
>     Cc: Dave Jiang <dave.jiang@intel.com>
>     Cc: <linux-cxl@vger.kernel.org>,
>     Cc: <dan.j.williams@intel.com>
>     Cc: Stefan Roese <sr@denx.de>
>     Cc: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
>     Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>     
>     ---
>     For all drivers other than CXL this is expected to at worse increase the
>     error reporting verbosity.  Because the errors are set to non-fatal by
>     default this should not adversely affect the operation of those devices.
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 625f7b2cafe4..9d3ed3a5fc23 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,11 +229,28 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +       int pos_cap_err;
> +       u32 reg;
>         int rc;
>  
>         if (!pcie_aer_is_native(dev))
>                 return -EIO;
>  
> +       pos_cap_err = dev->aer_cap;
> +
> +       /* Unmask correctable and uncorrectable (non-fatal) internal errors */
> +       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, &reg);
> +       reg &= ~PCI_ERR_COR_INTERNAL;
> +       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, reg);
> +
> +       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &reg);
> +       reg &= ~PCI_ERR_UNC_INTN;
> +       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, reg);
> +
> +       pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, &reg);
> +       reg &= ~PCI_ERR_UNC_INTN;
> +       pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, reg);
> +
>         rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
>         return pcibios_err_to_errno(rc);
>  }

