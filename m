Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A906C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 17:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiAYRwC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:52:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4514 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiAYRvm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 12:51:42 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjvTN6TK1z689wD;
        Wed, 26 Jan 2022 01:48:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 18:51:34 +0100
Received: from localhost (10.47.28.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 17:51:33 +0000
Date:   Tue, 25 Jan 2022 17:51:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 29/42] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Message-ID: <20220125175130.00005a46@Huawei.com>
In-Reply-To: <87sftbd9y9.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-30-Jonathan.Cameron@huawei.com>
        <87sftbd9y9.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.28.100]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jan 2022 17:02:32 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> > The concept of these is introduced in [1] in terms of the
> > description the CEDT ACPI table. The principal is more general.
> > Unlike once traffic hits the CXL root bridges, the host system
> > memory address routing is implementation defined and effectively
> > static once observable by standard / generic system software.
> > Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> > which has fixed system dependent routing configured so that
> > accesses can be routed to the CXL devices below a set of target
> > root bridges. The accesses may be interleaved across multiple
> > root bridges.  
> 
> This breaks the linux-user builds...
> > diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> > index 0eca715d10..27dff3868b 100644
> > --- a/hw/cxl/meson.build
> > +++ b/hw/cxl/meson.build
> > @@ -1,5 +1,9 @@
> > -softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
> > -  'cxl-component-utils.c',
> > -  'cxl-device-utils.c',
> > -  'cxl-mailbox-utils.c',
> > +specific_ss.add(when: 'CONFIG_CXL', if_true: files(
> > +      'cxl-component-utils.c',
> > +      'cxl-device-utils.c',
> > +      'cxl-mailbox-utils.c',
> > +      'cxl-host.c',
> > +))
> > +specific_ss.add(when: 'CONFIG_CXL', if_false: files(
> > +      'cxl-host-stubs.c',
> >  ))  
> 
> I think you want this:
> 
>   softmmu_ss.add(when: 'CONFIG_CXL',
>                  if_true: files(
>                    'cxl-component-utils.c',
>                    'cxl-device-utils.c',
>                    'cxl-mailbox-utils.c',
>                    'cxl-host.c'),
>                  if_false: files(
>                    'cxl-host-stubs.c',
>                  ))
> 
>   # This is required as well:
>   softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))

Ah.  I'd started with the first block and got incomprehensible error
message.  Second block fixes it.

I'll not pretend to understand the 'why' :)

Thanks,

Jonathan

> 
> 

