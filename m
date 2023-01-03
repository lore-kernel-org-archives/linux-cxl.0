Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC02C53210
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjACRPO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbjACRO5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 12:14:57 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A5D98
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 09:14:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NmfQZ5K36z67gR6;
        Wed,  4 Jan 2023 01:11:18 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 17:14:52 +0000
Date:   Tue, 3 Jan 2023 17:14:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 7/8] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230103171451.00005a91@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-7-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-7-2ce2ecc06219@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:37 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Hi Ira,

Whilst this seems good to me, it's buried deep in a CXL specific
patch set so I'm thinking it might not get the review it needs.

Perhaps we are better off starting with a local implementation then
posting a follow up series that introduces this an makes use of it
in the CXL code?

One comment inline.

Jonathan

> ---
>  include/qemu/bswap.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index e1eca22f2548..8af4d4a75eb6 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -25,6 +25,13 @@ static inline uint16_t bswap16(uint16_t x)
>      return bswap_16(x);
>  }
>  
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>  static inline uint32_t bswap32(uint32_t x)
>  {
>      return bswap_32(x);
> @@ -43,6 +50,13 @@ static inline uint16_t bswap16(uint16_t x)
>              ((x & 0xff00) >> 8));
>  }
>  
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}

Whilst I can see the logic in having two copies to keep it in a sensible
place wrt to the other implementations, neither of these is from byteswap
so I'd just drop it out of the ifdef and have just the one copy.

> +
>  static inline uint32_t bswap32(uint32_t x)
>  {
>      return (((x & 0x000000ffU) << 24) |
> @@ -72,6 +86,11 @@ static inline void bswap16s(uint16_t *s)
>      *s = bswap16(*s);
>  }
>  
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s);
> +}
> +
>  static inline void bswap32s(uint32_t *s)
>  {
>      *s = bswap32(*s);
> @@ -233,6 +252,7 @@ CPU_CONVERT(le, 64, uint64_t)
>   * size is:
>   *   b: 8 bits
>   *   w: 16 bits
> + *   24: 24 bits
>   *   l: 32 bits
>   *   q: 64 bits
>   *
> @@ -305,6 +325,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>      __builtin_memcpy(ptr, &v, sizeof(v));
>  }
>  
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>  static inline int ldl_he_p(const void *ptr)
>  {
>      int32_t r;
> @@ -354,6 +379,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>      stw_he_p(ptr, le_bswap(v, 16));
>  }
>  
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap(v, 24));
> +}
> +
>  static inline void stl_le_p(void *ptr, uint32_t v)
>  {
>      stl_he_p(ptr, le_bswap(v, 32));
> 

