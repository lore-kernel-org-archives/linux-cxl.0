Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9226CC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 09:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJKJN0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJKJNX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 05:13:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C477E32E
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 02:13:21 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mmqkc3rgbz67jy7;
        Tue, 11 Oct 2022 17:10:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:13:18 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 10:13:18 +0100
Date:   Tue, 11 Oct 2022 10:13:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 2/6] qemu/uuid: Add UUID static initializer
Message-ID: <20221011101317.000079a1@huawei.com>
In-Reply-To: <20221010222944.3923556-3-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
        <20221010222944.3923556-3-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 15:29:40 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> UUID's are defined as network byte order fields.  No static initializer
> was available for UUID's in their standard big endian format.
> 
> Define a big endian initializer for UUIDs.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Seems sensible.  Would allow a cleanup in the existing cel_uuid handling
in the CXL code where we use a static for this and end up filling it
with the same value multiple times which is less than ideal...
A quick grep and for qemu_uuid_parse() suggests there are other cases
where it's passed a constant string.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/qemu/uuid.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 9925febfa54d..dc40ee1fc998 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -61,6 +61,18 @@ typedef struct {
>      (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
>      (node3), (node4), (node5) }
>  
> +/* Normal (network byte order) UUID */
> +#define UUID(time_low, time_mid, time_hi_and_version,                    \
> +  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2,         \
> +  node3, node4, node5)                                                   \
> +  { ((time_low) >> 24) & 0xff, ((time_low) >> 16) & 0xff,                \
> +    ((time_low) >> 8) & 0xff, (time_low) & 0xff,                         \
> +    ((time_mid) >> 8) & 0xff, (time_mid) & 0xff,                         \
> +    ((time_hi_and_version) >> 8) & 0xff, (time_hi_and_version) & 0xff,   \
> +    (clock_seq_hi_and_reserved), (clock_seq_low),                        \
> +    (node0), (node1), (node2), (node3), (node4), (node5)                 \
> +  }
> +
>  #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
>                   "%02hhx%02hhx-%02hhx%02hhx-" \
>                   "%02hhx%02hhx-" \

