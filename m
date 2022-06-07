Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B1C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiFGQhQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbiFGQhO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 12:37:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C10B0D20
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 09:37:09 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LHbZg0GGjz6817f;
        Wed,  8 Jun 2022 00:35:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 7 Jun 2022 18:37:06 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 17:37:04 +0100
Date:   Tue, 7 Jun 2022 17:37:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3] hw/cxl: Fix missing write mask for HDM decoder
 target list registers
Message-ID: <20220607173702.00005ccf@Huawei.com>
In-Reply-To: <20220607161928.364mrju2mvzcvs56@bwidawsk-mobl5>
References: <20220607160747.21084-1-Jonathan.Cameron@huawei.com>
        <20220607161928.364mrju2mvzcvs56@bwidawsk-mobl5>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 7 Jun 2022 09:19:28 -0700
Ben Widawsky <bwidawsk@kernel.org> wrote:

> On 22-06-07 17:07:47, Jonathan Cameron wrote:
> > Without being able to write these registers, no interleaving is possible.
> > More refined checks of HDM register state on commit to follow.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v3: Actually pass the parameter to the call...
> > v2: (Ben Widawsky)
> > - Correctly set a tighter write mask for the endpoint devices where this
> >   register has a different use.
> >   
> >  hw/cxl/cxl-component-utils.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index 7985c9bfca..2208284ee6 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -154,7 +154,8 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
> >      reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
> >  }
> >  
> > -static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> > +static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> > +                            enum reg_type type)
> >  {
> >      int decoder_count = 1;
> >      int i;
> > @@ -174,6 +175,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> >          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
> >          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
> >          write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> > +        if (type == CXL2_DEVICE) {
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
> > +        } else {
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> > +        }
> > +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;  
> 
> Should it be (type == CXL2_DEVICE || type == CXL2_TYPE3_DEVICE) ?

Good point, but also for consistency I think we need 
type == CXL2_LOGICAL_DEVICE as well.

We will only exercise the match to CXL2_TYPE3_DEVICE currently
as we don't have any emulation for MLDs (and hence LD) or type 1/2 devices
(CXL2_DEVICE).

I'll send a v4 out tomorrow.

> 
> Otherwise,
> Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
> 
> >      }
> >  }
> >  
> > @@ -239,7 +246,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
> >      }
> >  
> >      init_cap_reg(HDM, 5, 1);
> > -    hdm_init_common(reg_state, write_msk);
> > +    hdm_init_common(reg_state, write_msk, type);
> >  
> >      if (caps < 5) {
> >          return;
> > -- 
> > 2.32.0
> >   

