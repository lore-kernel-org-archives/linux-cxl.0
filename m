Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05481EC8751
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 18:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbjIGSoG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjIGSoF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 14:44:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525991
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 11:44:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RhH5c2scjz6FBlH;
        Thu,  7 Sep 2023 19:27:16 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 7 Sep
 2023 12:27:29 +0100
Date:   Thu, 7 Sep 2023 12:27:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <20230907122728.00006968@huawei.com>
In-Reply-To: <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
        <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
        <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
        <20230905155639.00000b3a@huawei.com>
        <20230905160607.0000366f@huawei.com>
        <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 5 Sep 2023 18:55:23 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 5/9/23 17:06, Jonathan Cameron wrote:
> > On Tue, 5 Sep 2023 15:56:39 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >   
> >> On Mon, 4 Sep 2023 20:26:59 +0200
> >> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >>  
> >>> On 4/9/23 18:47, Jonathan Cameron wrote:  
> >>>> As an encoded version of these key configuration parameters is
> >>>> a register, provide functions to extract it again so as to avoid
> >>>> the need for duplicating the storage.
> >>>>
> >>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>> ---
> >>>>    include/hw/cxl/cxl_component.h | 14 ++++++++++++++
> >>>>    hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
> >>>>    2 files changed, 31 insertions(+)
> >>>>
> >>>> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> >>>> index 42c7e581a7..f0ad9cf7de 100644
> >>>> --- a/include/hw/cxl/cxl_component.h
> >>>> +++ b/include/hw/cxl/cxl_component.h
> >>>> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
> >>>>        return 0;
> >>>>    }
> >>>>    
> >>>> +static inline int cxl_decoder_count_dec(int enc_cnt)
> >>>> +{
> >>>> +    switch (enc_cnt) {
> >>>> +    case 0: return 1;
> >>>> +    case 1: return 2;
> >>>> +    case 2: return 4;
> >>>> +    case 3: return 6;
> >>>> +    case 4: return 8;
> >>>> +    case 5: return 10;
> >>>> +    }
> >>>> +    return 0;
> >>>> +}  
> >>>
> >>> Why inline?
> >>>      
> >>
> >> Bad habit.  
> > Nope. I'm being slow.  This is in a header so if I don't
> > mark it inline I get a bunch of defined but not used warnings.
> > 
> > Obviously I could move the implementation of this and the matching
> > encoding routines out of the header. I haven't done so for now.  
> 
> Inlined function in hw/ are hardly justifiable. They make the headers
> and debugging sessions harder to read in my experience. Compilers are
> becoming clever and clever, and we have LTO, so I rather privilege
> code maintainability. My 2 cents :)
> 
> >>> Alternatively:
> >>>
> >>>     unsigned cxl_decoder_count_dec(unsigned enc_cnt)
> >>>     {
> >>>         return enc_cnt <= 5 ? 2 * enc_cnt : 0;  
> >>
> >> It gets a little more fiddly than the code I'm proposing implies.
> >> For Switches and Host Bridges larger values are defined
> >> (we just don't emulate them yet and may never do so) and those
> >> don't have a sensible mapping.
> >>
> >> I guess there is no harm in adding the full decode however
> >> which will make it more obvious why it was a switch statement.  
> 
> Right, no problem.
> 
> Preferably having this tiny function not inlined

I'll push this and the enc() version down into the cxl-component-utils.c
as a precursor patch.

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 
Thanks, but the changes to do make these non inline, and include
the larger decode and encode values are big enough I won't pick up
the RB - too much changing (that I might mess up ;)


Jonathan


