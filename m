Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB7237180
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258102; cv=none; b=HW01kG/0tgMlY3epWg2MPAVbBFdUz7pZ9wAkIDsfqNWe4wdQ7dPzSdN8g28TybvukYpf5RMXQtGo0j1svwkAsu1YsORy2uGxVg2prGmN8UKbbVweZ7nBU4puvk0RFcmZBpw88BfilMwboRcW8cd8YKRQnijSZ106iLdL64634T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258102; c=relaxed/simple;
	bh=g8J+ptmtGGqWuSSsQ7TZxqhZVUkR9ZBTnUBiAorLsys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC2YGADDE5JsjrCJu4FgPYlS5Y7hS4sOFBq/+pJknW6ZbdeWBKi8zjOxISQOlRJby8wvHhQIk+mTHN4nEGoMY29lkTdpx0iJJ2da0e+l5S22NNdtZlrpCIAxDOl46tZwoz5tda1RrenuizgYTlZ8XXptypUQncKyNYcmd/VQMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L3J7XWTN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L3J7XWTN"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ba0d6c68a8so805025285a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768258100; x=1768862900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/FOrDSuSe73GLhcxyJAxVSV9DMbjGrW8sQhrhIMBYE=;
        b=L3J7XWTNODtQJwp738fHEdamFuvXRceLZUDcHksQuVjh/rFbkIccd+HT8/M1LD7tdt
         wKYUfju0FUj2+1wsTxZzAJnAi3bOyoSLFfqXiU7uETXWDq+orAMobx3vRVynZRVnT0kq
         XIBoc0p7zbgx8wis8VvLuvYZqkmrJ6PCWZGXcsGK04wrcgOLgmFmvkm/+u16Py/G8hCz
         xbeOrtLAY0EisMPSZwPx4Sevl+tSfX/czZAH/8uUMoSxvH23C+AnueFTDq3eYX26WRYG
         Mu8nCuzSmHMyuQ1kxS1laR1Mf7iT5ft9ouNUxdioSIVqtjGTy1R70lIXkm2g6vB9UNsw
         om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258100; x=1768862900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/FOrDSuSe73GLhcxyJAxVSV9DMbjGrW8sQhrhIMBYE=;
        b=DXaIgGGgjiD+5p6Q6OTqZxE9n3Vv9C98oT8kHM5K7xJD+vWRjhIUhtxT4FDpEcHjtI
         KUCkxfkx3iI2tXROzztpb2KnIgI1xk4gsmocREB5sg0+vbLpg1KfzJ6X/ZUAl9J8Y/ly
         H66e0F7I2+oV5pdyzT773sGxV182x3iiMABXaLkNyhOuatM+GcW65qNJqL9rVAMZjo6c
         mjUhD5UGLwbXd+14aBaOnavfpWKLKj6Xr/SFmdA8ASyvSFWGauSOal/JYAXmnsMqtd9C
         mqM7ms40mT/wpscuqfpevCGPeVXYpS0b4yfyfDtm5EmCokFfDlM0A7oLHGam0ycjKDlG
         GNJw==
X-Gm-Message-State: AOJu0Yw+Lt2UnOVAuWr2WauI8abqCntqvsr2r8de6X5V0vzNR2v80fk4
	64pSjVUpqzIWVHAKd18B5OpMj8vjL3BEuRUGnHmu0XoXa/bPMSUwNteK376J3uQScgg=
