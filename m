Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4E0CA550A
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 09:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjIMJBW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbjIMJBT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 05:01:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233381999
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 02:01:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlvXM0Vvyz6HJcx;
        Wed, 13 Sep 2023 16:59:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 10:01:13 +0100
Date:   Wed, 13 Sep 2023 10:01:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
 decoder block size everywhere
Message-ID: <20230913100112.000031a8@Huawei.com>
In-Reply-To: <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
        <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 13 Sep 2023 08:53:55 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 11/9/23 13:43, Jonathan Cameron wrote:
> > In order to avoid having the size of the per HDM decoder register block
> > repeated in lots of places, create the register definitions for HDM
> > decoder 1 and use the offset between the first registers in HDM decoder 0 and
> > HDM decoder 1 to establish the offset.
> > 
> > Calculate in each function as this is more obvious and leads to shorter
> > line lengths than a single #define which would need a long name
> > to be specific enough.
> > 
> > Note that the code currently only supports one decoder, so the bugs this
> > fixes don't actually affect anything. Previously the offset didn't
> > take into account that the write_msk etc are 4 byte fields.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > v3:
> > New patch to separate this out from the addition of HDM decoders.
> > ---
> >   include/hw/cxl/cxl_component.h |  2 ++
> >   hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
> >   hw/cxl/cxl-host.c              |  4 +++-
> >   hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
> >   4 files changed, 31 insertions(+), 18 deletions(-)  
> 
> 
> > @@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
> >   /* TODO: Support multiple HDM decoders and DPA skip */
> >   static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> >   {
> > +    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> >       uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> >       uint64_t decoder_base, decoder_size, hpa_offset;
> >       uint32_t hdm0_ctrl;
> >       int ig, iw;
> > +    int i = 0;
> >   
> > -    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
> > -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> > +    decoder_base =
> > +        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
> > +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);  
> 
> Alternatively easier to review as (matter of taste ?):
> 
> decoder_base = deposit64(cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * 
> hdm_inc], 32, 32,
>                           cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * 
> hdm_inc]);

I'll leave if for now for consistency in the CXL code.  Might make
sense to consider this as a cross subsystem cleanup at some point though!
Thanks for the suggestion.

> 
> Regardless:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Thanks.

Jonathan

> 
> 

