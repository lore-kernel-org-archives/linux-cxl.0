Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96331A8F84;
	Wed,  9 Apr 2025 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165670; cv=pass; b=YIJiba+WYgi7Xd6cAR/iZ7QPNHu3Bh8sYNTfpnDAkdFQ2IfA8l/WzJj872ibybiwnfQZA/vxmsxU0InKAFnrezawYt7jl5ltBnImdemKOezZuWShckv5wGe50W8mN1lyGgQ27Ks1bin9Fts3Wj5cXhtJxTM2ll31hZsGOafMclc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165670; c=relaxed/simple;
	bh=9dE9l6ezM0YNa4uq1onv3rHxkvBHGh+DgnDSfgpw6+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXnN4QdkDR0yCp1po3JRAeu2ZZauUE59d0Vr4LG/dTIwOGFi5fkfkFW8lj5VGInJrYMm8XcRjwIuFvyGaKntJqPTEn2/lkd44yWvBsgrDIBYifI1FawTTkf1JNi/vACoAfedpcniAITOqRt1aYKarS3AGC7vIlDxgN+KF0IYiQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Or1jbU+w; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Or1jbU+w"
ARC-Seal: i=1; a=rsa-sha256; t=1744165654; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lzPQwfYADmOkHyLAJnOSsaykEs0QWX6pT4BMApK1abHQpn/GEWgTE3b6YUgRLUFHlgxXO0yo3uRV718q7Rqi4xRgK569r8J7ijeilnPP3CezxygWbBbVzGVjMGjP7sh9691mu2sldWBVY1NV720W+4ao3v7CZ8w8WCI2jdAkkoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744165654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vZv4Eq5lF81LEzsG4V0s6zDPG3V9wW/vSpxZUku0jWY=; 
	b=Y5d6HnZiUqHReEAgYgPltGqI+f9KZvk4LzzEfRDZugO3F7CKa+jBXRoBKKAH+hVkyClaid8BKsuMOEwmO6gp+PsTKlWlz8m6rVSOpkI0Q00HXZclGNwUM7xv2pGQv+NWrBeIEc0+TdoJEGfVeyWnJaO6RvBmI7d3K3Q53AEcXAI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744165654;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vZv4Eq5lF81LEzsG4V0s6zDPG3V9wW/vSpxZUku0jWY=;
	b=Or1jbU+wr2oi7ynItENXROqTauGnTGrkCy8+rGUWOiUZd+74AiJHwpfK7YkEtTZK
	fdmbYcvihjNqK3aLqxqg3Dl42M6acFJMSb1NXi+axxXkeZPkRT7rml9BDWWOLI56YJP
	ba9LO3n0zylUcMALHOy9OtZKK2mbfVadFQYzZIXE=
Received: by mx.zohomail.com with SMTPS id 1744165650962337.66983751874034;
	Tue, 8 Apr 2025 19:27:30 -0700 (PDT)
Message-ID: <5a0c0846-1fad-4f46-a5d0-699d2407d266@zohomail.com>
Date: Wed, 9 Apr 2025 10:27:28 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/feature: Update rpc_out in set feature failure
 case
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409021234.509565-1-ming.li@zohomail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250409021234.509565-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122761dc8a8894c860bc5c7321500000e3aa4de60c445508d422e356d8cf0c6ff5843be81d350a0821:zu08011227125125597e93b232d22f4e870000bbe7fc134bd2a6fae4c921204f6c4a8d332423d1ad12bf1b61:rf0801122d96b98ebdb33302ad727520ad0000ad9fd2668e472395eb1a1b0ec9229c3164fee009129279a9b03d8f31e95951:ZohoMail
X-ZohoMailClient: External

On 4/9/2025 10:12 AM, Li Ming wrote:
> CXL subsystem supports userspace to configure component features via
> fwctl interface, it will configure features by using Set Feature
> command. Whatever Set Feature succeeds or fails, CXL subsystem always
> needs to return a structure fwctl_rpc_cxl_out to caller, and returned
> size is updated in a rpc_out parameter. The rpc_out is only updated in
> success case at this moment, it should also be updated in failure cases.
>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index fcc624cefe89..63f24f032209 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -540,13 +540,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;
>  		return no_free_ptr(rpc_out);
>  	}
>  
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> -	*out_len = sizeof(*rpc_out);
>  
>  	return no_free_ptr(rpc_out);
>  }

Sorry, please ignore this patch, Wrong description in changelog, already send out v2 for review.


Ming

