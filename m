Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220ECA5511
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 08:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjIMI6P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbjIMI6P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 04:58:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9C1993
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 01:58:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlvV85Tj0z6H7HS;
        Wed, 13 Sep 2023 16:57:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 09:58:09 +0100
Date:   Wed, 13 Sep 2023 09:58:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <20230913095808.00000df4@Huawei.com>
In-Reply-To: <20230912172005.GB319114@bgt-140510-bm03>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-3-Jonathan.Cameron@huawei.com>
        <CGME20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5@uscas1p1.samsung.com>
        <20230912172005.GB319114@bgt-140510-bm03>
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

On Tue, 12 Sep 2023 17:20:05 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Sep 11, 2023 at 12:43:11PM +0100, Jonathan Cameron wrote:
> 
> > As an encoded version of these key configuration parameters is available
> > in a register, provide functions to extract it again so as to avoid
> > the need for duplicating the storage.
> > 
> > Whilst here update the _enc() function to include additional values
> > as defined in the CXL 3.0 specification. Whilst they are not
> > currently used in the emulation, they may be in future and it is
> > easier to compare with the specification if all values are covered.
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> LGTM. Only one minor comment inline.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
Thanks!

> > +
> > +int cxl_decoder_count_dec(int enc_cnt)
> > +{
> > +    switch (enc_cnt) {
> > +    case 0x0: return 1;
> > +    case 0x1: return 2;
> > +    case 0x2: return 4;
> > +    case 0x3: return 6;
> > +    case 0x4: return 8;
> > +    case 0x5: return 10;
> > +    /* Switches and Host Bridges may have more than 10 decoders */
> > +    case 0x6: return 12;
> > +    case 0x7: return 14;
> > +    case 0x8: return 16;
> > +    case 0x9: return 20;
> > +    case 0xa: return 24;
> > +    case 0xb: return 28;
> > +    case 0xc: return 32;
> >      }
> >      return 0;
> >  }
> > @@ -410,6 +440,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
> >      }
> >  }
> >    
> 
> Similar as decoder count dec/enc, maybe we want to add a line of comment below.
> /* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */

I'll do it before cxl_interleave_ways_enc() - one function up in the file
as applies equally well there.
> 
> Fan
> > +int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
> > +{
> > +    switch (iw_enc) {
> > +    case 0x0: return 1;
> > +    case 0x1: return 2;
> > +    case 0x2: return 4;
> > +    case 0x3: return 8;
> > +    case 0x4: return 16;
> > +    case 0x8: return 3;
> > +    case 0x9: return 6;
> > +    case 0xa: return 12;
> > +    default:
> > +        error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
> > +        return 0;
> > +    }
> > +}
> > +
> >  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
> >  {
> >      switch (gran) {
> > -- 
> > 2.39.2
> > 
> >  

