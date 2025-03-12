Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477A198E76
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794553; cv=none; b=rcs6dRX1fm5a+0SF1/CQRdBppCb61nd5djLfhOA2zECbYdsEfFABvEjxOe1FLpfxVldEuaKYnW7Qvi0WetMJ5DpRUnRO26VyI4Jl/QfTwccxSjA/2uaRy33jhK8pF/xXe4N90KlR7XLZSAltyWR98j6XvKfNL16lOizmp2adOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794553; c=relaxed/simple;
	bh=lyu86/EH9by17rBAc9XiUsIwotdsGEea6rRN+fSn5Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE7yI6Mw15xRdN7msZF3Kr3htghC1VTQTFrqEEh5xPu0iXZsmwy5RL9ZKC1bcY0n916EtWwRdgRk7bOjP80+AOS8tqjPtfSbIuKmHCLlDaIPVZ9OoVp2UdtmqzFWJrAJIBWh8DhwxXT1R70xuLrEKYOJLh8LZmkCUjmlI0z0vcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jJH+aorG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jJH+aorG"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e1b11859a7so166156d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741794549; x=1742399349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofjgk4zuzVS+cwXy38yJsSZN8fRmew2OrhBauRs/AxI=;
        b=jJH+aorGgEkiLX5+MWr3iM0TUBVkVY7PBu47LDABFRM/S08v61AGcX++2L9tpca5zv
         VFNLzzvOh1Dc9M3P37iBonIJI5XkQ7Et/HTplSk4arltOTD9bkbPn+KDSO2GvvdgS0AX
         hYsH4uPLAgeMGyxyTot3ifCogF6IBUkD+9QMl51dnf/pss6jhs5Z6YqiKGN/IElV8dNe
         gOQSq2Xhp2xzp58aewMeaRtfyMV+/aqCJlOUP4jMmo1oSsZ2zS7JTHKcxi5/E6XToHbl
         a3cGrWYF7by32q1dJpJkTDcMmdI2YNtQwZuv9eqVu9mufLy1mDj5HVSUkv/b/6IVMbmO
         b9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794549; x=1742399349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofjgk4zuzVS+cwXy38yJsSZN8fRmew2OrhBauRs/AxI=;
        b=hEN8UEvs+uWi5WEfRCcJirnCZbw6tO5GdSZCBuxApAyaNGwlOeT6iAIB/4OIooTRjJ
         H7uLm5wRA1vgweSHJSh6+fXa2Yuhz/MZtTgRM6X+Jesfwx4OJ6+YlOjBDLLMR3LHuslx
         oNIXTiMJsVvIwoNYu34oFTPSmFLQVfY7l5e8iWOKUgH3A66KfDRZxWRmoL5jQfNmpyKo
         K31P8eGCCMW5o3S/VQo/kkwMMhNll5+UODSaPaX7ch9w0/uKioLL8vpgmxZThBzMPeJq
         ZTLscvd0WxI2vFpmbpDyXAaucbnenZM4kuSLQcPbPbV9aKanwYOMznd3XgBUemuN4n8s
         iqXw==
X-Forwarded-Encrypted: i=1; AJvYcCVSiiXjOrLvbpbD6p+yVluQ6Dg+CS5wz9dF6KCHXb1eMtIIPOyvwuiBnZZKhnSvyc5m1Owkr1OLOpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wEitQ5ktL/2MBtsfBwXrj44ETTcvuK5PMnUGj6JwiCbRdiDl
	ymZr15QhUG5No3Wygpag2KVw7CcK5TJ+62T1/tzejsbJBE/sjsCjc94Zappcl3w=
X-Gm-Gg: ASbGncudUMwTsgQh1HzSQBfa885pGAdXfChFdsdr45Y/jGxjB2PXz75g1BMAbNb4tTB
	LR6ZCDM8T8SWPzkpWlVYofQIz3Nuy+5TX2cqPKdpw92xfc1K1QeATlIK0F6F/EeUWqoyNCHBtNj
	+JVQrcpxarqTyHmXeZlqIXOS7BW8JrYt+cwFU/Je8SwTR9jCaxHbamWK2DG/jxZt5G+8fT1lA/d
	kbHClDtSQoadPSNvq3PH7jte/+b+OiEdpvYS6MibaOPBRwV59N85AQQAXltFQ52ASG12ShET7R4
	fJ6HjczD2yrLM0puQhksLBf5iHFQY1ae67mJVO3iyx8X7n08K1zxyqtL0bvDhYihq6iLx8Uqp6x
	HutLxpdqZYvdvR37Ow1lkAOKJPik=
X-Google-Smtp-Source: AGHT+IHgLZkEvIln4jLLyfDar99K/dWJ5BxlXAP1djqq5pBtYYfVdlZnJt+v1rDagFjkM9RWUey0ww==
X-Received: by 2002:a05:6214:500f:b0:6e6:6c7f:111a with SMTP id 6a1803df08f44-6e9007022f2mr241507726d6.40.1741794548627;
        Wed, 12 Mar 2025 08:49:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm85938316d6.64.2025.03.12.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:49:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:49:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-1-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:24PM +0900, Rakie Kim wrote:
> Improper cleanup of sysfs attributes caused kobject and memory leaks when
> initialization failed or nodes were removed.
> 
> This patch ensures proper deallocation of kobjects and memory, preventing
> resource leaks and improving stability.
>

This patch does multiple things, please split these changes into
multiple patches.

> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..1691748badb2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3541,39 +3541,40 @@ static int __init mempolicy_sysfs_init(void)
>  	int err;
>  	static struct kobject *mempolicy_kobj;
>  
> -	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> +	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> +	if (!mempolicy_kobj) {
>  		err = -ENOMEM;
> -		goto mempol_out;
> +		goto node_out;
>  	}

It's not clear to me why you re-ordered these allocations, it seems
superfluous.

>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");
> -	if (err)
> -		goto node_out;
> +	if (err) {
> +		kobject_put(mempolicy_kobj);

Is this correct? If kobject_init_and_add fails, from other examples we
need only free the mempolicy_kobj - because it failed to initialize and
therefore should not have any references.  I think this causes an
underflow.

> +		goto err_out;
> +	}
>  
>  	err = add_weighted_interleave_group(mempolicy_kobj);
>  	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
>  		kobject_put(mempolicy_kobj);
> -		return err;
> +		goto err_out;
>  	}
>  
> -	return err;
> +	return 0;
> +

Please keep functional changes and refactors separate.  There's more
churn in this patch than is needed to accomplish what the changelog
states is the intent.

>  node_out:
>  	kfree(node_attrs);
> -mempol_out:
> -	kfree(mempolicy_kobj);
>  err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	pr_err("mempolicy sysfs structure failed to initialize\n");
>  	return err;
> +
>  }
>  
>  late_initcall(mempolicy_sysfs_init);
> 
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> -- 
> 2.34.1
> 
