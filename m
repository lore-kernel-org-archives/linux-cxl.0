Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE81EC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCSGZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKCSGF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 14:06:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28276FC3
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 11:02:52 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3BMZ2tZ7z684kT;
        Fri,  4 Nov 2022 01:58:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:02:49 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:02:49 +0000
Date:   Thu, 3 Nov 2022 18:02:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] For ACPICA: Add the CXIMS structure definition
 to the CEDT table
Message-ID: <20221103180248.00007989@Huawei.com>
In-Reply-To: <a8832a0e46cad02e76648cc79181392113dabcf7.1666841669.git.alison.schofield@intel.com>
References: <cover.1666841669.git.alison.schofield@intel.com>
        <a8832a0e46cad02e76648cc79181392113dabcf7.1666841669.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Oct 2022 21:07:41 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> A linux-ized ACPI patch is included here for reference. The ACPI
> pull request has been merged and we expect the upstream version
> shortly. https://github.com/acpica/acpica/pull/795
> 
> The CXL XOR Interleave Math Structure (CXIMS) is added to the
> CXL Early Discovery Table (CEDT). This new structure is defined
> in the CXL 3.0 specification Section 9.17.1.4
> 
> https://www.computeexpresslink.org/spec-landing
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
One trivial comment.

Checked against spec and lgtm

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/acpi/actbl1.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..f96f4fe5328d 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -329,7 +329,8 @@ struct acpi_cedt_header {
>  enum acpi_cedt_type {
>  	ACPI_CEDT_TYPE_CHBS = 0,
>  	ACPI_CEDT_TYPE_CFMWS = 1,
> -	ACPI_CEDT_TYPE_RESERVED = 2,
> +	ACPI_CEDT_TYPE_CXIMS = 2,
> +	ACPI_CEDT_TYPE_RESERVED = 3,

Whilst I struggle to see the point of this RESERVED DEFINE it's almost in keeping
with other similar definitions.  However they do have comments to say
that /* 3 and greater are reserved */ and the comma isn't present
as these are guaranteed to be last element.  Probably want to do the same.

>  };
>  
>  /* Values for version field above */
> @@ -380,6 +381,7 @@ struct acpi_cedt_cfmws_target_element {
>  /* Values for Interleave Arithmetic field above */
>  
>  #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
> +#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR	    (1)
>  
>  /* Values for Restrictions field above */
>  
> @@ -389,6 +391,16 @@ struct acpi_cedt_cfmws_target_element {
>  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
>  
> +/* 2: CXL XOR Interleave Math Structure */
> +
> +struct acpi_cedt_cxims {
> +	struct acpi_cedt_header header;
> +	u16 reserved1;
> +	u8 hbig;
> +	u8 nr_xormaps;
> +	u64 xormap_list[];
> +};
> +
>  /*******************************************************************************
>   *
>   * CPEP - Corrected Platform Error Polling table (ACPI 4.0)

