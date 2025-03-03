Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477B215048
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017339; cv=none; b=b637+t8SkwVrfbuag5eqlYMXvtm5GbS8Q91En8MdAlgx1f35QDsMTnZTqf/c9rTLohQpt4x6gJL5KMQ57T2pE1Js046DJk4kR+OT7zbO+hmGJ5GGJ4roY+a+GIL+ol6xda7tipURWeKS454L1X+6LnUU6UhI5sawQRK9oOCKfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017339; c=relaxed/simple;
	bh=z/KmatcQ+OaKvAP+zAPyuRr4Y7ztXaiC7ZErKwUhdO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwU6Z177M0pOT0iQB6jvvLy6f8O0MHVXK40WWztA02stSpsMFDdDph3aac1Gnb276rOSdcv7LQ0+AGWXmU0nFQL5+0QrXejJ9ixXWk6UDF+zRNr3/PRLkxQfslJ+wTWnW+J5Z25gPYMvDsYNi7hlxsUvQLEkqyudrIsygtqP1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eSjbnVQL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eSjbnVQL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0818add57so506698485a.3
        for <linux-cxl@vger.kernel.org>; Mon, 03 Mar 2025 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741017336; x=1741622136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0yVVWEkLRZzQAPET4irodYuHGeDUDxcACxGBbqbp38=;
        b=eSjbnVQLfelyQA+c00jNevkIs4Xndl4LPGS6CDFU4ohRFnJjuoDEe/vYeljEyZMz2Z
         CwXhfKH4b6zE0gY0ExyqtRVP8b6hP35Hhq9secr0eqbDYd6UqpP2kajr3vtB1/JOlT6X
         iHXEwCnZch9UcBzH7L2RBGVJauHoAjFNlzF3T9rCveMvXX7wIyLJlMRmzIbzs7XIp6Sh
         qMpuf9rrkisPex6jMOmkU37tiW2OPmdwxvIs/tgSQaggJSV/dfRiXWnhOEMNmL90Otkg
         GCZ59kAudsksCcNeEFz/PLRlDymcFrkc93WdcER4lNkD/45nH4Qu5zrhMwys8kZ42qpj
         mf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017336; x=1741622136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0yVVWEkLRZzQAPET4irodYuHGeDUDxcACxGBbqbp38=;
        b=i5zK0YMfv9RiiX0woxLdYCEhRE3PH+CwNvr3e0j5wv8AaLsV6YSiXMHE2u0bZlu8Wz
         bAC+vdmUdfYeLgbwOI9gzsFv893QTHenek3ZuvRDDsLS3jIAaYqeLpvIEMKyKaCFz+l9
         +ZkZw6lTXsVXkpA61zY/muZShtHN94K2kZAgbBsQzxX3CxBXClkO69QRZusYPGlsmZ2z
         dgIGAw34hag0NTDvjP7PckUACC33DKwlGVmJvF6e6kxDK2OUGbDprYHndKAQHDr9dFLM
         MOt7gySs7qvSkTm4iDcTgtD3U5tvlkaDyMURwLBLFnY6ggGkGLvRFn2eRZqj3IPIiiGk
         NbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+gkM/c2/HYnZudKjl5DJKkoATQoKjRzgbpCbXJ0fPrrA31O0eHPn0755nLgq4XEftUdp8qCk7nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE099CrLkQuZHvlgokbn3rWt9lzRvlqa+mWM2gmS+FkOKzHu8
	1vQBz2Aga0VI3PiO2tmeEmRoFaNTg9RQUAcgGbHS5zphNKBvYIKfjxqbSxjQRXc=
X-Gm-Gg: ASbGncsLPIy7E5lZh3+/sC4d3fa57H2T+yyVwlEvvuG6EiG0Tm3H32AYrLyq6k/RBs+
	miNdHGEEvDLZccr8HMJIrotM+Hr9cnfAU1XVaoQu9g0LA4TSWfOTgz6sjWUZNUiVsw6BdfgyhtJ
	oUhohgtNSK93/rKO/krknllNM+BzPGdItRw4l/h4Br4tCS+3u5TPWVg/GYRv06AGc3sJc0SwkJP
	GX0jCIHV9EKA23mgLbeHeDcUotOQnE+eDxJOizlQjiz8Ds4EhYjjq2g0bQ5BCuSvIwN7CFF1BTN
	6Vc6cEs5sTb68UdkRsqJKP1Kuw6LROd2Xc/Iajf0yO6PmIqc6KnZTVGQQxnUAPD6vwWJs8ul9HP
	uQiPvA7LDrC/m9h6vSS4SVcjtdw8=
X-Google-Smtp-Source: AGHT+IFM0tip0IK1EmFEl/X5vlqq96cpWyeJ5x7wplFHlaZ1k9Ww/s40ZReUyRobKusoOZOQPH4L2w==
X-Received: by 2002:a05:620a:d88:b0:7c0:a46d:fa87 with SMTP id af79cd13be357-7c39c4c8911mr2016730085a.27.1741017336181;
        Mon, 03 Mar 2025 07:55:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b80dfde4sm165557685a.36.2025.03.03.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:55:35 -0800 (PST)
Date: Mon, 3 Mar 2025 10:55:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Byungchul Park <byungchul@sk.com>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z8XQ9VXGOCjsjxDI@gourry-fedora-PF4VCD3F>
References: <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
 <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
 <20250225050643.GB38036@system.software.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225050643.GB38036@system.software.com>

On Tue, Feb 25, 2025 at 02:06:43PM +0900, Byungchul Park wrote:
> On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> > I also think someone should actively ask whether `struct page` can be
> > hosted on remote memory without performance loss.  I may look into this.
> 
> Could you share the plan or what you have been thinking about it?
> 
> We'd be happy to discuss this topic together, and furthermore, it'd be
> even better to work on it together.
> 

Apologies for the late reply, i've been on some R&R.

I haven't written up any specific plan for this, but it is *reasonably*
simple to test with memmap_on_memory.

~Gregory
