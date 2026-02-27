Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B83A1E6C
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194490; cv=none; b=i0/IVvBo9IaUo2DVyPa1DaZmC20cApIOMtq98AnMdkpxO5lE3V7e9Xkmmtrrk488gsFaMr2mM0Po274JIMMRgZyrY04Z1mPgL+veTnbPUyCIFRVeE9/4zaeQyRxuyNvlh2CXZgqhRqyaTf6l+b/XHJNjRN14Lxb03RmZVRi0/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194490; c=relaxed/simple;
	bh=+ae2YZkM5X2grXoNUw2zKYzJkmx+K9dcqqtOpAqg7kc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIq//5PhxSpoS05UY5qJ+XKp0H8jOQYZkw4s1U483i0m/ZTyVIVPbZOVymR9bVBQK5YXSNdvrrbKkYfwHhltaRaeFH5H09yLyU4KKbfgkSTFq29I08nOh+1i6n43lQ8xGqaN7O9zPGWc+yvDMH0KeiEbnbO4OvEfJFo42Cj4ARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMnLH0k4ZzHnGjq;
	Fri, 27 Feb 2026 20:13:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E1FC040572;
	Fri, 27 Feb 2026 20:14:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 12:14:44 +0000
Date: Fri, 27 Feb 2026 12:14:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 1/3] cxl: support Type2 when initializing
 cxl_dev_state
Message-ID: <20260227121443.000011ff@huawei.com>
In-Reply-To: <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
	<20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Feb 2026 12:14:28 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 drivers add function and macro for
> differentiating CXL memory expanders (type 3) from CXL device
> accelerators (type 2) helping accel drivers to embed cxl_dev_state

Slight preference for 

"to embed struct cxl_dev_state"

> inside a private struct.
I'd be tempted to call this "a driver specific structure".

private is a little too much of a guide to how this 'might' be used
in the long run.

> 
> Update type3 driver for using this same initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

One minor wording comment below.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e21d744d639b..9daf4bc42692 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox);
> +
> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.
> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state

 * @member: name of the struct cxl_dev_state member in drv_struct

("as" to me implies a cast, which had me briefly confused).

> + * @mbox: true if mailbox supported
> + *
> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> + * struct initialized.
> + *
> + * Introduced for Type2 driver support.
> + */
> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +
