Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772853EF650
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939570; cv=none; b=sugRID9TbvPYAPJ8aq8i6DBt55YuVX58ecfvsUItg7BN3nz55EzTyRQEQqdKXfDGwNj+S3Rbgh2r5McQCfrRD0wRnDXARzH1MSd88l+9dyZaQQMAMHMAhbYCBN+9jk5leDRlQ2XqQf4LVc+ZTN79TdWp5D/3/KNeGLt6iM37S+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939570; c=relaxed/simple;
	bh=EX1gDS9T+zUexso8tM3/2eLcVuviUxcudlyNvVkh9Vc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc4DmmKSOG4aVzHlmZz6YbNM+A9wSS2fcHVz77pDyzXGdd6zgiFtVy0GxRI2o8/x1+Cs/RiWQPXZuRpoBSrr43ct7JP8DJbQ3c1QQ+1Ibc4a+ETxvRJg8VL4KDzT9bhQ+fHoZFr7pYrqlPuznaZPpU/rOP0sr4bOl0k1cV2cYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcBjv3DPwzHnGk1;
	Fri, 20 Mar 2026 00:58:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BACD40572;
	Fri, 20 Mar 2026 00:59:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 16:59:22 +0000
Date: Thu, 19 Mar 2026 16:59:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/6] cxl: Add Back-Invalidate register definitions and
 structures
Message-ID: <20260319165921.00003734@huawei.com>
In-Reply-To: <20260315202741.3264295-2-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 15 Mar 2026 13:27:36 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add CXL Back-Invalidate (BI) capability IDs, register definitions for
> the BI Route Table and BI Decoder capability structures, and associated
> fields. This includes HDM decoder coherency capability and control fields
> needed to support HDM-DB (device-managed coherency with back-invalidate).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxl.h    | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h |  2 ++
>  include/cxl/cxl.h    |  5 +++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 031846eab02c..efe06d60b364 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h

>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> @@ -51,6 +53,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>  #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>  #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)

Given this definitely wasn't in CXL 2.0 probably want to update the spec
references. I think that would be neater than adding specific notes
to say where these are in CXL r4.0

I'd define 0 as well.  My favorite case of papering over a spec hole.
The 'unknown' value ;)  To actually make use of this on devices
that have that value we'd need a list of IDs :(

> +#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
> +#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
> +#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> @@ -65,6 +71,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> @@ -152,6 +159,33 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>  
> +/* CXL 3.2 8.2.4.26 CXL BI Route Table Capability Structure */

I think we decided a while back that all new comments should use
latest public (via click through) available spec which is 4.0 now.
That being driven by the fact that getting hold of old spec versions
is not as trivial as it should be.

> +#define CXL_BI_RT_CAPABILITY_LENGTH 0xC


> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -241,6 +275,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)

Hmm. The comment above these looks to have grown stale.
/*
 * cxl_decoder flags that define the type of memory / devices this
 * decoder supports as well as configuration lock status See "CXL 2.0
 * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
 * Additionally indicate whether decoder settings were autodetected,
 * user customized.
 */

That definitely doesn't cover what is here.  Anyhow, not
a problem for this patch.



> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..74be940364e1 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -34,10 +34,12 @@ struct cxl_regs {
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 * @bi: CXL 3.2 8.2.4.26/27 CXL BI Capability Structure
Not sure what general view is but I think it's odd to have different spec
versions used in a single block of comments. Maybe drag them all into
the modern CXL r4.0 world.
>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *bi;
>  	);


