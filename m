Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F782BEFFE
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257843; cv=none; b=RyeGg2WeAntVbG/kYNa9SbqLXqzqQSlzP+Q6GQA/MKVYgaaFnPxJ22i5M5gfZdyg5iZegj42gPlwOKo48OLi4JizFmDfPMq7GcYP57gW3N/DBSdiiF7NnWaaH3S/xTTE2yUgoOGgtWQeZZRSmUwgmG0/p8D1SaDeC4zB+E2dGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257843; c=relaxed/simple;
	bh=g1R9ylICbqoyRRxYcuZbIs5wPX4pOd2UUJ9XQ6qoGS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKb4j2A/cqTXc1A0GHG73hFokQHW6a1lM2tJpc5eyXwX2GWDA9UDq5fpBRnf+6yJjqGRidWBI6toDxNNgQgE7vpHrYSXb6xb9tsJDg24FuyWiUI+gy5sBAk1NUmOTUu48liHNBLBZB4LGCqp01viOluWL2slStCdPbRo4bwCJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t7jBElX0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t7jBElX0"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2627269d5so780893885a.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768257841; x=1768862641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH8QtdWievukF51h7NvNfF87uO9BA61HaSXBOWn3Ngg=;
        b=t7jBElX0H9BJBPG9yerpNOc73YyxE1IenKBad+8GIT+HVIkDnzEEY8nvNhQvSMtqp4
         KCpNxnJhJYfYmgPhqBDa49es07jGYc+OyhwIGk7/NuLTRuaKQoLkOQC/2NifH+frNscm
         jm78iTARGkvKf1uL3b4zTzFzvTPaQqIia1Jb4z0nHf54Z9bfvMXImnPK7PoDLT1LNRqS
         uvbuvH6MJWX2sCEwsfw2sli2XNS8lHEFpDKt36eQhpl3uFdBuKcZTfTQxhgkMe5NChhD
         wD0Hj4Fqh57Jjcmn6rjIgioKH/ct9Wj6ZA1InMCU8mrT9OodmfYBIHCx1QpVCB/sQDAT
         l3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257841; x=1768862641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH8QtdWievukF51h7NvNfF87uO9BA61HaSXBOWn3Ngg=;
        b=eTjbr493tpGKd5rJIEyzdCfeb++VKadzazDM8OeSLKmokqbH36ehez7FFNjRXMpdZy
         JQzRgiJpCwZj0LvDSFtOK6kR7Ug+Av88b5GzEabXe3L1JXkXGhCWyJOznGrUq8RqZlWw
         IVb/S+/S+EZtJhJdAe+MSkH7LidQ8YxhexcuLT2fAqbHBXZ031LfX/S2BqHqa/qDcDPA
         NLwJT9cwCxgmTluGO5DCjLFS57QlXpuYETYpaf/Wg8X9YqFJYwpN8dET1PS49TXc+L5S
         r5eeHnfLRItQB9JzNOzhI8c2lzS/1HylC5Vgo0iYqN9jkTwNMul0SGp+kKaNJ8U/7uOY
         HEPg==
X-Gm-Message-State: AOJu0Yx4gp8C1zPv/NXpPFSlM9OJJsF2DCcpH9NP5zJn94kbO0uW6+So
	fAc3X7mcMKMC7nOGBTQVE37SDp+t2/zCZ0OSi26d0jkn/t5c/zc/w8nSg/QhaDSXtTw=
X-Gm-Gg: AY/fxX4v/4D6U6MLqamDv/kc/ON/1kR/ES3aPd6JD/PGBAn5rS+8osje1EIZNNblBOo
	40eFCTstiHWtXbYdg5mPzL4Ns0LMTmA4bEl4IZPmTBhr1fPvU61fJRfAG2PWEl+6tfE1eR14rVN
	5KknnAq3X7URpxHcd9+/vygJeWU7IpGw6pQG+I62yNuHMsdJgzo4CuFUDrnJ4jXIymAzjZRzYlx
	hMCeXW2qpKK2hlEvd6jk/KCob5TObmzc7zqBNpzR7xrfkIBYsnKApvnd7aPqO0gAHDBrLUqfFmY
	9iz5rE50PoSr3c+/1/a6EhEsVH4HUb4W8lOLhTEJcMl4XhnJDGODCkl/3HJwCVpb6iCLRpjY1Rq
	zsVt0CQVkpcxZ8obNpLykUVpbcZ8ThODj+Uw5QUoDhZUjY80cH1q2C/S+dudcSHNOpGhXTALU5o
	gTfYVVJsxABySVrhxUaRQ7j37yZdbP4GJal4JDIlyrzWvLhH3Q2r6/ukquS6dwA+sdiTfH3Cggh
	xWq8472
