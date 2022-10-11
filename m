Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C08FC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 15:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiJKP3r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJKP3K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 11:29:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C7F87F2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665501572; x=1697037572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y1yjhe8olM/DFdjUB47h+vY+fQqp0ZlEwQb0EM/zyPs=;
  b=giTrzVBGALxbx1Y0GSkHx25kdVS3swKhwmVqOgTkgsCdwI/Tp4YyV9Cm
   OL9AvvPR4v4aW088pxKpGvfrdXPEfFnCa4ELQ0S4r5r5B09osffnan5jn
   ceQTApqR6AU7GdDp3lpH06i6D5xTXZAQ7c3N7CgxpFgZzu+da90JSUQzk
   nnQHXHeIW5ssRS2rFfEEcFlKwEG5DDBNWm/CoCGTmAA9BOWkhZgS6EdWp
   u3qCqf6YTn4DvXhzWv38oXcoKllqmxE0cyWBTVp2K/MxBPdLFGs5eO02s
   4E1Te0yfOmoIrBnsiFKHON8eTb9Bb6GSJST+4bnA8Auqmsb0gjb14eqRz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="390836197"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="390836197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 08:18:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="768832758"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="768832758"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.164.137]) ([10.213.164.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 08:18:35 -0700
Message-ID: <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
Date:   Tue, 11 Oct 2022 08:18:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <20221011151744.00005278@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221011151744.00005278@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/11/2022 7:17 AM, Jonathan Cameron wrote:
> On Fri, 16 Sep 2022 16:10:53 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Series set to RFC since there's no means to test. Would like to get opinion
>> on whether going with using trace events as reporting mechanism is ok.
>>
>> Jonathan,
>> We currently don't have any ways to test AER events. Do you have any plans
>> to support AER events via QEMU emulation?
> Sorry - missed this entirely as gotten a bit behind reading CXL emails.
>
> Hmm. AER brings a few complexities IIRC. Can be handled either via
> native handling in the RCEC / RP, or via GHES records, GED etc.
>
> I don't think it would be particularly hard to emulate either of them.
> I have some old code for AER firmware first injection that I could
> recycle for that side of things but that's probably less interesting
> here than the native case.
>
> I have a few other things to send out as WIP first, but can have
> a mess around with AER paths after that.  There is some support
> already in QEMU for generic AER error injection, but we will need
> to build on top of that to get the rest of the status in place
> before the error is generated.  See hw/pci/pcie_aer.c
>
> Obviously if it's something you want to take a look at in QEMU that
> would be great too!

No worries. I know you are super busy. Before we go into injection, I 
think first step is having the CXL device advertise _OSC handover of AER 
handling? How complicated is it to have qemu advertise that?


>
> Jonathan
>
>> v2:
>> - Convert error reporting via printk to trace events
>> - Drop ".rmap =" initialization (Jonathan)
>> - return PCI_ERS_RESULT_NEED_RESET for UE in pci_channel_io_normal (Shiju)
>>
>> Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
>> Section 8.2.4.16 "CXL RAS Capability Structure" of the CXL rev3.0
>> specification defines the error sources considered in this
>> implementation. The RAS Capability Structure defines protocol, link and
>> internal errors which are distinct from memory poison errors that are
>> conveyed via direct consumption and/or media scanning.
>>
>> The errors reported by the RAS registers are categorized into
>> correctable and uncorrectable errors, where the uncorrectable errors are
>> optionally steered to either fatal or non-fatal AER events. Table 12-2
>> "Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
>> rev3.0 specification outlines that the remediation for uncorrectable errors
>> is a reset to recover. This matches how the Linux PCIe AER core treats
>> uncorrectable errors as occasions to reset the device to recover
>> operation.
>>
>> While the specification notes "CXL Reset" or "Secondary Bus Reset" as
>> theoretical recovery options, they are not feasible in practice since
>> in-flight CXL.mem operations may not terminate and cause knock-on system
>> fatal events. Reset is only reliable for recovering CXL.io, it is not
>> reliable for recovering CXL.mem. Assuming the system survives, a reset
>> causes CXL.mem operation to restart from scratch.
>>
>> The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
>> recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
>> least provide a mechanism for the Root Port to terminate in flight
>> CXL.mem operations with completions. That still poses problems in
>> practice if the kernel is running out of "System RAM" backed by the CXL
>> device and poison is used to convey the data lost to the protocol error.
>>
>> Regardless of whether the reset and restart of CXL.mem operations is
>> feasible / successful, the logging is still useful. So, the
>> implementation reads, reports, and clears the status in the RAS
>> Capability Structure registers, and it notifies the 'struct cxl_memdev'
>> associated with the given PCIe endpoint to reattach to its driver over
>> the reset so that the HDM decoder configuration can be reconstructed.
>>
>> The first half of the series reworks component register mapping so that
>> the cxl_pci driver can own the RAS Capability while the cxl_port driver
>> continues to own the HDM Decoder Capability. The last half implements
>> the RAS Capability Structure mapping and reporting via 'struct
>> pci_error_handlers'.
>>
>> The reporting of error information is done through event tracing. A new
>> cxl_ras event is introduced to report the Uncorrectable and Correctable
>> errors raised by CXL. The expectation is a monitoring user daemon such as
>> "cxl monitor" will harvest those events and record them in a log in a
>> format (JSON) that's consumable by management applications..
>>
>> [1]: https://www.computeexpresslink.org/spec-landing
>>
>> ---
>>
>> Dan Williams (8):
>>        cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
>>        cxl/pci: Cleanup cxl_map_device_regs()
>>        cxl/pci: Kill cxl_map_regs()
>>        cxl/core/regs: Make cxl_map_{component, device}_regs() device generic
>>        cxl/port: Limit the port driver to just the HDM Decoder Capability
>>        cxl/pci: Prepare for mapping RAS Capability Structure
>>        cxl/pci: Find and map the RAS Capability Structure
>>        cxl/pci: Add (hopeful) error handling support
>>
>> Dave Jiang (1):
>>        cxl/pci: add tracepoint events for CXL RAS
>>
>>
>>   drivers/cxl/core/hdm.c         |  33 ++---
>>   drivers/cxl/core/memdev.c      |   1 +
>>   drivers/cxl/core/pci.c         |   3 +-
>>   drivers/cxl/core/port.c        |   2 +-
>>   drivers/cxl/core/regs.c        | 172 +++++++++++++++-----------
>>   drivers/cxl/cxl.h              |  39 ++++--
>>   drivers/cxl/cxlmem.h           |   2 +
>>   drivers/cxl/cxlpci.h           |   9 --
>>   drivers/cxl/pci.c              | 216 +++++++++++++++++++++++++++------
>>   include/trace/events/cxl_ras.h | 117 ++++++++++++++++++
>>   10 files changed, 445 insertions(+), 149 deletions(-)
>>   create mode 100644 include/trace/events/cxl_ras.h
>>
>> --
>>
