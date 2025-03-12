Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F522DF9D;
	Wed, 12 Mar 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791885; cv=none; b=HBmzizjiLGg6nWFdsCPBtI8WfcBRf0piGFOoIMAb551hmLU7/9ZLoe6QFkyAsEgthsX6Fxy5ddO4yEVBJaLJrzSB+F5kyInxBGhgQexOrg7dujr1TvXwtSxoCU8xj45Jw1RTMo21GP6zyJ83FN3rxj77b8dAlpvbBFh4iHc2vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791885; c=relaxed/simple;
	bh=4kvwciWhtuLbjmDQrc8d4bXFZQIkcET9QjpPx2Lfh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D59UVWpoB+oSMwOJRXbFO3h1sPjFE+a7yx9EmpYXNQdjSzZBPUJ409cbf78IHkaMLLHW533UZsHNnp/HnMcMnqhKLwhXDpnpg7Znr+vyrRBYOFVEiWfBWypvd+HmGofmUmEWZAIYimFbDL5qUec1XvOk9+SKiapwE4wHwXbhZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpHyrsJJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpHyrsJJ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6febbd3b75cso56388087b3.0;
        Wed, 12 Mar 2025 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741791883; x=1742396683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWJQHvu5mtEWy0MPTSIyoI0L0d27oEw9ieErduQwILE=;
        b=XpHyrsJJp4wZlHRdN5ITsQTkvW1pFflSnw5+053Sdf1HeUiBPScLlUSM/s86yisqHb
         3P8/koLxTe3gdDFUPKlbqaKK45RUIawLK6oPInOHDo18eMDHTU8JBjhXmIRejqFBE78k
         KnUc62XKIXCB/IT/h9o27aDIGgxpKxMoYaFMOKZzS8w2xyliPB5QqDmHsWTGfixOprZD
         ccOFZYeqLgywLRFc/eh+bpMFtzO+w4e9Ewua0yFbfkHcsRmJbGHLxIxWsqJgtLsQHwMb
         gPc/P4S2k5eToNKAenFWvU+0vhBp4iW10s+dR3V0U3Y6uW7GVRajw1n2OSyFOabbDkd2
         eyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741791883; x=1742396683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWJQHvu5mtEWy0MPTSIyoI0L0d27oEw9ieErduQwILE=;
        b=MAxzEnFc9zx1j7BxLEUstEPoSWIXzo24zgOHlQzDhq99vw6SFbz8NjOSHDS6D2nU/o
         N3YQwRoN4I2MtyhznKRtVWp3XagoHjuy57FKKM5GnT6LKn3VHvJ83LSbbjNzu+2bXi0a
         xkT/10C41mSxRHG3M5xuFlrGvcG7gyT2kmYHPyI3PvJ3WhfOyAXUpM8WlWiPaC2KY0Jr
         SUczcdbdignKK7/1MlTi/rNAgJN1+8UFl1upbQvdpfYi7ZrOCryt+8LpyOxxMeBSblYA
         ERULnbleTe0hMD9P20Ri8NAGwepv1GWOdfgSm0FT/OtpA4sKvFiL1eGpFEKYs2//42z9
         dwog==
X-Forwarded-Encrypted: i=1; AJvYcCWCyUGOwQbuLVGNGX3dpaKvsIJPQzHY6RXNI1A4FqYkDibHuyZMA5MuFFeQbwmI6RKOmU//iGbM9mM=@vger.kernel.org, AJvYcCXJP8FeH5F0qOmR6bgxWRVZIX74RGNi5G7UMgwPKcl68IcXZGjEp16T7rDMGdapoGhr76kaj5w9zpBV50Ys@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZJxEZgHDUX2QmdQ8M3GvEEQ+0K/1R5CScRrvH4KOeZCuhcEx
	DiGcvB1D5FXo3HcxQDcEGLQcpMbLo4jVPVUYG+/y+fqzNfdpm6aP
