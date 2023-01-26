Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2B1C54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjAZSrV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAZSrV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 13:47:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660FBB
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 10:47:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2qMx5z2xz67M5Q;
        Fri, 27 Jan 2023 02:43:09 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 18:47:16 +0000
Date:   Thu, 26 Jan 2023 18:47:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <mst@redhat.com>, <bwidawsk@kernel.org>,
        <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20230126184715.0000474c@huawei.com>
In-Reply-To: <d47600e7-e555-4624-b031-a9e46d9533f7@intel.com>
References: <167475645654.1386523.7101990863993668595.stgit@djiang5-mobl3.local>
        <20230126182446.00001ce7@Huawei.com>
        <d47600e7-e555-4624-b031-a9e46d9533f7@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 26 Jan 2023 11:41:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/26/23 11:24 AM, Jonathan Cameron wrote:
> > On Thu, 26 Jan 2023 11:07:37 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > Hi Dave,
> > 
> > That was quick!
> >   
> >> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> >> ID value. Given the current CXL implementation does not involve switches,  
> > 
> > I don't follow.  What part doesn't involve switches?  
> 
> The devices are just behind the CXL host-bridge right? Do you think we 
> need to provide anything beyond the fake value right now?

No problem with fake value. It was just the not involve switches statement.
Both kernel and QEMU support switches in general so I wasn't sure why
'current' CXL implementation does not involve switches.

> 
> >   
> >> a faked value of 0 can be returned for the QTG ID. The enabling is for _DSM
> >> plumbing testing from the OS.  
> > 
> > Can you include a dump iasl -d for the DSDT chunk this generates. Much
> > easier to review with that available.  
> 
> Ok. Let me figure out how to do that.
> 
> > 
> > On that note, tests need updating I think
> > tests/qtest/bios-tables-test.c data which is in
> > tests/data/acpi/q35/DSDT.cxl  
> 
> ok
> 
> > 
> > We should update that test code as part of the volatile series as well
> > as it's using the deprecated memdev parameter - not critical
> > but never a good thing to leave old examples of what not to use in
> > the tests.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > p.s. I'm too lazy to look at the code without the AML to compare with
> > as I'll review the AML first then look at if there are any oddities
> > in the generation code.
> >   
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   hw/acpi/cxl.c         |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>   hw/i386/acpi-build.c  |    1 +
> >>   include/hw/acpi/cxl.h |    1 +
> >>   3 files changed, 59 insertions(+)
> >>
> >> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> >> index 2bf8c0799359..cd6839c24416 100644
> >> --- a/hw/acpi/cxl.c
> >> +++ b/hw/acpi/cxl.c
> >> @@ -30,6 +30,63 @@
> >>   #include "qapi/error.h"
> >>   #include "qemu/uuid.h"
> >>   
> >> +void build_cxl_dsm_method(Aml *dev)
> >> +{
> >> +    Aml *method, *ifctx, *ifctx2;
> >> +
> >> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> >> +    {
> >> +        Aml *function, *uuid;
> >> +
> >> +        uuid = aml_arg(0);
> >> +        function = aml_arg(2);
> >> +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> >> +        ifctx = aml_if(aml_equal(
> >> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> >> +
> >> +        /* Function 0, standard DSM query function */
> >> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> >> +        {
> >> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> >> +
> >> +            aml_append(ifctx2,
> >> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> >> +        }
> >> +        aml_append(ifctx, ifctx2);
> >> +
> >> +        /*
> >> +         * Function 1
> >> +         * A return value of {1, {0}} inciate that
> >> +         * max supported QTG ID of 1 and recommended QTG is 0.
> >> +         * The values here are faked to simplify emulation.
> >> +         */
> >> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> >> +        {
> >> +            uint16_t word_list[1] = { 0x01 };
> >> +            uint16_t word_list2[1] = { 0 };
> >> +            uint8_t *byte_list = (uint8_t *)word_list;
> >> +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> >> +            Aml *pak, *pak1;
> >> +
> >> +            /*
> >> +             * The return package is a package of a WORD and another package.
> >> +             * The embedded package contains 0 or more WORDs for the
> >> +             * recommended QTG IDs.
> >> +             */
> >> +            pak1 = aml_package(1);
> >> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> >> +            pak = aml_package(2);
> >> +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> >> +            aml_append(pak, pak1);
> >> +
> >> +            aml_append(ifctx2, aml_return(pak));
> >> +        }
> >> +        aml_append(ifctx, ifctx2);
> >> +    }
> >> +    aml_append(method, ifctx);
> >> +    aml_append(dev, method);
> >> +}
> >> +
> >>   static void cedt_build_chbs(GArray *table_data, PXBDev *cxl)
> >>   {
> >>       SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl.cxl_host_bridge);
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 285829802b1a..623f26a16db3 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1313,6 +1313,7 @@ static void build_acpi0017(Aml *table)
> >>       method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >>       aml_append(method, aml_return(aml_int(0x01)));
> >>       aml_append(dev, method);
> >> +    build_cxl_dsm_method(dev);
> >>   
> >>       aml_append(scope, dev);
> >>       aml_append(table, scope);
> >> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> >> index acf441888683..8f22c71530d8 100644
> >> --- a/include/hw/acpi/cxl.h
> >> +++ b/include/hw/acpi/cxl.h
> >> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >>                       BIOSLinker *linker, const char *oem_id,
> >>                       const char *oem_table_id, CXLState *cxl_state);
> >>   void build_cxl_osc_method(Aml *dev);
> >> +void build_cxl_dsm_method(Aml *dev);
> >>   
> >>   #endif
> >>
> >>  
> >   

