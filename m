Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2CCC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 26 May 2022 12:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiEZMKs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 May 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiEZMKr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 May 2022 08:10:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9B6FA35
        for <linux-cxl@vger.kernel.org>; Thu, 26 May 2022 05:10:46 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L86BT5wtPz67MpP;
        Thu, 26 May 2022 20:07:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 14:10:43 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:10:42 +0100
Date:   Thu, 26 May 2022 13:10:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
CC:     "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v11 0/2] hw/arm/virt: CXL 2.0 emulation support
Message-ID: <20220526131041.000077e2@Huawei.com>
In-Reply-To: <20220520163732.27545-1-Jonathan.Cameron@huawei.com>
References: <20220520163732.27545-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 20 May 2022 17:37:30 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The initial CXL support including support on x86/pc has now merged
> (thanks Michael!).
> 
> This is the first of the two remaining parts of that series, unchanged
> since v10.  The second is CXL switch support which can be applied
> separately to this series and will be sent shortly.
> 
> CXL support requires two types of memory regions and this hooks them
> up in arm/virt.
> 
> 1) CXL host bridge control register regions.  This allows for up to
>    16 host bridges which should keep anyone happy. The CEDT ACPI table
>    is used by system software to find these regions.
> 2) CXL Fixed Memory Windows. CFMWs are regions of PA space that are
>    configured to perform interleaved accesses over multiple host bridges.
>    They are fixed, but the OS may select between multiple CFMWs to find
>    one suitable for the interleave it desires.  All interleave in the
>    host bridges and switches is programmable and discoverable - only
>    these top level regions are static and described to system software
>    via another structure in CEDT.
> 
> A simple test cases is added to existing cxl-test qtest.
> 
> Jonathan Cameron (2):
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   qtest/cxl: Add aarch64 virt test for CXL
> 
>  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++
>  hw/arm/virt.c            | 40 ++++++++++++++++++++++++++++++++-
>  include/hw/arm/virt.h    |  1 +
>  tests/qtest/cxl-test.c   | 48 ++++++++++++++++++++++++++++++++--------
>  tests/qtest/meson.build  |  1 +
>  5 files changed, 113 insertions(+), 10 deletions(-)
> 

Note I'll send out a v12 of this series after resolving Paolo's
feedback on the main CXL series that proceeded this.
Principal impacts on this series will be updated tests for the
new command line and a move of CXLState into the virt machine
specific state structure.

Thanks,

Jonathan
