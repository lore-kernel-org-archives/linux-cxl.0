Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3265279DCD
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769654909; cv=none; b=lJanudFbeQY+CKjVDOjHxz6JzDya+1513n/SwTHajtTJnWzb3cn/v8b+Nb6CCP8Bwk/q9C/5A09qqZBS2Qhy9PjbQCvndAn45JLLpjjiQZ1aZIjkochOrSF1ClKKjwefgeLvb6W1ptPDnVIIqGdzIgAFfPTzAI9UqI02/v2pVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769654909; c=relaxed/simple;
	bh=MSegS80E30k4pDG+GLAY/UU/gkkjDOslUAcbbqkcFEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsW/BuI0+jIJzftyVQaTkQylVlEkLUjPe1kG3Dvb5k1dGcUOhTNU+xEU+o9yZY5EMWLC3aQUyBs4mMtK57tKNhq6Ch9OmyAwO1W5YasA+lul0aCdn0OqMNx/28thx062vveL18AI/JatFdJb3KtQOG/OhP5j/sN5M3ek9aTorio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BgVt4uNg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BgVt4uNg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c5320536bfso52466885a.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 18:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769654901; x=1770259701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=logWgHGlCER7wF/d1bfHjZorFrIMr5ik74BP+Q9xdGQ=;
        b=BgVt4uNgSawbWr6aN5HnkCdTelXAWLKTHq55Td5arp6lLdRdcLgIauD2vWGfPFIEpJ
         rn9+g2kQ0aPftObvlKr3AAtQolheV+M31cfsHOXdTSjfi7wThm5xpCc2+gXyXPpn55DG
         YZ8Sxgprh8PxMcDrKiawBmBq87p+XIBHdZAQd2QQ4qPVwWRo4mClX/l8rqI/P3kRaGjX
         Xbx9q43UI36sVzAmExhntmNn5YzIrVcmBDoXQ4/eynvQedgGFKpZ/x3TWRgPY1ZDqXg2
         zOlB6xuODT+iVHEtLkj7xDq6lQMzL6mzR2p5q0dG9RRKReSnTz3BNfjOpgqcKYGPAH1b
         cniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769654901; x=1770259701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=logWgHGlCER7wF/d1bfHjZorFrIMr5ik74BP+Q9xdGQ=;
        b=gQxjcnY0ZLPduK8fKXcMKwbRBYJsH2m2xhlkmyGhfOLHUJ4dH2JcORyIa0ZoYgKe3b
         IYNahHAyHhyDBDKWTPy1SpGFWZNKi4U4sWfle2zA4Z6jT3JiVOpZQMhlkVR6LP3wAPjY
         M9EXilrru5nD8jnptjk6+vkqqW+ysRQKO/3tP4Y/ORLEz53VOiFmNny36Ip8FhMb8QEW
         yMGNWkaKkcXoqLAT5TgnbZF7ZE0ufefDx7f7SBQFQfDRJ+0jwedKgZo831hO57/hbHyB
         J7hjTbCBPpx/jUUwNt4AsPwGVMo+84roCcySi8FUZea+UZh+Y25c30wdC9ZY4TFX2E02
         wviw==
X-Forwarded-Encrypted: i=1; AJvYcCU946f1vuIC5C5OHddCzwiV5XNGv4+QePq0YKA1K+9JIR6OzmFvzxQ/G33BiifusFkIdntLW2DBjH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvy7R+nhVQ/sbRSP13E+VPSAZ8VwV74XAE40xNMwhl2DBuXA7h
	RD+rx992CiLCO3+DW6lBmFhSqTYALQ6vkM0kwqPl7D/u7BGbUS86cZEBBvECPieBrjk=
X-Gm-Gg: AZuq6aI17hDRhbdt0OVW32CsyEDXVN43pai09dnExPyNqVyPvEbCpQrVpAcW6gjIRQi
	UUznBhK0tcfUnxDqdMrDFFwcQjhG1+0uZPTINiuAMUyGQJeTVMHsZ/ipOM4XxtGxHuTmNM/2Wfd
	3otUSbpHXEsK0hla6w/wTjd/3bdDjrK4jwnyZRvAB9n0Onl0kpGc8UpKWveRG+Is7nBXbzyXSBT
	2RnfXFxVHKRZisA3Xvn6VoP45uoBKJjCASuifG467dAGme8YkOtB9k+V82At2oo6kdEq8vmuz6Y
	iwVSGv8S7xbMjrTwFmpJvkhlgaDLQZ6LRcASw7Z8523KNRJ0Qr60ofXxHp4f0Y5x2UYCUBbZzx0
	7eTEhGugXy5hN6+eMRL2kMld6cpjfoxq/964vUHSj0FUCuVPWHZC86Rdo1fx1tgSLUYQPvNjGX7
	iC48vH0aUGZKAZnBtt98JWVwH5OAmd0M3LAgGVOdwaIcs7TeHCGjbEDvUSZhY+lYe+KgqNhwxse
	H2LFV1/
X-Received: by 2002:a05:620a:444b:b0:8c5:310d:3b2a with SMTP id af79cd13be357-8c70b86793amr829909085a.19.1769654900885;
        Wed, 28 Jan 2026 18:48:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7d169sm305514085a.4.2026.01.28.18.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:48:20 -0800 (PST)
Date: Wed, 28 Jan 2026 21:48:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXrKctiYCIAGyOWV@gourry-fedora-PF4VCD3F>
References: <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
 <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
 <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
 <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>
 <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F>
 <CAC5umyhrcb963mA9dUaZswJKq2MF_OVaipNmy=L4J7u6rPjfqA@mail.gmail.com>
 <aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F>
 <CAC5umyi6oW9qZZH75Owitojd+wgTGrz6uHsEFXxzo8aWF7FoKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyi6oW9qZZH75Owitojd+wgTGrz6uHsEFXxzo8aWF7FoKA@mail.gmail.com>

On Thu, Jan 29, 2026 at 09:51:44AM +0900, Akinobu Mita wrote:
> > I'm not sure there's a best-option here, we may need additional input to
> > determine what the least-worst option is.  Causing LRU inversion when
> > all the nodes are pressured but swap is available is not preferable.
> 
> Would it be better if can_demote() returned false after checking that
> there is no free swap space at all and that there is not enough free space
> on the demote target node or its lower nodes?
>

I need some time to think on this.

If we take your patch, I think we essentially default to the same
behavior as-if demotion was wholesale disabled in the first place -
toptier nodes would reclaim space directly into swap.  zswap would
probably get skipped if we're already in direct reclaim (if we can't
allocate a page, neither can zswap).

The alternative is reclaim makes absolutely no progress, even if there
is (z)swap space available - which is essentially what you're
experiencing.

Maybe there is an argument for simply falling back to swap if there's no
room on any node further away.

Will ponder this for a bit and get back to you.

~Gregory
