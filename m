Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E3EC3DA7D
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjAEOiP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAEOiO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 09:38:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48ED59331
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 06:38:11 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NnptJ48YXz6J6Hs;
        Thu,  5 Jan 2023 22:35:52 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 14:38:08 +0000
Date:   Thu, 5 Jan 2023 14:38:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 2/3] tests/qtest/cxl-test: whitespace, line ending
 cleanup
Message-ID: <20230105143807.0000315a@huawei.com>
In-Reply-To: <20221128150157.97724-3-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-3-gregory.price@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Nov 2022 10:01:56 -0500
Gregory Price <gourry.memverge@gmail.com> wrote:

> Defines are starting to exceed line length limits, align them for
> cleanliness before making modifications.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Hi Gregory,

I was just reordering my tree and noticed that you've only
gone with 2 space indent.  Given 4 spaces is the convention in QEMU
for other uses, I've switched my local copy of this over to 4 spaces.

Note there was also a single inconsistent 1 space indent - see below.

Jonathan

> 
> ---
>  tests/qtest/cxl-test.c | 99 +++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index c54f18e76b..e59ba22387 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -8,55 +8,64 @@
>  #include "qemu/osdep.h"
>  #include "libqtest-single.h"
>  
> -#define QEMU_PXB_CMD "-machine q35,cxl=on " \
> -                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> -                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> -
> -#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
> -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> -
> -#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
> -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
> -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> -
> -#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> +#define QEMU_PXB_CMD \
> +  "-machine q35,cxl=on " \
> +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> +
> +#define QEMU_2PXB_CMD \
> +  "-machine q35,cxl=on " \
> +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> + "- M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
This one only has one space.

> +
> +#define QEMU_VIRT_2PXB_CMD \
> +  "-machine virt,cxl=on " \
> +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
> +#define QEMU_RP \
> +  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>  
>  /* Dual ports on first pxb */
> -#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> -                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
> +#define QEMU_2RP \
> +  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> +  "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
>  
>  /* Dual ports on each of the pxb instances */
> -#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> -                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
> -                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
> -                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
> -
> -#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
> -
> -#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> -                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
> -
> -#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> -                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
> -                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
> -                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
> +#define QEMU_4RP \
> +  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> +  "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
> +  "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
> +  "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
> +
> +#define QEMU_T3D \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
> +
> +#define QEMU_2T3D \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> +  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
> +
> +#define QEMU_4T3D \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> +  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
> +  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
> +  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
>  
>  static void cxl_basic_hb(void)
>  {

