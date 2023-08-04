Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FDDC001DF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjHDOCo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjHDOCn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 10:02:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D191B9
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 07:02:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHS4f4pJsz689F7;
        Fri,  4 Aug 2023 21:59:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 15:02:39 +0100
Date:   Fri, 4 Aug 2023 15:02:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <fan.ni@samsung.com>, <dave.jiang@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/memdev: Improve sanitize ABI descriptions
Message-ID: <20230804150238.00005c89@Huawei.com>
In-Reply-To: <20230726051940.3570-2-dave@stgolabs.net>
References: <20230726051940.3570-1-dave@stgolabs.net>
        <20230726051940.3570-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 22:19:38 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Be more detailed about the CPU cache management situation. The same
> goes for both sanitize and secure erase.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6350dd82b9a9..c4c4acb1f3b3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -82,7 +82,11 @@ Description:
>  		whether it resides in persistent capacity, volatile capacity,
>  		or the LSA, is made permanently unavailable by whatever means
>  		is appropriate for the media type. This functionality requires
> -		the device to be not be actively decoding any HPA ranges.
> +		the device to be disabled, that is, not actively decoding any
> +		HPA ranges. This permits avoiding explicit global CPU cache
> +		management, relying instead for it to be done when a region
> +		transitions between software programmed and hardware committed
> +		states.

That worries me a bit.  Sounds like we are leaving a possible attack vector
after a user will assume that all data is definitely gone and their secrets secure.

I'm not sure what the attack would be, but I'd be happier if we didn't forgo
the cache evictions.  This is not exactly a fast path at any time.
However I though region tear down (and resulting HDM decoder disables) were followed
by a flush anyway so there should be nothing there...

>  
>  
>  What            /sys/bus/cxl/devices/memX/security/erase
> @@ -92,7 +96,12 @@ Contact:        linux-cxl@vger.kernel.org
>  Description:
>  		(WO) Write a boolean 'true' string value to this attribute to
>  		secure erase user data by changing the media encryption keys for
> -		all user data areas of the device.
> +		all user data areas of the device. This functionality requires
> +		the device to be disabled, that is, not actively decoding any
> +		HPA ranges. This permits avoiding explicit global CPU cache
> +		management, relying instead for it to be done when a region
> +		transitions between software programmed and hardware committed
> +		states.
>  
>  
>  What:		/sys/bus/cxl/devices/memX/firmware/

