Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0865C35295
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Feb 2022 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiBGOo6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbiBGOUN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 09:20:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D183C0401C0
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 06:20:12 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jsp8l1p5Mz67YYY;
        Mon,  7 Feb 2022 22:16:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 15:20:09 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 14:20:08 +0000
Date:   Mon, 7 Feb 2022 14:20:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 00/43] CXl 2.0 emulation Support
Message-ID: <20220207142007.00004801@huawei.com>
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 2 Feb 2022 14:09:54 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Changes since v4:
> https://lore.kernel.org/linux-cxl/20220124171705.10432-1-Jonathan.Cameron@huawei.com/
> 
> Note documentation patch that Alex requested to follow.
> I don't want to delay getting this out as Alex mentioned possibly
> having time to continue reviewing in latter part of this week.
> 
> Issues identified by CI / Alex Bennée
> - Stubs added for hw/cxl/cxl-host and hw/acpi/cxl plus related meson
>   changes to use them as necessary.
> - Drop uid from cxl-test (result of last minute change in v4 that was not
>   carried through to the test)
> - Fix naming clash with field name ERROR which on some arches is defined
>   and results in the string being replaced with 0 in some of the
>   register field related defines.  Call it ERR instead.
> - Fix type issue around mr->size by using 64 bit acessor functions.
> - Add a new patch to exclude pxb-cxl from device-crash-test in similar
>   fashion to pxb.
> 
> CI tests now passing with exception of checkpatch which has what
> I think is a false positive and build-oss-fuzz which keeps timing out.
> https://gitlab.com/jic23/qemu/-/pipelines/460109208
> There were a few tweaks to patch descriptions after I pushed that
> out (I missed a few RB from Alex).
> 
> Other changes (mostly from Alex's review)
> - Change component register handling to now report UNIMP and return 0
>   for 8 byte registers as we currently don't implement any of them.
>   Note that this means we need a kernel fix:
>   https://lore.kernel.org/linux-cxl/20220201153437.2873-1-Jonathan.Cameron@huawei.com/
> - Drop majority of the macros used in defining mailbox handlers in
>   favour of written out code.
> - Use REG64 where appropriate. This was introduced whilst this set
>   has been underdevelopment so I missed it.
> - Clarify some register access options wrt to CXL 2.0 Errata F4.
> - Change timestamp to qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> - Use typed enums to enforce types of function arguements.
> - Default to cxl being off in machine_class_init() removing
>   need to set it to off in machines where there is no support as yet.
> - Add Alex's RB where given.
> 
> Looking in particular for:
> * Review of the PCI interactions
> * x86 and ARM machine interactions (particularly the memory maps)
> * Review of the interleaving approach - is the basic idea
>   acceptable?
> * Review of the command line interface.
> * CXL related review welcome but much of that got reviewed
>   in earlier versions and hasn't changed substantially.
> 
> Big TODOs:
> 
> * Interleave boundary issues. I haven't yet solved this but didn't
>   want to futher delay the review of the rest of the series.

So... After fixing my test, it became clear that Qemu won't issue
unaligned memory accesses to device unless mr->ram == true.
We can't set that for a CXL Fixed Memory Window (CFMW) as we have only an
indirect association with the CXL type3 memory devices and their
backing RAM. The interleave decoding has to sit in between.

So it 'kind of' works without any special handling as QEMU splits the
accesses into two anyway.

I don't yet understand fully the implications of this and whether
it in any real way restricts what can be done with the interleaved
memory under a CXL fixed memory region.  Would definitely appreciate
inputs on this aspect.

The really short background story is:

1) Host PA memory region (CFMW) to which expectation is any access that
would be fine to normal DDR/Ram or NVDIMMs should work as long
as appropriate CXL topology and decoder configuration has been done
to get the memory accesses to actual memory.
2) The actual accesses to PAs in that region are interleaved
via several decoders on path to memory - min granularity is 256
bytes so any given access can only end up hitting 1 or 2 devices.
3) Fun corner cases are unaligned access crossing the interleave
boundary. 

Jonathan
