Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F4C54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 19:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAZTe3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 14:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAZTe2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 14:34:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF075C0DE
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 11:34:27 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2rQK6p7Sz67J5b;
        Fri, 27 Jan 2023 03:30:17 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 19:34:24 +0000
Date:   Thu, 26 Jan 2023 19:34:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230126193424.00005034@huawei.com>
In-Reply-To: <20230126185025.000016a0@huawei.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
        <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
        <20230126185025.000016a0@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 26 Jan 2023 18:50:25 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 25 Jan 2023 22:29:15 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dan Williams wrote:  
> > > There are still some sharp edges on this patchset, like the missing
> > > device-dax hookup, but it is likely enough to show the direction and
> > > unblock other testing. Specifically I want to see how this fares with
> > > Greg's recent volatile region provisioning in QEMU.
> > > 
> > > I am hoping to have those last bits ironed out before the end of the
> > > week. Note that this topic branch will rebase so do not base any
> > > work beyond proof-of-concept on top of it.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region    
> > 
> > I also spotted at least one bug-fix that needs to be broken out and
> > submitted separately, so reviewer-beware at this stage.  
> 
> So far I'm failing to set target0 via echo which is wonderfully getting
> an error of SUCCESS.  So I think you are returning rc == 0 somewhere.
> 
> 
> Ah. There is a shadowed int rc variable in store_targetN() else
> 
> Now to figure out why attach_target() is failing.  I probably have
> the config sequence wrong as I've just bodged an existing one I had
> for pmem.
> 
I was trying to add it to a pmem region. Oops.

Can successfully bind the region driver. But not sure how to test
beyond that.

Basically I got to the helpful 'TODO hook up devdax' as you mention above.
Looks like decoders are programmed correctly as I can read and write from
the HPA using devmem2.

So far I've just tested single direct connected device.

This is against http://gitlab.com/jic23/qemu cxl-2023-01-26 which has been
there for a good 30 seconds. Mostly unrelated changes wrt to this work, but
it includes a few trivial tweaks to Gregory's patches as discussed on list.

Thanks for sharing this early version. It unsticks Gregory's series as far as
I'm concerned (if there is anything broken in more complex tests that won't
be related to Gregory's stuff that only effects type 3 devices).

Jonathan

