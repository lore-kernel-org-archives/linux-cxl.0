Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7834FC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLTPff (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLTPfe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 10:35:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3D16589
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 07:35:32 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nc0wq3XSDz6H6pr;
        Tue, 20 Dec 2022 23:34:03 +0800 (CST)
Received: from localhost (10.81.208.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 15:35:29 +0000
Date:   Tue, 20 Dec 2022 15:35:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mem: Support sanitation commands
Message-ID: <20221220153528.00000a15@Huawei.com>
In-Reply-To: <20221219204744.rna4khfjdyt4dugx@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
        <20221206011501.464916-3-dave@stgolabs.net>
        <20221219174329.000073c3@Huawei.com>
        <20221219204744.rna4khfjdyt4dugx@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.216]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 19 Dec 2022 12:47:44 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 19 Dec 2022, Jonathan Cameron wrote:
> 
> >On Mon,  5 Dec 2022 17:15:00 -0800
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Implement support for the non-pmem exclusive sanitize (aka overwrite)
> >> and secure erase commands, per CXL specs.
> >>
> >> To properly support this feature, create a 'security' sysfs file that
> >> when read will list the current pmem security state or overwrite, and
> >> when written to, perform the requested operation.
> >>
> >> As with ndctl-speak, the use cases here would be:
> >>  
> >> $> cxl sanitize --erase memX
> >> $> cxl sanitize --overwrite memX
> >> $> cxl sanitize --wait-overwrite memX  
> >>
> >> Where userspace can implement entirely the wait/query mechanism for
> >> waiting for the sanitize to complete (albeit no poll support for
> >> the security sysfs file).
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >
> >Hi Davidlohr,
> >
> >Given I'm late to the game and there has been lots of discussion I'll
> >focus on just the ABI.
> >  
> >> +What:		/sys/bus/cxl/devices/memX/security
> >> +Date:		December, 2022
> >> +KernelVersion:	v6.2
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		Reading this file will display the security state for that
> >> +		device. The following states are available: disabled, frozen,
> >> +		locked, unlocked and overwrite. When writing to the file, the
> >> +		following commands are supported:
> >> +		* overwrite - Sanitize the device to securely re-purpose or
> >> +		  decommission it. This is done by ensuring that all user data
> >> +		  and meta-data, whether it resides in persistent capacity,
> >> +		  volatile capacity, or the label storage area, is made
> >> +		  permanently unavailable by whatever means is appropriate for
> >> +		  the media type. This causes all CPU caches to be flushed.
> >> +		* erase - Secure Erase user data by changing the media encryption
> >> +		  keys for all user data areas of the device. This causes all
> >> +		  CPU caches to be flushed.  
> >
> >General rule of sysfs is one file, one thing.  I think this interface needs splitting.
> >RO attribute security_state
> >WO attribute security_overwrite (or maybe security_sanitize as overwriting is an
> >  implementation choice?)
> >WO attribute security_erase  
> 
> Fine by me. How about instead: security/{state, sanitize, erase}?

Sounds good.

Jonathan
