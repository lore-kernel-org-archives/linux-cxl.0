Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30E1A7AF7;
	Fri,  7 Mar 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371620; cv=none; b=ACxlu1ep8WSN/CtrKlosdq2CN28cFxa1g0jyQOR9peovvCRuvKJ/c72JByMmD3Yjw1vN77iVA02phzH4gxN2f2xHzko6yXw8jyEnMUJoe44/rYRewfHHZMwmBB1V6XvKUaHeWdrskbSLhTyGYitXN4KxzoSQIYsAc49Sid7naRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371620; c=relaxed/simple;
	bh=rqrIgGVQ6M5vVw6p4Jr1p0YFHYVdn2Xj93tZ/3VW8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs8GlkedPXvSouInn7Hy3PuTW3r6IdBFPmaOksVW34fo3m8qIy6SZrJWhrYqja/yfgCg31uMbnq9q7fyhZEMDihxLkQa2AWe0aAu8/1NimhfbEEViZHiNhKKlZuxOWwd7YcUW2BYCflhZK5/7jX9XhDyYq64lnYreLm/b4xIN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+mHNaBF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+mHNaBF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fed0620395so678157b3.3;
        Fri, 07 Mar 2025 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741371618; x=1741976418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeJw1/wk13slq8SaTOaUUmP/IYv8V17ltprOZMyg7cg=;
        b=E+mHNaBFmFiS0Iocn7UQu6+0CFNC3fjcWs5SNuHm+4btnQsj+t3ugV3+d/4SauQGiq
         N8xtil+Tn3toaPP0kB7UfGPojnMC1T/FAAFaMEY2s6Gqnax83u3fZEQ5q5AQyjA3GHzE
         d7IvW/t3NHdx8VncHs4pMuI/3h0VtcibbSAdMDmbkBp0XP93o3isL4eFdMmyAGSFVWwA
         xLreJvhXPpKh/gEW3Enu8nfD2nTtOG8IALwS/ngRhuRE6K/22v41vJ7GZiYqWZcJ2uFk
         KQgwbSeopmh1WMb3kuuCvpnssV0P/aMdgG15DajkjxbHo1mZvTcKxR11IgsXJC7HITdc
         j0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741371618; x=1741976418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeJw1/wk13slq8SaTOaUUmP/IYv8V17ltprOZMyg7cg=;
        b=e6emIJ3ytodKFKfbKi2IY22OyK1OHShD2fiYTDbrpQ/oO4URoPNwkvCXb7WE8jUvCO
         BGvqep+lDpanPFBkYWI00Swp2cvV9F6D8jU2x1k4V+680HQmIxP8bkr6lcmsYWfGqXl7
         PegfikZMsPWIk5UlRoYWEJdLI9KGnjEBfy4cCV3fHBpTIe+W9EGSa5Z1K98L5AwGfZ5+
         XeIIQBZKXyAaEYA9XvF+ZM6WnI3drJMmoKjCZtUdF37cdkJ8EiyfdVGL5FtyN+hZDP/i
         Szgf3Wgwc8RJ6nQX3mjEnji+6MygAareHsbfDLrWnCjEW8SWr/Ws+LuedKNXUDepW8Vq
         z7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUIroZEMTwTXtgaJAFFFHFCHjl1b0JoCuZD9haxD6zq21DrCcAP1lIuIUnXNJH+af0bsNZcYrrt6a4=@vger.kernel.org, AJvYcCWwMZHZDfBfSA9U/hf9EeIadnKkc5gotr68vdtZL8+RLhR5RMex7mWiFYO1xO/DM8CJ4DdCR6iX8m+zB9yH@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJws5drAkwxQTd+6ogKz4pdo2zcKNeiDvPzHpEpgAvuedWisd
	/i4dVXrCV93IJZw850I0O9dRwAKziYOuH1O1E0A8lzdfpGRZxqOi
