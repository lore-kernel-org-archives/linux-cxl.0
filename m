Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C744C77B72
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 13:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNNnT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNNnS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 09:43:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845FEE4
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 06:43:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pycz024PQz6JDrD;
        Fri, 14 Apr 2023 21:40:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 14:43:12 +0100
Date:   Fri, 14 Apr 2023 14:43:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Wire up interrupts for background
 completion
Message-ID: <20230414144311.00007b15@Huawei.com>
In-Reply-To: <b3d67b5ygaxstcge2lzajrueqrddj6hjlx42s2qdxuksfdzify@wtgmzbpavzdv>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-3-dave@stgolabs.net>
        <20230403175224.00004c3f@Huawei.com>
        <b3d67b5ygaxstcge2lzajrueqrddj6hjlx42s2qdxuksfdzify@wtgmzbpavzdv>
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

On Tue, 11 Apr 2023 19:22:44 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 03 Apr 2023, Jonathan Cameron wrote:
> 
> >Also, the interrupt setup for the PCI cap is missing I think.
> >See handling in ct3_realize()  
> 
> Hmm how is this any different that what is already there
> for events and cpmu? Once msi is initialized for the device,
> I didn't expect any other setup necessary - and I'm also
> receiving irqs fine with this patch at the driver side.

Ah. Seems you are sharing with the DOE for the compliance
mailbox - probably not the intent but as we have no code
that binds to that at the moment I guess you won't notice
the sharing.  It should be harmless but I'd put this on 11
and increase msix_num in ct3_realize.

At somepoint I need to make all the msix code for all usecase
deal with the OS asking for fewer vectors.  Not a problem with
Linux as it always grabs them all, but the emulation isn't currently
spec compliant as those numbers should 'squish' into the available
space if not enough is requested.

When that's not happening I should add an enum for msix vectors
so that we can more easily reorder the patches that add them.

Jonathan


> 
> Thanks,
> Davidlohr

