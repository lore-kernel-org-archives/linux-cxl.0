Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F7372AD9
	for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658705; cv=none; b=WL9oQn6O3FWge2C07yu9Wts87EfICowb9BB1+jUnCsEqRit0PZHwfwMjfqZ7poANz1lENfmeHMNZM5Gf+6kg4whgqa3iLrKUpe9L/7ll/OAu7YVwKxCcxaCU4JxxR+rGZgol+MQuR+yP6XuBjtgUZgokK6K5sGjbjDkC/NgkTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658705; c=relaxed/simple;
	bh=2U5H0M+AmHJOzPsmhzLUd9oy7nlu/R+qhpQ/NyzGF28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuS6JWgmsML4La3vgXMiesMtwabmIgq09ke6smuHX3BKSAZMkFJy6iRtbHkIF9Yl1I3Nf5P+fPWuVi4hTr088HFn1ayyHhGTCIzhmIzJVENWKROM56e/xriRPk602zZcOwb0jXNvOnKbL3N9BeLzqw0Wp6iOBdX37QygadnPahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJQe5wZe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJQe5wZe"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so11614a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 09:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763658702; x=1764263502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Z72n9Cl1RL7pgenMI30Fd9ER6zUw/sTuQNIj1Gn78=;
        b=VJQe5wZe5CNOaRPOkeiVUPK6AdKPq270RU4A9N59lS03gXV/ip2ENgqZsVHU3KmsfK
         Mjn8Kh6CO5yUX452vf/IJneVShK6r83/w1FIZ+eTAf6Oe1W+9Cs7/aC7xY2WK55W4QgT
         xeBPoVq6EXYshMPAxbn+AKuyyTU9M/aY21GcVj3HZMMapDzrVBi4b7jJg8gXD1Lduzo5
         Ix9s7bt2Nyz1rhvdB6V9qlD1h+DVHBizIPxs5oX/EtklWnIFRdgFjtaAFhQbDT1zj4en
         80T4EFpJPVa9E6gm63kxyw0MPdxDA+URCR60Nuuk3/bHQWm7Mmyq/K+tOplpWe5zs/72
         25fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763658702; x=1764263502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/Z72n9Cl1RL7pgenMI30Fd9ER6zUw/sTuQNIj1Gn78=;
        b=CGhvHB8Q1HxcaP3ipP11JqEmT/fVOV6RSqgIXiJ9fWah+UQZuDS6EuHdEry/SvB1UF
         2quDPepRVwU9c6SMc0PF2G8munGBtsNKqKt6BHmiTe8XIBrjwpuaNZBRtV8cItLDGgXU
         YEz9Ko29og8mHg+lNJoqFFnZZLONJUDYGoUmb1lc5ktJVY6ZPORIRqLXnJ7d1R0cTt/k
         pbf9PWyDGVc5M98HuzL+RDTWMkcQtD8Bbwyn1yGhGlINcrmokOXy5qhZTBIidEg/VhKr
         NLy3VcWAh2ZXLzQuRaNn1/z8XIWduMnTSxmrob0+0wQmJyWeEKlaEzNcVLjAIkHGTTOm
         DBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUpJcOms2epwgUBs7f0DE8axQhZH9lipMh12wFVu1QNHkNQca1iGz+K0IzAZj7MOXaM0lviWqZE2ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5/3boaH6yRKvyQGJVbqJDKb/88VXM6bDJijiv17DsfF/JPg/
	ybNM3PKQwZ9bLka3MENU9p/2aZJmNV8id6eMw/7SVnT2TFIhO1SGnSgd3++kpCrbdlgMC+s2KOi
	Wv5H3P/ulxOHRojYcXPgqQ636tfmmI/2jWmkT7Oiy
X-Gm-Gg: ASbGncuOI/pMPa2bVgNM0QBSzG43/JgCyT9jkUNX+uz481KGMaqK0xCYPo+lpXnqiPK
	a56qEGnggssPLPQrxh9zHDoHDLns+p25wYxgxn9vWv7t65SFz0Ro0gtCrFhrzlpAPobK2Xz+CVC
	tTxVXK4PVQhi5ZzNV2gWghsWbCHzBAMyYw9nZZR6psB3RIgexUerhIZpN73olMSEl6+2rmWSMQU
	WEh1DW7cD4dEnhf0VvKkSaBvWnMK9g6s1ehcfe7lcZKl02W5eA7LMgT2kyeAcNkrOgme3dKeit/
	60Y50Pmmrxd5iTwHF25+KZE/tA==
X-Google-Smtp-Source: AGHT+IGeUbm7Ie6pXSb+0wmq57u5fAGeqTIJ1BMG7y6hDCVTSEGpacFalC/5UQNwdn4sUHRkFYy+wUrbd07aK5lUCBY=
X-Received: by 2002:a05:6402:460b:20b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-645369d2740mr52100a12.0.1763658701850; Thu, 20 Nov 2025
 09:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
 <20251024210518.2126504-6-mclapinski@google.com> <691ce9acae44c_7a9a10020@iweiny-mobl.notmuch>
In-Reply-To: <691ce9acae44c_7a9a10020@iweiny-mobl.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 20 Nov 2025 18:11:29 +0100
X-Gm-Features: AWmQ_bkl38cRsErW02FYYsJNSvgkRtb1E7YCtig5YF_mXurH4QMwznjZdg5sa3s
Message-ID: <CAAi7L5foTbvvskLxKW50T49bdUBbedoxQHifZ-4NJYf+Fv7YvA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the dax
 device driver
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:46=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Michal Clapinski wrote:
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> Sorry for the delay.  I picked up this series but I find that this breaks
> the device-dax and daxctl-create.sh.
>
> I was able to fix device-dax with a sleep, see below.
>
> I'm not 100% sure what to do about this.
>
> I don't want to sprinkle sleeps around the tests.  daxctl-create.sh also
> randomly fail due to the races introduced.  So not sure exactly where to
> sprinkle them without more work.

I see 2 possible solutions here:
1. Modify the tests to just poll for the devices to appear.
2. Modify ndctl to poll for the devices to appear before returning.

What do you think about those?

> Could dropping just this patch and landing the others achieve most of wha=
t
> you need?

No, device-dax is the only one I actually care about.
