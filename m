Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73468C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 10:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjEaKqv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 06:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEaKqu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 06:46:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B2126;
        Wed, 31 May 2023 03:46:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWQmr2KYlz6J7Mp;
        Wed, 31 May 2023 18:41:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 11:46:44 +0100
Date:   Wed, 31 May 2023 11:46:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        Andy Shevchenko <andy@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [RFC PATCH v2 4/6] i2c: aspeed: switch to generic fw
 properties.
Message-ID: <20230531114643.00006fad@Huawei.com>
In-Reply-To: <CAHp75VcjXFOG7ijEDgO7qdJiNPsBkuv_STH9e2GcSbPQDm40Mw@mail.gmail.com>
References: <20230530145601.2592-1-Jonathan.Cameron@huawei.com>
        <20230530145601.2592-5-Jonathan.Cameron@huawei.com>
        <CAHp75VcjXFOG7ijEDgO7qdJiNPsBkuv_STH9e2GcSbPQDm40Mw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 30 May 2023 22:50:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, May 30, 2023 at 5:58 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Moving over to generic firmware properties allows this driver to
> > get closer to working out of the box with both device tree and
> > other firmware options, such as ACPI via PRP0001.
> >
> > Tested only via QEMU emulation.  
> 
> ...
> 
> > -#include <linux/of_address.h>
> > -#include <linux/of_platform.h>  
> 
> > +#include <linux/property.h>  
> 
> Ah, stupid me. You can discard the previous question (in one of the
> previous emails).
> 
> ...
> 
> > +       bus->get_clk_reg_val = (u32 (*)(struct device *, u32))
> > +               device_get_match_data(&pdev->dev);  
> 
> Why not typedef this function and use it here and there?
> 
Minimizing scope of changes, but sure it's a reasonable tidy up so
a precursor patch.


Jonathan


