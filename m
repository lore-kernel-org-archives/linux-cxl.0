Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81340C7EE23
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 14:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjEVOlo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEVOlm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 10:41:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59ADB0
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 07:41:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ0QV5P9Qz67nrk;
        Mon, 22 May 2023 22:37:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 15:41:36 +0100
Date:   Mon, 22 May 2023 15:41:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: I2C Multi-master and Controller Slave Mode in QEMU
Message-ID: <20230522154135.00002be3@Huawei.com>
In-Reply-To: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 19:43:25 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> Hi,
>    Is there any implementation of I2C Multi-master and Controller Slave Mode in QEMU for x86 ?
> 
> What I want is to create CXL-I2C device that can exercise DCD commands via FM-API. For that I need a bus that can support both master and slave on x86. Is there one available ?

I have a side project underway to make this work.  It will be a little 'unusual'
as it'll bolt an aspeed-i2c controller with the right support onto an x86 host.
Might take me a few more days to get that working.  I have it up and running
with ACPI on an arm64 host (a few minor tweaks needed to the aspeed-i2c kernel
driver which I'll also post - mostly upstreamable but there are a couple of
hacks for now).

Currently that aspeed device is the only i2c controller that supports MCTP that has
some patches on list to do everything you want.

> 
> The second question is, can qemu-cxltype3 device be used on ARM ?

Yes, but you need the out of mainline patches from
gitlab.com/jic23/qemu Use the previous dated tag though as latest has some issues
(bad choice of base which turned out to crash :)

I'll be putting together a fixed version of that in next day or two.

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-04-19?ref_type=heads
for now.

That includes support for the aspeed-i2c controller but with dt only which isn't
that helpful if you want to also use the CXL drivers.

Anyhow, it's a watch this space for now. Hopefully I'll get the PoC code in a shape
to share later this week.

Jonathan



