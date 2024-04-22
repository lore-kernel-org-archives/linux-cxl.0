Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D114EC69
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784342; cv=none; b=Uv4l8ZHevIO2+twyUwM+zzbZuPivGKxH7LLvcTc9FIv6jKJIb8sx+EWaG788bvqidPQak4RFKuK5UzwoumJGN7qo4EZLhr+IsC4GPqnQvq4v8s7lllKfI0JstTfODX/lQ4Ri/LtR/hUg7/WBdOInKckXHoMbM16N15sRuKjpENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784342; c=relaxed/simple;
	bh=8TiAJoVCQRChXt+2l+52OMZy7P4q9uvAFH/iJt8ymR4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Svt+6OIqkdW12ega7PP9KyO26vKbwezxeH2K1PZWPppI3zGBtvIx683ZmVKpEXAufTCeU3s62rTUfBZeRqtcnT/WSsEtSUyAUuXqNGYAh/kTV4jyr32INYyyCV9PtgfdRiezPwpF5D0vsiI47CRtMIvSmATTYHXFw/uOvA8aVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNMyz0ppxz6K8tv;
	Mon, 22 Apr 2024 19:12:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0181140AE5;
	Mon, 22 Apr 2024 19:12:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 12:12:16 +0100
Date: Mon, 22 Apr 2024 12:12:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/core: add passthrough flag to struct
 cxl_switch_decoder
Message-ID: <20240422121215.0000344c@Huawei.com>
In-Reply-To: <20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
	<20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Apr 2024 05:13:49 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Per CXL specification (8.2.4.20 CXL HDM Decoder Capability Structure in
> r3.1), the host-bridges with single port and switches with single dport are
> not affiliated with any instance of the HDM capability structure.

To avoid any confusion in future, this is an option, but even with single
downstream ports they may support HDM decoders.

> 
> Driver will add a passthrough decoder for each of them during init, so the
> constraints imposed by the HDM capability structure do not apply to the
> passthrough decoders.
> 
> By utilizing this flag, we can swiftly ascertain whether a switch decoder
> qualifies as a passthrough decoder, thereby avoiding the need to conduct a
> string of capability constraint checks.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
With above description amended to reflect that it's talking about an
implementation option.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 1 +
>  drivers/cxl/cxl.h      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..27fb4f9d489e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -57,6 +57,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  	if (IS_ERR(cxlsd))
>  		return PTR_ERR(cxlsd);
>  
> +	cxlsd->passthrough = true;
>  	device_lock_assert(&port->dev);
>  
>  	xa_for_each(&port->dports, index, dport)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..6f562baa164f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -415,6 +415,7 @@ struct cxl_endpoint_decoder {
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
>   * @nr_targets: number of elements in @target
> + * @passthrough: indicate whether the decoder is passthrough
>   * @target: active ordered target list in current decoder configuration
>   *
>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
> @@ -426,6 +427,7 @@ struct cxl_endpoint_decoder {
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
>  	int nr_targets;
> +	bool passthrough;
>  	struct cxl_dport *target[];
>  };
>  

