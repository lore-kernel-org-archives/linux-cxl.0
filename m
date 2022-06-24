Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF685C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 14:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiFXOJF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiFXOIx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 10:08:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2364FC4D
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 07:08:52 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LTzVV11Wqz67sTc;
        Fri, 24 Jun 2022 22:08:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 24 Jun 2022 16:08:49 +0200
Received: from localhost (10.81.207.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 15:08:48 +0100
Date:   Fri, 24 Jun 2022 15:08:44 +0100
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
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 1/2] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20220624150844.000005ec@Huawei.com>
In-Reply-To: <CAFEAcA8GA+ZXr2eS9bVxnhZRtda17Wx0Ud8CfcA90T6yiaecew@mail.gmail.com>
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
        <20220616141950.23374-2-Jonathan.Cameron@huawei.com>
        <CAFEAcA8U9oNDStfLpxOwodGm9MCTdLrt-WV+x_-rTGw9UpBGvA@mail.gmail.com>
        <20220624133909.00005f6e@Huawei.com>
        <CAFEAcA8GA+ZXr2eS9bVxnhZRtda17Wx0Ud8CfcA90T6yiaecew@mail.gmail.com>
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

On Fri, 24 Jun 2022 13:56:32 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 24 Jun 2022 at 13:39, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 24 Jun 2022 11:48:47 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > >
> > > This seems to be missing code to advertise the new devices in the
> > > device tree.  
> >
> > Intentionally. I am not aware of any current interest
> > in defining DT support CXL or supporting it in operating systems.
> > Easy enough to add if anyone does the leg work to figure out the
> > bindings, but that needs to come from someone who cares and
> > would need to be driven by OS support and a usecase. The ACPI
> > stuff here is defined as part of the main CXL spec because the
> > target class of machines simply doesn't generally use DT.  
> 
> I don't really want new devices in the virt board that aren't
> usable in the common use case of "just pass a kernel with -kernel"...
> 
> -- PMM

Ok.  In that case, what do you suggest?  

Options I can think of:

1) I can come up with plausible DT bindings, but I'm not sure how
that will be received by the kernel community, It will add a bunch of
infrastructure to maintain that may be seen as useless at least in
the short to medium term. Hence is not in anyone's test matrices etc.

Dan, how open would you be to adding DT support? We'd have to ignore
some of the firmware query stuff like QTGs as there isn't an equivalent
in DT - or we'd have to go as far as defining actual devices with
mailboxes to query that info.

2) Add it to something like the SBSA machine, but that brings a large
burden in firmware etc and need to communicate everything via DT to
EDK2 that is needed to build the ACPI tables in a flexible fashion +
mass of EDK2 development.  Whilst the SBSA model is great for ARM
specific stuff, requiring the large additional complexity in
actually using it to test arch independent software is probably
going to just mean it bit rots.

3) Fork virt (obviously sharing as much as possible), potentially I
guess that could be pretty light weight by declaring a new
TypeInfo that is very nearly identical to virt with just the few extra
calls inserted. 

Any other routes open to me to getting this support available?

Jonathan


