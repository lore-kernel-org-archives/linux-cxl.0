Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FEC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 19:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiAYTSR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:18:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:47773 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbiAYTSL (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 25 Jan 2022 14:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138290; x=1674674290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0hLtylA604YuRLZ580x5CON+geQ4cf1w7KBzG0dO9uQ=;
  b=GWhwHUnmtLCKTXI3SNi4JRLloalPXsyoDr6C2pOygd3xbz05AtU7Map8
   gxZHTW1FBQ3HnuURUfF8zU+XfkTlH+dwAG1hHy75m6psWAkY+o2+iL2Gm
   TOhH6Ief7ymz5CWCWhFnR+T0AySV8kXSD18nbdyX0lL8vqheMbmTi5hIl
   cVH1SrfNc3tpbcDT9r/sKtQk/H4SVwoXEDsOgZGq3+pRk/+h43JcOmvzJ
   ES9mggPpVOS5lI3sklcpB+ent0a9zMf0luOIJYqVGxDIo6Xs4uVGO2oVb
   //a/TQPsEMUDDurVQitnZLkLfBBIHvmC0dutFRN956ZxAfxxtITQEwsdy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227066514"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="227066514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:18:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="532524278"
Received: from jungjunk-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.128.93])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:18:07 -0800
Date:   Tue, 25 Jan 2022 11:18:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 00/42] CXl 2.0 emulation Support
Message-ID: <20220125191806.ifbv2fuj2bik44zw@intel.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Really awesome work Jonathan. Dan and I are wrapping up some of the kernel bits,
so all I'll do for now is try to run this, but I hope to be able to review the
parts I'm familiar with at least.

On 22-01-24 17:16:23, Jonathan Cameron wrote:
> Previous version was RFC v3: CXL 2.0 Support.
> No longer an RFC as I would consider the vast majority of this
> to be ready for detailed review. There are still questions called
> out in some patches however.
> 
> Looking in particular for:
> * Review of the PCI interactions
> * x86 and ARM machine interactions (particularly the memory maps)
> * Review of the interleaving approach - is the basic idea
>   acceptable?
> * Review of the command line interface.
> * CXL related review welcome but much of that got reviewed
>   in earlier versions and hasn't changed substantially.
> 
> Main changes:
> * The CXL fixed memory windows are now instantiated via a
>   -cxl-fixed-memory-window command line option.  As they are host level
>   entities, not associated with a particular hardware entity a top
>   level parameter seems the most natural way to describe them.
>   This is also much closer to how it works on a real host than the
>   previous assignment of a physical address window to all components
>   along the CXL path.

Excellent.

> * Dynamic host memory physical address space allocation both for
>   the CXL host bridge MMIO space and the CFMWS windows.

I thought I had done the host bridge MMIO, but perhaps I was mistaken. Either
way, this is an important step to support all platforms more generally.

> * Interleaving support (based loosely on Philippe Mathieu-Daudé's
>   earlier work on an interleaved memory device).  Note this is rudimentary
>   and low performance but it may be sufficient for test purposes.

I'll have to look at this further. I had some thoughts about how we might make
this fast, but it would be more of fake interleaving. How low is "low"?

> * Additional PCI and memory related utility functions needed for the
>   interleaving.
> * Various minor cleanup and increase in scope of tests.
> * For now dropped the support for presenting CXL type 3 devices
>   as memory devices in various QEMU interfaces.

What are the downsides to this? I only used the memory interface originally
because it seemed like a natural fit, but looking back I'm not sure we gain
much (though my memory is very lossy).

