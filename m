Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D06E7B5E1
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbjJDJfa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjJDJf3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 05:35:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E6AB
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 02:35:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0qGv2bdrz6D8Wk;
        Wed,  4 Oct 2023 17:32:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 4 Oct
 2023 10:35:21 +0100
Date:   Wed, 4 Oct 2023 10:35:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004103520.00003425@Huawei.com>
In-Reply-To: <20231004045943-mutt-send-email-mst@kernel.org>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
        <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
        <20231004045943-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 4 Oct 2023 05:04:31 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Sep 04, 2023 at 05:18:46PM +0100, Jonathan Cameron wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> > ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> > from the OS.
> > 
> > Following edited for readbility only
> > 
> > Device (CXLM)
> > {
> >     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> > ...
> >     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> >     {
> >         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
> >         {
> >             If ((Arg2 == Zero))
> >             {
> >                 Return (Buffer (One) { 0x01 })
> >             }
> > 
> >             If ((Arg2 == One))
> >             {
> >                 Return (Package (0x02)
> >                 {
> >                     Buffer (0x02)
> >                     { 0x01, 0x00 },
> >                     Package (0x01)
> >                     {
> >                         Buffer (0x02)
> >                         { 0x00, 0x00 }
> >                     }
> >                 })
> >             }
> >         }
> >     }
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > v2: Minor edit to drop reference to switches in patch description.
> > ---  
> 
> >  include/hw/acpi/cxl.h |  1 +
> >  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c  |  1 +
> >  3 files changed, 59 insertions(+)  
> 
> 
> This is not the right way to format it. The correct way is:
> 
> ---
> v2: Minor edit to drop reference to switches in patch description.
> 
>  include/hw/acpi/cxl.h |  1 +
>  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |  1 +
>  3 files changed, 59 insertions(+)
> 
> The way you do it breaks b4 and a bunch of other tools.  signatures must
> come last before ---, then versioning info (which generally does not
> need to be in git because readers of git have no access to older
> versions, though there could be exceptions. If there's anything relevant
> in this versioning history, such as some design directions which were
> tried and discarded, then put it above ---). Then the diff.

Sorry, typo. I believe b4 and git am are also fine with what was intended
here.

---
v2: xxx
---

stats

which has advantage that you can track the change log easily in a git tree
as things evolve rather than a bunch of hand editing of patches to add
this stuff in at time of send.

I'll be more careful to check for errors like this in future.

Thanks for fixing it up and sorry for the waste of your time!

Jonathan



> 
> 
> > 
> > diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> > index acf4418886..8f22c71530 100644
> > --- a/include/hw/acpi/cxl.h
> > +++ b/include/hw/acpi/cxl.h
> > @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >                      BIOSLinker *linker, const char *oem_id,
> >                      const char *oem_table_id, CXLState *cxl_state);
> >  void build_cxl_osc_method(Aml *dev);
> > +void build_cxl_dsm_method(Aml *dev);
> >  
> >  #endif
> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > index 92b46bc932..5e9039785a 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -30,6 +30,63 @@
> >  #include "qapi/error.h"
> >  #include "qemu/uuid.h"
> >  
> > +void build_cxl_dsm_method(Aml *dev)
> > +{
> > +    Aml *method, *ifctx, *ifctx2;
> > +
> > +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> > +    {
> > +        Aml *function, *uuid;
> > +
> > +        uuid = aml_arg(0);
> > +        function = aml_arg(2);
> > +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> > +        ifctx = aml_if(aml_equal(
> > +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> > +
> > +        /* Function 0, standard DSM query function */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> > +        {
> > +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> > +
> > +            aml_append(ifctx2,
> > +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +
> > +        /*
> > +         * Function 1
> > +         * A return value of {1, {0}} inciate that
> > +         * max supported QTG ID of 1 and recommended QTG is 0.
> > +         * The values here are faked to simplify emulation.
> > +         */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> > +        {
> > +            uint16_t word_list[1] = { 0x01 };
> > +            uint16_t word_list2[1] = { 0 };
> > +            uint8_t *byte_list = (uint8_t *)word_list;
> > +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> > +            Aml *pak, *pak1;
> > +
> > +            /*
> > +             * The return package is a package of a WORD and another package.
> > +             * The embedded package contains 0 or more WORDs for the
> > +             * recommended QTG IDs.
> > +             */
> > +            pak1 = aml_package(1);
> > +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> > +            pak = aml_package(2);
> > +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> > +            aml_append(pak, pak1);
> > +
> > +            aml_append(ifctx2, aml_return(pak));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +    }
> > +    aml_append(method, ifctx);
> > +    aml_append(dev, method);
> > +}
> > +
> >  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
> >  {
> >      PXBDev *pxb = PXB_DEV(cxl);
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index bb12b0ad43..d3bc5875eb 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
> >      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >      aml_append(method, aml_return(aml_int(0x01)));
> >      aml_append(dev, method);
> > +    build_cxl_dsm_method(dev);
> >  
> >      aml_append(scope, dev);
> >      aml_append(table, scope);
> > -- 
> > 2.39.2  
> 

