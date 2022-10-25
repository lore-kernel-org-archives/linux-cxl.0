Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58750FA373D
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiJYWGw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiJYWGu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 18:06:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FB7284D
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 15:06:47 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxmGB16vyz6HJVH;
        Wed, 26 Oct 2022 06:05:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 00:06:44 +0200
Received: from localhost (10.45.158.174) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 23:06:43 +0100
Date:   Tue, 25 Oct 2022 23:06:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>,
        "Gregory Price" <gregory.price@memverge.com>, <ira.weiny@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v9 0/5] QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.
Message-ID: <20221025230621.00006ccb@huawei.com>
In-Reply-To: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.158.174]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Hi Michael,

Any chance of this making 7.2?  Gregory has identified a bug
in the Linux kernel support that we've reported (debug marking
related). I don't think there are any other queries outstanding on this.

I've been holding off on sending other features to focus on
getting this in, but given timing those will probably have to wait
for next cycle now along with Gregory's series for volatile support
(which we don't have OS support for yet anyway).

Thanks,

Jonathan

On Fri, 14 Oct 2022 16:10:40 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Changes since v8:
>  - Take the entry enums out of the functions and prefix them
>    appropriately.
>  - Use the visibility of *_NUM_ENTRIES to allocate the cdat_table
>  - Fix volatile_mr -> nonvolatile_mr
> 
> V7 Cover letter - lightly edited.
> 
> Whilst I have carried on Huai-Cheng Kuo's series version numbering and
> naming, there have been very substantial changes since v6 so I would
> suggest fresh review makes sense for anyone who has looked at this before.
> In particularly if the Avery design folks could check I haven't broken
> anything that would be great.
> 
> For reference v6: QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.0
> https://lore.kernel.org/qemu-devel/1623330943-18290-1-git-send-email-cbrowy@avery-design.com/
> 
> Summary of changes:
> 1) Linux headers definitions for DOE are now upstream so drop that patch.
> 2) Add CDAT for switch upstream port.
> 3) Generate 'plausible' default CDAT tables when a file is not provided.
> 4) General refactoring to calculate the correct table sizes and allocate
>    based on that rather than copying from a local static array.
> 5) Changes from earlier reviews such as matching QEMU type naming style.
> 6) Moved compliance and SPDM usecases to future patch sets.
> 
> Sign-offs on these are complex because the patches were originally developed
> by Huai-Cheng Kuo, but posted by Chris Browy and then picked up by Jonathan
> Cameron who made substantial changes.
> 
> Huai-Cheng Kuo confirmed they are happy to maintain this updated code.
> 
> What's here?
> 
> This series brings generic PCI Express Data Object Exchange support (DOE)
> DOE is defined in the PCIe Base Spec r6.0. It consists of a mailbox in PCI
> config space via a PCIe Extended Capability Structure.
> The PCIe spec defines several protocols (including one to discover what
> protocols a given DOE instance supports) and other specification such as
> CXL define additional protocols using their own vendor IDs.
> 
> In this series we make use of the DOE to support the CXL spec defined
> Table Access Protocol, specifically to provide access to CDAT - a
> table specified in a specification that is hosted by the UEFI forum
> and is used to provide runtime discoverability of the sort of information
> that would otherwise be available in firmware tables (memory types,
> latency and bandwidth information etc).
> 
> The Linux kernel gained support for DOE / CDAT on CXL type 3 EPs in 6.0.
> The version merged did not support interrupts (earlier versions did
> so that support in the emulation was tested a while back).
> 
> This series provides CDAT emulation for CXL switch upstream ports
> and CXL type 3 memory devices. Note that to exercise the switch support
> additional Linux kernel patches are needed.
> https://lore.kernel.org/linux-cxl/20220503153449.4088-1-Jonathan.Cameron@huawei.com/
> (I'll post a new version of that support shortly)
> 
> Additional protocols will be supported by follow on patch sets:
> * CXL compliance protocol.
> * CMA / SPDM device attestation.
> (Old version at https://gitlab.com/jic23/qemu/-/commits/cxl-next - will refresh
> that tree next week)
> Huai-Cheng Kuo (3):
>   hw/pci: PCIe Data Object Exchange emulation
>   hw/cxl/cdat: CXL CDAT Data Object Exchange implementation
>   hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange
> 
> Jonathan Cameron (2):
>   hw/mem/cxl-type3: Add MSIX support
>   hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE
> 
>  MAINTAINERS                    |   7 +
>  hw/cxl/cxl-cdat.c              | 224 ++++++++++++++++++++
>  hw/cxl/meson.build             |   1 +
>  hw/mem/cxl_type3.c             | 264 ++++++++++++++++++++++++
>  hw/pci-bridge/cxl_upstream.c   | 195 +++++++++++++++++-
>  hw/pci/meson.build             |   1 +
>  hw/pci/pcie_doe.c              | 367 +++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_cdat.h      | 166 +++++++++++++++
>  include/hw/cxl/cxl_component.h |   7 +
>  include/hw/cxl/cxl_device.h    |   3 +
>  include/hw/cxl/cxl_pci.h       |   1 +
>  include/hw/pci/pci_ids.h       |   3 +
>  include/hw/pci/pcie.h          |   1 +
>  include/hw/pci/pcie_doe.h      | 123 +++++++++++
>  include/hw/pci/pcie_regs.h     |   4 +
>  15 files changed, 1366 insertions(+), 1 deletion(-)
>  create mode 100644 hw/cxl/cxl-cdat.c
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/cxl/cxl_cdat.h
>  create mode 100644 include/hw/pci/pcie_doe.h
> 

