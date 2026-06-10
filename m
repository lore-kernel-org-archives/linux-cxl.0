Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116440313D
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088129; cv=none; b=aamuzkwMc9b63I4R6Zvy3QgkDWFMPOpZjLI5ijAMjcR+9/9MhD4n2ekP5JH+dF+qQDaLGAUDoy5F4I9n5XJbjPkcsxCY0VP9LgF5d1xRnC6VQUWwNteV5Tiu0ZBCHGCwL+ptnsX4Phe+WCt/MHwTR7mu8qYI1/ivnJ+/omrOmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088129; c=relaxed/simple;
	bh=rLAKx7oZEBl4l8VQ6/vsIVEV/nqRO6+w6w+1NuugFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIz9OG+NQpQ8bxTmEdPJTXgmQdvqhAtQQ4tTnSxrIgRVkZN1KgPBGKLjv5dsm8XTaS2YFvGhFBIaAPzJggDMYOC36Jtb02jO1QKppxlqOOm1MKg4szLeDugOtJNH8kBJYRc17HI4HR5qKMiTtupffoXDA3OhlNF3jZdyXOUBWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gpUTAXO7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gpUTAXO7"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8cce77eb087so56514416d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781088121; x=1781692921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=gpUTAXO7LYj55vqZytrIq49IGLWTJvLT+xAvLnjZFi7gjoGYGbTGjCIel1PHtM67TK
         fKtSbxARYH8l3bdsI1eQaDqaPVFqfZgLqYp2Hdz3Q8F9NJfn1/AGnBpOnXQl8Xp6HqVM
         fnpXPMJnuDMbGNyVvoklwWlIeAEsE40/bq+oK7DemyY/a4CJkZnYYCXzsxU6HbjjFEmF
         yzdeFiW+XXjOVaS62j0zEFozPv75geuKQhBJ/bx6qUvXD7YWWOSsFxDd+UVh+le0AZBv
         CIwPnI/Y91RzF+4pup0vWYBvUqDzBYJFSLPYs+DWujHYLHVfYs0K/EJP/e5pF7mytowE
         sOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088121; x=1781692921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=gXd6t1CJ7CbgyiLMv7yoG9gkY245MHB/uAK8XzIaS83K8EVYFrQHnKgoHgX4qkPOOx
         mt2rUC5X6nhLdLHUfj4DNZFmrXmFM9DR4vrEPu5+QDE+dvo4WrSc3QzQE+ztLXbEotzA
         SUWHMOzHNQ+CbFrU7O9oUwl6qn5UC3i/tXtzkQ6U87nLpZZDr1gRpefXt0wsISmxEPE9
         8cCCbP6DQ5C981AytruD1npX2YUE7eR7Vt4NwnGbEBHIlArYC5ISpa7YWJLqq+v9CMIg
         3Q3VmsvcF5IZCMmdzpuM+PNvZHGrlFOcncAZjW73O6QuyZQRbRH8a7beFOqaQp1NPK1M
         pf3A==
X-Forwarded-Encrypted: i=1; AFNElJ9nalenBuU9Hh2hkHFVXoWZvRsAV2UD/rBTEXubjFpSjbnEHMXjhM0Ia2Xd8goR3jN2Lrr0f37zJkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM16yaoGKPYO6AZ/J5HpUKk5jChj4L6GRrJMoWjlknmD58fmFJ
	UKp4d6O/a+NWanl30cV/KEOGeb4Ht2dGEtzww6hiONs6zAKFpfnT2BzA3UfOPK0+vxQ=
X-Gm-Gg: Acq92OGB98i+s6RBpYN6HCGJj0iyT4ByYc5TAZGMLKNrqmlNmlptJ/OBowPV80cJWtD
	y/CpeCR+hyq6mW5WWS7z2ySkovwgfBHOeZsWRw0Z36V8+rbzei2K+2cqOMhVaE3ogcQhd4x2cJg
	bSFjQTBw1H3xnuv37R7aKfh2urUb2cNssnZdi4r8vmLpiIC7/cRyHAOHH8UtmCozZutXFMb1gvj
	aMpGMeKc3pm+E2kI5v42Z3XjRmUicF5xcHCVQahuorx3oAa9XbJSNP/iR1pBUmzo+DUy8F3mV80
	VkqE9Y6oFs0bjY3ne0OO9MmfIRYaX9Y8R4O8vPTc8y56p2csYtjoL+X0D020aI6MXXW/vlZjZPK
	5jC7sZRBGfnkm8LRhyugvPMSBBGuiHxwaXnvRKtpBDXrbXyUd2PPtCjyQNR7MoRhwCu0iH3MuN2
	lxrQblxMXrBYLBgliD7m5z0cAnaEK8Vk2g8a1JrMFr6QV84WDG10ALnuJf/+s/6ukdjVOOY0krP
	fOmZfPbLZhHX85LTA==
X-Received: by 2002:a05:6214:c68:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8cee63e377emr394580386d6.42.1781088120984;
        Wed, 10 Jun 2026 03:42:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06e4d6sm231860136d6.36.2026.06.10.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:41:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:41:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-0CyZurn5D1ezY@parvat>

On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > 
> >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> 
> Let me clarify, I meant to say, let's use a nodemask for allocation
> and __GFP_THISNODE gets us to the node we desire, if that is the only
> node. My earlier comment might not have been clear.
> 

I've been tested an stripped back patch set where I drop all FALLBACK
entries for private nodes (including for itself) and only keep the
NOFALLBACK entry for private nodes.

This effectively isolates the nodes for any allocation without
__GFP_THISNODE.

This also precludes these nodes from ever using non-mbind mempolicies,
which I think is a completely reasonable compromise and something I was
already expecting we would do.

Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
which causes spillage into private nodes because slub allows private
nodes in its mask.  I think this is fixable.

I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
code, etc), but it seems like fully dropping the FALLBACK entries and
requiring __GFP_THISNODE might be sufficient.

~Gregory
