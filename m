Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79B1DA5F
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738985066; cv=none; b=aYTzyRrendOQTAVLEX8NobsJ70NmTVNZIPHUoLutKiSfgNStet2JexUqPfSb1SGsphUNmvKH673+6lwo6ec6ANn198hW/V8xGdLzH30Ufg8RDQ2ehET7znzHoa0ahbH4jj4AFo0h6ggB1zs59HLcl3nFn1gvjUxmVMS6F6cSRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738985066; c=relaxed/simple;
	bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWF+wyQ6f5j7WBpemY2bMqPdZ3FUQIi3ukciUQfRx4CDLkv/2tLuCd/7YfZEl38j8uxik7GaK79xewfQvStK/jQ8hxNOBQdUu5HJiKUTvlmM45ZQ8wrHGbsLkcHJoAv7uPYbGJb8hNtJGi0y7I0fUXIEt+Yof9+nhcEot9g4V1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gyu94s0l; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gyu94s0l"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd14c99d3so507518f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 19:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738985063; x=1739589863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
        b=gyu94s0lDtuZU6i/Dr+NKi9y1y+EDMmkPnayRDvSYJ382yB4EAkVuaW+EQ4/Iiu8Wp
         9deJxvJhVe+bsfjC08bKP+zBNfME3TdzU5brq6qQ/l0UE0W4NdDVIpdlFqHX5Wc7IEri
         8/poeC1Ekj74tzO7OckjzDvfO05U/VtQzh56g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738985063; x=1739589863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
        b=jERzm9cJeklL40P9O2HanbXG99Fl459BvzLYObkeLwk5VvmjPZ3cop2aWjZgHmsJd4
         dHKAjKwNHsk3ck1USOMjG7zuWDS+bMGtyqLCMCAyrWakuFteBKJF/8jQR1Z0neVk22cI
         82BchyxAfa0BdnntsOCRNLp2XjhoClDJcPt8s0S/XJ3NegNJNV5ule7DnhlFxGkX6q/S
         G73pSmticLdTwLMeSNEL/evZBbmBQ5XSYFFuzmYJ3o8G11FPOJHM3yFfBi6ZaI5dIXuQ
         KUQBfMc6B5iJFSpOzChRWhSSFsXu1JCgy9j/Vo/ek8pNfWl6AuhZTA88hb2C+oorJ14L
         4fgg==
X-Forwarded-Encrypted: i=1; AJvYcCUp6xp2RRvmByuJ/efSA9x1COBlf7ftG7sEHpBu8xJ9LMXcZmJBcSnipCDzhD/SAz5S70MdLQX8tsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPcw0MXrdXuqtQyKisFl2rB84Y5gG+uSEg0zQEejEBqLsiG7p
	hUmXHFBPqKqJc8yaAM6JcyOYCGTOb92jknOrp0GE2k7LGGEl9wGfga3cHb5u8JvDfJ+j86XqELp
	3PA9qqOeIxS6nSUyGYG1+aS7SeiPPHU97hsQ+
X-Gm-Gg: ASbGncsPpVfV120nbAWjkHuaY+PHbEX089hKTjD+K5uFGuvxkhby/wUbxQgqlj36+Gn
	s4qMWBTsY8OcP5QOuNtigSoHaieZvqt1IVGzHrUr6+fnMMVfKJ/mA0Oux6zBHOELeGg4CqZY0
X-Google-Smtp-Source: AGHT+IHVNfL+UbPR8r6YIkIAeXWNEW4gOAC+ilgLwizDADgYX4kQ+BV2BsgCSdE/lvi9D1W/g2gdhuhfsZtya/2NQx4=
X-Received: by 2002:a05:6000:4021:b0:38d:c9da:d0d7 with SMTP id
 ffacd0b85a97d-38dc9dad258mr4248135f8f.2.1738985062707; Fri, 07 Feb 2025
 19:24:22 -0800 (PST)
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
In-Reply-To: <20250208011647.GH3660748@nvidia.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Fri, 7 Feb 2025 22:24:11 -0500
X-Gm-Features: AWEUYZk3gk4vWfE5Xa1A63xy9j8Q_uI0hhFglszJkoyvnrcVpZjbm-6o_DTD9CY
Message-ID: <CACDg6nX-W7hzDUFMDmEtaZGUJu5dnSzcZpTXpn__O1kEu0ddRQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, 
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, "Nelson, Shannon" <shannon.nelson@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>
> > But if you agree the netdev doesn't need it seems like a fairly
> > straightforward way to unblock your progress.
>
> I'm trying to understand what you are suggesting here.
>
> We have many scenarios where mlx5_core spawns all kinds of different
> devices, including recovery cases where there is no networking at all
> and only fwctl. So we can't just discard the aux dev or mlx5_core
> triggered setup without breaking scenarios.
>
> However, you seem to be suggesting that netdev-only configurations (ie
> netdev loaded but no rdma loaded) should disable fwctl. Is that the
> case? All else would remain the same. It is very ugly but I could see
> a technical path to do it, and would consider it if that brings peace.
>

We can probably live with that as well if it's required to keep fwctl
in an RDMA driver and out of pure netdevs.