X-Gm-Gg: ASbGncsn/Gw0GT1JJ68mo+QojsOfyrqihWj7EooRHwtpwRFfPni9/FyLIbqkAeanCdE
	5hBbLF1KoTLTbibEz1H6zeP+hF9GDufvuJokiLZfJVdMOn0r2rqcS/Z1CRKI+BD0x37ZVCYKqqi
	NyCTgn3YIMYPNyK7ezYZIXizjevdBifRRgHwZUu/o6BXRkYbxw2oknwySoALgXSAsw3ZvFRAFfv
	sd4HWfnJE34JC2LDFMkAnP5P2T4Ix/RjH3Eo9e4HpjW+BA+2CQ32t4LO7EhTI/d1HftpihgRgVr
	lyDMUgzkby9iiiiu70aICwa4f2NPDFtze2tldt5LnZw=
X-Google-Smtp-Source: AGHT+IG2YFy9NIzuiSU0JWQXIeYFv/n1+QFXy6BL1HyvwEsV80P0bUaURpLNAaL1ozbvN4gTQ0q7mA==
X-Received: by 2002:a05:690c:998e:b0:6f9:ac35:4483 with SMTP id 00721157ae682-6febf3a9308mr61829397b3.25.1741371617759;
        Fri, 07 Mar 2025 10:20:17 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a5c217sm8348817b3.38.2025.03.07.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:20:17 -0800 (PST)
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
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH 2/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Fri,  7 Mar 2025 10:19:59 -0800
Message-ID: <20250307182015.489780-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250307063534.540-3-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  7 Mar 2025 15:35:31 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

Hi Rakie, thank you for your work on this patch! I think it makes a lot of
sense, given the discussion between Gregory & Honggyu in the weighted
interleave auto-tuning patch.

I have a few small nits and questions that I wanted to raise, but none that
should change the behavior at all : -)

> Previously, sysfs entries for weighted interleave were only created during
> initialization, preventing dynamically added memory nodes from being recognized.
> 
> This patch enables sysfs registration for nodes added via memory hotplug,
> allowing weighted interleave settings to be updated as the system memory
> configuration changes.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 51 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 385607179ebd..fc10a9a4be86 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3389,6 +3389,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct iw_node_group {
> +	struct kobject *wi_kobj;
> +	struct iw_node_attr **nattrs;
> +};
> +
> +static struct iw_node_group *ngrp;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3431,8 +3438,6 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
>  static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>  				  struct kobject *parent)
>  {
> @@ -3448,7 +3453,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>  	int i;
>  
>  	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +		sysfs_wi_node_release(ngrp->nattrs[i], wi_kobj);

Nit: I think it is slightly awkward to have a global struct ngrp, and then have
its members passed individually like this. Of course there's nothing that
we can do for sysfs_wi_release's argument, but I think we can make the
arguments for sysfs_wi_node_release a bit cleaner. An idea would just be to
pass an integer (nid) instead of the nattrs[i] pointer. We also don't need
to pass wi_kobj, since it is accessible from within sysfs_wi_node_release.

Once we make both these changes, patch 3 becomes a little bit cleaner (IMHO),
where we acquire the lock for the ngrp struct, then access its contents,
and we don't have to pass two pointers as arguments when they are already
accessible via the global struct anyways.

>  	kobject_put(wi_kobj);
>  }
>  
> @@ -3486,12 +3491,10 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  		return -ENOMEM;
>  	}
>  
> -	node_attrs[nid] = node_attr;
> +	ngrp->nattrs[nid] = node_attr;
>  	return 0;
>  }
>  
> -struct kobject *wi_kobj;
> -
>  static int wi_node_notifier(struct notifier_block *nb,
>  			       unsigned long action, void *data)
>  {
> @@ -3504,10 +3507,10 @@ static int wi_node_notifier(struct notifier_block *nb,
>  
>  	switch(action) {
>  	case MEM_ONLINE:
> -		err = add_weight_node(nid, wi_kobj);
> +		err = add_weight_node(nid, ngrp->wi_kobj);

Same idea here, we probably don't need to pass wi_kobj into add_weight_node.
With that said, I can also see the argument for passing the struct itself,
since it saves a line of variable declaration & definition.

[...snip...]

Please let me know what you think! I hope you have a great day, thank you
again for this patch!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

