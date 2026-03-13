Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E612FD1B3;
	Fri, 13 Mar 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404292; cv=none; b=FP5bmWMSX0w7L2RdT2ndL31V5CoVTFPJSdceCR7Etv75qSFQYFl6OxvVUpMTS6fzeK9d6W3Q9248j/6Nlw68Wv7rXa//fuoZ43rmU6VbWjZDsfx5p2eFVZkWMcbGl6c3S4z24i9I/S3KDq+VNSX8RKlCOrnX1KatAN8k2ADBTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404292; c=relaxed/simple;
	bh=QDRbhqTQiyEO35Oirmyj7FfC/SljS6/opUnObVcoVPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOhRDY4+pQWJxngtQaZAxfUOX3Qlacj22ELVwm/BRoC8IkFiFN+2ziOXq5eyc+lW8sfEBWYHtPbkK+a8ugMLBqEbYgRnofSagDlVGI7xziaLwQUGaIzrg0vLXFJuiKF2/PEtItdgeofGp5tehBAdBrlkmC+ogLNE29N7VtN50Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXNlf1SRCzJ46nT;
	Fri, 13 Mar 2026 20:17:18 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A7C444056B;
	Fri, 13 Mar 2026 20:18:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 12:18:06 +0000
Date: Fri, 13 Mar 2026 12:18:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <mhonap@nvidia.com>
CC: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 03/20] cxl: Move CXL spec defines to public header
Message-ID: <20260313121805.0000611e@huawei.com>
In-Reply-To: <20260311203440.752648-4-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-4-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 12 Mar 2026 02:04:23 +0530
mhonap@nvidia.com wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> HDM decoder capability structure and component reg block size
> needs to be used by VFIO subsystem. Move the macros from private
> CXL header to public one.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Not really related to this patch, but...

Maybe this is the time to think about doing a PCI like
uapi/linux/cxl_regs.h header?

So far we have these duplicated in at least a couple of code
bases and that is less than ideal!

Move seems fine to me otherwise.

> ---
>  drivers/cxl/cxl.h | 30 ------------------------------
>  include/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 10ddab3949ee..7146059e0dae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -24,9 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>  
> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> -
>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>  #define CXL_CM_OFFSET 0x1000
>  #define CXL_CM_CAP_HDR_OFFSET 0x0
> @@ -39,33 +36,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>  
> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> -
>  /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
>  #define CXL_DECODER_MIN_GRANULARITY 256
>  #define CXL_DECODER_MAX_ENCODED_IG 6
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 610711e861d4..27c006fa53c3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -75,6 +75,36 @@ struct cxl_regs {
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;

