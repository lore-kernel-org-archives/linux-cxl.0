Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BECC7EE29
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 16:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjEYQXT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEYQXQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 12:23:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB241B5
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 09:23:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRtbD3vQHz67M5Q;
        Fri, 26 May 2023 00:21:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 17:23:11 +0100
Date:   Thu, 25 May 2023 17:23:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Message-ID: <20230525172307.00005a8b@Huawei.com>
In-Reply-To: <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230524173938.00002d7e@Huawei.com>
        <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> ss: Thats great ! Can you please share the code, both QEMU and kernel driver ?

QEMU:  http://gitlab.com/jic23/qemu cxl-2023-05-25 
https://lore.kernel.org/linux-cxl/20230525160859.32517-1-Jonathan.Cameron@huawei.com/T/#t
Kernel:  To enable ACPI support in the aspeed-i2c driver used.
https://lore.kernel.org/linux-cxl/20230525152203.32190-1-Jonathan.Cameron@huawei.com/T/#t

Other than enabling MCTP + the aspeed-i2c driver, not much special needed kernel side
(all access is from the MCTP socket interface in userspace).

Have fun.  It's pretty minimal at the moment.
For switches it pokes at the number of ports (the port status is all lies for now)
For Type 3 devices it just provide Identify.

I need to do a little more spec diving to check I've enabled them for the correct
MCTP bindings.

Jonathan
