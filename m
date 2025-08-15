Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC3306D39
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272479; cv=none; b=DgwCPR1voqwSo7HBUMTRb9dE1rvtL/w1HMm0jYpddIQj29oBZXR9XnHVnZagm/hi3dsjV45DoBG1ualBAyC9uOeFmRMaR1BJMRd26HtwYfErhqW2macrbRtccnxQ8bNxSEecRDLPIQcdm91sekMaGJN2WblUKUDILu31o9m6/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272479; c=relaxed/simple;
	bh=tpX+tR+uNr2zb0qeDAsQLbP621Da7ddAT/q0V3rPkQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjI9s2ngA0gBs2J9x7Titv2rT54ohWTLMQVwrVITkldEoGO1QeYp4HG5HKakN2vaTHgU8Xy1KgKvHSiWORx9G5FwFXMQeb9Hsg5eyn2zaXm5w9an9t+gTCtpOubCs1ux6oH5llSN9SyNlKZiMLTtnwl/t4fJhtLGzKB/d+FCdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3R8b2Rgqz6L5Rw;
	Fri, 15 Aug 2025 23:38:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DED3C1400F4;
	Fri, 15 Aug 2025 23:41:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 17:41:10 +0200
Date: Fri, 15 Aug 2025 16:41:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl: Support creating HDM-DB regions
Message-ID: <20250815164108.0000658e@huawei.com>
In-Reply-To: <20250812010228.2589787-4-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
	<20250812010228.2589787-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 18:02:28 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> A single Type 3 device can expose different parts of its memory with different
> coherency semantics. For example, some memory ranges within a Type 3 device
> could be configured as HDM-H, while other memory ranges on the same device
> could be configured as HDM-DB. This allows for flexible memory configuration
> within a single device. As such, coherency models are defined per memory region.
> 
> For accelerators (type2), it is expected for accelerator drivers to manage the
> HDM-D[B] region creation. For type3, relevant sysfs tunables are provided to
> the user.
> 
> Other than the HDM decoder supported coherency models, the main dependency
> to create these regions is for the device state to be BI-ready (cxlds->bi),
> for which already committed HDM decoders with the BI bit set detected during
> enumeration is currently not supported because endpoint and port enumerations
> are independent.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 41 ++++++++++++++----
>  drivers/cxl/acpi.c                      |  2 +
>  drivers/cxl/core/core.h                 |  4 ++
>  drivers/cxl/core/hdm.c                  | 56 +++++++++++++++++++++---
>  drivers/cxl/core/port.c                 | 55 +++++++++++++++++++++++-
>  drivers/cxl/core/region.c               | 57 +++++++++++++++++++++----
>  drivers/cxl/cxl.h                       |  7 ++-
>  drivers/cxl/cxlmem.h                    |  1 +
>  include/acpi/actbl1.h                   |  1 +
>  9 files changed, 199 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6b4e8c7a963d..7d9e3db736c3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6361365c5ce9..0a9532fa4ec1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -51,6 +51,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>  #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>  #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)

Given the values are a bit non obvious (particularly what 0 means :),
I'd add defines for them alongside the mask.

You use the value 1 later which should have been a define.


>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> @@ -65,6 +66,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)

