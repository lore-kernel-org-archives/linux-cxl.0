Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E85C3DA7D
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 16:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAEQyN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjAEQyM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 11:54:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476D200D
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 08:54:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F980B81B35
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 16:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A1BC433EF;
        Thu,  5 Jan 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672937649;
        bh=ELO4eqWCmqDuN0y0Y4IEOKoda00uAzOV/BhbMOVfErg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tqRJcx6kuxqdlQuLGyvOA2GcBEIftA5/zMij0ahujuLdz4YXECOaDOwr+JkybOYhL
         k65aFnkORPhFC0N2cPd2Qg3p6w5Bh8VMYTm5XtthsbbyqhUrixdqx06ekaUtf+PdVC
         D/JyAQSeV+kbVIwF+nYCptGbW4Jou8DM0MPoqjHPye773BKXNh7Q6HvnLa4+r0nF+o
         qlMy2uOaKN67ZxsUR9XMWlIXE7kMdAIDbA8tuxQTIa3xe03A7egzDIHI3M2UiNIzSz
         vYQ1rabYaZ3sVNdpSyONxGAwQ6vcIi8C7L8TVpOenzNlkkITmPQICsTn1L8ABgK2kr
         GqHaLztVXK5zA==
Date:   Thu, 5 Jan 2023 10:54:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <20230105165406.GA1150163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105163127.00005ae2@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 05, 2023 at 04:31:27PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Dec 2022 11:27:31 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:

> > > I realized that adding this patch still only enables error because I
> > > didn't check the PCIe spec when writing the QEMU emulation. I had
> > > changed the value of  "Correctable Internal Error Mask" to default
> > > to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> > > I thought these masks were impdef (should have checked ;)  
> > 
> > I assume you refer to the AER "Corrected Internal Error Mask" bit
> > (PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
> > bit is implemented.
> 
> Spot on.  I keep confusing the correctable / corrected stuff in PCIe.
> Made more confusing by the CXL stuff layered on top.

Great, it wasn't confusing enough already, so CXL rectified that
problem :)

> > We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > native"), which turns on error reporting in Device Control for all
> > devices at enumeration-time when the OS has control of AER.  But this
> > is only the generic device-level control; it doesn't configure any
> > *AER* registers.
> > 
> > I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
> > some mips and powerpc arch-specific code and a few individual drivers.
> > It seems like maybe pci_aer_init() should do some more configuration
> > of the AER mask and severity registers.
> 
> Sounds good.  Any thoughts on where to get the policy from?
> Feels like an administrator thing rather than a kernel config one
> to me, so maybe pci_aer_init() is too early or we'd benefit from
> a nice easy per device interface to tweak a default?

If we get a solid system-level policy in place and still end up
needing some kind of administrative control, that might be OK.  But we
don't have that solid system policy yet, so I'd like to push on that
before adding admin interfaces.

Bjorn
