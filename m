Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE2C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 10:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJJKa2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiJJKa1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 06:30:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167012AE5
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 03:30:23 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmFXQ0Mymz6HHqk;
        Mon, 10 Oct 2022 18:29:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 12:30:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 11:30:20 +0100
Date:   Mon, 10 Oct 2022 11:30:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>
CC:     <ira.weiny@intel.com>
Subject: Re: [PATCH v7 0/5] QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.0
Message-ID: <20221010112940.00003fc9@huawei.com>
In-Reply-To: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 7 Oct 2022 16:21:51 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Whilst I have carried on Huai-Cheng Kuo's series version numbering and
> naming, there have been very substantial changes since v6 so I would
> suggest fresh review makes sense for anyone who has looked at this before.
> In particularly if the Avery design folks could check I haven't broken
> anything that would be great.

I forgot to run checkpatch on these and there is some white space that
will need cleaning up and one instance of missing brackets.
As that doesn't greatly affect review, I'll wait for a few days to see
if there is other feedback to incorporate in v8.

Sorry for the resulting noise!

These are now available at
https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-09
along with a bunch of other CXL features:
* Compliance DOE protocol
* SPDM / CMA over DOE supprot
* ARM64 support in general.
* Various small emulation additions.
* CPMU support

I'll add a few more features to similarly named branches over the next
week or so including initial support for standalone switch CCI mailboxes.

Jonathan
 
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
> Huai-Cheng Kuo / Chris Browy, please confirm you are still happy to maintain this
> code as per the original MAINTAINERS entry.
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
> 
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
>  hw/cxl/cxl-cdat.c              | 222 ++++++++++++++++++++
>  hw/cxl/meson.build             |   1 +
>  hw/mem/cxl_type3.c             | 236 +++++++++++++++++++++
>  hw/pci-bridge/cxl_upstream.c   | 182 +++++++++++++++-
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
>  15 files changed, 1323 insertions(+), 1 deletion(-)
>  create mode 100644 hw/cxl/cxl-cdat.c
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/cxl/cxl_cdat.h
>  create mode 100644 include/hw/pci/pcie_doe.h
> 

