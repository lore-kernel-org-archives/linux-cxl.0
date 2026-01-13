Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C23B1BD
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262957; cv=none; b=LW5mSGMe9yTFLHHnlVKg0HUtehouJhLbaQtqnEYm+lE4XifMOz/iDhlv/CtUwmyYSb5XNC9C4jHYAHRSlTPjel9kWoKgTtBXQFDdtM5kipvQKsQplhCuArAKmJpVwww5HSV/2Qf5BQMKU6/u6eLTFEnuvvBkzdtq8ZVA/nDuKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262957; c=relaxed/simple;
	bh=0vSM7KQU1Y5sVBulCNKjlJci52Z9QZ+9t97kzOhQuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=livuyoLyWCbUQ8bn97xgd2O8LTZ2w/lx1xsobsTF4cxep4syIEn9QmE2VnzjIuPFFyEvac6gtkOwM6VZU2Ghk/bbCMma6D2NCg1P1tTSoA55K1Z6BSfRCrQLtdapY9Sm6m1RGiq43fycPpKIF1OJacNUZ9ldUbAQdN314MdrSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lkrO8dzR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lkrO8dzR"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso473209585a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768262955; x=1768867755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2e4ZxIQBq8duxJYNjjyJZ5JRaq51GX1ITQ9hYZknog=;
        b=lkrO8dzR1D4A227lfYhjDGEM67dJbu6EaIcrFMuDxCp3CQGaNY7HPWxHFqWts7YRXk
         7gEOXmjihSmkj64R3qzaiMIadIUV6D3I6Dec6wdSfqU5UUy1a7lb0+NBJdBS654noxM9
         CPHLUjcTiTM0+a5mwEjU2r9EWJC91i91BMbeWdw1Bn26ChzGz8BxKUkeleK1AfslkBKJ
         kahbm60quwvpljjEGAO5LOM+hGgQhgMaXNGjsZXnz/p59jkNqvpaM9shsli8EGSTNKpi
         BihADsNVzCYuA6WgvPKK70pHOnsJrKXywdq4LdcIJWeaLtnbs5WhmKySLMruDlFHEqlk
         x8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768262955; x=1768867755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2e4ZxIQBq8duxJYNjjyJZ5JRaq51GX1ITQ9hYZknog=;
        b=N8U4V0oRli9xvNyj6bwhccRwAUu01Q4UtekbvouCxsQ2j4mLPR+oDthLSEmXnF1wW4
         2+vYXtCrVwKivZnhGsoOKrCkmQciHIYAPxy0SfQCxr/TmLyB3ymlrPSobf06bXESBd4c
         fxpYUQF4kq0KtfzACpkv6WsF+YXdq1Zck7EIP/3sShXbsJpm8x5oDoTODPdw4OWHnh34
         XaA2xKMfS7fzkB5nEGS61LE0xIMGB13ES72IlMuWZw598B2ELzuIWQRzt8CkNa2EFNTY
         9IH0g+F+hAqL4icc4k5EmLYIeIyiAEarVG/Yp8xPs+qZIYcnC4BukuUTXoIYpJwtoimr
         sHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ChMX2hNS0lfwtAEkz4Dwpx5DR/jczpbazGbuL2viJNZPME2fso3qnhKbNpRj4toILQ5pj9EAtmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vNz2w5Z/x9P3t997q42GMdtvjBdVFIEMvdggNcCd0rJzMABm
	YWLQz8NC1Yx0GHS7Qj9F94h9FoimRfPMMIAF4BpD9ZlbD8o7/UJqqTaL5pd1fNumw6c=
