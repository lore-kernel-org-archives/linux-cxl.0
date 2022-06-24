Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ACC43334
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 17:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiFXR7d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXR7d (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 13:59:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5ED49917
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 10:59:30 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LV4Zp3MCxz67xW6;
        Sat, 25 Jun 2022 01:57:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:59:27 +0200
Received: from localhost (10.81.207.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 18:59:26 +0100
Date:   Fri, 24 Jun 2022 18:59:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     <qemu-devel@nongnu.org>, <alex.bennee@linaro.org>,
        <qemu-arm@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v11 2/2] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <20220624185922.0000458f@Huawei.com>
In-Reply-To: <CAFEAcA_tck3fG67qO=4QiTHY2ST3jvy7-w156XkMKMv38-aN9g@mail.gmail.com>
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
        <20220616141950.23374-3-Jonathan.Cameron@huawei.com>
        <CAFEAcA_tck3fG67qO=4QiTHY2ST3jvy7-w156XkMKMv38-aN9g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.131]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Jun 2022 17:12:25 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 16 Jun 2022 at 15:20, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Add a single complex case for aarch64 virt machine.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  tests/qtest/cxl-test.c  | 48 +++++++++++++++++++++++++++++++++--------
> >  tests/qtest/meson.build |  1 +
> >  2 files changed, 40 insertions(+), 9 deletions(-)
> >
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index 2133e973f4..1015d0e7c2 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -17,6 +17,11 @@
> >                        "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> >                        "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> >
> > +#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
> > +                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > +                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
> > +                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > +  
> 
> If CXL requires booting via UEFI, what does this test case do?
> It doesn't seem to be passing in a BIOS image.

Not a lot beyond checking device creation is valid etc and the machine boots.

There is a bios tables test that checks we pass the right tables to the BIOS image.
I didn't duplicate that for ARM on the basis it's more or less identical, but
perhaps that is worth adding.

To do any useful functional testing will require a mass of complex OS
handling after booting. That testing is definitely something I'd like to
add, but the userspace tooling isn't all in place yet. Final kernel series that's
needed to get to the point where you can use the non volatile memory had
a new version posted yesterday.

Jonathan

> 
> thanks
> -- PMM

