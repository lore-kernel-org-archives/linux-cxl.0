Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7CC001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHKNti convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjHKNth (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 09:49:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E818F
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 06:49:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RMlRt0tJ1z6J6fr
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 21:45:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 11 Aug
 2023 14:49:33 +0100
Date:   Fri, 11 Aug 2023 14:49:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ravi Kanth <mvrravikanth@gmail.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: Support for CXL v3.0 spec with QEMU
Message-ID: <20230811144932.00005c05@Huawei.com>
In-Reply-To: <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
        <20230810173322.0000543c@Huawei.com>
        <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Aug 2023 22:10:48 +0530
Ravi Kanth <mvrravikanth@gmail.com> wrote:

> Thanks Jonathan for pointing this out. I will definitely take a look
> at this. Current support for the simulation of CCI mailbox is only via
> MCTP messages or even via CXL driver IOCTLs?

For switch CCI PCI function it's via CXL driver IOCTLs. 

You will need:
https://lore.kernel.org/linux-cxl/20230804115414.14391-1-Jonathan.Cameron@huawei.com/T/#t
though which is an RFC for the kernel side of things. Examples in the cover letter.
(including relevant QEMU command line interface).

For MCTP you need a bunch of other stuff as we can only use the ASPEED I2C controller
today as it's the only one with MCTP support. The upstream driver doesn't handle ACPI,
so you need:
https://lore.kernel.org/linux-cxl/20230531100600.13543-1-Jonathan.Cameron@huawei.com/
which includes various things I should upstream and some hacks to deal with the reset
that are not suitable for upstream.


> 
> Ravi
> 
> On Thu, Aug 10, 2023 at 10:03 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 10 Aug 2023 21:42:12 +0530
> > Ravi Kanth <mvrravikanth@gmail.com> wrote:
> >  
> > > Hello,  
> >
> > Hi Ravi,
> >  
> > >
> > > I am writing this mail to know if the latest QEMU has support for CXL
> > > spec v3.0? I understand from the older tutorials that QEMU has support
> > > for CXL v2.0. Is there any update to QEMU to support the CXL v3.0? I
> > > would like to specifically test the CCI mailbox functionality which
> > > has been added to CXL v3.0 spec.  
> >
> > The nature of the CXL specification and the QEMU support is that for
> > devices there isn't a clear divide between different generations of
> > the specification. By that I mean, that a device based on the CXL 2.0
> > specification is compatible with the CXL 3.0 specification. As such,
> > the QEMU emulation has focused on features of interest - it is a far
> > from complete implementation of all the options in the CXL 2.0
> > specification but conversely there are some parts of CXL 3.0 are supported.
> >
> > Note that the particular CCI functionality is not yet ready for CXL upstream,
> > but we do have some support in the staging tree I maintain.
> >
> > https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
> > specifically
> > https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea894a1d27625a4b80c
> >
> > Note at this stage we only support subset of commands.
> > Contributions of more support welcomed!
> >
> > Intent of the current support and related MCTP CCI access (over I2C) is
> > to enable ecosystem development, particularly of fabric managers.
> > For that a tiny subset of commands was sufficient to be sure the architecture
> > inside QEMU worked and that the proposed kernel code functions correctly.
> >
> > Jonathan
> >  
> > >
> > > Thank you in advance for your assistance.
> > >
> > > Ravi  
> >  
> 
> 

