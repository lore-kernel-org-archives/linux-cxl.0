Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3F6A33F;
	Tue,  8 Apr 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119922; cv=none; b=A2S47c4JU5JSD2T7Wcg59zDFwhwflxObk4+gq3g1uYFmQYPg+WH5fw1DfCe3S+W4GHyxT9SspFIHWT/CAGZBuduka2LtXh5a51+vHLPr8XGedUJJsclm1dRt81VCKsJbWg7aOyDLeZYg8uXRcB3twKyM83ffGu7M7Mz03imx7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119922; c=relaxed/simple;
	bh=02tKonEyjE8il5xrivQt+HLW4nnHApchfcIkVH1/NZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDea1Of15NfsAdOvUiDoahYRrBvDfN/qrHOoNRWD1YEpfDdX/hhpcIFSdXSoN2mG2RcXBRrTFtWS8xqvy0s0ssuZtr6aIwB2DWydutrLr3ZY7VVC2NvWhf67hQ+LHYjX+QCB6GR48MagDleZHcJdjZSfgsMSuKs/R9uykCWTXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ7OoVcs; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ7OoVcs"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7042ac0f4d6so13649347b3.1;
        Tue, 08 Apr 2025 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744119920; x=1744724720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw7kJPJQYjxaMDo7nd/b+XbBOuOHAwMDyUEb/lvDyhg=;
        b=gZ7OoVcswxQPCUNnMyG38lQ7Z1JNJxnyvuSEnWXTCy9o9MsfBgydACThFEPX5MtAQz
         k5l0eEJb6CeZq8OW6W/VyZvdsjCqqZ/kJRsKiNvkSG/+5G89kcZXZhrYjPXe6qMkpdyj
         l5pmiDOhrruFFbvWzrveT1JFqBfOZqJ0mPEXwUStk3uIcNphB4+O+Q+wojAMRqCtMdtm
         ZfSloLC9TldC2bwxQS1RWj3l/hZkE46E0xFa7iGrrY8lQ9IAJ52gyxP27eC+zzv3azWD
         g2JT0gPHHEo3tsoDU8YFhjybVASQNGyb5gCo+fg0X+TV+It1ESBTcUkW9PcxcVsVYRT4
         CMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744119920; x=1744724720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw7kJPJQYjxaMDo7nd/b+XbBOuOHAwMDyUEb/lvDyhg=;
        b=gLA0vTsI4IkXMNvE8t3C+6wuA3VQW/sCMZXF/ScFrCBK0HjDx1Wy9/VQLf6TyD47Df
         AZfyt6b93zBJkh5XUd9k/dB4u94z8B6dTFhXKGFOt/H0yCpnibyAyi27WKfn24N4pqkd
         LCQA/beAFY5tXufWf6L973xHHEuPZXFWpmtGms1FrwueIXqMbOS8e3pvVQ44yI+n3HiT
         MiRJFh6y4jCADx2NLZf5IEXW8Z8dIFiKirCAMJoPzUQ0TZi+PWR5RMqoJSct792OXi+E
         6UcJfgdrR1aloCB0ARJKRcJ+6/RvZf2RaW8FyZ/qwTGhvIUhkehwcKi7U936WfH5+ZDn
         NtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB1PCoLu+s3hOmNiBJFSefGdGBh6DDlSWHfZ7iTMKWIHHF0HEcj5x+Wjo5q+QjKEEVPp4nRuCROcY=@vger.kernel.org, AJvYcCXA+nh60Zfy5dNjiaHh6FaeKxngVfLNLPWWu255OjhWTb58qA/EwmqKybd2WMmCN5lQIPnsujdjLaPluUiJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzRpWpolX0Ma6ZHWywo/dOZuGWw3DyecYMhBosz8Weisj1xH1
	Wk3Z+xm9tFAqfMVU8skPTB2/AA7Be0UYEm6vwMGPw2YY7ckAnjxg
