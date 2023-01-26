Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F9C05027
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAZSub (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAZSua (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 13:50:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED43B125A5
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 10:50:28 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2qWS1M7Bz689lY;
        Fri, 27 Jan 2023 02:49:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 18:50:26 +0000
Date:   Thu, 26 Jan 2023 18:50:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230126185025.000016a0@huawei.com>
In-Reply-To: <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
        <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 25 Jan 2023 22:29:15 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dan Williams wrote:
> > There are still some sharp edges on this patchset, like the missing
> > device-dax hookup, but it is likely enough to show the direction and
> > unblock other testing. Specifically I want to see how this fares with
> > Greg's recent volatile region provisioning in QEMU.
> > 
> > I am hoping to have those last bits ironed out before the end of the
> > week. Note that this topic branch will rebase so do not base any
> > work beyond proof-of-concept on top of it.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region  
> 
> I also spotted at least one bug-fix that needs to be broken out and
> submitted separately, so reviewer-beware at this stage.

So far I'm failing to set target0 via echo which is wonderfully getting
an error of SUCCESS.  So I think you are returning rc == 0 somewhere.


Ah. There is a shadowed int rc variable in store_targetN() else

Now to figure out why attach_target() is failing.  I probably have
the config sequence wrong as I've just bodged an existing one I had
for pmem.

Jonathan
