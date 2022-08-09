Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAAEC19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 16:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiHIQIn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbiHIQId (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 12:08:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DCC1FCF2
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 09:08:28 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2Hwm10Sdz685PJ;
        Wed, 10 Aug 2022 00:05:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 9 Aug 2022 18:08:26 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 9 Aug
 2022 17:08:26 +0100
Date:   Tue, 9 Aug 2022 17:08:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bobo WL <lmw.bobo@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <20220809170825.00001b61@huawei.com>
In-Reply-To: <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
        <20220808133727.00001171@huawei.com>
        <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 9 Aug 2022 21:07:06 +0800
Bobo WL <lmw.bobo@gmail.com> wrote:

> Hi Jonathan
> 
> Thanks for your reply!
> 
> On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Probably not related to your problem, but there is a disconnect in QEMU /
> > kernel assumptionsaround the presence of an HDM decoder when a HB only
> > has a single root port. Spec allows it to be provided or not as an implementation choice.
> > Kernel assumes it isn't provide. Qemu assumes it is.
> >
> > The temporary solution is to throw in a second root port on the HB and not
> > connect anything to it.  Longer term I may special case this so that the particular
> > decoder defaults to pass through settings in QEMU if there is only one root port.
> >  
> 
> You are right! After adding an extra HB in qemu, I can create a x1
> region successfully.
> But have some errors in Nvdimm:
> 
> [   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
> [   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
> [   74.927470] nd_region region0: nmem0: is disabled, failing probe

Ah. I've seen this one, but not chased it down yet.  Was on my todo list to chase
down. Once I reach this state I can verify the HDM Decode is correct which is what
I've been using to test (Which wasn't true until earlier this week). 
I'm currently testing via devmem, more for historical reasons than because it makes
that much sense anymore.  

> 
> And x4 region still failed with same errors, using latest cxl/preview
> branch don't work.
> I have picked "Two CXL emulation fixes" patches in qemu, still not working.
> 
> Bob
