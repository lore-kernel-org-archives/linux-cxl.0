Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC9C3DA7A
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 16:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAEQbe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjAEQbd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 11:31:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70361395E1
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 08:31:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NnsLB4bWLz6880d;
        Fri,  6 Jan 2023 00:26:42 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 16:31:28 +0000
Date:   Thu, 5 Jan 2023 16:31:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Stefan Roese" <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <20230105163127.00005ae2@huawei.com>
In-Reply-To: <20221229172731.GA611562@bhelgaas>
References: <20221217175204.0000170a@huawei.com>
        <20221229172731.GA611562@bhelgaas>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 29 Dec 2022 11:27:31 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Stefan, Kuppuswamy]
> 
> On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:
> > On Fri, 16 Dec 2022 09:10:02 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > By default the CXL RAS mask registers bits are defaulted to 1's and
> > > suppress all error reporting. If the kernel has negotiated ownership
> > > of error handling for CXL then unmask the mask registers by writing 0s.  
> 
> > +CC Bjorn for a question on the AER control element of this.  
> 
> Timely question (unlike my response, sorry, I've been on vacation).
> 
> > I realized that adding this patch still only enables error because I
> > didn't check the PCIe spec when writing the QEMU emulation. I had
> > changed the value of  "Correctable Internal Error Mask" to default
> > to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> > I thought these masks were impdef (should have checked ;)  
> 
> I assume you refer to the AER "Corrected Internal Error Mask" bit
> (PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
> bit is implemented.

Spot on.  I keep confusing the correctable / corrected stuff in PCIe.
Made more confusing by the CXL stuff layered on top.

> 
> > I'll drop that change in QEMU, but upshot is that if we want the
> > correctable ones to be delivered, we'll need to clear that bit as
> > well as the ones you do in this patch.  
> 
> I don't think Corrected Internal Error Mask affects reporting of other
> Correctable Errors, e.g., Receiver Error, Bad TLP, Bad DLLP, etc.  As
> I read sec 6.2.10, those would not be classified as "internal" errors.

I should have been more detailed in this part. You are absolutely correct
for errors defined by the PCIe spec.

CXL handles it's Protocol errors by reporting them all as 'internal'
errors as defined by PCIe and then providing extra register to demultiplex
that into a range of different CXL protocol errors. A similar set of
mask /severity registers to those found in PCIe for PCIe defined protocol errors
are used for fine grained control.  Currently there are about 7
correctable and 7 uncorrectable errors in CXL r3.0
It was the CXL correctable errors that I meant to refer to with
the above comment.


> 
> > This got me thinking about why I never saw the same issue for UNC
> > errors.  Upshot, QEMU never sets the UNCOR mask so defaults to everything on
> > (it also doesn't allow anyone to write the register). Curiously it has
> > the code that uses the mask even though there was no means to set any
> > bits in it. 
> > I'll fix that (draft patch below) + we should update lspci to cover more of these AER
> > flags as it's a PITA debugging by reading the hex dumps!
> > 
> > Bjorn, is there any convention on drivers enabling these 'default' masked
> > AER errors?  Or is expectation that this is policy and userspace should
> > be dealing with it?  
> 
> I think AER configuration should generally be a system policy
> decision, not a driver-level choice (unless we need quirks to work
> around device defects, of course).

Makes sense, though we may need a second layer of system policy to
cover CXL errors - currently that's what this patch is pushing to the
driver.

> 
> We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), which turns on error reporting in Device Control for all
> devices at enumeration-time when the OS has control of AER.  But this
> is only the generic device-level control; it doesn't configure any
> *AER* registers.
> 
> I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
> some mips and powerpc arch-specific code and a few individual drivers.
> It seems like maybe pci_aer_init() should do some more configuration
> of the AER mask and severity registers.

Sounds good.  Any thoughts on where to get the policy from?
Feels like an administrator thing rather than a kernel config one
to me, so maybe pci_aer_init() is too early or we'd benefit from
a nice easy per device interface to tweak a default?

Jonathan

> 
> Bjorn

