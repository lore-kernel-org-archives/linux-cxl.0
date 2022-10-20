Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153FDC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 15:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJTPC4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJTPCy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 11:02:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD41C8413
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666278173; x=1697814173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6GApd8pz0qGomGUBJomk2CQUF0UFsyFa+znsgjvUGNU=;
  b=BAe11PAtBUxy6vsBPK88gwtoTaN+D6Z6kRgCf6mUnIPkRfNxAbGsSO4y
   MKVFRABxQDGYZdpYWEfSFPeczPE4+oLzW0DE3ed7xWjFmpudOBt9kv65t
   yI+stk0ovKRI/RYBGKYk3qcLKauTQXTlkPvOLJDtEND28WuNrPQOeP3tg
   /1MXEZ4L4A7BN6di6wBup1g4Pn5Ote8iJiwfD9khnUb/C+jVHYlCFd5nk
   O4z4qKgQZB9dRQV1u52JeyGyIDuokun1+yRNKH1hbARMGv6zhD6ZW2Ii9
   3TZBZWrTI4Kgwrn+/dSGnHe6l2olVx03Gt9ZfZ6jtGqFGktsHZbGz8f3B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333300969"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="333300969"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:57:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693030361"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="693030361"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.65.105]) ([10.212.65.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:57:47 -0700
Message-ID: <dd9a237f-ba28-7525-b8ac-ee31961004a6@intel.com>
Date:   Thu, 20 Oct 2022 07:57:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
 <20221020150320.00006553@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221020150320.00006553@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/20/2022 7:03 AM, Jonathan Cameron wrote:
> On Fri, 16 Sep 2022 16:11:45 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Add nominal error handling that tears down CXL.mem in response to error
>> notifications that imply a device reset. Given some CXL.mem may be
>> operating as System RAM, there is a high likelihood that these error
>> events are fatal. However, if the system survives the notification the
>> expectation is that the driver behavior is equivalent to a hot-unplug
>> and re-plug of an endpoint.
>>
>> Note that this does not change the mask values from the default. That
>> awaits CXL _OSC support to determine whether platform firmware is in
>> control of the mask registers.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   
>> +/* CXL spec rev3.0 8.2.4.16.1 */
>> +#define DATA_HEADER_SIZE 16
> I'm not immediately seeing a spec justification for these sizes.
> The table refes to containing H2D or D2H headers.
> Jumping back to 3.2.3.3 D2H Data
> The D2H Data Header is between 17 and 24 bits (assuming PBR irrelevant here)
> H2D header is 24 to 28 bits.
>
> So where does 16 bytes come from?  I'd be tempted to just spit out the whole
> 512 bit register in 32 bit chunks and leave interpretation of it to userspace.

Fair enough. That would make the kernel code simpler.


>
>
>> +#define FLIT_SIZE (64 + 2)
>> +static int header_log_setup(struct cxl_dev_state *cxlds, u32 fe, u8 *log)
>> +{
>> +	void __iomem *addr;
>> +
>> +	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
>> +
>> +	if (fe & CXL_RAS_UC_CACHE_DATA_PARITY || fe & CXL_RAS_UC_CACHE_ADDR_PARITY ||
>> +	    fe & CXL_RAS_UC_CACHE_BE_PARITY || fe & CXL_RAS_UC_CACHE_DATA_ECC ||
>> +	    fe & CXL_RAS_UC_MEM_DATA_PARITY || fe & CXL_RAS_UC_MEM_ADDR_PARITY ||
>> +	    fe & CXL_RAS_UC_MEM_BE_PARITY || fe & CXL_RAS_UC_MEM_DATA_ECC) {
>> +		memcpy_fromio(log, addr, DATA_HEADER_SIZE);
>> +		return DATA_HEADER_SIZE;
>> +	}
>> +
>> +	if (fe & CXL_RAS_UC_RSVD_ENCODE) {
>> +		memcpy_fromio(log, addr, FLIT_SIZE);
>> +		return FLIT_SIZE;
>> +	}
>> +
>> +	if (fe & CXL_RAS_UC_RECV_OVERFLOW) {
>> +		*log = readb(addr);
>> +		return sizeof(u8);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