X-Gm-Gg: AY/fxX7qLvypv8/ZgWxtvNKZXBNPhlyzDte1Mkq2bfBHFT/cGF4XzMO85efMWtHutv6
	P3pS+qg/4dfFkgLrAlyKT7J2zLl9NBWvQ43sBgBn5qHxqgIjhOp92gcsLTMa0fv0Sbe12ssgv8i
	KUWsBdMMDJQ4LerBRQnhpAzNnfs8cWrh7L/+GTi3E53nrIOnm1ajjghuMtakSovdg3kuZsxQxsI
	S05Zt4js6rGRcTxvxncYejtPvdjwm52+/S70JZ6tJS8Xm1sTw0qwhxqAYf8XmC77wY+cTW71Hsa
	d9vMENjEIMcv7tJdGJooEuOVaLbLJd+EXPEVceT1xNNh6ZKIRNcLsGoVS8OW8KFFSl62twAsRIz
	9Ze4rEWWxd1yfOLloBCrvmsPymj0hDAVQkL/7vUrUH+z67vFrGY1rCoZz+W8zltrpEYkpl98xsD
	CX2Z8KwM1ZmBCLHqv/tKGjBswvmKujDOofCFI1XsWelrThaNlhTmhcYe6EO7Tie6/e1M5ksw==
X-Received: by 2002:a05:620a:2942:b0:8b2:62ae:acba with SMTP id af79cd13be357-8c5208a50c3mr164991185a.26.1768262954730;
        Mon, 12 Jan 2026 16:09:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772674fdsm161880336d6.47.2026.01.12.16.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 16:09:14 -0800 (PST)
Date: Mon, 12 Jan 2026 19:08:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: dan.j.williams@intel.com, Ira Weiny <ira.weiny@intel.com>,
	dave@stgolabs.net, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aWWNCDtltJZ3apM8@gourry-fedora-PF4VCD3F>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
 <693cdf385657a_2e71710083@dwillia2-mobl4.notmuch>
 <aWV6mZYxGdpGnkWJ@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWV6mZYxGdpGnkWJ@4470NRD-ASU.ssi.samsung.com>

On Mon, Jan 12, 2026 at 02:50:01PM -0800, Anisa Su wrote:
> On Sat, Dec 13, 2025 at 12:36:24PM +0900, dan.j.williams@intel.com wrote:
> > Anisa Su wrote:
> > [..]
> > > > Unfortunately none of the details presented in this cover letter really
> > > > show why the kernel needs this additional complexity.
> > > > 
> > > > Can you go into more details on the use cases of multiple partitions?
> > > > 
> > > From what I understand, the motivation for DCD as a whole has always been a
> > > blocker for the entire series. However, this year we've seen multiple vendors
> > > demo memory pooling/sharing at SC,25[1], as well as the development of a 
> > > controller that supports "memory pooling and sharing across 
> > > multiple hosts" from Montage[2].
> > > 
> > > The flexibility and control provided by multiple partitions is
> > > an important capability of DCD for enabling composable memory 
> > > infrastructures. IMO, adding multi-partition support back in from v8 or
> > > picking up this patchset would strengthen the series.
> > 
> > Can you explain the use case for multiple partitions per-device?
> > Describe it in terms of what Linux loses if it never entertains this
> > aspect of the specification. It significantly complicates the ABI for a
> > benefit to Linux that I am unable to articulate.
> 
> Let me backtrack a bit here :( I was too hasty trying to push for
> multiple partitions.
> 
> However, can I ask for some clarification on what a sufficient use case is
> (with just a single partition)?
> 
> Then I'll (try my best) to demonstrate how this series can accomplish it
> so I can help land the single partition stuff first. Does that sound fair
> to you? Or am I misunderstanding the core problem?
> 
> Thanks,
> Anisa

regions != partitions

the discussion from today was regarding FAMFS wanting to balance over
subscription and max bandwidth - which requires a per-device region
and an interleaved regions, they cannot be managed with one region.

I can't think of a reason to need multiple *physical partitions* on
the device, when you can chop up a single partition with many regions.

Either way you need dedicated decoders for each region - regardless of
what partition it's on, so the extra partition doesn't get you much.

~Gregory