X-Gm-Gg: ASbGncsCIW9pKvBtxTNIgtkQilhSmMkC+toDg+/4R92E+jrZ7xUzV1EChRoM21N5UqF
	TdlvAw8irJBXTpzbyaEm4x5gxt45d/YYAlPjATZShb4qpqm4fJOEsUzLMECy/SMsrkW8/qP4ffO
	f4JzGmibuBxCLKPQVu5FoX13qbY5sGwuRupqWADgYIvmz9o2iLWIpWwDIjrwj171QlyulCf3U5s
	L73JpHRgToNOHPERQx4DR2y5F8o3kMoAkfez3/k2tG3d6E4cxGs6KKATQEYkY7m4mlOyNpej+I4
	Elmyf+IlfBQItDuz0Y+1RW7kOGrcZKweY7TrRvp/jVBL
X-Google-Smtp-Source: AGHT+IF9U6SlWjVO5e8FD64REsmZ+AmpBbsbhviSf5KKYvGmv6Wzl2qnU8103UftabS8nl6n3qlxfg==
X-Received: by 2002:a05:690c:4b83:b0:6fd:2b7d:9a4e with SMTP id 00721157ae682-6febf30734bmr331638857b3.18.1741791882857;
        Wed, 12 Mar 2025 08:04:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a1bf6esm31766217b3.19.2025.03.12.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:04:42 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in sysfs for weighted interleave
Date: Wed, 12 Mar 2025 08:04:39 -0700
Message-ID: <20250312150440.2301373-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312075628.648-4-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rakie, thank your new revision!

I think this new ordering of the series makes more sense, since the bug exists
even before your patch is applied! IMHO, it might also make sense to take
patch 1 out of this series, and send it separately (and make patches 2-4
their own series). 

I have a nit and a few thoughts about this patch and the way we order locking
and allocating:

>  static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3464,35 +3470,54 @@ static const struct kobj_type wi_ktype = {
>  
>  static int sysfs_wi_node_add(int nid)
>  {
> -	struct iw_node_attr *node_attr;
> +	int ret = 0;
>  	char *name;
>  
> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> -	if (!node_attr)
> -		return -ENOMEM;
> +	if (nid < 0 || nid >= nr_node_ids) {
> +		pr_err("Invalid node id: %d\n", nid);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mutex_lock(&ngrp->kobj_lock);
> +	if (!ngrp->nattrs[nid]) {
> +		ngrp->nattrs[nid] = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);

I am unsure if kzallocing with the mutex_lock held is best practice. Even though
two threads won't reach this place simultaneously since *most* calls to this
function are sequential, we should try to keep the code safe since future
patches might overlook this, and later make non-sequential calls : -)

It also doesn't seem wise to directly assign the result of an allocation
without checking for its success (as I explain below).

IMHO it is best to allocate first, then acquire the lock and check for
existence, then assign with the lock still held. We can also reduce this code
section into a single if statement for clarity (but if you think it looks
cleaner with the if-else, please keep it!)

struct iw_node_attr *node_attr;

...

node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
if (!node_attr) {
	ret = -ENOMEM;
	goto out;
}

mutex_lock(&ngrp->kobj_lock);
if (ngrp->nattrs[nid]) {
	mutex_unlock(&ngrp->kobj_lock);
	kfree(node_attr);
	pr_info("Node [%d] already exists\n");
	goto out;
}
ngrp->attrs[nid] = node_attr;
mutex_unlock(&ngrp->kobj_lock):


> +	} else {
> +		mutex_unlock(&ngrp->kobj_lock);
> +		pr_info("Node [%d] is already existed\n", nid);

NIT: To keep consistency with other parts of the kernel, maybe this can be
rephrased to "Node [%d] already exists\n"

> +		goto out;
> +	}
> +	mutex_unlock(&ngrp->kobj_lock);
> +
> +	if (!ngrp->nattrs[nid]) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

If we make the changes above, we don't have to check for allocation success
*after* already having locked & unlocked and making the unnecessary assignment.

>  
>  	name = kasprintf(GFP_KERNEL, "node%d", nid);
>  	if (!name) {
> -		kfree(node_attr);
> -		return -ENOMEM;
> +		kfree(ngrp->nattrs[nid]);
> +		ret = -ENOMEM;
> +		goto out;
>  	}

For the same reasons above, I think it makes sense to make this allocation
together with the allocation of node_attr above, and free / return -ENOMEM
as early as possible if we can.

[...snip...]

Thank you again for this patch! Please let me know what you think : -)
Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

