Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D45C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJTSzE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTSzD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 14:55:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB2BD047
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666292101; x=1697828101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LuvrrJbcGaOuNNeY0LghnuyqZSyTBUIMVbKP8JJOpw0=;
  b=B594fNy5AmVWmSpHccqmM5iL4VSSxedrWvT+IWYNeqhOybAatHDwo3/J
   UZyYaUw8TNCKgcBfecVVUXGP8LjD5+0gTVXwQ4KNgpW16D7AZl9mjcIx5
   VcrcNeYwjyCV7fsAZZaPQFuzo4N3ay5F1/PbYlL8DD42CXZ/7jv6rpj/I
   CZKlOJAriXw6ozMxzFN+tTjI4hn0cn+a/q9qUHfQAIg8NHr9PvGm9sbG0
   dvtBn+Tu6NQmjo+GjsFzUWh12HV8vHX+6Co+IxbkbAJwU9eq1VsynE1j1
   fbkw2O2XWbIs2xhbh64XwZsfCudkB8wIBjIyiKuoThza2EvUjg0Z/YLoL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286529669"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="286529669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:55:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772549765"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="772549765"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.41.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:55:00 -0700
Date:   Thu, 20 Oct 2022 11:54:58 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Cheatham <benjamin.cheatham@amd.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, bwidawsk@kernel.org
Subject: Re: [PATCH] cxl: identify CXL3.0 cache/mem register capability IDs
Message-ID: <Y1GZgjGg50/+bz6f@aschofie-mobl2>
References: <723490fa-04de-ac22-2bcc-713cd77e6d3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <723490fa-04de-ac22-2bcc-713cd77e6d3c@amd.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 20, 2022 at 12:52:39PM -0500, Ben Cheatham wrote:
> Add code to identify the non extended cache mem CXL register capabilities
> based on capability ID.
> 
> As of now, nothing is done with this information except logging that the
> capabilities were found. In the case of the NULL capability this is
> probably all that should be done since the spec specifies software should
> skip this capability. The other capabilities are added so that if any
> additional setup/info is required, like for the HDM decoder capability, the
> stub is already there.

Hi Ben,

What is the user visible impact of making this change.
Perhaps it would be better reviewed alongside it's use case.

Alison
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/regs.c | 42 ++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h       | 13 ++++++++++++-
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 39a129c57d40..616d926de1e6 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -27,8 +27,8 @@
>   * @base: Mapping containing the HDM Decoder Capability Header
>   * @map: Map object describing the register block information found
>   *
> - * See CXL 2.0 8.2.4 Component Register Layout and Definition
> - * See CXL 2.0 8.2.5.5 CXL Device Register Interface
> + * See CXL 3.0 8.2.3 Component Register Layout and Definition
> + * See CXL 3.0 8.2.8 CXL Device Register Interface
>   *
>   * Probe for component register information and return it in map object.
>   */
> @@ -42,7 +42,7 @@ void cxl_probe_component_regs(struct device *dev, void
> __iomem *base,
> 
>      /*
>       * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
> -     * CXL 2.0 8.2.4 Table 141.
> +     * CXL 3.0 8.2.3 Table 8-21.
>       */
>      base += CXL_CM_OFFSET;
> 
> @@ -71,6 +71,26 @@ void cxl_probe_component_regs(struct device *dev, void
> __iomem *base,
>          register_block = base + offset;
> 
>          switch (cap_id) {
> +        case CXL_CM_CAP_CAP_ID_NULL:
> +            dev_dbg(dev, "found NULL capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_CXL:
> +            dev_dbg(dev, "found CXL capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_RAS:
> +            dev_dbg(dev, "found RAS capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_SECURITY:
> +            dev_dbg(dev, "found Security capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_LINK:
> +            dev_dbg(dev, "found Link capability (0x%x)\n",
> +                offset);
> +            break;
>          case CXL_CM_CAP_CAP_ID_HDM:
>              dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
>                  offset);
> @@ -84,6 +104,22 @@ void cxl_probe_component_regs(struct device *dev, void
> __iomem *base,
>              map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
>              map->hdm_decoder.size = length;
>              break;
> +        case CXL_CM_CAP_CAP_ID_EXT_SEC:
> +            dev_dbg(dev, "found Extended Security capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_IDE:
> +            dev_dbg(dev, "found IDE capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_SNOOP:
> +            dev_dbg(dev, "found Snoop Filter capability (0x%x)\n",
> +                offset);
> +            break;
> +        case CXL_CM_CAP_CAP_ID_TIMEOUT:
> +            dev_dbg(dev, "found Timeout and Isolation capability (0x%x)\n",
> +                offset);
> +            break;
>          default:
>              dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>                  offset);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..762e5243162a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -33,9 +33,20 @@
>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> 
> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> 
> +/* CXL 3.0 8.2.4 Table 8-22 CXL_Capability_ID Assignment*/
> +#define CXL_CM_CAP_CAP_ID_NULL 0x0
> +#define CXL_CM_CAP_CAP_ID_CXL 0x1
> +#define CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define CXL_CM_CAP_CAP_ID_SECURITY 0x3
> +#define CXL_CM_CAP_CAP_ID_LINK 0x4
> +#define CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define CXL_CM_CAP_CAP_ID_EXT_SEC 0x6
> +#define CXL_CM_CAP_CAP_ID_IDE 0x7
> +#define CXL_CM_CAP_CAP_ID_SNOOP 0x8
> +#define CXL_CM_CAP_CAP_ID_TIMEOUT 0x9
> +
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> -- 
> 2.34.1
