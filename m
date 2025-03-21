Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8F1C5F0E
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567091; cv=none; b=nZSUkqUmNAN4DUhgKyy5SMevRH67cIxC7Xu96QaU9inzgu7R/KqVyt4KbDAOYHkIvHG0+uKUYQecVlwwOj0BpGVb+JwrSn3FIAgqE2CYxi/LxK4zzskHbjIN1YnNqNGISC3aBLBNM9UsdHiS6MNBdqtnatfaop06AuXpfysx6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567091; c=relaxed/simple;
	bh=dnRWHvGCz98+KYcbyvDsSuyhDnLx7Q+KXKKLo4bFwcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDE+AFgd4yfAx6FP8o8a6qyZjCIwDTrRz9TpcfwlLk9CsU/VgPVEas4Xz7MR+lUkbTGzge1o5cMKqmvH9OI3SUwX/QBTh9pGdGUSVtTmJhgCUqJUnUcJFYRPgu0CGmZS2x8ArwURFCwci3eJDEW75MAuo+pEdbwTl3UdauV2Hgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XUqf+gZR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XUqf+gZR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8daso18374961cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742567088; x=1743171888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69s8y69dA2iHvCOzWVvchKfNb2Pevk6gRGLN3vcOyXY=;
        b=XUqf+gZR+LxQm5z6ZrSNdzmJJ8kpjh2ugAG8KjYdjH+B7pxqYKu5VP3FC+trOQ6MWz
         GlI/MvWPHd3OEM0xPbgiglBw2OmLwN28hM1HWc+9B5/6eErN4UfRkukdbCNxVAx4FgaY
         +RNzG9AS7gSNTrG/4yZSICrk9xtTBcGQHlNwNB1TMD413bn3cGinI+QYwrRDqGp5ZKX5
         oqwdJBQOxGLeEmJMSOl2RGfRx5TNzKnUUOrP/hnrsKwLOBGfKSaNc3kQfc5jMRNmHcAj
         vb3AKlfoXyX+TkCT8UST9xH9ZF0JaFWjj6DWFzZDfckQFjBSrRNhD3yohKF8+6TyIjzi
         psaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567088; x=1743171888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69s8y69dA2iHvCOzWVvchKfNb2Pevk6gRGLN3vcOyXY=;
        b=grx3m6l62LOEtjp2GtYsrg8v8b45IS4/ai+1/e6JQH+hWYxOVa1377PXN39cdFdljR
         os9enjd36WxE6b6K2QlN5z0PyygU4ImBP8f4LRzquNS/WVpVs7p/tikH/yAWVz+vxOpv
         U9IUJfMZPPLxWzPqywFyMLYTEnTvnDJtOItPUA/UY/t0XrjWRqBZz3ttB+13P10OqFzO
         9kRFmMGTzg6/Rm7n4j20TKfSonXdHog9Skx50sac8730fkTVtFsw28TlZpDNqEOwTAug
         /CQsBZqiMzQIzL1oZTHlcohMctX3eL4B3IHlpYQV/f3JZrkppe4dFhMJgzdKuWzGMgOl
         oC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWhlu3sUTom5OpexOcmPkivscTenivqdbzAeA69lBwW+ctcojCAzRBJl3NLo8cQkyOjeV0jqyVFnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxON4y5pveAA9R8r2dZE0Jv9YPmLrgDZ3Jc9RbFVERbvfX5+OaK
	RoUaOlhfaHEa2RVcrON/EYdt/gnM68pFrVRAtf6WTh/QUmPwUCliTg0KzhOFX2g=
X-Gm-Gg: ASbGncsmH1rBDq8nMWVCu+RZPIfDLbFmFezjdiujcBTvUayzPBAL6yQRD7GX7DRnJEx
	OUIr9AunLxqcRI8oF0IXkZWdxiYwjhWNo+mOqIJUqygsgwlCOmdzs3jLbA8xTz6hTy/hb5yojY3
	De4Yuv+e2V1IciwftWOJhR6n6pCZM/Uv15BYdLmlJW7p/qkFjbhVfYoTRkaF8fvt6cruF2TYfgI
	k3hYEyEWyOBC374kt9WsK9lPY+GxsG84VUudrLWhK2mpdZQCurtU3LRFlnGgbibTdjvqW2YE0mY
	ymNCdeTpAq+bo/aJdiX3KnF5rSnwUe1Ow8etlvaY/2hoa/PCAH0n01W5288VCaSyZXNk4mfilxH
	5QIlZD4GWghEQqES2u9fMWa/lZyg=
X-Google-Smtp-Source: AGHT+IFnmfQBTkT3h+MKJEQnCw/DkMwVRgocyPIP5yUesWNNpKMxrx7pD8ssts4+almvOH3s+oc8IQ==
X-Received: by 2002:ad4:4ea6:0:b0:6d8:80e8:d567 with SMTP id 6a1803df08f44-6eb3f2e2651mr53079806d6.18.1742567088549;
        Fri, 21 Mar 2025 07:24:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef33e4bsm11644556d6.53.2025.03.21.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:24:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:24:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z912rrV4xTOBwEP7@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320041749.881-4-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 01:17:48PM +0900, Rakie Kim wrote:
... snip ...
> +	mutex_lock(&sgrp->kobj_lock);
> +	if (sgrp->nattrs[nid]) {
> +		mutex_unlock(&sgrp->kobj_lock);
> +		pr_info("Node [%d] already exists\n", nid);
> +		kfree(new_attr);
> +		kfree(name);
> +		return 0;
> +	}
>  
> -	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
> -		kfree(node_attr->kobj_attr.attr.name);
> -		kfree(node_attr);
> -		pr_err("failed to add attribute to weighted_interleave\n");
> -		return -ENOMEM;
> +	sgrp->nattrs[nid] = new_attr;
> +	mutex_unlock(&sgrp->kobj_lock);
> +
> +	sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
> +	sgrp->nattrs[nid]->kobj_attr.attr.name = name;
> +	sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
> +	sgrp->nattrs[nid]->kobj_attr.show = node_show;
> +	sgrp->nattrs[nid]->kobj_attr.store = node_store;
> +	sgrp->nattrs[nid]->nid = nid;

These accesses need to be inside the lock as well.  Probably we can't
get here concurrently, but I can't so so definitively that I'm
comfortable blind-accessing it outside the lock.

> +static int wi_node_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
... snip ...
> +	case MEM_OFFLINE:
> +		sysfs_wi_node_release(nid);

I'm still not convinced this is correct.  `offline_pages()` says this:

/*
 * {on,off}lining is constrained to full memory sections (or more
 * precisely to memory blocks from the user space POV).
 */

And that is the function calling:
	memory_notify(MEM_OFFLINE, &arg);

David pointed out that this should be called when offlining each memory
block.  This is not the same as simply doing `echo 0 > online`, you need
to remove the dax device associated with the memory.

For example:

      node1
    /       \
 dax0.0    dax1.0
   |          |
  mb1        mb2


With this code, if I `daxctl reconfigure-device devmem dax0.0` it will
remove the first memory block, causing MEM_OFFLINE event to fire and
removing the node - despite the fact that dax1.0 is still present.

This matters for systems with memory holes in CXL hotplug memory and
also for systems with Dynamic Capacity Devices surfacing capacity as
separate dax devices.

~Gregory
