Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD82BC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 16:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjEXQjz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEXQjp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 12:39:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA736E9
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 09:39:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRH1N6JP5z67pnk;
        Thu, 25 May 2023 00:38:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 17:39:39 +0100
Date:   Wed, 24 May 2023 17:39:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Message-ID: <20230524173938.00002d7e@Huawei.com>
In-Reply-To: <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 23 May 2023 22:08:21 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, May 22, 2023 7:41 AM
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU 
>  
> External Email
> 
> ----------------------------------------------------------------------
> On Fri, 19 May 2023 19:43:25 +0000
> Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:
> 
> > Hi,
> >    Is there any implementation of I2C Multi-master and Controller Slave Mode in QEMU for x86 ?
> > 
> > What I want is to create CXL-I2C device that can exercise DCD commands via FM-API. For that I need a bus that can support both master and slave on x86. Is there one available ?  
> 
> I have a side project underway to make this work.  It will be a little 'unusual'
> as it'll bolt an aspeed-i2c controller with the right support onto an x86 host.
> Might take me a few more days to get that working.  I have it up and running
> with ACPI on an arm64 host (a few minor tweaks needed to the aspeed-i2c kernel
> driver which I'll also post - mostly upstreamable but there are a couple of
> hacks for now).
> 
> Currently that aspeed device is the only i2c controller that supports MCTP that has
> some patches on list to do everything you want.
> 
> SS: I was able to get MCTP working on openBMC + ARM. But I was interested in using MCTP on x86. I will look forward for your patch.

I now have it running on both ARM (ACPI + DT) and x86 (ACPI).

Needs a few hacks on the relevant i2c driver in the kernel and unfortunately at least
one of those probably isn't ever going to be upstreamable.

However, that aside it all works nicely.

> 
> > 
> > The second question is, can qemu-cxltype3 device be used on ARM ?  
> 
> Yes, but you need the out of mainline patches from
> gitlab.com/jic23/qemu Use the previous dated tag though as latest has some issues
> (bad choice of base which turned out to crash :)
> 
> I'll be putting together a fixed version of that in next day or two.
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_jic23_qemu_-2D_tree_cxl-2D2023-2D04-2D19-3Fref-5Ftype-3Dheads&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=HjxYTjPnn1_sL7TKjONiz2tjg7Wgb2SHDpdPWugtqp91xBPuXM8apydEWLy-PNOA&s=KPl9oVgiVvYj9UcBRp7CohPsuEPicbpQzsFLV7uieOw&e= 
> for now.
> 
> That includes support for the aspeed-i2c controller but with dt only which isn't
> that helpful if you want to also use the CXL drivers.
> 
> Anyhow, it's a watch this space for now. Hopefully I'll get the PoC code in a shape
> to share later this week.
> 
> Do you mean to say, if I take patch from gitlab.com/jic23/qemu, can I boot linux on ARM and use CXL kernel drivers ?

Yes, though use a slightly old version for now as I think the latest one crashes for
reasons that I never tracked down (think it was just an unlucky base).

Once I have done a tiny bit more tidying up of this MCTP stuff I'll get back to ensuring
there is a stable branch at that address and put the MCTP stuff on top.

It's minimal at the moment:
* Identify from CCI command set
* A few FM-API physical switch commands,

However that should be enough that it's fairly obvious how to extend it to add
lots more commands and hopefully others will jump in at that point.

Main job I still need to do is write some docs on how to bring it up + userspace
tooling to use etc.

Jonathan


> Thanks
> Shesha
> 
> Jonathan
> 
> 

