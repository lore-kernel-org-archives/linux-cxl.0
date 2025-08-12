Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6624BC01
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012808; cv=none; b=VWYkXSPBEr7xD229YfXLbATeuoRANx/X1Q07zbODFALEzMxvL7+E/1Tl+48Yg6+YJqr45nK6dF9bmHT8P4fIRVk9wI4FQ91cpCOLkAo89NPwj4lK2Uso/BQHhOJTzhwNm5juOUfpKa0ajePtdyB22o8ixU+Lf42X6TykdLgjZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012808; c=relaxed/simple;
	bh=DM0+H1NnEE+yvY+YFHZTx/yA/OdBMDgPLZf0p08uG6U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhq0OPV1rdVvl6mIhj6Ga3Nqjsfm2u6PoIk9Y8G/LS5alreXfI6SPcfDfl3AouPZ29HBicdOr1QbSit7AHc4jEVX9JQELgY5GvwmxaXLRTi5JC00IBcbf3sMQSl6DkyodGG+5wllwV2mbJXBM50sDSBku3pN6sMlEW/jBfTqnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1b790SHWz6L53F;
	Tue, 12 Aug 2025 23:30:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AC55140371;
	Tue, 12 Aug 2025 23:33:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 17:33:22 +0200
Date: Tue, 12 Aug 2025 16:33:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] cxl: Move hpa_to_spa callback to a new root
 decoder ops structure
Message-ID: <20250812163321.00006e20@huawei.com>
In-Reply-To: <818530c82c351a9c0d3a204f593068dd2126a5a9.1754290144.git.alison.schofield@intel.com>
References: <cover.1754290144.git.alison.schofield@intel.com>
	<818530c82c351a9c0d3a204f593068dd2126a5a9.1754290144.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  4 Aug 2025 01:00:09 -0700
alison.schofield@intel.com wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> The root decoder's HPA to SPA translation logic was implemented using
> a single function pointer. In preparation for additional per-decoder
> callbacks, convert this into a struct cxl_rd_ops and move the
> hpa_to_spa pointer into it.
> 
> To avoid maintaining a static ops instance populated with mostly NULL
> pointers, allocate the ops structure dynamically only when a platform
> requires overrides (e.g. XOR interleave decoding).
> 
> The setup can be extended as additional callbacks are added.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
One trivial thing inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> 
> Changes in v5: Remove stray blank line in cxl_root_decoder_alloc() (DaveJ)
> 
> 
>  drivers/cxl/acpi.c        | 10 +++++++---
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/region.c | 11 ++++++++---
>  drivers/cxl/cxl.h         | 12 +++++++++---
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 712624cba2b6..b8d69460a368 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -20,7 +20,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> -

Valid but unrelated change.

>  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)