X-Gm-Gg: ASbGnctefrlYZb55XTxCMSmyHCTO0lvwn8lEfIA0BXuvjYOTsx8oKctLj9FrQmDxNN8
	a8fLxMKDtvsuYUfS4VZ7sfxlfAfTn82JjBg2W1BugzppJSSNuut/uK/wiZX8zPRUr0myB1RNO7U
	HH1xK/NZ6teLolxs1uRwOtmq7bV1qx1WFJBImFpGlWWOeCLDXYgWXbxZ/edLhZkjmbdCydicVUA
	eqMetP/UvzRhgjuneqAyjskYEgXutKTSrVICni4FV9TcLFzxoN9uGMsw1V4E1EP65JPtCbZu8gy
	wpjSNR9vOnCIJ4j4MXyxC/bjmo59BhEdwrKQk4lL8OQ=
X-Google-Smtp-Source: AGHT+IHDxXOXAIt3KXx6UHSUynoTCZwbV0/9Izo05tTRDzAD3JSCLU0CPGbeASO9hlZh4g0QmhvDhg==
X-Received: by 2002:a05:690c:7006:b0:6f9:b12b:8953 with SMTP id 00721157ae682-703f4196e1fmr221965077b3.20.1744119919840;
        Tue, 08 Apr 2025 06:45:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e4dedasm31013877b3.27.2025.04.08.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:45:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH v7 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Tue,  8 Apr 2025 06:45:16 -0700
Message-ID: <20250408134517.2967112-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408073243.488-2-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Apr 2025 16:32:40 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

Hi Rakie,
Thank you for your work on this fix! Everything looks good to me : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with proper `kobject_del()` and `kobject_put()` sequences,
> ensuring correct teardown and preventing memory leaks.
> 
> By explicitly calling `kobject_del()` before `kobject_put()`,
> the release function is now invoked safely, and internal sysfs
> state is correctly cleaned up. This guarantees that the memory
> associated with the kobject is fully released and avoids
> resource leaks, thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 66 ++++++++++++++++++++++++--------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b28a1e6ae096..0da102aa1cfc 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3479,7 +3479,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>  
>  	for (i = 0; i < nr_node_ids; i++)
>  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> -	kobject_put(wi_kobj);
> +
> +	kfree(node_attrs);
> +	kfree(wi_kobj);
>  }
>  
>  static const struct kobj_type wi_ktype = {
> @@ -3525,27 +3527,37 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	struct kobject *wi_kobj;
>  	int nid, err;
>  
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs)
> +		return -ENOMEM;
> +
>  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	if (!wi_kobj) {
> +		kfree(node_attrs);
>  		return -ENOMEM;
> +	}
>  
>  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");
> -	if (err) {
> -		kfree(wi_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto err_put_kobj;
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
>  		err = add_weight_node(nid, wi_kobj);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> -			break;
> +			goto err_del_kobj;
>  		}
>  	}
> -	if (err)
> -		kobject_put(wi_kobj);
> +
>  	return 0;
> +
> +err_del_kobj:
> +	kobject_del(wi_kobj);
> +err_put_kobj:
> +	kobject_put(wi_kobj);
> +	return err;
>  }
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
> @@ -3559,7 +3571,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> -	kfree(node_attrs);
>  	kfree(kobj);
>  }
>  
> @@ -3573,37 +3584,24 @@ static int __init mempolicy_sysfs_init(void)
>  	static struct kobject *mempolicy_kobj;
>  
>  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> -		err = -ENOMEM;
> -		goto err_out;
> -	}
> -
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> -		err = -ENOMEM;
> -		goto mempol_out;
> -	}
> +	if (!mempolicy_kobj)
> +		return -ENOMEM;
>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");
>  	if (err)
> -		goto node_out;
> +		goto err_put_kobj;
>  
>  	err = add_weighted_interleave_group(mempolicy_kobj);
> -	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
> -		kobject_put(mempolicy_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto err_del_kobj;
>  
> -	return err;
> -node_out:
> -	kfree(node_attrs);
> -mempol_out:
> -	kfree(mempolicy_kobj);
> -err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	return 0;
> +
> +err_del_kobj:
> +	kobject_del(mempolicy_kobj);
> +err_put_kobj:
> +	kobject_put(mempolicy_kobj);
>  	return err;
>  }
>  
> -- 
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)

