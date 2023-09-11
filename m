Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE6CA0EC7
	for <linux-cxl@archiver.kernel.org>; Mon, 11 Sep 2023 22:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjIKWWJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjIKLki (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 11 Sep 2023 07:40:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB612E
        for <linux-cxl@vger.kernel.org>; Mon, 11 Sep 2023 04:40:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rkl9B1yRbz6HJq5;
        Mon, 11 Sep 2023 19:38:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 11 Sep
 2023 12:40:30 +0100
Date:   Mon, 11 Sep 2023 12:40:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/3] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230911124029.00000c37@Huawei.com>
In-Reply-To: <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
        <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
        <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 7 Sep 2023 14:41:16 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 7/9/23 13:35, Jonathan Cameron wrote:
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl_component.h |  10 ++++
> >   hw/cxl/cxl-component-utils.c   |  27 +++++----
> >   hw/cxl/cxl-host.c              |  65 ++++++++++++++-------
> >   hw/mem/cxl_type3.c             | 100 +++++++++++++++++++++++----------
> >   4 files changed, 140 insertions(+), 62 deletions(-)  
> 
> If you ever have to respin, please split the 'hdm_inc' introduction
> in a preliminary patch, to reduce the number of changes and the
> probability of missing a bug.
> 

I didn't do this originally because it's a bit interleaved with the
other changes.  I can make this separable by adding the register definitions
for HDM decoder 1 and a note that it's only used for offset calcs.

I've also pushed it into various other functions that before the
other changes in here don't attempt to deal with multiple hdm decoders
at all.

Didn't end up looking too bad.

Whilst changing this, I noticed a bug where in one place the encoded version
of the hdm count was being used undecoded. So all good in the end :)

Jonathan