X-Google-Smtp-Source: AGHT+IFNRFsCye/L0TjmYzMj9slskh69Z6egn+dOxFWH73HuXbt8paZZikjzfT3XP/huGZSAVHaypA==
X-Received: by 2002:a05:620a:1791:b0:8b1:b2ed:2735 with SMTP id af79cd13be357-8c389407c32mr2540922685a.46.1768257840841;
        Mon, 12 Jan 2026 14:44:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f5438f6sm1568702285a.53.2026.01.12.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:44:00 -0800 (PST)
Date: Mon, 12 Jan 2026 17:43:27 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
Message-ID: <aWV5D_9DoiynqViB@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
 <3d5ccbb3-a083-4a5c-8c97-2db2adbc5446@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5ccbb3-a083-4a5c-8c97-2db2adbc5446@kernel.org>

On Mon, Jan 12, 2026 at 09:00:54PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/12/26 17:35, Gregory Price wrote:
> > Add a sysram memctrl that directly hotplugs memory without needing to
> > route through DAX.  This simplifies the sysram usecase considerably.
> > 
> > The sysram memctl adds new sysfs controls when registered:
> > 	region/memctrl/[hotplug, hotunplug, state]
> > 
> > hotplug:   controller attempts to hotplug the memory region
> 
> Why disconnect the hotplug from the online state?
> 
> echo online_movable > hotplug ?
>
> Then we can just have something like add_and_online_memory() in the core.
> 

mostly i cobbled this together over the weekend to have it for
discussion at the community DAX meeting.

I think just having 

[offline,online,online_movable] > hotplug

is probably the better option.  There's not much use in a memory_region
control that lets you offline the memory but not remove the blocks.

I mean, I know of *a* use for that, and it's not something we want to
support :]

> > hotunplug: controller attempts to offline and hotunplug the memory region
> > state:     [online,online_normal,offline]
> >     online       : controller onlines blocks in ZONE_MOVABLE
> 
> I don't like this incosistency regarding the remainder of common hotplug
> toggles.
> 
> We should use exactly the same values with exactly the same semantics. Yes,
> user-space tooling should be thaught to pass in online_movable :)
> 
> >     online_normal: controller onlines blocks in ZONE_NORMAL
> >     offline      : controller attempts to offline the memory blocks
> 
> Why is that required? ideally we'd start with hotplug vs. hotunplug and
> leave manual onlining/offlining out of this interface for now.
> 

That is fair, although i would like a build option to default the online
mode to ZONE_MOVABLE for auto-configured sysram regions w/ the SP bit
set, otherwise that will be forever locked to using the DAX model.

> > +	} else if (sysfs_streq(buf, "offline")) {
> > +		int offline_rc = 0;
> > +
> > +		rc = walk_memory_blocks(range.start, range_len(&range),
> > +					&offline_rc, offline_memory_block_cb);
> > +		if (!rc)
> > +			rc = offline_rc;
> 
> Let's expose this functionality through some common-code helpers. I really
> don't want more code doing this non-obvious device_offline() etc dance.
> 
> walk_memory_blocks() should become a core-mm helper. Maybe we can also
> cleanup drivers/acpi/acpi_memhotplug.c in that regard.
> 
> Hopefully we can then also reuse these helpers in ppc code (see
> dlpar_add_lmb() and dlpar_remove_lmb() that do something similar, but grab
> the device hotplug lock themselves as they want to perform some additional
> operations).
> 

I'll take a look.

Thanks!
~Gregory
