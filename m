Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD92C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 17:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJKRT0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKRTZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 13:19:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B54E63E
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 10:19:21 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mn2Xn08zxz67xWY;
        Wed, 12 Oct 2022 01:17:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 19:19:18 +0200
Received: from localhost (10.81.205.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 18:19:17 +0100
Date:   Tue, 11 Oct 2022 18:19:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Message-ID: <20221011181915.000031a1@huawei.com>
In-Reply-To: <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <20221011151744.00005278@huawei.com>
        <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Oct 2022 08:18:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:
> > On Fri, 16 Sep 2022 16:10:53 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >  
> >> Series set to RFC since there's no means to test. Would like to get opinion
> >> on whether going with using trace events as reporting mechanism is ok.
> >>
> >> Jonathan,
> >> We currently don't have any ways to test AER events. Do you have any plans
> >> to support AER events via QEMU emulation?  
> > Sorry - missed this entirely as gotten a bit behind reading CXL emails.
> >
> > Hmm. AER brings a few complexities IIRC. Can be handled either via
> > native handling in the RCEC / RP, or via GHES records, GED etc.
> >
> > I don't think it would be particularly hard to emulate either of them.
> > I have some old code for AER firmware first injection that I could
> > recycle for that side of things but that's probably less interesting
> > here than the native case.
> >
> > I have a few other things to send out as WIP first, but can have
> > a mess around with AER paths after that.  There is some support
> > already in QEMU for generic AER error injection, but we will need
> > to build on top of that to get the rest of the status in place
> > before the error is generated.  See hw/pci/pcie_aer.c
> >
> > Obviously if it's something you want to take a look at in QEMU that
> > would be great too!  
> 
> No worries. I know you are super busy. Before we go into injection, I 
> think first step is having the CXL device advertise _OSC handover of AER 
> handling? How complicated is it to have qemu advertise that?
> 
Should be trivial. Actually if the comments are right we already have
it set to say the OS can take control - which is reasonable seeing as
we haven't implemented any firmware handling yet.

https://elixir.bootlin.com/qemu/latest/source/hw/acpi/cxl.c#L193

the AML in DSDT on my ARM test machine (happened to have that running)
looks plausible though my ability to parse AML is a bit limited!

Seems to mask with 0x1f which means the firmware accepts:
Native PCI express hotplug
SHPC Native hot plug control
PCI Express Native Power Management
PCI Express Advanced Error Reporting
PCI Express Capability Structure control
if the OS asks for them.

Reject OS request for higher bit controlled things like DPC.

Absolute minimum we'd then need would be AER capability for the EP.
cxl-rp needs support but I have a feeling we already got that by
inheriting from PCIE_ROOT_PORT :)
So may just need to hook up AER at the type 3 device and then figure out
the routing to fake the result of ERR_COR and the other messages.

Obviously we'd need to fill the rest of the error stuff in at
the type 3 device or (switch :) before "sending".

Jonathan

> 
> >
> > Jonathan
> >  
> >> v2:
> >> - Convert error reporting via printk to trace events
> >> - Drop ".rmap =" initialization (Jonathan)
> >> - return PCI_ERS_RESULT_NEED_RESET for UE in pci_channel_io_normal (Shiju)
> >>
> >> Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
> >> Section 8.2.4.16 "CXL RAS Capability Structure" of the CXL rev3.0
> >> specification defines the error sources considered in this
> >> implementation. The RAS Capability Structure defines protocol, link and
> >> internal errors which are distinct from memory poison errors that are
> >> conveyed via direct consumption and/or media scanning.
> >>
> >> The errors reported by the RAS registers are categorized into
> >> correctable and uncorrectable errors, where the uncorrectable errors are
> >> optionally steered to either fatal or non-fatal AER events. Table 12-2
> >> "Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
> >> rev3.0 specification outlines that the remediation for uncorrectable errors
> >> is a reset to recover. This matches how the Linux PCIe AER core treats
> >> uncorrectable errors as occasions to reset the device to recover
> >> operation.
> >>
> >> While the specification notes "CXL Reset" or "Secondary Bus Reset" as
> >> theoretical recovery options, they are not feasible in practice since
> >> in-flight CXL.mem operations may not terminate and cause knock-on system
> >> fatal events. Reset is only reliable for recovering CXL.io, it is not
> >> reliable for recovering CXL.mem. Assuming the system survives, a reset
> >> causes CXL.mem operation to restart from scratch.
> >>
> >> The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
> >> recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
> >> least provide a mechanism for the Root Port to terminate in flight
> >> CXL.mem operations with completions. That still poses problems in
> >> practice if the kernel is running out of "System RAM" backed by the CXL
> >> device and poison is used to convey the data lost to the protocol error.
> >>
> >> Regardless of whether the reset and restart of CXL.mem operations is
> >> feasible / successful, the logging is still useful. So, the
> >> implementation reads, reports, and clears the status in the RAS
> >> Capability Structure registers, and it notifies the 'struct cxl_memdev'
> >> associated with the given PCIe endpoint to reattach to its driver over
> >> the reset so that the HDM decoder configuration can be reconstructed.
> >>
> >> The first half of the series reworks component register mapping so that
> >> the cxl_pci driver can own the RAS Capability while the cxl_port driver
> >> continues to own the HDM Decoder Capability. The last half implements
> >> the RAS Capability Structure mapping and reporting via 'struct
> >> pci_error_handlers'.
> >>
> >> The reporting of error information is done through event tracing. A new
> >> cxl_ras event is introduced to report the Uncorrectable and Correctable
> >> errors raised by CXL. The expectation is a monitoring user daemon such as
> >> "cxl monitor" will harvest those events and record them in a log in a
> >> format (JSON) that's consumable by management applications..
> >>
> >> [1]: https://www.computeexpresslink.org/spec-landing
> >>
> >> ---
> >>
> >> Dan Williams (8):
> >>        cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
> >>        cxl/pci: Cleanup cxl_map_device_regs()
> >>        cxl/pci: Kill cxl_map_regs()
> >>        cxl/core/regs: Make cxl_map_{component, device}_regs() device generic
> >>        cxl/port: Limit the port driver to just the HDM Decoder Capability
> >>        cxl/pci: Prepare for mapping RAS Capability Structure
> >>        cxl/pci: Find and map the RAS Capability Structure
> >>        cxl/pci: Add (hopeful) error handling support
> >>
> >> Dave Jiang (1):
> >>        cxl/pci: add tracepoint events for CXL RAS
> >>
> >>
> >>   drivers/cxl/core/hdm.c         |  33 ++---
> >>   drivers/cxl/core/memdev.c      |   1 +
> >>   drivers/cxl/core/pci.c         |   3 +-
> >>   drivers/cxl/core/port.c        |   2 +-
> >>   drivers/cxl/core/regs.c        | 172 +++++++++++++++-----------
> >>   drivers/cxl/cxl.h              |  39 ++++--
> >>   drivers/cxl/cxlmem.h           |   2 +
> >>   drivers/cxl/cxlpci.h           |   9 --
> >>   drivers/cxl/pci.c              | 216 +++++++++++++++++++++++++++------
> >>   include/trace/events/cxl_ras.h | 117 ++++++++++++++++++
> >>   10 files changed, 445 insertions(+), 149 deletions(-)
> >>   create mode 100644 include/trace/events/cxl_ras.h
> >>
> >> --
> >>  
> 

