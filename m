Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CF3E314F
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109304; cv=none; b=DEx4cc3Zs180WD5J+wq5Tyxz+dm7g9J9godjlkIaBM92Om+q8dPXTwCBi1dzdZEBe8+xnBxheuSVR8nRbNKekv3Vgec4swo9aNQdJWKAJ9PDB5Bn646+AcAEz189MQJzrfm2M1kVGb4WkPVzJ4r7t7ge0xSfn6oWQwT63IVdVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109304; c=relaxed/simple;
	bh=6hRiNGqvtOWKux9ylwRAer4046Lz3jBPnR8zW37UMoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyN0rvyaL42ByoupZqxUqL1ZswXnYYUVz+vyRpeVojYiOhn2rB6SFqOBLQe741WOFTwC/5aAysmVvHqk6KljasVokXM6/Sat8xv8oOpoNZPoJwInLX2i9weLMhshwT0vSaQMqwa4Sz7krKFJbj6Z24TLH1eXbkoimqlb7/QEPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FRo9LgiE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FRo9LgiE"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb38e86cf2so434637385a.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776109302; x=1776714102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANyztBlS8ASp9MHR198GNmIsfqkyGsWGhTyu9QD8TKg=;
        b=FRo9LgiES7NQwMR9ULvyVcTSS3IjJAqLCF3Kp3xZyVjvoNFVwZoiNn4FWXvLif03UM
         iFdFl4XBFQHMbtQRyHas5Q3MS9qTIb+uwMhl2+xm1WCgkYynQhkNuDjUbrAtA3y+Rcr5
         YvWxZlyrbgP5Dj7aS9U6c931SPItYy5qxXgf4xlgy9x2UzKnfeqvnl713wD9jWmSrIj+
         gRMHZ6LGMO9l2iVKL++u3FuG7o6ZvMVdADsPBbWBFqiVlj1XAbAPLgfcriccqgjF/bIi
         WBiWzRtPeZKR4OiB46Wk6bfqWTrA6J/boX5wa2xnmJxzYocLwIADIpkRo5Tj3PxiKUQN
         /+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109302; x=1776714102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANyztBlS8ASp9MHR198GNmIsfqkyGsWGhTyu9QD8TKg=;
        b=ssKF8Fxbb7d0AcdFlu3bvULgvvAbufHvaGo9aWEGbtQhpKTnSPgfao24X2tk/2tI8o
         eMLbdlz/kIEebiSzYguqeCg91PCxUzBfCcF/+pQ+Ig4n9SR1QOwAZAmKJCKxQeRCbMiU
         jns8zsJ1ZQUVWFFFi+YUz9qG+nPTQbsrBBHy6bV0TJvQeeNMjOSnau4pUcXPfS4xEpNY
         1NIvd4FhTtOaeE0gx+3EX+EtW5CmE+q4wq8unoJqnLWN4bWKd8cdi6Pecl5KDlIlP6wq
         JPjppL20CynLgD/9XM9fmhHKQ1elPISdBVq1UEUvvNUVz1Ra0uw4Zh+41fEmeyNmOtdY
         +Dew==
X-Forwarded-Encrypted: i=1; AFNElJ9Ypqrucgu/+VPEvGA1LDw92+KUfHKrZ5FrP9ZCpbDpf34aHJDDmTR9tvdrHzUlph5BY9AEufNKMwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQitZV8mIwoTGvsyuDoWQWX76dYGVN0NunKHi2S4jZa4K1VKz8
	DGwB+CClMzAwEJvZWJnXwN9v7fa3ut7GiUHuAXaHbTvomFIpOzAQDc8r5VIZQeHNtJo=
X-Gm-Gg: AeBDiesOF1fdgUBtCLs+49ovhBFhEpzz/cswHyY/nhyWh2le4ATBWRVrereqpWEEreK
	rzybSajkw8hxDtXfsNbqBHBpNh09ZBwnE3tMu2SPgbE4Kr6CPrgyk4v2TgFj5G3cR7L5gWLoNts
	58AyCLFBYZx1wuVgg8hUXKy4sjibDEg2ZbSAex2uqeo1IMnClET3+qAf/CSNh5rs1ldt+8PUcVq
	jxdz3hjtGj4ptkHzUYLb2WxCS2grrDSQSU6asZWdlgtULfde75cwa1Bk+ZMpM8JxPuqfZRJKW/e
	MolcuOmTTToviTjZRonj8FZ11KwZxwQsvduu4cekDUkrPFf4L5MgEaEBnCGKdmh5YzpjdY/VluM
	srl6MM7TDJycNgQyDH34I8H33EbxqlZpnulP6zEVSecNGQwGQoLHnZ84zqf3C+5PzZFfal1CNAu
	Tl74ptR1cqzyPtjn29/j4HKEBtx6UoBaIJdt7TNWdtG8QtEisd7w8RCKdZSFjempQnNFy0S9Ftv
	MsXFqEi24eAZDtL00zNXl4rcGrrJyGYdg==
X-Received: by 2002:a05:620a:440c:b0:8cd:8320:3359 with SMTP id af79cd13be357-8ddcd024831mr2080049985a.9.1776109302203;
        Mon, 13 Apr 2026 12:41:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88c82sm901067685a.2.2026.04.13.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:41:41 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:41:39 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, osalvador@suse.de,
	dan.j.williams@intel.com, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/8] mm/memory-tiers: consolidate memory type dedup into
 mt_get_memory_type()
Message-ID: <ad1G84KdvOmKSRNM@gourry-fedora-PF4VCD3F>
References: <20260321150404.3288786-1-gourry@gourry.net>
 <20260321150404.3288786-2-gourry@gourry.net>
 <e0e48659-8ce1-496d-8b5a-f6d4416f2ea0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e48659-8ce1-496d-8b5a-f6d4416f2ea0@kernel.org>

On Mon, Apr 13, 2026 at 05:06:35PM +0200, David Hildenbrand (Arm) wrote:
> On 3/21/26 16:03, Gregory Price wrote:
> > Replace per-driver memory type list infrastructure with a single
> > mt_get_memory_type(adist) that deduplicates against the global
> > default_memory_types list under memory_tier_lock.
> > 
> > The per-driver lists (mutex + list_head + find/put wrappers) provided
> > dedup within a single driver, but not across drivers or with the core.
> > Since the number of distinct adist values is bounded and types on
> > default_memory_types are never freed anyway, the per-driver cleanup
> > on module unload was not useful.
> > 
> > Add MEMTIER_DEFAULT_LOWTIER_ADISTANCE to replace the default DAX
> > adistance, since it was really used as a standin for all kmem hotplugged
> > memory.  This at least makes the default tier relationship clearer to
> > other drivers and they can see where to put their memory in relation to
> > the default lower tier.
> 
> Very confusing code.
> 
> What's the purpose of kref_get/kref_put if "the types on
> default_memory_types are never freed anyway" ?
> 

Mostly trying to retain existing functionality rather than delete it.

I think the entire memory_type() infrastructure in memory-tiers.c is
generally very confusing and of dubious value - but i don't know who
out there still depends on it.

> IOW, couldn't init_node_memory_type()/clear_node_memory_type() just
> consume the "adist", and lookup the memory type itself?
> 
> All you'd need is some way in the driver to verify that there is a
> memory type for the given adist, as some kind of prepare step.
> 
> Alternatively, let init_node_memory_type() return an error to get a
> clean interface? :)
> 

tl;dr: yes all of this is true and I will rework it.

~Gregory
