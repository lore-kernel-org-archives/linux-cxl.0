Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A33D97A;
	Thu, 24 Oct 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762744; cv=none; b=c+gYI5GKX+qxzas5/guXU14CHkv+vIC3f4GvxfK3qxlPqtMSxHDoZhaLBMK+gYEmcIpxXMFNRyAvtQI1ZDzLvYMOfw9MMA4jvYc1/G2iooV/l4PSXcbpJgTyyuKhTU4dJwG+ozogu+5vzI/1Uai9vgCUFgog0CQ3uysWGPZQhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762744; c=relaxed/simple;
	bh=2m73KAYM6zCci5LsNmrhwhdMM5NOURZE9sSH/sEkT5s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0FQM885lK377gQpZH5h3TlhDPZi1EZ2wbn2GxgKg1BqORlmnHDdIXe30LQgP/WUOt5vl9i6sxMphwTTfbPX7U0e/0NtBLvKmGDSw9EQsN/dnNsuW4dNcXkZ8zghQWPETo2sKR5wuzL1j4GXwPOilMlMVAsLE1rnLrAZ8TmwypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ16t2rNBz6K5rC;
	Thu, 24 Oct 2024 17:37:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D99D7140158;
	Thu, 24 Oct 2024 17:38:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 11:38:58 +0200
Date: Thu, 24 Oct 2024 10:38:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zicheng Qu <quzicheng@huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>,
	<zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
Subject: Re: [PATCH] cxl: core-pmu: Fix the usage of uninitialized variable
Message-ID: <20241024103856.000031ed@Huawei.com>
In-Reply-To: <20241023105610.668964-1-quzicheng@huawei.com>
References: <20241023105610.668964-1-quzicheng@huawei.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 23 Oct 2024 10:56:10 +0000
Zicheng Qu <quzicheng@huawei.com> wrote:

> In the devm_cxl_pmu_add() function, the variable rc might be
> uninitialized before its first use 'if (rc) goto err', leading
> to undefined behavior since its value depends on the compiler.
> Currently, the switch statement is limited to the CXL_PMU_MEMDEV type.
> If additional types are introduced, it could lead to similar concerns.
> If the type range remains unchanged, using a switch case is unnecessary.
> To enhance code extensibility and stability, it is recommended to
> address this potential aspect.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")

Not a fix, because this is only called for CXL_PMU_MEMDEV.
So drop stable and fixes tag as I don't see this as appropriate to
backport (unless I'm missing something!)

Reasonable to harden the code. These might turn up in other
types of device. Ports will be handled differently (part of the
portdrv rework that I need to get back to), but maybe someone
will put a CXL PMU on a type 2 device and call this function.

Jonathan
 

> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  drivers/cxl/core/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
> index 5d8e06b0ba6e..2d12887c9915 100644
> --- a/drivers/cxl/core/pmu.c
> +++ b/drivers/cxl/core/pmu.c
> @@ -51,6 +51,9 @@ int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
>  	case CXL_PMU_MEMDEV:
>  		rc = dev_set_name(dev, "pmu_mem%d.%d", assoc_id, index);
>  		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
>  	}
>  	if (rc)
>  		goto err;

