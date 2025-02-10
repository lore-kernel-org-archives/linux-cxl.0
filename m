Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79D247DC5
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203594; cv=none; b=YzcXul/ak5h9EH0ko+sOQ8KNFMg85apdHCoGb2L4YFGsD1Ap1IhIsiznbPpDVLD0k2OAO/0zICo46YARD2D+JZv7BENZYapH6XAgzGCyNm6dBaoR53OHC27YdY/ntQVzoByVm9fpcatrJQKLgsEF6vheKEC/XfkSe2tdxBAppeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203594; c=relaxed/simple;
	bh=IoAusKnyic2p6lBkB5BTjYOllZgE4iVJ0Ghm7UPRRrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYKEdmoASX3nhdq8ekq/inrWINgi1XxtCB6Ud4h5F1dx2g8k1uY3EO0TpINSkyddJaOPTexXE3ARebaNPOvo0hbHyvKMjdV2V1E8+yRABXFfYBd1+fuDYU5oMdjNTfJ/SlB9L0flm+aYd4E4jDEuq7s2uKkJJO7ViISLk8DOR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jl7ixIw2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jl7ixIw2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e440e64249so49763196d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739203591; x=1739808391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tke47kbpnFrWp9UrJwZsklKqJ06afMwqKKSvzF3lCiQ=;
        b=Jl7ixIw2S5q4N57J5F2cwZxtu/P58eTYhRvjZjRXddljbo/6L7Vkrp9e97HeJTSG4i
         PFI7hfaD48ApJyoQJE/og3zeLZiFk05FXC8/7++4jPw5xwnrLy0j1RYYeGFHA2WNMU+a
         xi9LvbhB3KNzpcxk2576nlq9MytZOg2hjw1X9GPlROwbOw0V1v35ICW3ir/P7NtGIvMc
         XLQooXB2oZ1+MqZ8u7NJluJja7Dj7htT4id4uPLL4ZqGmF+MYxoLQq5Vo7lauAPJQxOZ
         2BeZyXulbbeQx1jb0nc/FmkjCTsfXiFPZzmx47beN4YKdfyvGZO0J7/AlV3cpMieLMFh
         PHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203591; x=1739808391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tke47kbpnFrWp9UrJwZsklKqJ06afMwqKKSvzF3lCiQ=;
        b=qWjkcvMasPpgbfiHa7NCjGcEqrgRcJOIN0fmWvdPSurd5wr8TyUV2Ff2fiNxKdJY+c
         OEv4zJDJBpmKOe37ac48Up+4vrJH+e3cI5QJxeYFtr858vo1iPqVsM88sXCHz0BDQcgG
         CzkwH1q5+hww8PE0NWDK8PhYbahepSzXx+gCM6DbmhFLRlKblmnRpXJyBpuhedakDmmW
         e+mooCrT8SdArLTALmo/hngxxJN/XnxT+kUeERe4bLUZ3d/HY56ctweuvxh7vR56OIhe
         KVCVqS36xWLB29/kLNPgXq3KYt4h3xy13c8tl9ktgB71LWP127+/xySYSC/5h8uXcQQr
         iTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAkwrMvx+pVKWJcgqo2X0TcKJeBef+JOAnzIzDp+KaJWETYLNZqBwn1dQjJfsMyItgJMJPoQ/yaT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU+MH0MNcBbksPLj3jSmU7vU+4bRCZyNU4QUmTBAR7oCI/bGY
	mDNlYDHInR81fGL9ITw+hI5pOACLwaTEyD5pEqTHjnvzeZGxtkUSk6OB/g1G094=
X-Gm-Gg: ASbGncsEe/gHzl8UrVqgtVTlf0YnP6B65jfvBVAI/UXKXlScayoXgOj3OUuRpsy6dEO
	o/pY702HqBwi/AhTJuHwFj1elFrKmnxehW6Gc3Zc34JNdH8ctkNvStf2213ZGOwg77qOiGxLqxh
	KQjOAjnnEnDRWJvX+H0JmgNjbemmHppcUiicwe43YlH8BCzmSDarW9dMygP77TP4r470E0Az1Uf
	kLUD7xr8ZvzY/8yzekXOCq/gmDq643HSL8OP4eU0FZn6tpdCH0PiTDRzfeWwPeDyl2sF7G2wC7B
	O8geM348c/dD117zO7wDUeKG2YEe0TH+s5RKtP5lSPKjDDTPVdi1SKTQJqrbILRNOFmun+eZHQ=
	=
X-Google-Smtp-Source: AGHT+IHyY64XYBQP0i1c6Qh0JHQpZ6nK53wQfuc9tLq7d03x5CkTUoa8aqdVuHXijLL2T+ZMD90Vww==
X-Received: by 2002:a05:6214:76f:b0:6e2:2dd7:1404 with SMTP id 6a1803df08f44-6e4455bafc7mr200422336d6.3.1739203590049;
        Mon, 10 Feb 2025 08:06:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4556d150csm24531036d6.54.2025.02.10.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:06:29 -0800 (PST)
Date: Mon, 10 Feb 2025 11:06:28 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Byungchul Park <byungchul@sk.com>,
	"Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6okBKZFTHIBAucy@gourry-fedora-PF4VCD3F>
References: <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
 <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
 <Z6ohgwNuLUGsaTi5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ohgwNuLUGsaTi5@casper.infradead.org>

On Mon, Feb 10, 2025 at 03:55:47PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> > I also think someone should actively ask whether `struct page` can be
> > hosted on remote memory without performance loss.  I may look into this.
> 
> Given that it contains a refcount and various flags, some of which
> are quite hot, I would expect performance to suffer.  It also suffers
> contention between different CPUs, so depending on your cache protocol
> (can it do cache-to-cche transfers or does it have to be written back
> to memory first?) it may perform quite poorly.  But this is something
> that can be measured.
> 
> Of course, the question must be asked whetheer we care.  Certainly Intel's
> Apache Pass and similar Optane RAM products put the memmap on the 3DXP
> because there wasn't enough DRAM to put it there.  So the pages are
> slower, but they were slower anyway!
> 

Well, *if* said memory is intended to host cold(er) data, then we may
find the structures to describe those pages aren't particularly hot or
contended.  This is my suspicion - and I'd rather limit kernel resource
allocation on remote memory than try to move kernel resources around.

Plus this would still enables hot-unplug.  Once all the zone movable
regions are clicked off, the page-desc regions are unused... probably.

Would just be nice to have some concrete data on when greater zone
movable capacity becomes a net-negative. We're making the assumption
this this occurs fairly early.

~Gregory