> * Dropped the patch letting UID be different from bus_nr.  Whilst
>   it may be a useful thing to have, we don't need it for this series
>   and so should be handled separately.
> 
> I've called out patches with major changes by marking them as
> co-developed or introducing them as new patches. The original
> memory window code has been dropped
> 
> After discussions at plumbers and more recently on the mailing list
> it was clear that there was interest in getting emulation for CXL 2.0
> upstream in QEMU.  This version resolves many of the outstanding issues
> and enables the following features:
> 
> * Support on both x86/pc and ARM/virt with relevant ACPI tables
>   generated in QEMU.
> * Host bridge based on the existing PCI Expander Bridge PXB.
> * CXL fixed memory windows, allowing host to describe interleaving
>   across multiple CXL host bridges.
> * pxb-cxl CXL host bridge support including MMIO region for control
>   and HDM (Host manage device memory - basically interleaving / routing)
>   decoder configuration.
> * Basic CXL Root port support.
> * CXL Type 3 device support with persistent memory regions (backed by
>   hostmem backend).
> * Pulled MAINTAINERS entry out to a separate patch and add myself as
>   a co-maintainer at Ben's suggestion.
> 
> Big TODOs:
> 
> * Volatile memory devices (easy but it's more code so left for now).
> * Switch support.
> * Hotplug?  May not need much but it's not tested yet!
> * More tests and tighter verification that values written to hardware
>   are actually valid - stuff that real hardware would check.
> * Main host bridge support (not a priority for me...)

I originally cared about this for the sake of making a system more realistic. I
now believe we should drop this entirely.

> * Testing, testing and more testing.  I have been running a basic
>   set of ARM and x86 tests on this, but there is always room for
>   more tests and greater automation.
> 
> Why do we want QEMU emulation of CXL?
> 
> As Ben stated in V3, QEMU support has been critical to getting OS
> software written given lack of availability of hardware supporting the
> latest CXL features (coupled with very high demand for support being
> ready in a timely fashion). What has become clear since Ben's v3
> is that situation is a continuous one.  Whilst we can't talk about
> them yet, CXL 3.0 features and OS support have been prototyped on
> top of this support and a lot of the ongoing kernel work is being
> tested against these patches.
> 
> Other features on the qemu-list that build on these include PCI-DOE
> /CDAT support from the Avery Design team further showing how this
> code is useful.  Whilst not directly related this is also the test
> platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> utilizes and extends those technologies and is likely to be an early
> adopter.
> Refs:
> CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
> CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> 
> 
> As can be seen there is non trivial interaction with other areas of
> Qemu, particularly PCI and keeping this set up to date is proving
> a burden we'd rather do without :)
> 
> Ben mentioned a few other good reasons in v3:
> https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> 
> The evolution of this series perhaps leave it in a less than
> entirely obvious order and that may get tidied up in future postings.
> I'm also open to this being considered in bite sized chunks.  What
> we have here is about what you need for it to be useful for testing
> currently kernel code.
> 
> All comments welcome.
> 
> Ben - I lifted one patch from your git tree that didn't have a
> Sign-off.   hw/cxl/component Add a dumb HDM decoder handler
> Could you confirm you are happy for one to be added?

Sure.

> 
> Example of new command line (with virt ITS patches ;)
> 
> qemu-system-aarch64 -M virt,gic-version=3,cxl=on \
>  -m 4g,maxmem=8G,slots=8 \
>  ...
>  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=256M,align=256M \

Is align actually necessary here?

>  -object memory-backend-file,id=tt,share=on,mem-path=/tmp/tt.raw,size=1g \

Did you mean to put this in there? Is it somehow used internally?

>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>  -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
>  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,size=256M \
>  -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
>  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,size=256M \
>  -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
>  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,size=256M \
>  -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
>  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,size=256M \
>  -cxl-fixed-memory-window targets=cxl.1,size=4G,interleave-granularity=8k \
>  -cxl-fixed-memory-window targets=cxl.1,targets=cxl.2,size=4G,interleave-granularity=8k

I assume interleave-ways is based on the number of targets. For testing purposes
it might be nice to add the flags as well (perhaps it's there).

> 
> First CFMWS suitable for 2 way interleave, the second for 4 way (2 way
> at host level and 2 way at the host bridge).
> targets=<range of pxb-cxl uids> , multiple entries if range is disjoint.
> 
> With Ben's CXL region patches (v3 shortly) plus fixes as discussed on list,
> Linux commands to bring up a 4 way interleave is:
> 
>  cd /sys/bus/cxl/devices/
>  region=$(cat decoder0.1/create_region)
>  echo $region  > decoder0.1/create_region
>  ls -lh
>  
>  //Note the order of devices and adjust the following to make sure they
>  //are in order across the 4 root ports.  Easy to do in a tool, but
>  //not easy to paste in a cover letter.
> 
>  cd region0.1\:0
>  echo 4 > interleave_ways
>  echo mem2 > target0
>  echo mem3 > target1
>  echo mem0 > target2
>  echo mem1 > target3
>  echo $((1024<<20)) > size
>  echo 4096 > interleave_granularity
>  echo region0.1:0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Tested with devmem2 and files with known content.
> Kernel tree was based on previous version of the region patches
> from Ben with various fixes. As Dan just posted an updated version
> next job on my list is to test that.
> 
> Thanks to Shameer for his help with reviewing the new stuff before
> posting.
> 
> I'll post a git tree shortly for any who prefer that to lots
> of emails ;)
> 
> Thanks,
> 
> Jonathan

Thanks again!
Ben

[snip]


