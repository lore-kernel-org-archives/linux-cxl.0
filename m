Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D526CA0FE2
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347706AbjIEQYQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354854AbjIEPGO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 11:06:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206D18D
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 08:06:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg7xw5BF6z67y8J;
        Tue,  5 Sep 2023 23:01:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 16:06:08 +0100
Date:   Tue, 5 Sep 2023 16:06:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <20230905160607.0000366f@huawei.com>
In-Reply-To: <20230905155639.00000b3a@huawei.com>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
        <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
        <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
        <20230905155639.00000b3a@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 5 Sep 2023 15:56:39 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Mon, 4 Sep 2023 20:26:59 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> > On 4/9/23 18:47, Jonathan Cameron wrote:  
> > > As an encoded version of these key configuration parameters is
> > > a register, provide functions to extract it again so as to avoid
> > > the need for duplicating the storage.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   include/hw/cxl/cxl_component.h | 14 ++++++++++++++
> > >   hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
> > >   2 files changed, 31 insertions(+)
> > > 
> > > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > > index 42c7e581a7..f0ad9cf7de 100644
> > > --- a/include/hw/cxl/cxl_component.h
> > > +++ b/include/hw/cxl/cxl_component.h
> > > @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
> > >       return 0;
> > >   }
> > >   
> > > +static inline int cxl_decoder_count_dec(int enc_cnt)
> > > +{
> > > +    switch (enc_cnt) {
> > > +    case 0: return 1;
> > > +    case 1: return 2;
> > > +    case 2: return 4;
> > > +    case 3: return 6;
> > > +    case 4: return 8;
> > > +    case 5: return 10;
> > > +    }
> > > +    return 0;
> > > +}    
> > 
> > Why inline?
> >   
> 
> Bad habit.
Nope. I'm being slow.  This is in a header so if I don't
mark it inline I get a bunch of defined but not used warnings.

Obviously I could move the implementation of this and the matching
encoding routines out of the header. I haven't done so for now.


> 
> 
> > Alternatively:
> > 
> >    unsigned cxl_decoder_count_dec(unsigned enc_cnt)
> >    {
> >        return enc_cnt <= 5 ? 2 * enc_cnt : 0;  
> 
> It gets a little more fiddly than the code I'm proposing implies.
> For Switches and Host Bridges larger values are defined
> (we just don't emulate them yet and may never do so) and those
> don't have a sensible mapping. 
> 
> I guess there is no harm in adding the full decode however
> which will make it more obvious why it was a switch statement.
> 
> >    }
> > 
> >   
> 
> 
> 

