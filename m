Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD02EFD95
	for <linux-cxl@vger.kernel.org>; Sat, 27 Jun 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782592944; cv=none; b=osfI61AbdoIDNX5RhzlwCbioGOob5CKr0YUyPTQaphgDftOr/S4LhtrKlWC6qFZgmnkrlUtPJkqLz8tA6xU0krVHtG2Auk7Jz9a7GzEZnpEDoKJEQ/p5a7H2v0UMXOvmCfQpgH9XcTCsRSQzc+yIMhqxyn/7nBauwvkG3wPg8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782592944; c=relaxed/simple;
	bh=7vb4snxpMOpyUr0gr4AhCLWmvUzZ8GqvNt/munNwM6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z03lA61+0VZvkoUjMZ5wSsgVtsKP/dk9FK1whb4FMHjNcJNrM4VKD8ORvLIOZsXev6r57D/rnlbqOpPevPobtqRmuyi9alZVhUj76UZtIFP/W9DgLFe9L2Kg0ax2egbL4v+T3Er+V6yYH6ER3zCRrYF6Nmf00Yld011CsR+L7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NHaOIZ59; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NHaOIZ59"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e0980fa96so38114285a.1
        for <linux-cxl@vger.kernel.org>; Sat, 27 Jun 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782592941; x=1783197741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvBTXqN1MAazPmYZrbZsf15Ac2BOg/NxzUUoaLCPN5k=;
        b=NHaOIZ59u8gKxw7npgJ6bR4dLFwGJYTa+D2IEvUChuZhhRbtlxjFVaihWazirK8tqB
         h0e2mZHv3rb4GABo7X4d3muhLOPW+4bCmgqYzinavKkC0t8mDSHPYeZfW5yUftcGxNoA
         e9KvQXhqzNgpWFYypJHlqUT9p7d0+18DERE/e2w6Ds95+pZTYAjpSlxfomUR5IQcZ7tY
         WOai7NFh1FZROUmTLeFrCdvTYILzrsfCL+/wEOwUzNLXm7bD3LQ+1K0jC/B0w/rRRQKZ
         3BgJUdk72ayOSAQsAo50s4MqJj4IzrwX6IRjB3QB/cJSTmlP25+7+CGgKW0ftyltfmdH
         /30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782592941; x=1783197741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvBTXqN1MAazPmYZrbZsf15Ac2BOg/NxzUUoaLCPN5k=;
        b=KujRiYhLsZ1Morx1THM02ZHVcOp6RRJUVoi4h0t+/O8/Yd9f4YsTvE4TXWaCntKtQ1
         faXmAodgp7/Bnj/aicYMHLbh240zXA3wwb74R6NM4hIUx+RmUKh5Kol1gNQyOcWjYJCe
         +nTRYTRmyUDkZBHfZ4tEqUDDaemMXAar+nLEMc7TiDxwX96D2OgA8wfTZvwhMUci8f3z
         bRXb3kW8ppGW40huotxfX+rFcQ01cEIBjSj0vpIi//WlWVMEXG7aBs8Cv0NakuuyZpG3
         xUpkWy01yIswdVoFNplA2HDVK2ChkXmeNNK4Bot4gmStZqd8Dk2HM1cIdGFYlRbmIYD1
         9D4A==
X-Forwarded-Encrypted: i=1; AFNElJ9MB9LqTZqSl4G37SkQoapyQukkTncYmLA3p979lzSXc3oI7ByVvZMxNiVxEftENriAshqTcbDi4rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11Kj7cxTzydoDOG4zNQrgz/IVP5C+ei/TsGjzWbjlK1RH/15L
	a9h8qpM64BU/Ni0/1YUlO/+jRkty0HnHxGRC09O0aN3iOIDKIQ0jBJRxX9ZrrbDQ6E4=
X-Gm-Gg: AfdE7cn4CET025XO0T01TXmhubuRZ72YXkx5ruykK3G+BfU67pC34HJx/6vrQAUD3oo
	jQCedhO2c3h9IQP5N8YN76ncmOBM8cMgll38UWaWDjHKwffWmGkEPaeToGY0Vpox+4OTjkhKITl
	jkX7NPschqLkklOc+ftQPDV1sViBRLOuaXPA852JePqq7vCoCyoAzfFVTGytoHRlJ07kuFvok+S
	PKDIL1mY9vt4d2ZPt9ZUyK+GdYGd2dnUNNyFLZJh1Ls1ZzFkIMEAEuZaBZcybtfthJhIqD7jUeq
	VqswWNiWQtLkabVgIehJAPA1KOV3v9VjRNFDgzn9SC9nymF/0tnK/boVPfGL9AoU6n1+Nc4FgWD
	2oL89fr8orVuUf8V9ReyedqUcsFEm71NOnQx072+gM64XbMY5UvMpXbBlcnHdZepRVgvETjVC4o
	4hQIjDizEcMTIXsKrBOfSEGEKqlaJYX2JRQY/I82gUYCww4cwFw5KOZxdYgvckNrzxeAALWFXpr
	Npponw=
X-Received: by 2002:a05:620a:2915:b0:922:2baf:d757 with SMTP id af79cd13be357-9293d4a105fmr1727191785a.58.1782592940972;
        Sat, 27 Jun 2026 13:42:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda626b9sm1585236085a.14.2026.06.27.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:42:20 -0700 (PDT)
Date: Sat, 27 Jun 2026 16:42:15 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, hannes@cmpxchg.org, mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes
 offline
Message-ID: <akA1p_scgVk5FTmA@gourry-fedora-PF4VCD3F>
References: <20260627073107.523499-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627073107.523499-1-gourry@gourry.net>

On Sat, Jun 27, 2026 at 03:31:07AM -0400, Gregory Price wrote:
> A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.
> A balanced counter can sit split as global=+N / per-cpu=-N.
> 
> The folds reconciling the split only walk online nodes, so when
> try_offline_node() marks a node offline - per-cpu deltas are stranded.
> 
> A subsequent online zeroes the per-cpu area but not pgdat->vm_stat[],
> orphaning the +N permanently. All NR_VM_NODE_STAT_ITEMS are affected.
> 
> Flush the deltas before the node leaves the online set.  A remote
> fold races the periodic per-cpu fold, so do it as per-cpu work.
> 
> Discovered when a node/compact call hung for a nearly empty node, as
> the math to determine throttling broke. Reproduced by repeated memory
> hotplug/unplug cycles on a node under pressure. NR_ISOLATED_ANON
> ratchets up and never returns to zero.
> 
> Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>

Realized I changed the title on v2:
https://lore.kernel.org/linux-mm/20260627073107.523499-1-gourry@gourry.net/

Core issue was the zeroing at online time causing the skew, just have to
do the fold there instead.  disregard this version please
