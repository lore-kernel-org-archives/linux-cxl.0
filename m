Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11EBC54EED
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 13:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjA3NY6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 08:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3NY4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 08:24:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B034004
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 05:24:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P585l08WQz6J9xg;
        Mon, 30 Jan 2023 21:23:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 13:24:52 +0000
Date:   Mon, 30 Jan 2023 13:24:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230130132451.00002d5b@Huawei.com>
In-Reply-To: <20221128150157.97724-4-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index e59ba22387..6893f54e28 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -40,32 +40,46 @@
>    "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
>    "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
>  
> -#define QEMU_T3D \
> +#define QEMU_T3D_DEPRECATED \
>    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
>    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
>  
> +#define QEMU_T3D_PMEM \
> +  "-object memory-backend-file,id=m0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-m0,lsa=lsa0,id=pmem0 "
naming mismatch. I've fixed up with mem0 as the device name. 
The naming isn't totally consistent so I may tweak this some more before
sending for upstream.


