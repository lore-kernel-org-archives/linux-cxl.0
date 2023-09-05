Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200FCA0FFA
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbjIEQYa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354904AbjIEPoV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 11:44:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394FDA8
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 08:44:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg8sV4Bgfz6HJRk;
        Tue,  5 Sep 2023 23:42:54 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 16:44:14 +0100
Date:   Tue, 5 Sep 2023 16:44:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/2] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230905164413.0000406c@huawei.com>
In-Reply-To: <56291b02-5474-77b6-5563-6367bf5dcb4c@linaro.org>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
        <20230904164704.18739-3-Jonathan.Cameron@huawei.com>
        <56291b02-5474-77b6-5563-6367bf5dcb4c@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 4 Sep 2023 20:36:02 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> Hi Jonathan,
> 
> Few style comments inlined.
> 
> On 4/9/23 18:47, Jonathan Cameron wrote:
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
Hi Philippe,

Thanks for the particularly quick reviews! 

...

> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index e96398e8af..79b9369756 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -42,6 +42,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> >   
> >       switch (offset) {
> >       case A_CXL_HDM_DECODER0_CTRL:
> > +    case A_CXL_HDM_DECODER1_CTRL:
> > +    case A_CXL_HDM_DECODER2_CTRL:
> > +    case A_CXL_HDM_DECODER3_CTRL:
> >           should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> >           should_uncommit = !should_commit;
> >           break;
> > @@ -81,7 +84,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> >       }
> >   
> >       if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > -        offset <= A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
> > +        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> >           dumb_hdm_handler(cxl_cstate, offset, value);
> >       } else {
> >           cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> > @@ -161,7 +164,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
> >   static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >                               enum reg_type type)
> >   {
> > -    int decoder_count = 1;
> > +    int decoder_count = 4;  
> 
>    unsigned decoder_count = HDM_DECODER_COUNT;
> 
> >       int i;
> >   
> >       ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
> > @@ -174,19 +177,22 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >                        HDM_DECODER_ENABLE, 0);
> >       write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> >       for (i = 0; i < decoder_count; i++) {  
> 
> Alternatively:
> 
>          for (i = 0; i < decoder_count; i++, write_msk += 8) {
>              write_msk[R_CXL_HDM_DECODER0_BASE_LO] = 0xf0000000;

That's a bit nasty and fragile given we are offsetting the base register than
indexing into it (so applying a later offset).

> 
> > -        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
> > -        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
> > -        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
> > -        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
> > -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> > +        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4] = 0xf0000000;  
> 
> (this 0x20 / 4 bugs me a bit).

Instead, I've gone with a local variable which leaves me room for deriving
this based on the step between the registers for decoders 0 and 1.

hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;

I haven't added a define for this because it would probably have to be
long enough that it will cause line length problems :(
So it is replicated in a few different places which isn't ideal
but definitely better than the 0x20 / 4

> 
> > +        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4]  = 0xffffffff;
> > +        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4] = 0xf0000000;
> > +        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4] = 0xffffffff;
> > +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4] = 0x13ff;
> >           if (type == CXL2_DEVICE ||
> >               type == CXL2_TYPE3_DEVICE ||
> >               type == CXL2_LOGICAL_DEVICE) {
> > -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
> > +                0xf0000000;
> >           } else {
> > -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
> > +                0xffffffff;
> >           }
> > -        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
> > +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20 / 4] =
> > +            0xffffffff;
> >       }
> >   }  
> 

