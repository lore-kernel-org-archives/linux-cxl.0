Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D3C54E76
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Jan 2023 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAQRus (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjAQRsr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Jan 2023 12:48:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA9582A2
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jan 2023 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673977074; x=1705513074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DGXh4rfBNmr8eY/uZSrZIvQT5uaT0efds9z4LMBWAcU=;
  b=UKrpainWuFWmwrrokr2A/sIXyE+/iYIkWVbMnGVAZqcPjcHUA7/yCwO9
   /2UNQCGLo8xn0GfHqb9wW0Iage2Ph0Nupb6rDlb1VQlCU21Fhr03YMI4s
   kRf1fUoJDmJbNR9r595sPVUMPbPI2yYEO/15yCXdudW9N9rNfzASdHPhL
   tr1GoM6qc3l+5P+ChfGcdvg85DvGAbXiFeUeySkx7+uQNUgb75hgxubNS
   DJ/g0JVD0WH74zOWk0AfeYyqAlBRmV8zto0vFPtzSRZr0wihyfJtzW8Dz
   3WQhoPRd8arcDn658DChPAN4kigh1O4G7Dk9HtVWEfWrgTuPp42RaD2P1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305139775"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305139775"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:37:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659460797"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659460797"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 09:36:59 -0800
Message-ID: <d38de32e-a049-c020-4898-436add42e57e@intel.com>
Date:   Tue, 17 Jan 2023 10:36:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 0/2] CXL UE RAS Multiple Header Logging support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     linuxarm@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <20230113154011.16205-1-Jonathan.Cameron@huawei.com>
 <20230113155338.00006b35@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230113155338.00006b35@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 8:53 AM, Jonathan Cameron wrote:
> On Fri, 13 Jan 2023 15:40:09 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> Missed Dave Jiang off cc so resent
> (I thought I'd hit cancel fast enough but apparently not)
> Sorry for the noise!

No worries. I see them from the list either way.

> 
>> CXL UE RAS Error reporting allows an EP to report the capability of
>> recording Multiple Header Logs for uncorrectable errors.
>> Unlike equivalent feature in PCIe, there is no enable control
>> for this feature, so a supporting device may be expecting
>> a more complex software flow than that necessary for devices
>> that do not support this feature. Documentation of this feature
>> is sparse, with assumption it works the same as PCIe.
>>
>> There are hardware implementation choices allowed in the
>> equivalent PCIe r6.0 base spec section (6.4.2.4) that could
>> be safely used with the existing code, even with Multiple
>> Header Recording support but there are others that cannot.
>>
>> The issue is what happens when the EP is doing Multiple Header
>> Recording but then the software writes 1 to clear more than one
>> status bit at the time (PCIe spec warns against doing this
>>   - but it is what the current kernel code will do):
>> Option 1)
>>    It does the nice thing and clears all matching errors.
>>    Note this is a bit strange for the case where the device
>>    supports logging multiple instances of a given error - so
>>    the two can't be combined cleanly.  With that feature
>>    I can't see how anyone could implement hardware that coped
>>    cleanly with the wrong software flow.
>> Option 2)
>>    It clears only the first error bit leaving a bunch of error
>>    bits set (note that if it has recorded multiple errors of
>>    same type it might not even do that). These are sticky
>>    across resets, so you will probably end up coming back up
>>    and immediately seeing an error.
>>
>> So whilst you can design an EP to safe against non MH recording
>> aware software, it isn't generally the case. As we don't have
>> an explicit enable on CXL we have to handle anything reporting
>> the capability in a MH safe fashion.
>>
>> This feature was developed against emulation in QEMU.
>> The relevant patches have not yet been posted but can be found on
>> https://gitlab.com/jic23/qemu/-/commits/cxl-2023-01-11
>> along with description of how to inject errors in the patch
>> descriptions.  I'll post them for review for QEMU inclusion
>> shortly.
>>
>> RFC simply because the lack of specification detail means I am
>> less sure on this code than I would normally be. Unfortunately it
>> could be argued that the first patch is a fix for the
>> current upstream CXL RAS support.  If we want a simpler fix
>> one option would be to just fail to enable RAS support if
>> Multiple Header recording capability bit is set.  Or we
>> decide that it doesn't matter for now and add support for this
>> feature via the normal merge cycle.
>>
>> Second patch is just there to make this easier to test as
>> no additional software is needed to print the header log.
>>
>> Base is rather messy due to a clash between multiple cxl tree
>> branches.
>> cxl/fixes with the trace move on cxl/next cherry picked on top
>> as it moves the code that was fixed.
>>
>> Jonathan Cameron (2):
>>    cxl: RAS: Multiple header recording support
>>    cxl: Add tprintk support for header log hex dump
>>
>>   drivers/cxl/core/pci.c   | 17 ++++++++++++-----
>>   drivers/cxl/core/trace.h |  7 +++++--
>>   drivers/cxl/cxl.h        |  1 +
>>   3 files changed, 18 insertions(+), 7 deletions(-)
>>
> 
