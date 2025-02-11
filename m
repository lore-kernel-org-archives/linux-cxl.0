Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C51FBE8D
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284042; cv=none; b=rA8pGbXOJBNfB04eYghOdtdD6z+Lbm8X5OlTVj7uB0sWWYE/sJSB2vPu863YzhKyIlo4Zp2uVMVRYO4vNDkIfyhk2OR0ZYeLVL5tz58LyL19xcPPkTxp+BrTbZlwUfQDR8wgTdNuCTmrU51BK7if0iI+WZhmqOIqAKuIeZyvo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284042; c=relaxed/simple;
	bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/oMDK1N+Y1i2/0LbRhaccBsYj3RVV/6HvnKWeswR9ckY+oAVcebhP/WYrMDZGV9qiYlZIrFQNkw3Kas2uG34m8d7C+bhZ6lkzOK3vwIConl0BUNtt+lIUeNXnIOb7hE9bla7337YRtWbz9ZIqVcQQr79Qggx3nduVRlheHmJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y512ZHj3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y512ZHj3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283d48so39291225e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739284039; x=1739888839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
        b=Y512ZHj3qYlOWzZxZSE41D3b5CBN0+Pdng2iCT6szcLj0NAsa0+a4Z7TrFXSdeYscf
         nz4D9z/j5lDD25RJGpggp28WUJavwEToCPb6cx/Fk9SpnR7Bq6I2cVyFXyKphHvOj+0H
         wNtDCEaWFn3nnJq1jdHIvHAFX2UlIFC/BtzqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284039; x=1739888839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
        b=pYjvc0VU3KJ6N3p04oTJckKPK6ZDqCkmyFf6bBOtWSKXypTVNru5mVTXfYLqH3gXDW
         eiOdo+KD2z+WoAEGy5VVwvloovlkoi59leex0Rn2qH3enAxAR8xNApWfDI8VeFc5pp5Z
         sMla7u+tSFEoEFsR53wG0TUr7wZ3V9TLs0EptOoX15+m0MXAc9+H//2xN8cnQHUB4jLo
         DPoebxMPSPmwVc3iKEHfLB4ycPDE9uwKKVauVPL6pvRS8VY2A6Nx7DeUv9IohaxgrSAc
         cqXJVrrTMQmUqEGFs0IcIU0NfEGYj3ge8WyJtBRgGjbHZQkVK0+LtsISvJecYQNo83p1
         Stuw==
X-Forwarded-Encrypted: i=1; AJvYcCUEXFC/TQqtyEZGDP6Irtl0jul+TyzgOYYYurLHJHUKsrWZrlM4vdsQgH2ZrfRRqUoM5efFUXwEYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdxagTGFnOOGhAcpVvIUQtBAE06YS1RqzfNAABMPa4NOATZeY
	vskNJGrQDRT9uJfl+bra2XxAhSvzh01a7W30DouIwrAOiPlISdZpG9643HVfHWYOJZBwZGaFu8y
	Usm34Soiz3GCYwiA7rOwwlfuSvFa7SIKebbht
X-Gm-Gg: ASbGnctroV8CD7QReh6d2WCbD/6vFOt6/EyUVJw9wYPjIOr4lubz+3dpzuyiLsN1LZg
	Q4WLb4Ru4KjHH7jsLG1KUNLpkXc6O36cDLdybLTo9bDgMb5OnhLx3sNRxiSSNZL7HHCB3XQlClw
	==
X-Google-Smtp-Source: AGHT+IFW7u3ksUwAMmyoe75NSXKQw3EDTiEgPEkojwwD1QDJJuhHYXuBrsR8LCMPEx+0bgTRETrP9rJoVdQsTMQzrYE=
X-Received: by 2002:a05:600c:1c9c:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-4394c82a79cmr38871705e9.18.1739284038988; Tue, 11 Feb 2025
 06:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org> <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org> <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org> <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org> <20250211075553.GF17863@unreal>
In-Reply-To: <20250211075553.GF17863@unreal>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 11 Feb 2025 09:27:08 -0500
X-Gm-Features: AWEUYZm-CIvbNlYRQ_mzQIY1n8Q1iLl7J8dNt2g_9kIBamNTxj7FCsKs0Luw5rc
Message-ID: <CACDg6nWiSbBV=Ls=Rts=vsx0V7pKHX0ZztbKJL_UM0+u34uiZg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, 
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:55=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
> > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> > >
> > > > But if you agree the netdev doesn't need it seems like a fairly
> > > > straightforward way to unblock your progress.
> > >
> > > I'm trying to understand what you are suggesting here.
> > >
> > > We have many scenarios where mlx5_core spawns all kinds of different
> > > devices, including recovery cases where there is no networking at all
> > > and only fwctl. So we can't just discard the aux dev or mlx5_core
> > > triggered setup without breaking scenarios.
> > >
> > > However, you seem to be suggesting that netdev-only configurations (i=
e
> > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
> > > case? All else would remain the same. It is very ugly but I could see
> > > a technical path to do it, and would consider it if that brings peace=
.
> >
> > Yes, when RDMA driver is not loaded there should be no access to fwctl.
>
> There are users mentioned in cover letter, which need FWCTL without RDMA.
> https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
>
> I want to suggest something different. What about to move all XXX_core
> logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
> place?
>

I understand the logic in your statement, but I do not want to
separate/split PCI driver from the NIC driver for bnxt-based devices.

We can look at doing that for future generations of hardware, but
splitting/switching drivers for existing hardware creates a poor
user-experience for distro users.