X-Gm-Gg: AY/fxX59I3e9EXliXW6bJ5nZDNLPJdSU1Elkv5Oz46p5Z7NkJ4VJbhHhUMc7MRgl6nX
	tdZSNQxJrlpVYm7tmFezJ7I+644v9cgghp22Pth0otR8jA9aLH7IlhYH1ahGtVwezmeTKMeFImi
	Vwj+uBlN9tfDj3gO0Qte8ThBw0H3LkApYbRViiSG4lbxC1SUSU0/Or+M57MBZFeU0NqrJt919hp
	1PXRA00y0clmyreq8/+l4A0Mx7Jr8K/WtDwdQ4C9hI6EbNkcxcWbklPBcbG9T5ZZWOBp/XsFdMC
	TyRo4ALmQwaOhGhVX3jG51SAcnQ99iwqR+YaMaruzWnXtV1sDpo1vpvfzhvML9nAl9UeGU8wmQx
	LGLAtjV03bAhvoZKWVa8jcycgHI7nM7bnj5j9BTMdehGHOfiKvlDTF4WKtguvTYeRf5zJTC3emt
	ljnbx7b/kLtGYUCkUNDSyzgQ1C//4ysS7q5qKcTcfScivu9LawaUWSz9uI5FKVGNTWtGKENJbZA
	aOr3JGl
X-Google-Smtp-Source: AGHT+IGFjBIBvvPhMLHDfPjGZzl60n7jh7AC5xOVUFHaYrImzbLr1/HgTgg/suN43dG2/OQzn2FNlA==
X-Received: by 2002:a05:620a:1904:b0:8b2:f1f3:900e with SMTP id af79cd13be357-8c38941c68dmr2595479185a.62.1768258099885;
        Mon, 12 Jan 2026 14:48:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm1601253085a.26.2026.01.12.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:48:18 -0800 (PST)
Date: Mon, 12 Jan 2026 17:47:45 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
Message-ID: <aWV6ETg1Km_AVFsG@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
 <69656337337f9_2071810063@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69656337337f9_2071810063@dwillia2-mobl4.notmuch>

On Mon, Jan 12, 2026 at 01:10:15PM -0800, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
> > 
> > This can result in future management functions failing (such as adding a
> > new region).  This is why "online_normal" is explicit, and the default
> > online zone is ZONE_MOVABLE.
> 
> David's early feedback aligns with my own with respect to not creating
> new "online_*" ABI terms, but I want to go a step further.
> 
> Part of the proposal here solves a fundamental problem with the way
> dax_kmem operates in terms of fixing the complication of dax_kmem
> depending on fine grained / multi-step online control via memblock
> sysfs.
> 
> If we are going to introduce a new omnibus way to online entire regions
> at a time then that goodness should first come to dax_kmem and then
> potentially be refactored into a library that CXL can use to skip the
> device_dax indirection.
> 

I think that probably just looks like sinking some of this into
memory_hotplug.c as bulk-commands and then exposing a similar
dax0.0/hotplug function that shows up if you're bound to dax_kmem.

That should be trivial to sink, can do.

> I.e. the end result would be this "hotplug" mechanism that fixes a long
> standing dax_kmem problem and then go further to drop the indirection
> through device_dax and have a "hotplug" mechanism directly at the
> cxl_region level.
>

The only catch may be auto-online behavior in dax, we may not want to
encode that there and instead improve the hotplug interface to entice
users to use it directly instead.

> > +int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
> > +{
> [..]
> > +err_add_group:
> > +	dev_set_drvdata(dev, NULL);
> > +	/* if this fails, memory cannot be removed from the system until reboot */
> > +	remove_memory(range.start, range_len(&range));
> > +err_add_memory:
> > +	remove_resource(res);
> > +	kfree(res);
> > +err_request_mem:
> > +	memory_group_unregister(data->mgid);
> > +err_reg_mgid:
> > +	kfree(data->res_name);
> > +err_res_name:
> > +	kfree(data);
> > +err_data:
> > +	clear_node_memory_type(numa_node, mtype);
> > +	return rc;
> 
> ...btw, this feels like too many new gotos in the age of
> scope-based-cleanup. It also feels like a bunch of duplicated code that
> CXL and fixed up dax_kmem can share.

Yeah i cribbed a bunch of this from dax and hotplug, i expect this to
get significantly cleaner in a version or two.

~Gregory
