Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E463E51D2
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110360; cv=none; b=U74wkFsrSIufggG+tDoGFzpkH/4RXQRmXUrcPRSFjwjgK5v3tePZ5+qjQg8CD3S4oQmdQ5pWzL78jHAFmf3Gjy+vB3UFTAZY3FitTaKBILSU+Vz9JyUp8eXgA9jLqegK5qWQqyV30N1TH4p9yo5nocay60b/KobxMx6AbOlw/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110360; c=relaxed/simple;
	bh=dkvR6+DO0Np/gQd4zUN6ufz3HgdPmilT+Y3eAl7ElY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie4NFOpo+OfUPmpdI28D0/H8Ty4E3SVsnFh8i2tyMkyzIz05uwwINxflbBCiKT1N1vbmHnGiz6mimM044eTtXvrd29C5Cuy2irrFrUjpU92lnzjR+SqO7y5nltBC/bcBs4CA4XC4FmsjmM7+Iyg+tojVIXzIfUu7QDV+hiNAkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mai9XVu/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mai9XVu/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc3ca1922so446543585a.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776110357; x=1776715157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1azq21Esoe1p/aY/WIwRSLCrXwL5NJKdtQZKDmxglNA=;
        b=Mai9XVu/wyzHrkYnCEtLPCXb9Yf8JoGTb6DdvjUgtGRZdyljYJhCCBTHZTPLzyt2bv
         hU1vwOi2HqMhs8Pcy5a85CZ4V9BV9tt+hP2ADB56Pr4C0pBVY6HtWKI527i0YEhDclBh
         RsVGL/wnvBg1TnEKWhY0/xviuqm62d7+CQMTU9usro+NMKwBl+UtDicfSA3VxnPSTYWc
         gtivuqNrco4UPNd2XNV59LFkDZcKFJvzMU4p/cGj1Cimy7KUv4oiBPZZHOdxvzL9ON98
         p71HiFfEOb/sezev6JZ6PFfAaXR8ioTPI1ITsBliz7LwcKXR2eBDfG2kD4pQg4+io+7J
         OysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110357; x=1776715157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1azq21Esoe1p/aY/WIwRSLCrXwL5NJKdtQZKDmxglNA=;
        b=HpkLK0uOxuV/iev6ip++s2UJtsCgbksZIsPUNmWG6Z9av2+exYUMzd9gTWZKR+o7+v
         wQQWpCFxKXBYgo2o+1KMY+U8eUkxqXHOX9Lxc7wCISQG7n7ZyX2q16UfBFdCpEtsCNMh
         Bv8gckMTj4D3MHyMv5RGCinbnyYrXKdLaNW0+jMirU5qs6O07vkfSC3R/ssfAWpqvdOX
         gL6yapRhZnlz4f61jiprRHZIsqntneQHBuf53rnAmhFqakLLkL4Ll/M2zn3Yh9lci5Bi
         Ria7Zfm50th5dAXFl0Oa1ERsRmPKMWNX7PcGBtG+iyXQHI3FDKEctBRhglnW+ZbC3QgX
         iYkg==
X-Forwarded-Encrypted: i=1; AFNElJ/68WX80GtCQwBC/c0W2l4XNsKqDBlWwGYemZkJqZ0tHmghTelM7MbBgrVwtPNXB3/0C2vw1avT/PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2DfG9GCbPgdFkFHMTZbiPPK4zaIpftIeeTTUNNFcPsaDztPE
	nnz4+7UOylSc6APT5QTGRziNlM5B079o2hJqBfV4z+y4la6LW9bJCMf0nRikmYAx/RM=
X-Gm-Gg: AeBDievv4KHcdoQtmz6Ws7QY26Sj5xhxluOWNfZqUVVi7AhLdHSA0yXE2ssXxlzIIGl
	B81fvuDx3LKXSfdzCcpmu1Zk5EcBvQzfuGr9dyIZLQBqdsPorbYeywXlgfZdm95yNyGBvH8wQVI
	TxswglmjGXp7EKJRQQkuuOhq6Z/XbMnDbeEWaGSqNLnl5ZNB9hef2jC3vO/9P2eUb1kipubuJWN
	pnNZ/oW3xGQgdh59/GhwA2Kl9A61MT8hXybewWEEHfIvw+V/aXWvVa+jQLz4txxtjN6ZGpZ8a99
	IWOzo4v5+b6S/v+glIxfkI63wIu/CIREmnAueKRFqO052sbrlKgOUjF63aEiLvfSPlKOC1nirzv
	hJNf1sz6gOlBg3/K99D2aIrHwYZ2a2TukpvmB2UbRDi/W5cf5TxnhQZfl0yWEVZSIs6lP+2papM
	SdcFnxZByes0akXA29F4bLKb+KHrZped+LPgid6gDIzTnX+Lbu+ryb5V45VAJPPqowXqZm9Qpjz
	L0EfrO3vsoC9Iw3SS57A53wqHwrZyetWg==
X-Received: by 2002:a05:620a:44ce:b0:8d8:9434:9379 with SMTP id af79cd13be357-8dc444ad8d1mr2489658185a.18.1776110357176;
        Mon, 13 Apr 2026 12:59:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca259724csm53270746d6.12.2026.04.13.12.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:59:16 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:59:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com, osalvador@suse.de,
	dan.j.williams@intel.com, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/8] dax/kmem: atomic whole-device hotplug via sysfs
Message-ID: <ad1LEgvfwzgvvWPO@gourry-fedora-PF4VCD3F>
References: <20260321150404.3288786-1-gourry@gourry.net>
 <20260321104021.4a6074330131a2058e8706bd@linux-foundation.org>
 <ab7_AVLgzLaDRcv5@gourry-fedora-PF4VCD3F>
 <a4be48f2-ab0a-4808-a7db-2532ec65ad0b@kernel.org>
 <ad1GJRyAfIAhj1iz@gourry-fedora-PF4VCD3F>
 <478c5700-8bf5-42b9-ad71-bbc618b36c9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <478c5700-8bf5-42b9-ad71-bbc618b36c9c@kernel.org>

On Mon, Apr 13, 2026 at 09:40:49PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > I don't think this is a very large lift, just a slightly larger hotplug
> > locking scope.  But then - the per-range thing in this set should just
> > work, so let me know if it's worth the extra churn.
> 
> Well, you can rather cleanly undo the operation if any offlining fails.
> If that's not a requirement, then no need to change it!
> 

It's not a requirement for me, but maybe it makes sense that

   echo unplug > dax0.0/hotplug

Either fully succeeds or fully rolls back.  Otherwise `cat hotplug`
would have to report "¯\_(ツ)_/¯".

So makes sense, i'll come back around on this.

~Gregory
