Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B4C61DA7
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjAZSl7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjAZSl5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 13:41:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4F4CE7C
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758512; x=1706294512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5tEjxECACWFvZtO0FkW8B87L1Q2QE/TH1kuTy+IXukk=;
  b=nNmkPfenjMl4B1oatOCx7j2kJdt4qFxB8ssgzM2COZFoneWyPHA09Tsj
   pmQINPRgd0t3jHiduQXSXDlfFF0f7jbKubEY3MRM1UbI63ePhXL3hJswV
   xRiNKDOnDvG2XfzfW1CnYR0X5uuR7ERqqc2kcGu2J2v5KBdu+bF1NLma2
   +YkPZuZW+FZDOnpgwCEASaEfAr4xLGx+yfU6uDtB7nQ5L3oG77aF8JdBp
   RM1uwX+MYXdWjkdufMi11S4qiMoN8S9wEMvI9MF8bMtuHkPCVChLH4fJk
   Yg48hHtrNZN7XhS7FOiJkFZjJmYCSNUEge1y6fEan7ZgmZO4bnIrYxHyK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307254064"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="307254064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:41:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656276553"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="656276553"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.115]) ([10.212.112.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:41:48 -0800
Message-ID: <d47600e7-e555-4624-b031-a9e46d9533f7@intel.com>
Date:   Thu, 26 Jan 2023 11:41:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] hw/cxl: Add QTG _DSM support for ACPI0017 device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     mst@redhat.com, bwidawsk@kernel.org, peter.maydell@linaro.org,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <167475645654.1386523.7101990863993668595.stgit@djiang5-mobl3.local>
 <20230126182446.00001ce7@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230126182446.00001ce7@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/26/23 11:24 AM, Jonathan Cameron wrote:
> On Thu, 26 Jan 2023 11:07:37 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> Hi Dave,
> 
> That was quick!
> 
>> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
>> ID value. Given the current CXL implementation does not involve switches,
> 
> I don't follow.  What part doesn't involve switches?

The devices are just behind the CXL host-bridge right? Do you think we 
need to provide anything beyond the fake value right now?

> 
>> a faked value of 0 can be returned for the QTG ID. The enabling is for _DSM
>> plumbing testing from the OS.
> 
> Can you include a dump iasl -d for the DSDT chunk this generates. Much
> easier to review with that available.

Ok. Let me figure out how to do that.

> 
> On that note, tests need updating I think
> tests/qtest/bios-tables-test.c data which is in
> tests/data/acpi/q35/DSDT.cxl

ok

> 
> We should update that test code as part of the volatile series as well
> as it's using the deprecated memdev parameter - not critical
> but never a good thing to leave old examples of what not to use in
> the tests.
> 
> Thanks,
> 
> Jonathan
> 
> p.s. I'm too lazy to look at the code without the AML to compare with
> as I'll review the AML first then look at if there are any oddities
> in the generation code.
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   hw/acpi/cxl.c         |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/i386/acpi-build.c  |    1 +
>>   include/hw/acpi/cxl.h |    1 +
>>   3 files changed, 59 insertions(+)
>>
>> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
>> index 2bf8c0799359..cd6839c24416 100644
>> --- a/hw/acpi/cxl.c
>> +++ b/hw/acpi/cxl.c
>> @@ -30,6 +30,63 @@
>>   #include "qapi/error.h"
>>   #include "qemu/uuid.h"
>>   
>> +void build_cxl_dsm_method(Aml *dev)
>> +{
>> +    Aml *method, *ifctx, *ifctx2;
>> +
>> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
>> +    {
>> +        Aml *function, *uuid;
>> +
>> +        uuid = aml_arg(0);
>> +        function = aml_arg(2);
>> +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
>> +        ifctx = aml_if(aml_equal(
>> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
>> +
>> +        /* Function 0, standard DSM query function */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
>> +        {
>> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
>> +
>> +            aml_append(ifctx2,
>> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
>> +        }
>> +        aml_append(ifctx, ifctx2);
>> +
>> +        /*
>> +         * Function 1
>> +         * A return value of {1, {0}} inciate that
>> +         * max supported QTG ID of 1 and recommended QTG is 0.
>> +         * The values here are faked to simplify emulation.
>> +         */
>> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
>> +        {
>> +            uint16_t word_list[1] = { 0x01 };
>> +            uint16_t word_list2[1] = { 0 };
>> +            uint8_t *byte_list = (uint8_t *)word_list;
>> +            uint8_t *byte_list2 = (uint8_t *)word_list2;
>> +            Aml *pak, *pak1;
>> +
>> +            /*
>> +             * The return package is a package of a WORD and another package.
>> +             * The embedded package contains 0 or more WORDs for the
>> +             * recommended QTG IDs.
>> +             */
>> +            pak1 = aml_package(1);
>> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
>> +            pak = aml_package(2);
>> +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
>> +            aml_append(pak, pak1);
>> +
>> +            aml_append(ifctx2, aml_return(pak));
>> +        }
>> +        aml_append(ifctx, ifctx2);
>> +    }
>> +    aml_append(method, ifctx);
>> +    aml_append(dev, method);
>> +}
>> +
>>   static void cedt_build_chbs(GArray *table_data, PXBDev *cxl)
>>   {
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl.cxl_host_bridge);
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 285829802b1a..623f26a16db3 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1313,6 +1313,7 @@ static void build_acpi0017(Aml *table)
>>       method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>>       aml_append(method, aml_return(aml_int(0x01)));
>>       aml_append(dev, method);
>> +    build_cxl_dsm_method(dev);
>>   
>>       aml_append(scope, dev);
>>       aml_append(table, scope);
>> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
>> index acf441888683..8f22c71530d8 100644
>> --- a/include/hw/acpi/cxl.h
>> +++ b/include/hw/acpi/cxl.h
>> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>>                       BIOSLinker *linker, const char *oem_id,
>>                       const char *oem_table_id, CXLState *cxl_state);
>>   void build_cxl_osc_method(Aml *dev);
>> +void build_cxl_dsm_method(Aml *dev);
>>   
>>   #endif
>>
>>
> 
