Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B450C04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiJYPYt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiJYPYa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 11:24:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142432049
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666711391; x=1698247391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1EAHUz0hZG9xrFQrLxZEijPmJln/G6/Efgs8lVkhFyU=;
  b=hN4gi2la7WvHsLqI/KldFDgXz5yIjyBK6UepmqCE//hbHl35vMYGY51a
   wHrulI4o1jepgbP7O9NZBvd65MI7xJpxsNoBxNhz67y3+nC2vnYXkaOVg
   kc+9xPSC/dAnHz6mYJR9wneNgWwYA3CJvmVSI41gi5Is9svjUusSguyOi
   z8r2hVUOxUscq0raOZaZfFi/uscZ9Fnve1GTnON/j1skjwSIwCu/Wg7ex
   3RjLORK+e31iVaIku4pVCMHn7pZNYJFiGn0hiEo7e6sspPZAZxePCnCF0
   ZZobr3qQxeWdntgoBVmVsexz20eCjfp1OKu1D1eoqWcsy7lmem5aTnnOC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369773159"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="369773159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:23:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631667227"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="631667227"
Received: from sagarpha-mobl.amr.corp.intel.com (HELO [10.212.108.126]) ([10.212.108.126])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:22:56 -0700
Message-ID: <e2ecfdc9-28ec-e4ca-6a09-8b99e82311bf@intel.com>
Date:   Tue, 25 Oct 2022 08:22:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <20221011151744.00005278@huawei.com>
 <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
 <20221011181915.000031a1@huawei.com> <20221019183012.00007201@huawei.com>
 <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
 <20221024170102.00000c4b@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221024170102.00000c4b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/24/2022 9:01 AM, Jonathan Cameron wrote:
> On Wed, 19 Oct 2022 10:38:13 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> On 10/19/2022 10:30 AM, Jonathan Cameron wrote:
>>> On Tue, 11 Oct 2022 18:19:15 +0100
>>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>>   
>>>> On Tue, 11 Oct 2022 08:18:34 -0700
>>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>>   
>>>>> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:
>>>>>> On Fri, 16 Sep 2022 16:10:53 -0700
>>>>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>>>>        
>>>>>>> Series set to RFC since there's no means to test. Would like to get opinion
>>>>>>> on whether going with using trace events as reporting mechanism is ok.
>>>>>>>
>>>>>>> Jonathan,
>>>>>>> We currently don't have any ways to test AER events. Do you have any plans
>>>>>>> to support AER events via QEMU emulation?
>>>>>> Sorry - missed this entirely as gotten a bit behind reading CXL emails.
>>> Hi Dave,
>>>
>>> Quick update.
>>>
>>> Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
>>> figuring out why I wasn't getting messages past the upstream switch port.
>>> Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
>>> that patch isn't upstream yet.
>>> Also QEMU AER rooting seems to be based on some older PCIE spec
>>> so needed some tweaks to get the device to actually issue ERR_FATAL etc.
>>>
>>> Anyhow, should have something you can play with in a day or two.
>> Awesome! Thanks! :)
> Took a little longer than expected..
>
> Anyhow, now at
> https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-24

Thank you! I'll try this out as soon as I get a chance.

>
> That tree is carrying far too many things right now for it make much sense
> to me to email this to qemu-devel - though I may pull
> hw/pci/aer: Add missing routing for AER errors
> out in advance as that's closing a spec different between QEMU emulation of AER
> and what the PCI spec says.
>
> Hopefully set of out of tree patches will start to shrink soon - v9 of the DOE
> patches have been on list for a week or so.
>
> Top patch includes a very short 'how to' in patch description.  Basically fire
> up QMP: Add something like -qmp tcp:localhost:444,server=on,wait=off to your
> qemu commandline and use commands like:
>
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-error",
>      "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "type": "cache-address-parity",
>          "header": [ 3, 4]
>      } }
> ...
> { "execute": "cxl-inject-correctable-error",
>      "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "type": "physical",
>          "header": [ 3, 4]
>      } }
>
>
>
>>
>>> In meantime an example dump (not writing the header log yet!)
>>>
>>> pcieport 0000:0c:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:0f:00.0
>>> cxl_pci 0000:0f:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>>> cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
>>> cxl_pci 0000:0f:00.0:    [14] CmpltTO                (First)
>>> cxl_ras_uc: mem3: status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error' header log: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
>>> cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
>>> cxl_port endpoint6: No CMA mailbox
>>> cxl_pci 0000:0f:00.0: mem3: error resume successful
>>> pcieport 0000:0e:00.0: AER: device recovery successful
>>>
>>> Jonathan
