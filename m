Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E401922F1;
	Thu, 29 Aug 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942634; cv=none; b=r/LOmDk/11BnBipXpvV1YyUhTIeGJTfUMfkK6I43HCnJ2TyEXQJ8ImXD/Wv7yMdC8uG8azALgA8rAcVCBKEV5gbhHVid1yzZsP3C2sCKdpC9QrbbAM9nRd2h/VUV96JwQPv/hbcGuzvwQYdQee5ZodwsYVKp1tb6qIpsMczcl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942634; c=relaxed/simple;
	bh=FgtLsvE2Z8nQ5GkSJHHX2Xh3JCncwV6NJfiC6LrqmBM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlX8RTVx/YsNCZMdMs0jx3pizbjducgShB/U8+sFNSVsrevWj9lan0VnUVlMZxBXO3TikAEgLKgfa1MnJaMHPrICY1PQnBXBOpAuCjhUxwLLU5GWb+ulImzQg/MbD48FNH+k8QUUxOPwRNEbn6kVJZmrVdNEce6TsaUJj22/kAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WvkSs063Gz6K6V4;
	Thu, 29 Aug 2024 22:39:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D4183140519;
	Thu, 29 Aug 2024 22:43:45 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 15:43:45 +0100
Date: Thu, 29 Aug 2024 15:43:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuesong Li <liyuesong@vivo.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<Benjamin.Cheatham@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] cxl/port: Convert to use ERR_CAST()
Message-ID: <20240829154344.00000f9c@Huawei.com>
In-Reply-To: <20240829125235.3266865-1-liyuesong@vivo.com>
References: <20240829125235.3266865-1-liyuesong@vivo.com>
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

On Thu, 29 Aug 2024 20:52:35 +0800
Yuesong Li <liyuesong@vivo.com> wrote:

> Use ERR_CAST() as it is designed for casting an error pointer to
> another type.
> 
> This macro utilizes the __force and __must_check modifiers, which instruct
> the compiler to verify for errors at the locations where it is employed.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..bdd3275ad417 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -941,7 +941,7 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
>  
>  	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>  	if (IS_ERR(port))
> -		return (struct cxl_root *)port;
> +		return ERR_CAST(port);
>  
>  	cxl_root = to_cxl_root(port);
>  	cxl_root->ops = ops;

