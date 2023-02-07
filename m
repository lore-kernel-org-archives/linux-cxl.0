Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C1DC636CC
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBGQbZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBGQbY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 11:31:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1536A4
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 08:31:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PB7rh3hScz682wj;
        Wed,  8 Feb 2023 00:29:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 7 Feb
 2023 16:31:16 +0000
Date:   Tue, 7 Feb 2023 16:31:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230207163116.00006642@Huawei.com>
In-Reply-To: <Y9sHf+rczFO8q+jz@memverge.com>
References: <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
        <Y9meWfDiCGbca4nP@memverge.com>
        <Y9mhe2xPGRE1/7cC@memverge.com>
        <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
        <20230131235003.GA336751@bgt-140510-bm03>
        <Y9n4zjtwf+w6xnmW@memverge.com>
        <Y9rWskfaz9dLoW+l@memverge.com>
        <20230202160314.00002cfa@Huawei.com>
        <Y9riPw7ccA34FQG6@memverge.com>
        <63dbfe79dbb44_ea22229468@dwillia2-xfh.jf.intel.com.notmuch>
        <Y9sHf+rczFO8q+jz@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Feb 2023 19:44:47 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Feb 02, 2023 at 10:18:33AM -0800, Dan Williams wrote:
> > Gregory Price wrote:
> > [..]  
> > > To me, the solution here isn't to change QEMU, it's to change the kernel
> > > to try to get it to aggressively keep executable regions out of CXL by
> > > marking CXL regions into a new zone type that essentially says "Use this
> > > as a last resort only for X pages".  But that would likely require
> > > adding migration code to the likes of mprotect and friends.  
> > 
> > No, this can't be the path forward as far as I can see. QEMU is a test
> > vehicle for CXL enabling, there's no expectation that QEMU is running
> > CXL emulation in production. The quirks of how the QEMU-CXL memory
> > behaves are not something the kernel should worry about mitigating. CXL
> > is "System RAM" especially in the case when it is mapped by
> > platform-firmware. If it's not suitable to be treated as "System RAM"
> > then the onus is on platform-firmware to keep it out of the general
> > purpose pool.
> >   
> 
> Eh, you're right, just spitballing.  On real hardware this isn't an
> issue so there's no reason to change the kernel.  QEMU should just model
> the hardware.

FYI.  Richard Henderson has posted a fix. 
We should be fine going forwards on QEMU TCG. Waiting on confirmation
that it fixes the reported the instruction straddling the QEMU normal
to MMIO boundary, but looks right to me (and it's confirmed to fix
a different issue that hit same restriction).  Thanks Richard!

https://lore.kernel.org/qemu-devel/20230206193809.1153124-1-richard.henderson@linaro.org/

I hadn't even gotten a reproducer up yet so very much appreciate that
I might not have to ;)

Jonathan
