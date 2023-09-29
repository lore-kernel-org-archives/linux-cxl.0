Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A6E732D0
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 09:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjI2JD2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjI2JDY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 05:03:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE61B1
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 02:03:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RxksF66RRz67ZCK;
        Fri, 29 Sep 2023 17:03:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 29 Sep
 2023 10:03:16 +0100
Date:   Fri, 29 Sep 2023 10:03:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/mem: Fix shutdown order
Message-ID: <20230929100316.00004546@Huawei.com>
In-Reply-To: <169596542307.790108.11339208844199665348.stgit@dwillia2-xfh.jf.intel.com>
References: <169596542307.790108.11339208844199665348.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 28 Sep 2023 22:30:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira reports that removing cxl_mock_mem causes a crash with the following
> trace:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000044
>  [..]
>  RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
>  [..]
>  Call Trace:
>   <TASK>
>   cxl_region_detach+0xe8/0x210 [cxl_core]
>   cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>   cxld_unregister+0x29/0x40 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   device_unregister+0x13/0x60
>   devm_release_action+0x4d/0x90
>   ? __pfx_unregister_port+0x10/0x10 [cxl_core]
>   delete_endpoint+0x121/0x130 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   ? lock_release+0x142/0x290
>   cdev_device_del+0x15/0x50
>   cxl_memdev_unregister+0x54/0x70 [cxl_core]
> 
> This crash is due to the clearing out the cxl_memdev's driver context
> (@cxlds) before the driver is done with it. Fix it by keeping the driver
> context valid until device unregistration completes.
Ideally good to have an explicit statement of which bit of context
is used in the cdev_device_del() call.
> 
> Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not that keen on the fix, because it makes some incidental ordering
changes and the ordering in here is messy.  What you have feels like
it's fixing on symptom whereas there are other issues here.

Firstly, as a side note given I'm looking at this
code cxl_memdev_security_shutdown() should perhaps take a
struct cxl_memdev rather than the struct device that it then
uses just to get hold of the cxl_memdev available in
cxl_memdev_shutdown().  The equivalent setup code
cxl_memdev_security_init() already does take a struct
cxl_memdev so this would be desirable for symmetry if nothing else.

However, cxl_memdev_security_shutdown() doesn't actually undo
the stuff in cxl_memdev_security_init() which previously sent me
on a wild goose chase.

Offloading that put_santize callback here to devm looks dubious to me:
https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/cxl/core/memdev.c#L1031

.. for a function mid way through a bunch of stuff that is otherwise cleaned up
by cxl_memdev_unregister() via devm here
https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/cxl/core/memdev.c#L1066
seems like a recipe for future pain. Could we just move the put_santize()
call directly into cxl_memdev_unregister() and the error path in
cxl_memdev_add_dev() and make sure the order is as expected.

I had a long argument written up on why cxl_memdev_security_shutdown()
was in the wrong place in the new sequence before seeing that it
didn't balance with what I assumed it did.  So probably still in an illogical
place given I'd expect all the 'security stuff' to be initialized at same
point in setup and tear down sequences (reversed obviously.)

Thanks,

Jonathan






> ---
>  drivers/cxl/core/memdev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..92d40c5e7efb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -580,8 +580,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> -	cxl_memdev_shutdown(dev);
>  	cdev_device_del(&cxlmd->cdev, dev);
> +	cxl_memdev_shutdown(dev);
>  	put_device(dev);
>  }
>  
> 

