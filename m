Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55374C43334
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 16:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbiFGQlX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbiFGQlV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 12:41:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5345DD02BD
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 09:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5587CE2319
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 16:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD1AC385A5;
        Tue,  7 Jun 2022 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654620076;
        bh=nzfxWt+CAzao4R1WE/AQaZXGtbOyttsgCG+UyjdkIew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jL1e2c+l6kI5XP4DJHkQJNVnBD8DXqYSoSjV5QY/M2va5fKha6dAm+8hkGymlJ+LB
         mKN17En9iB1EDDLtQraWYVZJ/Yp7bXKqx5oTdjhHVSYER0gYGgW2ggjwnq+UyeJlIz
         8pCVr+zRo7CRJow/YK3M2Cg15JWDqLSnh+frjUB1i1pg+Xb2vHmQuqlWAqFTrqyrWU
         ON8gkvNsFdjMBpgxPFrHGz71eckL4E/ueijBKwT2A3ONKN+D73DGkIftygGFP+skig
         D6S+ok2gPyWdc/+DhABr0738p8P6mLZes1QzDsWJuQQtolMhzggkbHMVwdCKkUAcI3
         tyfTnETNll7IQ==
Date:   Tue, 7 Jun 2022 09:41:14 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3] hw/cxl: Fix missing write mask for HDM decoder target
 list registers
Message-ID: <20220607164114.mbwcqk4wxekhzxfo@bwidawsk-mobl5>
References: <20220607160747.21084-1-Jonathan.Cameron@huawei.com>
 <20220607161928.364mrju2mvzcvs56@bwidawsk-mobl5>
 <20220607173702.00005ccf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607173702.00005ccf@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-06-07 17:37:02, Jonathan Cameron wrote:
> On Tue, 7 Jun 2022 09:19:28 -0700
> Ben Widawsky <bwidawsk@kernel.org> wrote:
> 
> > On 22-06-07 17:07:47, Jonathan Cameron wrote:
> > > Without being able to write these registers, no interleaving is possible.
> > > More refined checks of HDM register state on commit to follow.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > v3: Actually pass the parameter to the call...
> > > v2: (Ben Widawsky)
> > > - Correctly set a tighter write mask for the endpoint devices where this
> > >   register has a different use.
> > >   
> > >  hw/cxl/cxl-component-utils.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > index 7985c9bfca..2208284ee6 100644
> > > --- a/hw/cxl/cxl-component-utils.c
> > > +++ b/hw/cxl/cxl-component-utils.c
> > > @@ -154,7 +154,8 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
> > >      reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
> > >  }
> > >  
> > > -static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> > > +static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> > > +                            enum reg_type type)
> > >  {
> > >      int decoder_count = 1;
> > >      int i;
> > > @@ -174,6 +175,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> > >          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
> > >          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
> > >          write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> > > +        if (type == CXL2_DEVICE) {
> > > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
> > > +        } else {
> > > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> > > +        }
> > > +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;  
> > 
> > Should it be (type == CXL2_DEVICE || type == CXL2_TYPE3_DEVICE) ?
> 
> Good point, but also for consistency I think we need 
> type == CXL2_LOGICAL_DEVICE as well.

I was looking at this and I am not sure, but I defer to you.

> 
> We will only exercise the match to CXL2_TYPE3_DEVICE currently
> as we don't have any emulation for MLDs (and hence LD) or type 1/2 devices
> (CXL2_DEVICE).
> 
> I'll send a v4 out tomorrow.
> 

Sounds good, feel free to keep the r-b tag.

> > 
> > Otherwise,
> > Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
> > 
> > >      }
> > >  }
> > >  
> > > @@ -239,7 +246,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
> > >      }
> > >  
> > >      init_cap_reg(HDM, 5, 1);
> > > -    hdm_init_common(reg_state, write_msk);
> > > +    hdm_init_common(reg_state, write_msk, type);
> > >  
> > >      if (caps < 5) {
> > >          return;
> > > -- 
> > > 2.32.0
> > >   
> 
