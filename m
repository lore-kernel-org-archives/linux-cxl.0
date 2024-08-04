Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9493136320;
	Sun,  4 Aug 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789501; cv=none; b=NAB4NzsUGIRTK4RJzh5lRBK543vrw41SJ8M2nCNZqQZTXsEDGQQTMTHiXBsI5gLcL3IRivfYUwKbUbGVrmYv9eDW5HilLAlce3SoeHfpv/h1CfFRrdTlKqlc6c7QaTHCy6PuMiw8nzZyEXpcHO579cA+tvu14z/2xpSvxgBROmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789501; c=relaxed/simple;
	bh=0g+kBU2ClY6oqIW1UsBXZKTBzXFL4mS+SsUJV5DcD1Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQNySuEFfoLVRxO0ziacbfqNatEB3EUS3Ge1rKvd+pCvd/kbT4oyY/Ry2iSb6ncNxy7QQjl728saeOZkPCSTrx9ZjPDIsemOLtV9j6/MW+M+kHsFa7qKOQo83XJueUyKpEmIomxeKFUo9OnzMcoPDJTneaqO7mXxnoh0/ERr8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcQD223h1z6K5Yq;
	Mon,  5 Aug 2024 00:35:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 15EAF1401DC;
	Mon,  5 Aug 2024 00:38:15 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 17:38:14 +0100
Date: Sun, 4 Aug 2024 17:38:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH 3/3] cxl: Avoid to create dax regions for type2
 accelerators
Message-ID: <20240804173813.00001018@Huawei.com>
In-Reply-To: <20240729084611.502889-4-ying.huang@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-4-ying.huang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jul 2024 16:46:11 +0800
Huang Ying <ying.huang@intel.com> wrote:

> The memory range of a type2 accelerator should be managed by the type2
> accelerator specific driver instead of the common dax region drivers,
> as discussed in [1].
> 
> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
> 
> So, in this patch, we skip dax regions creation for type2 accelerator
> device memory regions.
> 
> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9a483c8a32fd..b37e12bb4a35 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +		/*
> +		 * HDM-D[B] (device-memory) regions have accelerator
> +		 * specific usage, skip device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_DEVMEM)
> +			return 0;

As in previous need to be careful as that may not mean it's
an accelerator.

However, we do need to deal with BI setup for HDM-DB type 3 devices
etc and to check the HDM Decoder capability registers to make sure
Supported Coherence model is appropriate. (e.g. 11 for host only or
device coherency - HDM-H/HDM-DB)

> +
> +		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",

