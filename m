Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5870EC7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjFBMZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjFBMZZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 08:25:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E31AE
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 05:25:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXhws04W1z67lKb;
        Fri,  2 Jun 2023 20:23:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:25:18 +0100
Date:   Fri, 2 Jun 2023 13:25:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Message-ID: <20230602132517.00006793@Huawei.com>
In-Reply-To: <DM6PR18MB2844DA254DE3754A3E07AC92AF49A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230524173938.00002d7e@Huawei.com>
        <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230525172307.00005a8b@Huawei.com>
        <DM6PR18MB2844DA254DE3754A3E07AC92AF49A@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 1 Jun 2023 23:07:54 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> Thanks a lot. It works. I am planning to add more CXL commands, especially DCD commands. Are you or any one working ? If so I will wait :)

It's on my todo list, but I'm more than happy if you do it instead.

I'll get on with something else:
I want to get the mailbox based tunneling working so that we have that
path for MHDs as well which is reasonable separate at this stage anyway
- later on we'll want to factor out some common solutions - I suspect
a lot of the actual command responses will be done in hw/mem/cxl_type3.c
and hw/pci-bridge/cxl_upstream.c, but for now it's convenient
to keep them separate.  The switch CCI stuff needs to be in the mix as well
and will likely look a bit like how the mctp CCI hooks into the switch USP.
The old prototype of that didn't talk to the devices at all so was returning
made up responses.

Jonathan



> 
> 
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, May 25, 2023 9:23 AM
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU 
>  
> 
> > ss: Thats great ! Can you please share the code, both QEMU and kernel driver ?  
> 
> QEMU:  https://urldefense.proofpoint.com/v2/url?u=http-3A__gitlab.com_jic23_qemu&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=UQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3LxL&s=DWzpkbi44uasdoDv_GxAR2to07vEd_Cr7eaKz0lpP6E&e=  cxl-2023-05-25 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dcxl_20230525160859.32517-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=UQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3LxL&s=3zV1e3KB_3wAesmu5jsYP7YodFFgzjydMl0vICy6Tis&e= 
> Kernel:  To enable ACPI support in the aspeed-i2c driver used.
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dcxl_20230525152203.32190-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=UQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3LxL&s=tPmsOiZy9jqzAIFK46Nj_WIzpX7WNf5bxge2uZUa2Yg&e= 
> 
> Other than enabling MCTP + the aspeed-i2c driver, not much special needed kernel side
> (all access is from the MCTP socket interface in userspace).
> 
> Have fun.  It's pretty minimal at the moment.
> For switches it pokes at the number of ports (the port status is all lies for now)
> For Type 3 devices it just provide Identify.
> 
> I need to do a little more spec diving to check I've enabled them for the correct
> MCTP bindings.
> 
> Jonathan
