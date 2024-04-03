Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FA148305
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153186; cv=none; b=CKSj5v+oKJjA8dl+9vkt4PonV1YLYrd/EaUt6MhO/ZDN4H1uXZ0oP2mSF1mBYSRzY2WjpYfalHtEcT7Ck5aEvLU9/JgzzJaM6oHH9Um4RJD41GPzZbxoR52YPpFbOgnw35TQ17nv5S4oH68dTj4ql+UkciUnJ7vfU8eSjC3vXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153186; c=relaxed/simple;
	bh=lOl9gJHZcw5Rn+JZuYC16LOBAR+QKgY3w3HoillmwSk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwAfFbOdSY81e9md0AkQ5BbXaTnAlr1MLmZWN25MQlnIhe4TZhi+4St+Xx6YwhC07bE8UcNLiSqWWAK7V1fo+tSBvbJCItCkDCNpYet7F0vDL13zWPMxipLzOIdw6aZ6t2oTKVXdEGTELFERf0y93B2IvtnCHQD5TGjU14Mr0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8mj11BYtz6D8Yj;
	Wed,  3 Apr 2024 22:04:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 84BC81400CA;
	Wed,  3 Apr 2024 22:06:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 15:06:12 +0100
Date: Wed, 3 Apr 2024 15:06:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/core/hdm: rename interleave_mask to
 ig_cap_mask
Message-ID: <20240403150611.0000180c@Huawei.com>
In-Reply-To: <20240403021747.17260-2-yaoxt.fnst@fujitsu.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
	<20240403021747.17260-2-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  2 Apr 2024 22:17:46 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave contains interleave ways and interleave granularity,
> using ig_cap_mask is better to describe this capability.

Hi Yao,

I don't follow the reasoning of this.

ig suggests interleave granularity which whilst related to the address
bits, they aren't masking the granularity as such.

I agree current naming isn't particularly meaningful, but don't see the
suggested change as an improvement.

Jonathan
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c | 4 ++--
>  drivers/cxl/cxlmem.h   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..9bb6a256cc6f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -76,9 +76,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> -		cxlhdm->interleave_mask |= GENMASK(11, 8);
> +		cxlhdm->ig_cap_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> -		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +		cxlhdm->ig_cap_mask |= GENMASK(14, 12);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 20fb3b35e89e..b53f7ae0fdd6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -852,7 +852,7 @@ struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
>  	unsigned int target_count;
> -	unsigned int interleave_mask;
> +	unsigned int ig_cap_mask;
>  	struct cxl_port *port;
>  };
>  

