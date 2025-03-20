Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B31EB5E0;
	Thu, 20 Mar 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489137; cv=none; b=mCjYJMnbnTyMu02Llo1zpKBdy1NRSMy/veTZ0JA/2ktl76TLiEMgh1n3EZZxZi9jYP99ZufJuoi6cCvc9nMru0bkjlqG3zCwUuOJfepXNtqUmINThdPWavwZCdB7nXsxUpcvl/5Mwbj21rv6/TZHd1gABCiVzRvDr4pGe+ei0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489137; c=relaxed/simple;
	bh=qqItqlFyk4AZ90MU5hbCbICUAFIIBuVrqI1oy8rs+0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFBNNqxhVup2D8b42R9hBXFfkNaJsy9cOvtV5ZxQP+5X/+HS4lAeCUlcw9CMYyzEaUVPGIrOtIp6TDwqMeJv5kl+TU+RqixLDWFSZ9V5S/9kqX7QdUhF22JIWrsZ6clvqfYLfPYr05ETLJfh4aCtcTqkBlPvMpOI5lvRJGMvCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avX6NG7A; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avX6NG7A"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6febf391132so9931347b3.1;
        Thu, 20 Mar 2025 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742489135; x=1743093935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KezL3PAx4Yqh0KckvimzJ7vzPDGdKm/LH84hRf1qio=;
        b=avX6NG7AUZxFRzKdzUqhNUf1NRyXs+XM1O9NOE1FmHw9uaojKtWmefGU2nfPAmnqVS
         Nelj9krFdk7SemgGm3cz4a0gkdkFfgsf2tnAgNQc/xNSBKf/bwwX8H96U76EOtfJhM8Q
         EkRhs7qZKIvGC6g/LAZMMZHGBCyaDcl/fLxfHZft/8kVuzZkouSMSsBGhLXzxj/BZ0dt
         CyXDFnXmAzNha4EKbrJpaA6++Wo/yjP1RbGya7vE8MCoL6Dccfgyh07K56h0dksV/aju
         Wizkgn5C9UdpAwXTRZhbqWh6eQsaQExVrVbzzF8oV1BJ0D2Z/9Fstqy6QdGXfwOHEK5W
         zimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489135; x=1743093935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KezL3PAx4Yqh0KckvimzJ7vzPDGdKm/LH84hRf1qio=;
        b=GrrRH8obBV3prL8RbYPp20pus2AF2qZ1udqpUsMW05IL64yXo3bNRgGmToKzxmkCwG
         Dk3uExIuEE2MkOLXfq8PtnsNtq56HudrG/t99JQeLf0jLg/r3oR2qO7GFiK3LGYf2Dkz
         GWF5TyIZcf63f+qWWeEK2pjmFmqI0L4xLgYVjztKRYOAkRzUxTtKlWednzoYfyYl0xGG
         xuSCISfI2VT8ew+YG5VYgt3KEqZaTsVTffJwAPdjL+yr/sNURqKSoQBcaMjrpbxSpF4c
         NyHQQOoJKNeY9p5D2iibv4UJEs0hUoHi69kA1J7dO+ajDHxgQH+boCuko+Lp0Umb9ZFA
         0DtA==
X-Forwarded-Encrypted: i=1; AJvYcCW3gEiXlBNGD8AUckPVddER8y+bum/4dJACHw8RVhQJxYJ/qIbIcrHOW1A6u+UQhrfOc2kNN3DiJf+syqqL@vger.kernel.org, AJvYcCWhMIUk7SO2BvHwE4dQL9lV/hzigq+fqL6OOzA58WFQcxVsjZn+6bkveomdzXuM+UpLiIPiYP+Hur8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgFKGRGSPylO6ePfIRv2uQcqbGeIqWd6ER/BPJogx44QuH65s
	IzwiYrlFse0Ny8iGzfpF2hNU0plOhdLNYGGcgANc3C+KCIWb5B3t
