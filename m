Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4F15B142
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642559; cv=none; b=XEOpIoqEB8advqOo95jAsntwMNv4vDBtiToQA8GiRGgJP3S0LyiVUpTjS+cj4uN7+fb+4GjmlkH209lU54dDThPU/TF0FakOS+MucH/cGMZKJ+RcfKuHReu8R+MUCnFVyGqFf/CsTN29HGGKECDj7qk8LlepFqjrifRJJswQPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642559; c=relaxed/simple;
	bh=zTgYN3hwyeYhMobLchNJ0N25eGkRkK7+/WD5oBZxXr0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrNjBxdnW6tYC0iVlczhwHt6C2GR3ls1AU/0RzBr6MOJ7XKVU1+t4lxEEnetwaOxW+4KWVK+tyHYh2sO8rMMiY1lFoyAGFvbdomMeHFpg2r9w/U/bBbm/5Uk3K2j61r/0YNR2I34HVyAOIZNeKA+BW6JB/hDwq55LrgeWiZ4jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W2wcd1Yqtz6K9JJ;
	Tue, 18 Jun 2024 00:41:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C513140736;
	Tue, 18 Jun 2024 00:42:34 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 17 Jun
 2024 17:42:33 +0100
Date: Mon, 17 Jun 2024 17:42:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] cxl/region: check interleave capability
Message-ID: <20240617174233.000051ca@Huawei.com>
In-Reply-To: <20240614084755.59503-2-yaoxt.fnst@fujitsu.com>
References: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
	<20240614084755.59503-2-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 04:47:54 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 
> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Register),
> bits 11 and 12 indicate the capability to establish interleaving in 3, 6,
> 12 and 16 ways. If these bits are not set, the target cannot be attached to
> a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 represent the capability of the bits used for
> interleaving in the address, Linux tracks this in the cxl_port
> interleave_mask.
> 
> Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
>   eIW means encoded Interleave Ways.
>   eIG means encoded Interleave Granularity.
> 
>   in HPA:
>   if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are used,
>   the interleave bits are none, the following check is ignored.
> 
>   if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleave bits
>   start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.
> 
>   if eIW is greater than 8 (interleave ways: 6, 12), the interleave bits
>   start at bit position eIG + 8 and end at eIG + eIW - 1.
> 
>   if the interleave mask is insufficient to cover the required interleave
>   bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Trivial comment inline. Either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..034cc0a90e8f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int high_pos, low_pos;
> +
Possibly reorder to be reverse xmas tree.



