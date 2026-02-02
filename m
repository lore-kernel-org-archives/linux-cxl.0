Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A42FF664
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059955; cv=none; b=UPYxVIZINAbPxVD4Oy2S+c/NPO9Eo3Jt+pOHh7qG+WFtIGf/6wZZRrSrpvqW4b+tH8jM5OYAWCmShyqb2DDVb/oJwjeiT4Oz6OqEmKumvjubMQTQDhRY5dORB41nLAjSlUpRZOpnR/9b6ONlUxNN1cXetWrQc+F8Yluuwboga98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059955; c=relaxed/simple;
	bh=0x7jvlrx5XFJyx/jKqbZh9Z1RPvxu1cgo/tyO/MM6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R15/n+nF7hkcuI9vygesnmCfi4cw4HVE5t6dE6GNhWcOOVA3+XK3IpEJm0Sad1VwxsQwPtfWMl9EYtl/jvr97ee7w3TijO4RbjTbxfG9skwWUIOmLmwSks/9hgSHZ3QkDT1MO4lG6Uq6h1Q/015aLmIi3z2Zv1qqLmDe+iFHKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U2qNsPFN; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U2qNsPFN"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a288811a4so47350106d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770059953; x=1770664753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asmdN+eKpioswtzM18Womc5lL+dXDrk6p42YTES7X6Y=;
        b=U2qNsPFNBQhv24mlITltEayI08i1maVSDm8ByplOD+la0RGDSjY8Mv2H9n2daDnKOl
         xFGqK6Nb/SYf/KFQV9g5T0gvLgrWXOj0rxnNJHB5sOxcIP+uYUeTjRn/gdAeb7GLnWwn
         7HycReeNfTp2wqqE/Tfi3ogmFcyzVfMfWgVOyj/zWwFEN7elO76wfdRDZdPfhnnsMaXr
         FiWQpHKejx40v20H5vZ12+Z5NhinnT3aCZeXMaWsoQnruq6PiIKMdLczMmxPpszpCTxj
         KQfbsDGCEIgB0R96PatMSsngQ6AxnEQ0DmeIQ6Z5vAXVdsJHEoMaBEQ/SbsWFlsDrIeC
         6INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770059953; x=1770664753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asmdN+eKpioswtzM18Womc5lL+dXDrk6p42YTES7X6Y=;
        b=qL2T+Dr/RCMvzcER2YLugSRt2hDiLvRaYc5wnf2M4V8GqOl7x6y4v8DnUjqOq0FUjH
         LNz5lGL1IaBKbGtzB/CR6NLRHGZs0na19LTLEopnmvCpDIy5zSTC3tTnNu8bZ1OR+07v
         jjXQtMFJeoiwg2vaOt1ZOK8N3iiuslv1mauLAjLhUdACFDjfm9Xali5tnU+7xEeyE50f
         yy4UBBI9e55fNgPQU/IeK5ugKLNc0hL4CcaNlwlq+lR3PkMoxKmN7nS0Ae4liiBlrXOT
         RRncQik9g1UlrwG6qMAO5ujZI94tjOjiV9Ju1DtOY5BI6hl5/ansbxHNOD4ITTF424o9
         3K7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt48ptMtuZYOokj2wGqFQNAJges1JwvN4MAkxqrGQg3WralveaTk3K0qS0xXN6i3KPcsXvHdr49yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1hzjaPCE/zrEQ9b18xnToIKdbuNJzfq6oTJzq26FB9SmS2n3
	IdYDUnLPSRtnRcM70ZK1vjaLekieXYDc8+2VPleYq4KPer/D8sP/ZfRSLFM92gztiNI=
X-Gm-Gg: AZuq6aKnCHYc2/Nkh0LSmLrX6owsr89UvPX6czEivm9ada9zWb0L3tz5yMTygvueJIp
	hk8Z/ftpKzORbAKM7dl8DW45d+jl9byqzsxMbiXZTmqg9mAShl1HtvlTGn7RSVqf6hhxBNj04q7
	L3plFK7lkdhbzD6onjgjRPavLJn0E8SuqyvP+BIRCgNHdt5/s6I+k862RyNh/BeFufph0BgrFVp
	LoaGwItPUYh7TQ7uHFRVYPhoI1FtGUZu3GRSYQPI085huRa6tvdSkAJb8tpi3+gU+3WV4dVTvht
	0y/6rYkiiBcxfqkM12bdvLCm5+7a8bHsm+Hx9KZYAkIPpgc2yyNsHXH4RBXhH0/YID8STmg9JBR
	LoGaKHxZz7IeVUqhaAvbahVbqqr7X1MaDHtaTpf9rilwAi/RVTGjCX55yuz5njvg8P/dPgRlUiM
	8wrgy5sEX/dPHY4oWV79u9h/D6T2adL7HCcjNOmtwrJKNrf7NwnUueTlRldaVx/rhhNbCw8g==
X-Received: by 2002:a05:6214:1311:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-894ea096c06mr178827036d6.55.1770059953093;
        Mon, 02 Feb 2026 11:19:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2889asm1253553485a.27.2026.02.02.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:19:12 -0800 (PST)
Date: Mon, 2 Feb 2026 14:19:10 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
Message-ID: <aYD4roMbjyBkK9l5@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <c1d7d137-b7c2-4713-8ca4-33b6bc2bea2b@amd.com>
 <aX0s4i5OqFhHkEUp@gourry-fedora-PF4VCD3F>
 <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>

On Mon, Feb 02, 2026 at 11:02:37AM -0600, Cheatham, Benjamin wrote:
> Sorry if this is a stupid question, but what stops auto regions from binding to the
> sysram/dax region drivers? They all bind to region devices, so I assume there's something
> keeping them from binding before the core region driver gets a chance.
> 

I just grok'd the implications of this question.

I *think* the answer is "probe order" - which is bad.

I need to think about this a bit more and get a more definitive answer.

~Gregory
