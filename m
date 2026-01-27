Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E12F0C76
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557444; cv=none; b=AJ3EIPxUwwL1nDeEty9fMpkJ7vvFEO76G1iPpmIuwQIISO/ojyhAnXIDzRw2uMGtI+gtPshmnhjuUqn2mvqJZPiuEvcGJwAJFr9UuYGd+q8cGyoHgJOGbplCNJ7xKDxlJEMVYkB1nibBswmoPm5bHAt7TfyzVSi/klZzcB1gmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557444; c=relaxed/simple;
	bh=mZxrKfWzsH+HpL912CxymP7zKV/HmFcJyYKcV/OWayg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WumtVZe+cJ/d8kmWL7n1hH2/w0OLDIdktc1D1u8lTwHTRUNs1XxGwaR5c6yy8GCsaOa9TgHIpALdhzxYplbSyW95PQVSQPtgs0Ikxl6XWBDIuMZYUG66gQNU9SrWnD3PatxTFjbj7Ih9/JF2XKhZbRZWd3oGpcoane5Nhp10blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZCd/VEAF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZCd/VEAF"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501488a12cbso82023561cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769557442; x=1770162242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1qRlmFFKOqQW1uayanhd5aQp7S6yFTJSXPtSSKOmMM=;
        b=ZCd/VEAF6jMbYiDECWICPFJ2WMVNzv+fMt3gFm2vpSpJ+TEWFbowgVn5ic5i/3OqB7
         /w3L1BB5Kd5EH9pzPa6aPBlZB7HtXo/yAFjY83/iCVFzV3Sm26jpNOY62ELsjrJRNJyF
         IMlY05ZC8r9wL+DsrVZAgUyK327dLHFMMMn4TkbI+9eIlIjgtP2mBXktBHMBnxes/eRj
         2reCNfhLGrZLBBMzsY3QupRXCusSgAPlEQDsQ2khkrMHCmbdz4VyHld6FW+07P9g109E
         O5l2iUpyIdmtjU5gMYuoV7T6G6QOLsLVAuy4u6naAewNtU0IyjIczuiBnK3TfCuiUlp1
         J36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557442; x=1770162242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1qRlmFFKOqQW1uayanhd5aQp7S6yFTJSXPtSSKOmMM=;
        b=JOlxhprQBYbk/T6FbKQx8rwrT2z1ySQNQoKhaUXDZrg+h/BIpmpVI3n1g4tWX5WR+Z
         LBYnNaY5cWjgYkgN1/axc0LwZOxC4F1ri9H3dUkByzieaKpgto9v5dab/TP6D44foUse
         5P8RUsLOhn4sj4LNd0g9Yu9q86T3BDm4bb5wx4vNvi68rJhze8QhdYtd/f4qRntkZg8I
         XtH45GJzTCYnOXefja9NtZtCO/e9pNk6WRygpDqnfW5SekCQi3x1kV86jN287gkJ3e/R
         ktqCwvdeJKnFDK231iuiLG3ezFgJK2mopSjecDdrRP5MVIhqO+36incp2ohoq5UtMlRN
         jXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt+bcHkNN+a3Wg0MwmAKZGJe3be/ZhHq8RIQ59frKw1e8bSXAZw8fbS8rQ+fqX6qoeMbdg2Q9N+Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmKKCSnkdC7ZUYq3unugRERt4SIHTCW4QrS+sbCgSUOhJw6dO
	ZRk5k45/yWPsnWp+dMrEhFh9yNFmWhOKM2wLPgVqUK6T+c/2hUHQTLhzmGiy/IXxWfE=
X-Gm-Gg: AZuq6aJyc6zpG6LmEHt2OBoUhxWsVFS9V+Z1SR57sUuUvQvbXx8bmqd5rPOhKBsPDyx
	fEgl9bYgfMav0G0lgUjS8tBCU39niEt9IqluMpJhR2OxN8ZhDxsTbqMCxeQlXymuSQby2R40zqy
	sdECmDUtmfnxPX/MXJd+3gtNHzCjxq6c/vwu2jxivhx7hXs/moK6wKBnf9DE2PCHXgGXpxdE3IZ
	y+uK8h3vqWNoXuXXQhY9EbmO8iHw+CgAwv5tskFGGRxN/uvQeYucVXZYZNbYk8FnK1yn4OaJl1d
	TgHOb/pxFBwDbVyxmf9YJdvQ9XVThB+pLsSQzAcK717KV9RSk/7dWxk78AoUpVejFP2iM8xu/DA
	n3IqXvFbMJCRAIePUCviwXURfeT5Q/8EGaj2dkCZmGFNxXYe7idz+ENCfHBUC+ddLtQkpW/j1zn
	PGjmqnHLL0q95cy6ZST9Q1xO2Rm7ZGKuM0DPHxS81pgUSyZvIGHy0igGy4qenNfp6cqResi+N/t
	38tIP4A
X-Received: by 2002:ac8:5902:0:b0:4ee:2074:4b6e with SMTP id d75a77b69052e-5032fa034e6mr45336511cf.45.1769557442464;
        Tue, 27 Jan 2026 15:44:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a9bdbsm6298466d6.11.2026.01.27.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 15:44:01 -0800 (PST)
Date: Tue, 27 Jan 2026 18:43:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Bing Jiao <bingjiao@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXlNvgS1CsU0JoE_@gourry-fedora-PF4VCD3F>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
 <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
 <aXlKOxGGI9zne8sl@google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXlKOxGGI9zne8sl@google.com>

On Tue, Jan 27, 2026 at 11:28:59PM +0000, Bing Jiao wrote:
> Hi, Gregory, hope you are doing well.
> 
> I observed that during the allocation of a large folio,
> alloc_migration_target() cleans __GFP_RECLAIM but subsequently applies
> GFP_TRANSHUGE. Given that GFP_TRANSHUGE includes __GFP_DIRECT_RECLAIM,
> I am wondering if this triggers a form of reclamation that should be
> avoided during demotion.
> 
> struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> ...
> 	if (folio_test_large(src)) {
> 		/*
> 		 * clear __GFP_RECLAIM to make the migration callback
> 		 * consistent with regular THP allocations.
> 		 */
> 		gfp_mask &= ~__GFP_RECLAIM;
> 		gfp_mask |= GFP_TRANSHUGE;
> 		order = folio_order(src);
> 	}
> 
> #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
> 

I think the answer is that the demotion code is a mess and no one
actually knows what it's doing.  We probably need to rework this
entirely because we've now found at least 2 paths which clean and then
add reclaim.

~Gregory
