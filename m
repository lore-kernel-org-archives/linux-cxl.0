Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC4C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 09:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJKJDH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKJDG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 05:03:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FC76976
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 02:03:05 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmqX95RFYz67xwN;
        Tue, 11 Oct 2022 17:01:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:03:02 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 10:03:01 +0100
Date:   Tue, 11 Oct 2022 10:03:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
Message-ID: <20221011100300.00006c99@huawei.com>
In-Reply-To: <20221010222944.3923556-2-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
        <20221010222944.3923556-2-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 15:29:39 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gcc requires constant versions of cpu_to_le* calls.
> 
> Add a 64 bit version.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Seems reasonable to me but I'm not an expert in this stuff.
FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There are probably a lot of places in the CXL emulation where
our endian handling isn't correct but so far it hasn't mattered
as all the supported architectures are little endian.

Good to not introduce more cases however!

Jonathan


> ---
>  include/qemu/bswap.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 346d05f2aab3..08e607821102 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -192,10 +192,20 @@ CPU_CONVERT(le, 64, uint64_t)
>       (((_x) & 0x0000ff00U) <<  8) |              \
>       (((_x) & 0x00ff0000U) >>  8) |              \
>       (((_x) & 0xff000000U) >> 24))
> +# define const_le64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))
>  # define const_le16(_x)                          \
>      ((((_x) & 0x00ff) << 8) |                    \
>       (((_x) & 0xff00) >> 8))
>  #else
> +# define const_le64(_x) (_x)
>  # define const_le32(_x) (_x)
>  # define const_le16(_x) (_x)
>  #endif

