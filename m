Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F92C32796
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiHXOrE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiHXOrD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 10:47:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72F7D1EB
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 07:47:02 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCTSg1LF2z686q6;
        Wed, 24 Aug 2022 22:46:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:47:00 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:46:59 +0100
Date:   Wed, 24 Aug 2022 15:46:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4 2/6] cxl: Add CXL spec v3.0 interleave support
Message-ID: <20220824154658.00006dd5@huawei.com>
In-Reply-To: <166077130837.1743055.16772443540776610507.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
        <166077130837.1743055.16772443540776610507.stgit@djiang5-desk4.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Aug 2022 14:21:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
rev3.0 - though I don't really care that much...  Dropping the v works too.
CXL 3.0 is fine by me.

> CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
> is capable. Bit 12 indicates that 16 way interleave is capable.
> 
> Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
> cxl_interleave_verify() call to make sure those CAP bits matches the passed
> in interleave value.

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One comment on naming inline, but other than that bikeshedding.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c    |    6 ++++++
>  drivers/cxl/core/region.c |    3 +++
>  drivers/cxl/cxl.h         |    2 ++
>  drivers/cxl/cxlmem.h      |    5 +++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..2f91ff9b0227 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -80,6 +80,12 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +
> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;

DEFAULT is somewhat odd naming for a capability value.
BASELINE maybe?

> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_3_6_12;
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_16;
>  }
>  
>  static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 28272b0196e6..9851ab2782f2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -960,6 +960,9 @@ static int cxl_interleave_capable(struct cxl_port *port, struct device *dev,
>  	if (eiw == 0)
>  		return 0;
>  
> +	if (!test_bit(ways, &cxlhdm->interleave_cap))
> +		return -EINVAL;
> +
>  	if (is_power_of_2(eiw))
>  		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
>  	else
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..11f2a14f42eb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..4e65c9cc1d30 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -393,11 +393,16 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> +#define CXL_HDM_INTERLEAVE_CAP_DEFAULT BIT(1) | BIT(2) | BIT(4) | BIT(8)
> +#define CXL_HDM_INTERLEAVE_CAP_3_6_12 BIT(3) | BIT(6) | BIT(12)
> +#define CXL_HDM_INTERLEAVE_CAP_16 BIT(16)
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned long interleave_cap;
>  	struct cxl_port *port;
>  };
>  
> 
> 

