Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31B20B1E8;
	Tue, 15 Apr 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727776; cv=none; b=EejlqvPNVMcaNScY6XuLRavuLQ7S8razZH0s2ok99v9fFrOrpmahVihq48P0Kxx2r5AHYRUtTYSLGK+4Dm0TADMycMTCCaoO04RoMqXBNcyDVwsp790oxsmIWrR+IA2zL1dL10vsFdJEWE8qkoYaGFuzn+dHxgr2D9no/ceW9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727776; c=relaxed/simple;
	bh=fT4+CBacz9O3qeOVo3oxdrEc9GHq77Sp80z13yhIrl4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc9CxTuZOzpi5gQ43BUzTQun0YtbH4i5M775UTwpCrFGG2lGtXhyQIfm4vaHdd0u/AxvSsU1wsuH8i7rp+50Q4tqcBlTiiFC/GD6nnYFHolvHVKNk9KpCOVn1ZlaMOIuLB2eE3FVTy/Yuqe4BkZPDd0zwXVQDtYtJAdPxVldVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcRWT4dmjz6FGYC;
	Tue, 15 Apr 2025 22:34:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CAAF714050D;
	Tue, 15 Apr 2025 22:36:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 16:36:03 +0200
Date: Tue, 15 Apr 2025 15:36:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shiju.jose@huawei.com>, John Groves
	<John@groves.net>
Subject: Re: [PATCH v2 1/1] cxl/feature: Using Full Data Transfer only when
 offset is 0
Message-ID: <20250415153601.00001824@huawei.com>
In-Reply-To: <20250410024726.514170-1-ming.li@zohomail.com>
References: <20250410024726.514170-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Apr 2025 10:47:26 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)
> 
> "If the Feature data is transferred in its entirely, the caller makes

entirety 

> one call to Set Feature with Action = Full Data Transfer. The Offset
> field is not used and shall be ignored."
> 
> It implies if using Full Data Transfer, the received data will be
> updated from offset 0 on device side.
> 
> Current driver implementation is if feature data size is less than mbox
> payload - set feature header, driver will use Full Data Transfer even if
> user provides an offset. Per above description, feature data will be
> written from offset 0 rather than the offset value user provided, the
> result will not be what user expects.
> 
> The changes is checking if the offset caller provides is equal to 0, if
> yes, using Full Data Transfer, if not, using Initiate Data Transfer -
> Finish Data Transfer.
> 
> After the changes, all Set Feature transfer scenarios are below:
> 
> 1. data size + header is less than mbox payload and offset is 0
> 	Full Data Transfer
> 
> 2. data size + header is less than mbox payload and offset is not 0

Is it valid to call this function with a none zero offset? I'm not sure.
In my possibly entirely incorrect mental model the offset should be
an internal detail of how we get the features that we should not expose to
userspace (oops).  The specification is confusing on this point so I think
we should ask for a clarification.

There is text that for example says
"Once the _entire_ Feature data is fully transferred to the device (i.e.
 Action = Full Data Transfer or Action = Finish Data Transfer"), the
 device shall update the attribute(s) of the Feature."

What does 'entire Feature data mean here?'  The whole thing or just
the bit from offset used in Initiate Data Transfer onwards?

I'd read entire as meaning all of it so effectively the offset passed
to this function should always be zero.

I'll send a query and let you know the answer. Maybe I'm reading too
much into that 'entire'.

J



> 	Initiate Data Transfer(with all feature data) - Finish Data Transfer(with no feature data)
> 
> 3. data size + header is greater than mbox payload with any value of offset
> 	Initiate Data Transfer - Continue Data Transfer(s) - Finish Data Transfer
> 
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
> 
> v2:
> - Drop RFC tag. (Dave)
> - Fix typo issue in changelog
> ---
>  drivers/cxl/core/features.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..fcc624cefe89 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -259,6 +259,17 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	return data_rcvd_size;
>  }
>  
> +static bool is_last_feat_transfer(struct cxl_mbox_set_feat_in *pi)
> +{
> +	switch (le32_to_cpu(pi->flags) & CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK) {
> +	case CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER:
> +	case CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
>   * available in the mailbox for storing the actual feature data so that
> @@ -294,14 +305,14 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
>  		return -ENOMEM;
>  
> -	if (hdr_size + feat_data_size <= cxl_mbox->payload_size) {
> +	if (hdr_size + feat_data_size <= cxl_mbox->payload_size && !offset) {
>  		pi->flags = cpu_to_le32(feat_flag |
>  					CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
>  		data_in_size = feat_data_size;
>  	} else {
>  		pi->flags = cpu_to_le32(feat_flag |
>  					CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> -		data_in_size = cxl_mbox->payload_size - hdr_size;
> +		data_in_size = min(feat_data_size, cxl_mbox->payload_size - hdr_size);
>  	}
>  
>  	do {
> @@ -322,7 +333,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  		}
>  
>  		data_sent_size += data_in_size;
> -		if (data_sent_size >= feat_data_size) {
> +		if (data_sent_size >= feat_data_size &&
> +		    is_last_feat_transfer(pi)) {
>  			if (return_code)
>  				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  			return 0;

