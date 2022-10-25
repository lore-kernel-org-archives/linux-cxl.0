Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A3ECDFA1
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiJYWau (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiJYWat (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 18:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD4444BC
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666737029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03WiWi24jZjT8M33f/iFpmzMcN+oScfZ3blTCs6cqtQ=;
        b=NlmopP8kGkASU/rHlLSzq9FBHNk6jAOrb8HsnmCO5gYzBOYzZRfI1+m53z7bLbj9OGdBth
        Ege6MXKMulLXMVlzz53nkwEDznz2AS4iEP+Qk+8pXt3YkHcO9x7rKn3HvOtrUgfaHiqPy+
        LFGkSnZm46jPJNdbZNllnUhQ7zlAALA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-s7eD5uDLMiiY1GclK39fPg-1; Tue, 25 Oct 2022 18:30:27 -0400
X-MC-Unique: s7eD5uDLMiiY1GclK39fPg-1
Received: by mail-wm1-f71.google.com with SMTP id 133-20020a1c028b000000b003c5e6b44ebaso152371wmc.9
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 15:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03WiWi24jZjT8M33f/iFpmzMcN+oScfZ3blTCs6cqtQ=;
        b=WagXIKVuB8aU3a3QCwQnz0NPAJrcLjWJTjWSnDCxeRNScam+Kmgjrrcghubq9JE5Yh
         BX50WZ7qViz0l7lis8GdALT2HSYH1qXxumd9FLBKzxIjmkVGBNO5/QZA2T1EJ5n0wM0d
         4EjRnffgmQIUXFS3AoxWNvS0gXDdkWbX6OI+ytvJJSJhSIXcuACztidzLyNEhvZCUvjM
         wB4v7QqMwVjxqEUGWTEVYg76pKttsDMXFsdt/MRrOwGywlfkCnCqtOU402U5L/+23NtW
         naKKGyXWcE2a8LG0+yCxAFY8q6q6XYToRFEXU+hpsBY/cTXnn/e33+r0bcmU7F4gNulq
         wcbw==
X-Gm-Message-State: ACrzQf1FK3oCSC/qo7OpqOpure6XsWxnHioXEumGcqCsqO9wkVy3xRz9
        uJI5D9UmLlpNeUFtMrPzfEL4ofgZoYR9QaM+wM0aivFXARjh6r1dJeEBo1hChE86XS3c9PruPcM
        4m1+9KnNIjQsu6nWRAxFd
X-Received: by 2002:a5d:4409:0:b0:236:6dac:c644 with SMTP id z9-20020a5d4409000000b002366dacc644mr10189776wrq.390.1666737026730;
        Tue, 25 Oct 2022 15:30:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5f/LlmHrsG84VTDtWqe2/yMz82K80LURMGSlYxhL7teS6xi6yPrtyUo0QfI5n60mzaPcKgHQ==
X-Received: by 2002:a5d:4409:0:b0:236:6dac:c644 with SMTP id z9-20020a5d4409000000b002366dacc644mr10189767wrq.390.1666737026450;
        Tue, 25 Oct 2022 15:30:26 -0700 (PDT)
Received: from redhat.com ([2.55.3.42])
        by smtp.gmail.com with ESMTPSA id m12-20020a05600c3b0c00b003b47ff307e1sm173185wms.31.2022.10.25.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:30:25 -0700 (PDT)
Date:   Tue, 25 Oct 2022 18:30:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Ben Widawsky <bwidawsk@kernel.org>,
        linux-cxl@vger.kernel.org,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>,
        Gregory Price <gregory.price@memverge.com>, ira.weiny@intel.com
Subject: Re: [PATCH v9 0/5] QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.
Message-ID: <20221025183007-mutt-send-email-mst@kernel.org>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
 <20221025230621.00006ccb@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221025230621.00006ccb@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Queued for next pull, thanks!

On Tue, Oct 25, 2022 at 11:06:39PM +0100, Jonathan Cameron wrote:
> 
> Hi Michael,
> 
> Any chance of this making 7.2?  Gregory has identified a bug
> in the Linux kernel support that we've reported (debug marking
> related). I don't think there are any other queries outstanding on this.
> 
> I've been holding off on sending other features to focus on
> getting this in, but given timing those will probably have to wait
> for next cycle now along with Gregory's series for volatile support
> (which we don't have OS support for yet anyway).
> 
> Thanks,
> 
> Jonathan
> 
> On Fri, 14 Oct 2022 16:10:40 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Changes since v8:
> >  - Take the entry enums out of the functions and prefix them
> >    appropriately.
> >  - Use the visibility of *_NUM_ENTRIES to allocate the cdat_table
> >  - Fix volatile_mr -> nonvolatile_mr
> > 
> > V7 Cover letter - lightly edited.
> > 
> > Whilst I have carried on Huai-Cheng Kuo's series version numbering and
> > naming, there have been very substantial changes since v6 so I would
> > suggest fresh review makes sense for anyone who has looked at this before.
> > In particularly if the Avery design folks could check I haven't broken
> > anything that would be great.
> > 
> > For reference v6: QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.0
> > https://lore.kernel.org/qemu-devel/1623330943-18290-1-git-send-email-cbrowy@avery-design.com/
> > 
> > Summary of changes:
> > 1) Linux headers definitions for DOE are now upstream so drop that patch.
> > 2) Add CDAT for switch upstream port.
> > 3) Generate 'plausible' default CDAT tables when a file is not provided.
> > 4) General refactoring to calculate the correct table sizes and allocate
> >    based on that rather than copying from a local static array.
> > 5) Changes from earlier reviews such as matching QEMU type naming style.
> > 6) Moved compliance and SPDM usecases to future patch sets.
> > 
> > Sign-offs on these are complex because the patches were originally developed
> > by Huai-Cheng Kuo, but posted by Chris Browy and then picked up by Jonathan
> > Cameron who made substantial changes.
> > 
> > Huai-Cheng Kuo confirmed they are happy to maintain this updated code.
> > 
> > What's here?
> > 
> > This series brings generic PCI Express Data Object Exchange support (DOE)
> > DOE is defined in the PCIe Base Spec r6.0. It consists of a mailbox in PCI
> > config space via a PCIe Extended Capability Structure.
> > The PCIe spec defines several protocols (including one to discover what
> > protocols a given DOE instance supports) and other specification such as
> > CXL define additional protocols using their own vendor IDs.
> > 
> > In this series we make use of the DOE to support the CXL spec defined
> > Table Access Protocol, specifically to provide access to CDAT - a
> > table specified in a specification that is hosted by the UEFI forum
> > and is used to provide runtime discoverability of the sort of information
> > that would otherwise be available in firmware tables (memory types,
> > latency and bandwidth information etc).
> > 
> > The Linux kernel gained support for DOE / CDAT on CXL type 3 EPs in 6.0.
> > The version merged did not support interrupts (earlier versions did
> > so that support in the emulation was tested a while back).
> > 
> > This series provides CDAT emulation for CXL switch upstream ports
> > and CXL type 3 memory devices. Note that to exercise the switch support
> > additional Linux kernel patches are needed.
> > https://lore.kernel.org/linux-cxl/20220503153449.4088-1-Jonathan.Cameron@huawei.com/
> > (I'll post a new version of that support shortly)
> > 
> > Additional protocols will be supported by follow on patch sets:
> > * CXL compliance protocol.
> > * CMA / SPDM device attestation.
> > (Old version at https://gitlab.com/jic23/qemu/-/commits/cxl-next - will refresh
> > that tree next week)
> > Huai-Cheng Kuo (3):
> >   hw/pci: PCIe Data Object Exchange emulation
> >   hw/cxl/cdat: CXL CDAT Data Object Exchange implementation
> >   hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange
> > 
> > Jonathan Cameron (2):
> >   hw/mem/cxl-type3: Add MSIX support
> >   hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE
> > 
> >  MAINTAINERS                    |   7 +
> >  hw/cxl/cxl-cdat.c              | 224 ++++++++++++++++++++
> >  hw/cxl/meson.build             |   1 +
> >  hw/mem/cxl_type3.c             | 264 ++++++++++++++++++++++++
> >  hw/pci-bridge/cxl_upstream.c   | 195 +++++++++++++++++-
> >  hw/pci/meson.build             |   1 +
> >  hw/pci/pcie_doe.c              | 367 +++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_cdat.h      | 166 +++++++++++++++
> >  include/hw/cxl/cxl_component.h |   7 +
> >  include/hw/cxl/cxl_device.h    |   3 +
> >  include/hw/cxl/cxl_pci.h       |   1 +
> >  include/hw/pci/pci_ids.h       |   3 +
> >  include/hw/pci/pcie.h          |   1 +
> >  include/hw/pci/pcie_doe.h      | 123 +++++++++++
> >  include/hw/pci/pcie_regs.h     |   4 +
> >  15 files changed, 1366 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/cxl/cxl-cdat.c
> >  create mode 100644 hw/pci/pcie_doe.c
> >  create mode 100644 include/hw/cxl/cxl_cdat.h
> >  create mode 100644 include/hw/pci/pcie_doe.h
> > 

