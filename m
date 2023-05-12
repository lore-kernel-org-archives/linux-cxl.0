Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A2C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 17:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjELRAP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjELRAO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 13:00:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77637358A
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 10:00:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvzc3s82z67nyn;
        Sat, 13 May 2023 00:56:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 18:00:11 +0100
Date:   Fri, 12 May 2023 18:00:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <20230512180010.000059f2@Huawei.com>
In-Reply-To: <qnulxxlnw224b4sjdmdv2vqe4weal4ljes2bgtq3e7ksjdez5x@3gyjww5z66w7>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-5-dave@stgolabs.net>
        <20230511160741.00004531@Huawei.com>
        <qnulxxlnw224b4sjdmdv2vqe4weal4ljes2bgtq3e7ksjdez5x@3gyjww5z66w7>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 10:23:31 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Thu, 11 May 2023, Jonathan Cameron wrote:
> 
> >> +What:           /sys/bus/cxl/devices/memX/security/sanitize
> >> +Date:           May, 2023
> >> +KernelVersion:  v6.5
> >> +Contact:        linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RW) Write a boolean 'true' string value to this attribute to
> >> +		sanitize the device to securely re-purpose or decommission it.
> >> +		This is done by ensuring that all user data and meta-data,
> >> +		whether it resides in persistent capacity, volatile capacity,
> >> +		or the LSA, is made permanently unavailable by whatever means
> >> +		is appropriate for the media type. This functionality requires
> >> +		the device to be not be actively decoding any HPA ranges.
> >> +
> >> +		Reading this file shows either "disabled" when not running, or
> >> +		"sanitize" during the duration of the sanitize operation. This
> >> +		sysfs entry is select/poll capable from userspace to notify upon
> >> +		completion.  
> >
> >A sysfs attribute that reads different from what is written is not very intuitive.
> >The one file one thing rule suggests to me that you should have a separate
> >santize_status or similar.  Or just have this read true when in progress making
> >it a self resetting toggle that returns -EBUSY if anyone tries to unset it.  
> 
> So the plan is to also to have the (cached) pmem security status (read-only):
>      /sys/bus/cxl/devices/memX/security/status
> 
> sanitize could nicely be incorporated there and just read/poll that file for all
> things security. So security/sanitize file goes to being write-only, just like
> its secure erase counter part.

That works nicely. Good plan.

> 
> >> +
> >> +
> >>  What:		/sys/bus/cxl/devices/*/devtype
> >>  Date:		June, 2021
> >>  KernelVersion:	v5.14
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index cde7270c6037..28daf7dcdec4 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -1021,6 +1021,62 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> >>
> >> +/**
> >> + * cxl_mem_sanitize() - Send a sanitation command to the device.
> >> + * @cxlds: The device data for the operation
> >> + * @cmd: The specific sanitation command opcode
> >> + *
> >> + * Return: 0 if the command was executed successfully, regardless of
> >> + * whether or not the actual security operation is done in the background,
> >> + * such as for the Sanitize case.
> >> + * Error return values can be the result of the mailbox command, -EINVAL
> >> + * when security requirements are not met or invalid contexts, or -EBUSY
> >> + * if the device is not offline.  
> >
> >What does offline mean for the device?  Perhaps a tighter definition needed.  
> 
> I can expand. But overall, with Alison's poison work being picked up, now we
> can add a cxl_memdev_active() helper to ensure no regions are mapped to this
> memdev.

Ok.
> 
> Thanks,
> Davidlohr

