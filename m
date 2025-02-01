Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD21B87EF
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422820; cv=none; b=Yc8fhBLX9KMIJ8z8btNVOqJqxRPOvRim/9vMHARYaTQycnoqOotOyYAFGXB7LrnatHsaFK3dA3UNgVX4z580Rx1j2emgqkUnNrBloI6HEBZBtzW3AtBryBSu7RNvXBtpLFmPZETpMUi7oc9Bd2LS0rn7lXa1/TYg679eTHgBFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422820; c=relaxed/simple;
	bh=qb2DIggfjX6eduoQ6NH/O3e+lQI7QGq629YQqPyy0No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGS9mHytig6cUmIecyyBEgqJj7xBrhcirqmahxOXwDCz2V6wRk8n7iBVHmJc4Vv+5T5l58WYC2e3l2Awc1skubxTLPjrURXzGw77cz301rrdjpBnYZZfmSezhgTOjqhF6rs1j39JokCYCjwWxDk1LwUuJsh1HM9cnxdLpssCxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpdnsezW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpdnsezW"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53f22fd6832so3253113e87.1
        for <linux-cxl@vger.kernel.org>; Sat, 01 Feb 2025 07:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738422816; x=1739027616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkEBogS3njtSSMnywk8aHqS941/Oe9cAxXVD76zALzI=;
        b=NpdnsezW1tKM4tNufwJ9v8TkY2rA3X1YcVHKUQO1zTVXIst07G2ahoHkNQ/OjwvszI
         vX9UzJhwDhaeMK34AOlEzjEyvnJq37Dx3AHFCR4XdMynpzddeIbpnJENgqmW2BFuQPW0
         1N5+eWryOH8YmfnuOG6cDU5Kx5l6wW1erWNCvxhBcts+74tth2Bi8flKIzbRTSyrqTPv
         8vvm8pqTGhMmjpic6iZnd3HegEeNAu79jYO+VPe6Llu4fcILnKMU47uRHRMgoWIut4cS
         eY0MUMUyqPl+eO/yh7LPVYkokCrvniQj5hOHwXdwtVxWAWXSgLImCvAXpT5H4GO810Am
         yPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422816; x=1739027616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkEBogS3njtSSMnywk8aHqS941/Oe9cAxXVD76zALzI=;
        b=GVOouI2O7i4QLfkbM8bGBe6xPbqDz//xTFaQT6hsNLUyOSlonYgjx+79e4cK0SZEey
         topVzOXJGZn9WXfjxwvdijtktXomCfeg/Di/+yB5I64Poz/KIj+DG9MyOzfi8itRVrqo
         xWIrtFpNRNNt4T1MCQh5iD5h+Q7gmQmA4BW0YRLkKuU2tOwrehVthmvkXnuWxMGPm2cX
         Ggj2EuUyaoqEoJCnjlmbPp64/wBynbUknGiPv6ys2qM+akzLvYQEcFpSe0m7WbJGDwfz
         VSk17ineewHhC8u4DkVOUFuoqaeMapLaJOeMC9LI/OVignZc6VYI6RLTQOShK6Yb1lPd
         krlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwv0jVlNGbolMKe/4gnRaEnPsE96mxvuJ0/CU0+B5PJzb0LxuI/tScng8j05sI1yDT/flyFcjTGS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rzU+6iPZcDFjIoI641WuAunTWbQlJHZnuABUyQQ5HB7X5TAV
	wotYvW0zoaJsC59klGQDwAeW0aPDjaxHJRKYNwRKaZouxRh71S8QuQjys7qPBsq+klgVWowC6XW
	v9xDkdHcBBeNo5jPXdq45tX9zcsbHNTymd2c=
X-Gm-Gg: ASbGncsE8Y+4JB/cCmBM217QhyEtDzmaNhcQ8+yQ9+IX/EA9p3GlyAYxR31wuHYEIOD
	7DXKulZBPXg3A9xij7QvPTOSmgNvYy+JLF8E+X+3d/OU6wWhnngH7Nq5EPvjTvw+ZOk9TzN4=
X-Google-Smtp-Source: AGHT+IFfMfRi/0COUKqps4xd0EcyGK5Kl+QVlFhrzOrq4+TfuZU0DPTzGpcqh5smpGzQ4g+0aW7aWCktvFQadk+sYt8=
X-Received: by 2002:a05:6512:234c:b0:542:1c1e:ea7f with SMTP id
 2adb3069b0e04-543e4be02b2mr4279832e87.9.1738422816115; Sat, 01 Feb 2025
 07:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain> <Z54p4QOnAlTYm6DG@casper.infradead.org>
In-Reply-To: <Z54p4QOnAlTYm6DG@casper.infradead.org>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 2 Feb 2025 00:13:23 +0900
X-Gm-Features: AWEUYZlN48gcqVlRk5gKbITpV0iJCmnAxWMamnjQC7e9Mr2TA7FjeYRSh9-U1E4
Message-ID: <CAB=+i9T15XXbbZsvz2sg7JQNOVjaHzpj0LtCW9QtOQfwqq8W_g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Byungchul Park <byungchul@sk.com>, 
	Honggyu Kim <honggyu.kim@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 11:04=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Feb 01, 2025 at 10:29:23PM +0900, Hyeonggon Yoo wrote:
> > The Linux kernel supports hot-plugging CXL memory via dax/kmem function=
ality.
> > The hot-plugged memory allows either unmovable kernel allocations
> > (ZONE_NORMAL), or restricts them to movable allocations (ZONE_MOVABLE)
> > depending on the hot-plug policy.
>
> This all seems like a grand waste of time.  Don't do that.  Don't allow
> kernel allocations from CXL at all. Don't build systems that have
> vast quantities of CXL memory (or if you do, expose it as really fast
> swap, not as memory).
>
> All of the CXL topics I see this year are "It really hurts performance
> when ..." and my reaction is "Yes, I told you it would hurt and you did
> it anyway".  Just stop doing it.  CXL is this decade's Infiniband / ATM
> / (name your favourite misguided dead technology here).

Hi, Matthew. Thank you for sharing your opinion.

I don't want to introduce too much complexity to MM due to CXL madness eith=
er,
but I think at least we need to guide users who buy CXL hardware to avoid
doing stupid things.

My initial subject was "Clearly documenting the use cases of
memhp_default_state=3Donline{,_kernel}" because at first glance,
it was deemed usable for allowing kernel allocations from CXL,
which turned out to be not after some evaluation.

So there are a few questions from my side:
- Why do we support onlining CXL memory as ZONE_NORMAL then?
- Can we remove the feature completely?
- Or shouldn't we at least warn users adequately about it in the documentat=
ion?

I genuinely don't want to see users misusing it either.

Best,
Hyeonggon

> You can't stop other people from doing foolish things, but you don't have=
 to join in.
> And we don't have to take stupid patches.
