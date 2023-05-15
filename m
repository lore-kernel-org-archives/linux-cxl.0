Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E30C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 12:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbjEOMDc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjEOMDP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 08:03:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC1359E
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 05:01:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKdGY72Rkz687PR;
        Mon, 15 May 2023 20:00:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 13:01:50 +0100
Date:   Mon, 15 May 2023 13:01:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -qemu rfc 0/3] hw/cxl: Add support for Scan Media
Message-ID: <20230515130150.0000355f@Huawei.com>
In-Reply-To: <20230426021418.10186-1-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Apr 2023 19:14:15 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hi,
> 
> The following is a very early rfc for supporting the rest of the Media an Poison
> mailbox commands, extending what is currently there for background command support
> and making use of the poison list infrastructure. The kernel is also pretty much
> at the same point, for which the motivation of this series is to help aid any
> incoming driver support. Similarly testing is 0 but sending this early hoping for
> feedback to at least know if I'm going in the right direction while the kernel bits
> are developed.
> 
> A few general notes:
>  o I have no particular affinity to the values provided for media scan hinting times.
>    Feel free to suggest new ones.

Look fine to me.

>  
>  o Scan Media will directly update the poison list, with its own special type,
>    based on random values (number of new poison entries and actual dpa).

I comment on this in the code.  There is no such type and we shouldn't need to
invent one - all poison is just poison.  The question is whether a device can
track it or not.  QEMU can track anything, but pretends it has limited tracking
resources. 

>    
>  o As with the current poison commands, this needs proper checking of input dpa
>    ranges to: 1) ensure it fits within the actual address space of the device
>    (ie: compare query_start/len to memdev's  mr->addr through cxl_dstate->mem_size
>    ranges). And 2) ensure that the passed range does not span both ram and pmem
>    devices, albeit unlikely for the qemu cases.

Why unlikely specifically for QEMU cases? Or do you mean no OS should do this
so we should never hit the test?

> 
>  o DRAM Event Logs are not generated for every new poisoned dpa. 

Agreed that needs fixing for the Poison injection in general. It needs to happen
after all the moving parts are in place though as it's hard enough to get those
series merged without adding complex interactions from the start.

> afaict we will
>    need to have a scan media version of the qmp event error injection interface,
>    as I don't see qmp being usable for scan media.

I don't understanding why we don't just use the existing QMP poison injection interface.
Just keep injecting poison after we have overflowed the list. That hidden record
of poison is only available if we use the scan media command.
Get Poison List just reports the first part.  Then if you clear poison it will actually
clear (that shouldn't care if it's in the list or not).

The only subtle part is how we clear the overflow event (not just because the list is
no longer overflowed, but only on explicit call of scan media on the whole address
range that doesn't find an overflow.

>  
>  o Getting the scan results inherits the current get poison list limitations,
>    such as limited number of records, so only one call is necessary.

Yeah. We should relax that at somepoint, but not yet I think!

> 
> Series applies on top of Jonathan's 'cxl-2023-04-19' branch, which fyi has the
> v1 version of the bg cmd support (required for this series), so will require
> rebasing eventually:
> 	https://gitlab.com/jic23/qemu/-/tree/cxl-2023-04-19

I'll get to rebasing that and collecting new version in a few days time (probably).
I promised myself I'd catch up with review first... :)

Jonathan

> 
> Thanks!
> 
> Davidlohr Bueso (3):
>   hw/cxl: Add get scan media capabilities mailbox command support
>   hw/cxl: Add scan media mailbox command support
>   hw/cxl: Add scan media mailbox command support
> 
>  hw/cxl/cxl-mailbox-utils.c  | 225 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |   3 +
>  include/hw/cxl/cxl_device.h |   8 ++
>  3 files changed, 233 insertions(+), 3 deletions(-)
> 
> --
> 2.40.0
> 
> 

