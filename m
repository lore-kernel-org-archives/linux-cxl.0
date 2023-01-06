Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D3BC4708D
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAFL0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAFL0K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 06:26:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4707631A2
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 03:26:08 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NpLZC34M5z6891V;
        Fri,  6 Jan 2023 19:23:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 6 Jan
 2023 11:26:06 +0000
Date:   Fri, 6 Jan 2023 11:26:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Stefan Roese" <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <20230106112605.00006cf6@Huawei.com>
In-Reply-To: <20230105165406.GA1150163@bhelgaas>
References: <20230105163127.00005ae2@huawei.com>
        <20230105165406.GA1150163@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 5 Jan 2023 10:54:06 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jan 05, 2023 at 04:31:27PM +0000, Jonathan Cameron wrote:
> > On Thu, 29 Dec 2022 11:27:31 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:  
> 
> > > > I realized that adding this patch still only enables error because I
> > > > didn't check the PCIe spec when writing the QEMU emulation. I had
> > > > changed the value of  "Correctable Internal Error Mask" to default
> > > > to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> > > > I thought these masks were impdef (should have checked ;)    
> > > 
> > > I assume you refer to the AER "Corrected Internal Error Mask" bit
> > > (PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
> > > bit is implemented.  
> > 
> > Spot on.  I keep confusing the correctable / corrected stuff in PCIe.
> > Made more confusing by the CXL stuff layered on top.  
> 
> Great, it wasn't confusing enough already, so CXL rectified that
> problem :)
> 
> > > We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > > native"), which turns on error reporting in Device Control for all
> > > devices at enumeration-time when the OS has control of AER.  But this
> > > is only the generic device-level control; it doesn't configure any
> > > *AER* registers.
> > > 
> > > I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
> > > some mips and powerpc arch-specific code and a few individual drivers.
> > > It seems like maybe pci_aer_init() should do some more configuration
> > > of the AER mask and severity registers.  
> > 
> > Sounds good.  Any thoughts on where to get the policy from?
> > Feels like an administrator thing rather than a kernel config one
> > to me, so maybe pci_aer_init() is too early or we'd benefit from
> > a nice easy per device interface to tweak a default?  
> 
> If we get a solid system-level policy in place and still end up
> needing some kind of administrative control, that might be OK.  But we
> don't have that solid system policy yet, so I'd like to push on that
> before adding admin interfaces.

I guess next step is a straw man proposal for people to test / shoot at.
I'll send out an RFC that enables the lot as defined in PCI r6.0
as that will be most useful for identifying quirks we need to handle.

My assumption being people will push back on some of them / we'll need
to quirk others.

Jonathan

> 
> Bjorn

