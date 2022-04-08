Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FAC433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Apr 2022 20:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDHUmP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Apr 2022 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDHUmN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Apr 2022 16:42:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B314014
        for <linux-cxl@vger.kernel.org>; Fri,  8 Apr 2022 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1trNanUSmB+LSY0nvIAqScb0YJ7HeFDsKsSWxbVLbeU=; b=pQ9vhpHVy2zw+1Wd5+Dze1deNq
        oHx9YhE1ACawp7nm+nfRxJ+CsJJ12auNIX0abAgO5zCgnc528yjexR9OTDz1QV6ilho531PxGfnM8
        RNspQLGIUWJAb7kxk2pEHh7v2zfxzL1wB/Q0cWmxFlr5wX2P1nX+zHaiurLWzv5RZobD7C48Tq8Kd
        hoIS4MtF+6u0xkPSHxmtMACaQ4J0Vs48Qdts44ZSnqhlo8g0uSu/eYk2vqvwIb2EyRsrWRSSZUYtr
        hbcs/uqpqGDCGpr+SZJ5CBW31YShTgNp66O9VWPxGYIPggtAxMBTUS58CbmU2cuFuNROBBLM3gMj8
        6J52AEHA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncvOQ-0033Y1-K0; Fri, 08 Apr 2022 20:40:01 +0000
Message-ID: <a6df2591-c61a-7f01-73b3-9dc5fa592a22@infradead.org>
Date:   Fri, 8 Apr 2022 13:39:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cxl/pci: Drop shadowed variable
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc:     lkp <lkp@intel.com>
References: <164944636936.455177.14136200464724208233.stgit@dwillia2-desk3.amr.corp.intel.com>
 <bb1fe225cb4885fe84a638ba3b6eae4b0aec30be.camel@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bb1fe225cb4885fe84a638ba3b6eae4b0aec30be.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/8/22 12:39, Verma, Vishal L wrote:
> On Fri, 2022-04-08 at 12:32 -0700, Dan Williams wrote:
>> 0day notices that wait_for_media_ready() declares an @rc variable twice.
> 
> s/notices/noticed/ ?
> 
> Other than that, looks good.
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
>>
>>>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
>>      int rc;
>>          ^
>>    drivers/cxl/pci.c:431:6: note: Shadowed declaration
>>     int rc, i;
>>         ^
>>    drivers/cxl/pci.c:439:7: note: Shadow variable
>>      int rc;
>>          ^
>>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Fixes: 523e594d9cc0 ("cxl/pci: Implement wait for media active")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

>> ---
>>  drivers/cxl/pci.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 077ea064bddd..e7ab9a34d718 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -437,7 +437,6 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
>>  
>>         for (i = mbox_ready_timeout; i; i--) {
>>                 u32 temp;
>> -               int rc;
>>  
>>                 rc = pci_read_config_dword(
>>                         pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
>>
> 

-- 
~Randy
