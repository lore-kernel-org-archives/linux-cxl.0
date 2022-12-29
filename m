Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC85FC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Dec 2022 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiL2Rak (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiL2R3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Dec 2022 12:29:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC7175AC
        for <linux-cxl@vger.kernel.org>; Thu, 29 Dec 2022 09:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF67FB81A1D
        for <linux-cxl@vger.kernel.org>; Thu, 29 Dec 2022 17:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C40DC433EF;
        Thu, 29 Dec 2022 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334853;
        bh=jfF501M0KjbHvRkP/ft1dr3kk6cacdstv4Emyou4Wno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ga02GAqVvCHI6vqRt5E73/+oK+77EOJRXbJ4pKtbeFAmAInSj17LxjQ8tLWmlRGky
         ZbSiP4le0cAuPEknM+ZA/vYM56sb4KV6CQ80jUNtfXm5BWKb80sOHVyJC6khPR5o++
         O6r95UEbWc7dGFq2gOLNXVhbRLDZt+jiazg72/SDQvxRvNVgrkhj0Pk1VqX1iCJLQM
         gZ0hUvkURHKLNRjJobEiXe34529iWSlxdnyu6qRPTaDkmaZROUgdCNcjRZ0leL03Tj
         j6bEfc2KlinUsmddPTzAnhOjivmwmfE/IibPU2wH7ZB20jkvMPNn2ZCAp5ccVd2FdZ
         iG8IzwtJ8mO8A==
Date:   Thu, 29 Dec 2022 11:27:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Message-ID: <20221229172731.GA611562@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217175204.0000170a@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

[+cc Stefan, Kuppuswamy]

On Sat, Dec 17, 2022 at 05:52:04PM +0000, Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 09:10:02 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.

> +CC Bjorn for a question on the AER control element of this.

Timely question (unlike my response, sorry, I've been on vacation).

> I realized that adding this patch still only enables error because I
> didn't check the PCIe spec when writing the QEMU emulation. I had
> changed the value of  "Correctable Internal Error Mask" to default
> to unmasked.  PCIe 6.0 says it defaults to masked.  For some reason
> I thought these masks were impdef (should have checked ;)

I assume you refer to the AER "Corrected Internal Error Mask" bit
(PCIe r6.0, sec 7.8.4.6), which indeed defaults to 1b (masked) if the
bit is implemented.

> I'll drop that change in QEMU, but upshot is that if we want the
> correctable ones to be delivered, we'll need to clear that bit as
> well as the ones you do in this patch.

I don't think Corrected Internal Error Mask affects reporting of other
Correctable Errors, e.g., Receiver Error, Bad TLP, Bad DLLP, etc.  As
I read sec 6.2.10, those would not be classified as "internal" errors.

> This got me thinking about why I never saw the same issue for UNC
> errors.  Upshot, QEMU never sets the UNCOR mask so defaults to everything on
> (it also doesn't allow anyone to write the register). Curiously it has
> the code that uses the mask even though there was no means to set any
> bits in it. 
> I'll fix that (draft patch below) + we should update lspci to cover more of these AER
> flags as it's a PITA debugging by reading the hex dumps!
> 
> Bjorn, is there any convention on drivers enabling these 'default' masked
> AER errors?  Or is expectation that this is policy and userspace should
> be dealing with it?

I think AER configuration should generally be a system policy
decision, not a driver-level choice (unless we need quirks to work
around device defects, of course).

We now have f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), which turns on error reporting in Device Control for all
devices at enumeration-time when the OS has control of AER.  But this
is only the generic device-level control; it doesn't configure any
*AER* registers.

I'm surprised to learn that the only writes to PCI_ERR_UNCOR_MASK are
some mips and powerpc arch-specific code and a few individual drivers.
It seems like maybe pci_aer_init() should do some more configuration
of the AER mask and severity registers.

Bjorn
