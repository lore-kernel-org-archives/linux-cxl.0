Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1FC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 09:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjFAJLD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjFAJK6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 05:10:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E9123;
        Thu,  1 Jun 2023 02:10:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX0jP3q1Sz6J7QZ;
        Thu,  1 Jun 2023 17:10:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 10:10:50 +0100
Date:   Thu, 1 Jun 2023 10:10:49 +0100
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
Subject: Re: [RFC PATCH v3 6/7] i2c: aspeed: Set the fwnode for the
 adap->dev
Message-ID: <20230601101049.00003662@Huawei.com>
In-Reply-To: <CAHp75Vctpy_4yoaCWETxF_Ui7uVLzgUkfL_WqEgZdh=baYX5Uw@mail.gmail.com>
References: <20230531100600.13543-1-Jonathan.Cameron@huawei.com>
        <20230531100600.13543-7-Jonathan.Cameron@huawei.com>
        <CAHp75Vctpy_4yoaCWETxF_Ui7uVLzgUkfL_WqEgZdh=baYX5Uw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 31 May 2023 20:46:42 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, May 31, 2023 at 1:09 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > This is needed for the bus matching used for ACPI based
> > i2c client registration.  
> 
> Btw, this patch like maybe others (e.g., patch 1) can be sent already
> as non-RFC and applied independently on the goal of the entire series.
> 

True but then I have to reference two sets of precursors for
what I care about for now.  Now this is fairly stable, I'll circle
back to post these as a separate set - I can carry on referencing the
RFC from the QEMU side of things (and blog post etc I should write on this...)

Jonathan
