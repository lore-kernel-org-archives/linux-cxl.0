Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F552135A4;
	Mon,  7 Apr 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006266; cv=pass; b=jfyib8dQNq1mYoTPBHE3LrqYWYqQu5BcRYyU8Ey/+ssbtgt4N/gaJhGGMqOiMyASc4dPzp4WYNUl5hEeEB5/Zig8uzjvG+zLFg2vnmmUePxlrU2ufGOx/JquEOPG2XisQsnEP2hjRrPaCQU2gVhc2wk+O7ixQEQ4556R4/z3ucI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006266; c=relaxed/simple;
	bh=HJnxSu2wXA5Q3mOn5vriohSJ54Ww2I1nuUo6mgUqmrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDviRav0aPoAk7tQnWVEtTeueyCOqSv3oifDu1rpWnjiVDl1zG2JlgZOEzrQUt7u+2DZf+PppW8ikCYUtY5rjFiFUCE+l+7UWTFa37cWmfrxq7w7ZdvvqeQz0aA1CD7ZvNuEtaolkATagtr0xbmXMGHwA1mfrm8fnEXVTKaz2Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=OAOhuUEO; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="OAOhuUEO"
ARC-Seal: i=1; a=rsa-sha256; t=1744006245; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LOb1LOo6e6FrVjbcXFkZDOf5RiK5UB6Jrz87D+3e1zb4ZMsmH7CNKJwd5VOQjGNTdwPsBZOLdyWhwjWssCm7LAqX6TQ6EhcZrJG/y/EsGp29bI+xmmxKS/mE2YcwGZJW+gnxGE3tmJtqBwT5Zp0uLvyb1oW5bMnEsOMdh3qDnHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744006245; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wyu8LmD8rRUC3H0Pg/fx0A4u+L35MGgNu7fRwBGIKp4=; 
	b=ECymkep1DL6hSSXoJQQ+kMnroVf5TE2RqHhu0wscziYFUChQbpUiPUo+P9dSDcwy3fTzGa33y4Zz0WCL+pq0cdYWqLhjZ7sRkAo+rT1xirplfLotzRafUOYoa/MYbCRr/lXn6YqrHLUR0iF/7J3vEJLyP41jVxmv8zoL77SiKDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744006245;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=wyu8LmD8rRUC3H0Pg/fx0A4u+L35MGgNu7fRwBGIKp4=;
	b=OAOhuUEOalrd40FBWJdb5hHRC3xV9D9li5BaIfAhfPLYrmwo9ay0d2AhBXglxW09
	WsqAhzMxA6MWrOXQnS8EIs5cROkNUoCoFiZ3ga9asseCpmW2FPjOz+Dy0g2vLwebmZ3
	UvLCFXSVtuhQIoGCenxG6O9dGDSfGE97Fx6mMisA=
Received: by mx.zohomail.com with SMTPS id 1744006225872305.6751632388572;
	Sun, 6 Apr 2025 23:10:25 -0700 (PDT)
Message-ID: <deb343df-39be-4bf9-9288-179a73154ad0@zohomail.com>
Date: Mon, 7 Apr 2025 14:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl : fix cxlctl_validate_hw_command() warn: always true
 condition
To: xiaopeitux@foxmail.com, Pei Xiao <xiaopei01@kylinos.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_30DA5E4827F37333AE881122DCE054DC9008@qq.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <tencent_30DA5E4827F37333AE881122DCE054DC9008@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112278ed2c46ca8c805236446b2150000005dc0fbd22db3673912ec2d41b9135561f10ce0509cd0d9ee:zu080112275498a79d7e5acc0f086d7c010000ae28deadba607b8c68279e1fdfd9c2f67face246f4817df21b:rf0801122dac3b15604d8ae45714d9bf6100004e3000f8d706d8d0385c8fc4328e3f2be30f05ac6b798f19480a0b50def7f0:ZohoMail
X-ZohoMailClient: External

On 4/7/2025 11:41 AM, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
>
> smatch warnings:
>     drivers/cxl/core/features.c:441 cxlctl_validate_hw_command()
>     warn: always true condition '(scope >= 0) => (0-u32max >= 0)'
>
> remove always true condition.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/cxl/core/features.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..fdca93c984ce 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -616,9 +616,8 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>  	case CXL_MBOX_OP_GET_FEATURE:
>  		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>  			return false;
> -		if (scope >= FWCTL_RPC_CONFIGURATION)
> +		else
>  			return true;
> -		return false;
>  	case CXL_MBOX_OP_SET_FEATURE:
>  		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
>  			return false;

Already have a patch posted for this issue.

https://lore.kernel.org/linux-cxl/67f02de69d89c_9fe8529481@iweiny-mobl.notmuch/T/#m84c3093032b5eb167bbb1d0a787019d0387f4ae8