X-Gm-Gg: ASbGnct5rdn3ZyZWHRAK6HeGpxkOvysn74lK6n1e1dpXkpyuCV2/dUkKJUF8F0PYeuV
	jjaumyTWd71VtfIHiZlchf0ghbPFI8M+I4W+mjLSBbImgOiWD7+rSAt3CGcSZWI356w5fKxoA1I
	JxZBaMFwx+96LHrOkcJ5BDqyu0w8s9QLA5P/Hbh6PeLXUBjtSFBdW8TluMbtZ/iU3rce7SvGspd
	yBdVhKMl7jHOq5rwVmECEiS7cWhlEksro5H9JCFA47HGekg7JW784bMj8DYyDhLbcAhW+c808Eq
	uX8NVH+7LKGyEz9Eu1rakZURbWt/BEr0ckyQWgK+MCAb
X-Google-Smtp-Source: AGHT+IEHB9i2wGUB7JoCCEDiuzQ+VHkFY61m+oAR66RJyCZK95REKh6ZfA0CzpEWMiphX0glIYrNPg==
X-Received: by 2002:a05:690c:4809:b0:6fb:9702:f1ca with SMTP id 00721157ae682-700ac5fe1c2mr57390707b3.20.1742489134456;
        Thu, 20 Mar 2025 09:45:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba8565a4sm81687b3.86.2025.03.20.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:45:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: gourry@gourry.net,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Thu, 20 Mar 2025 09:45:31 -0700
Message-ID: <20250320164532.1313581-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320041749.881-2-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rakie, thank you for the new version! I have just a few questions / nits
about this patch.

On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with `kobject_put()`, ensuring proper cleanup and preventing
> memory leaks.
> 
> By correctly using `kobject_put()`, the release function now
> properly deallocates memory without causing resource leaks,
> thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..5950d5d5b85e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>  
>  	for (i = 0; i < nr_node_ids; i++)
>  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> -	kobject_put(wi_kobj);
> +
> +	kfree(node_attrs);
> +	kfree(wi_kobj);
>  }

I think the intent here is to make mempolicy_sysfs_init call kobject_put, which
will then call sysfs_wi_release when the refcount is 0. So I think replacing
kobject_put with kfree makes a lot of sense here. However, I think it is a bit
confusing based on the commit message, which states that you are doing the
opposite (replacing kfree with kobject_put). Perhaps it makes more sense to
say that you are moving kfree() from sysfs_init to the release function, so
that the struct and the node_attrs struct is freed together by the last
reference holder.

>  static const struct kobj_type wi_ktype = {
> @@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs)
>  		return -ENOMEM;

It's also not obvious to me why the allocation for node_attrs was moved to
add_weighted_interleave_group. Maybe this refactoring belongs in patch 2,
whose described intent is to consolidate the two objects into one (I expand
on this idea below)

> +	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!wi_kobj) {
> +		err = -ENOMEM;
> +		goto node_out;
> +	}
> +
>  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");
>  	if (err) {
> -		kfree(wi_kobj);
> -		return err;
> +		kobject_put(wi_kobj);
> +		goto err_out;
>  	}
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
> @@ -3512,9 +3521,17 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  			break;
>  		}
>  	}
> -	if (err)
> +	if (err) {
>  		kobject_put(wi_kobj);
> +		goto err_out;
> +	}
> +
>  	return 0;
> +
> +node_out:
> +	kfree(node_attrs);
> +err_out:

NIT: Is there a reason why we have a single line goto statement? Maybe it
is more readable to replace all `goto err_out` with `return err` and save
a few jumps : -)

> +	return err;
>  }
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
> @@ -3528,7 +3545,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> -	kfree(node_attrs);

I think the intent of this patch is slightly confusing. Viewing this patch
alone, it is not entirely obvious why the kfree for node_attrs is now being
moved from the release of mempolicy_kobj to wi_kobj. Of course, we know that
it is actually because this patch serves a secondary purpose of moving
the allocations / freeing of nattrs and wi_kobj together, so that in the
next patch they can be combined into a single struct.

I think one way to make this patch more readable and maintainable is to
separate it into (1) fixes, (as the Fixes: tag in your commit message suggests)
and (2) refactoring that prepares for the next patch.

Please let me know what you think -- these were just some thoughts that I had
while I was reading the patch. Thank you again for this new version!

Have a great day : -)
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

