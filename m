Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A2C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 11:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiHQLpz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbiHQLpl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 07:45:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04932501B9
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 04:45:40 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M75gJ0KVDz67NZt;
        Wed, 17 Aug 2022 19:40:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 13:45:37 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 12:45:37 +0100
Date:   Wed, 17 Aug 2022 12:45:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] hw/cxl: Two CXL emulation fixes.
Message-ID: <20220817124536.000004a4@huawei.com>
In-Reply-To: <20220808122051.14822-1-Jonathan.Cameron@huawei.com>
References: <20220808122051.14822-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 8 Aug 2022 13:20:49 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Peter Maydell reported both these issues, having looked into Coverity
> identified issues. The memory leak was straight forward, but testing the
> second patch identified a bug in the Linux kernel.
> 
> This bug has been fixed in the series
> https://lore.kernel.org/linux-cxl/165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com/T/#t
> and is now available in the cxl.git pending branch.
> 
> Another clear example of why QEMU emulation is useful for kernel development.

Hi,

Any feedback on these two fixes?

Along with a two more fixes to follow in a few mins these are needed for the region code
in Linux 6.0-rc1 to work (there is a kernel fix as well that came from testing against
QEMU).

For full support we need one more feature (serial number provisioning) but without that
we get regions working as long as you create them fresh on each boot.

Thanks,

Jonathan

> 
> Jonathan Cameron (2):
>   hw/cxl: Fix memory leak in error paths
>   hw/cxl: Fix wrong query of target ports
> 
>  hw/cxl/cxl-host.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 

