Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BEEC636CC
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 22:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBGWXA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBGWW5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 17:22:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672F71042C
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675808573; x=1707344573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qVprWDLKvevW5+DwfLA6YAimCc/kcIgFtEcN77jioao=;
  b=T688/gkI4cfI2zAxTD/q8r4pIJuZz/PzQiDaY4YS95+ebuVBeyIhEIUu
   5vGa+nav3xRRuHxPM/wA2L9QRNG2wwKLXTH6uqkkUYLUbB4Rp1IYee6oH
   TzzGIDSyojJB7yhn1h58XzUkZYKqJIK+o06MvmniAOyL9fmkmUdF2q7Z2
   C5ryv+40evEiwKxrhflXSJ51r/q3N1Fc50I/5B7mwbLfUQRhD8qi/x+9S
   vJmFAItN7WqB5p3mf/mtRuT1yCvBjhwc81TZ0crG1r2MLdNH008re/X98
   XHq9jEQFJerAyH7aB4UW7oeEo9WcJa+/5TYEpwxdDIidlUhuhq7Z98dwp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415864873"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="415864873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:22:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697435537"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="697435537"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:22:52 -0800
Message-ID: <3ef63f7b-7ea0-607d-0a16-f6f3fbb94905@intel.com>
Date:   Tue, 7 Feb 2023 15:22:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, jonathan.cameron@huawei.com
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406530747.1455071.6556733331321082239.stgit@djiang5-mobl3.local>
 <63e2c8d4bcc4d_e3dae2947d@dwillia2-xfh.jf.intel.com.notmuch>
 <63e2c9933a27e_e3dae29415@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63e2c9933a27e_e3dae29415@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/7/23 2:58 PM, Dan Williams wrote:
> Dan Williams wrote:
>> Dave Jiang wrote:
>>> There are 2 scenarios that requires additional handling. 1. A device that
>>> has active ranges in DVSEC range registers (RR) but no HDM decoder register
>>> block. 2. A device that has both RR active and HDM, but the HDM decoders
>>> are not programmed. The goal is to create emulated decoder software structs
>>> based on the RR.
>>>
>>> Move the CXL DVSEC range register decoding code block from
>>> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
>>> the HDM decoder emulation.  There is no functionality change to the code.
>>> Name the new function to cxl_dvsec_rr_decode().
>>>
>>> The only change is to set range->start and range->end to CXL_RESOURCE_NONE
>>> and skipping the reading of base registers if the range size is 0, which
>>> equates to range not active.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ---
>>> v2:
>>> - Refactor to continue when size is 0. (Jonathan)
>>> ---
>>>   drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
>>>   1 file changed, 40 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 57764e9cd19d..a8ecc6ddb3d7 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>> [..]
>>> @@ -410,6 +400,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>>>   			return rc;
>>>   
>>>   		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>>> +		if (!size) {
>>> +			info->dvsec_range[i] = (struct range) {
>>> +				.start = CXL_RESOURCE_NONE,
>>> +				.end = CXL_RESOURCE_NONE,
>>> +			};
>>
>> This should just be .start = 0, and .end = -1, or .start =
>> CXL_RESOURCE_NONE, and .end = CXL_RESOURCE_NONE - 1, right? Otherwise,
>> range_len() on this range will be non-zero. Likely moot because the
>> range will be skipped because @ranges++ gets skipped, but it looks
>> strange written this way.
> 
> Actually, IIUC, this update can just be deleted altogether because
> @ranges++ being skipped already invalidates this entry.

Ok, I'll remove and fix the follow on code bits that relies on this.
