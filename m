Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC6CA550A
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 09:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbjIMJDr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjIMJDq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 05:03:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F921999
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 02:03:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rlvb93q9Cz6HJbM;
        Wed, 13 Sep 2023 17:01:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 10:03:39 +0100
Date:   Wed, 13 Sep 2023 10:03:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230913100338.000006c2@Huawei.com>
In-Reply-To: <20230912180844.GD319114@bgt-140510-bm03>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-5-Jonathan.Cameron@huawei.com>
        <CGME20230912180845uscas1p28e989eaff6b92939cfdb85886137354b@uscas1p2.samsung.com>
        <20230912180844.GD319114@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 12 Sep 2023 18:08:44 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Sep 11, 2023 at 12:43:13PM +0100, Jonathan Cameron wrote:
> 
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---  
> 
> One comment inline, other than that, looks good to me.

I think we are fine, but also possible I'm missing something :)

> >  
> >  /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
> >  #define EXTSEC_ENTRY_MAX        256
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index aa011a8f34..3ecdad4a5e 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -90,6 +90,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> >  
> >      switch (offset) {
> >      case A_CXL_HDM_DECODER0_CTRL:
> > +    case A_CXL_HDM_DECODER1_CTRL:
> > +    case A_CXL_HDM_DECODER2_CTRL:
> > +    case A_CXL_HDM_DECODER3_CTRL:
> >          should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> >          should_uncommit = !should_commit;  
> 
> So for the commit/uncommit flag, we always check decoder 0 control
> register? Or i read it wrong? I thought the commit bit is per control register
> thing?

This is in the write handler and the value passed in that we are looking at is
for whichever of the _CTRL registers is being written.

I could have coded this as separate entries for each register as
FIELD_EX32(value, CXL_HDM_DECODER[X]_CTRL, COMMIT)
but as this only figures out the field offset and mask, it is the same for X=0,1,2,3

Jonathan



