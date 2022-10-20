Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91860C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 14:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTO7W (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJTO7Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 10:59:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7C1CB505
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666277954; x=1697813954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jSf2v1su90njiK2T43DpTxlm2WCCEFviYpZITaLXSZM=;
  b=MeCKtECOQssKONfULUUAfnUEJkVQ4KSIG+UUFmlkJXpav76Ignuf0etE
   eEEiVWmDoAGB/9VYbNzNO5BGqUdPS89Cl5nox5gJpKDPab8Ce/5fwhVBd
   wYJo+jxeALg3q1ojJqNZLaudQJqteBsKuC5DrA2nrhoJkmexhVYk1twWB
   wOr5WSLvnVJSAl2GfuNrqsHlQ7cC7iIh05bu1yA/YaXCtXzmKPFAeYs2U
   jfR9mg78y+SwfDN0fqNjbyp7CM0AnrNhG/w5mKr74rkw/Z0NghteOvmpt
   L51cx3u5Rlq6rva4foyrX7jmaYXptHUsamfc+mDwj1mGTSizG8AtOaCJZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306723242"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="306723242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:50:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="958976128"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="958976128"
Received: from ekfraser-mobl1.amr.corp.intel.com (HELO [10.212.65.105]) ([10.212.65.105])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:50:04 -0700
Message-ID: <80592639-de80-c20c-b894-d2d0672fa845@intel.com>
Date:   Thu, 20 Oct 2022 07:50:03 -0700
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
 <20221020144530.00000201@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221020144530.00000201@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/20/2022 6:45 AM, Jonathan Cameron wrote:
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
> ...
>
>> +/* CXL spec rev3.0 8.2.4.16.1 */
>> +#define DATA_HEADER_SIZE 16
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
> I'd forgotten his gremlin.
>
> You can't use memcpy_fromio() because on some architectures it will issue 8 byte
> reads and 8.2.4.16.7 states that the log shall be accessed as aligned 4-byte
> quantities.
Ok I'll fix.
>
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
> Also not valid for same reason.  Do a 32bit read and mask out the bottom byte.

Will fix. Thanks.


>
> That was a pain to track down (and worst of all we hit the same thing for another
> bit of CXL last year I'd forgotten about it :(
>
>> +		return sizeof(u8);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
