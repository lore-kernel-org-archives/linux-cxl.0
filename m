Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC31263F2D
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017841; cv=none; b=cuwlhSUY2O5TZvsFjQVG4CM3HEnebtlsV1p/+9HwHs7KqWDuPNan/28D2cZMAqbHFLOXeH3lfLtZBRUzwtUVH/TIRgr58gk8OiAn962ToNxigfrUPfTz0tvB50Qe9LpiyUAEu38IXq32U3qLccSTl1pT8WX4Tv2VAVpZi82x7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017841; c=relaxed/simple;
	bh=WZauXH+MPa+G5mIjej9+lL+y3hp8looiMpGaZ3G0SjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDrc55gvlCcgAwh3ePn7BmXy/dqny/gDB2S1Tu3PCt7v3YHnJymWisdL9tJ3GKUpk5BU5m6wbbk5jzyDyRAIjeczjl193nhqEd9+9LdnSxWiZ5ihKshB0FyY2S5ZVqZZljwEGM2P7MvJhZQDhvQ7Lf38xokJascEKWexza8j9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhdV6Ssf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhdV6Ssf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea2b9631so557237785a.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768017837; x=1768622637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZauXH+MPa+G5mIjej9+lL+y3hp8looiMpGaZ3G0SjY=;
        b=jhdV6SsfK2yVS6Zqwe/ruMU+VnQlpXDFiQ1xipTH2azONiCNN9LBc2dmCUU5uojYL1
         ZQ2hBf1BE92eYnL/f6s8YpGNFBAhLfl4njUcGWNrnZOVoD86kYAot2HHQ6c6WGlOObPa
         KtUGlfilP0SeK/wzJ+d8wLsbJLlMJ9h7S5Bm0IjkLKqQ78Naje9qkSF6hDFk2+7Amsu9
         fu/MftpkzYfv4Mo3Z4ijjE0RQFF2Kiln2e737EhqtSQqBV+uXl5cgMvi6GRUdDRC3FaB
         R63Ab9H+nyqVhUoKlprXAtTi13EGkO3eHVQpuaaUd+39TKlMi3EhsnIPDUfOJaJ6uVlp
         dI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768017837; x=1768622637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZauXH+MPa+G5mIjej9+lL+y3hp8looiMpGaZ3G0SjY=;
        b=YpWqkofsVHGHlzfCmJVbeG1llfZXGpEUlBHkhzqIxFEZB83WKTKldqkuqoNX8IPztV
         MuLKAjA/FXhJ0UOitcS4V29OSPkGLKvG/TQYBjtS/PUnOnL4Qx990LAUv/VX4EoLvdSM
         njnS2XyFzX3daOgKw5bxYR3x8WBE+ojF7wYaEjNsv7n3EQ621YjtjAkJDIvwPgHC46/Q
         5/owK48Jbair30ARBD2Fa6UJhj2K1ASUieyzPTMuXhFWfxRGS+9YlitOuGxLS3vqoR/t
         7f3720CFdgZOHm7af7X581c3VIfowQjNhG85HatUdHmdV9vt0LqMCR5RDgZlRhGr0J9G
         az2g==
X-Gm-Message-State: AOJu0YwULhNfPZzWgjTQyrWZBVT0yOn28BAKX8YTjFJ5xOYdSgTtpdX6
	3x2K5es8Q81MXyLNJMmCEEJdoGjPQVzN9f8H5nGOORhL760r1ywXFIz+m9bW2iIAPjq+LTXdKxt
	a6O5pawjejcudOzBjRe8LsmDB4WcTeoU=
X-Gm-Gg: AY/fxX6gHzYtN/LGqnDOYdJQrpoQ2gsrnQfKbNWbYyKdf3Pvc9UywSKiV0qMsfYZM7Y
	do9xUCIlSLtuiNgmmvP/uOF7+GcI9kINetaBJdW+09ULcHBEOriHAAO+Ny25gRF2n1GZouy/KI0
	aEWGdoG8Xmts5dI6DeylGLVpaZdKAfUSKCewpuxUOOwQ+5as8AtvVX2tLwMNpLr/Wr0pRFWaDLn
	8mSaOuhlJ5kD5v2Vx3z773MR45eS1CHybl2tsEsSkENGEjpgYBAl5SD3I2VDnl5NB7q3osisCij
	IyQNXCRtrFRULvvpmFml8zE=
X-Google-Smtp-Source: AGHT+IGkoL2AF8SQKFOHJCmnDdpS23VSI9v0VXX4sG8uoPW2wp+fzBtIvWSsAOWNdGOX02I4Xj+89b2hG49Vj20t4K8=
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id
 af79cd13be357-8c3893dca80mr1563823485a.45.1768017837553; Fri, 09 Jan 2026
 20:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-2-akinobu.mita@gmail.com> <cb77c9eb-6dab-4147-a0bb-ce488524beb2@oss.qualcomm.com>
In-Reply-To: <cb77c9eb-6dab-4147-a0bb-ce488524beb2@oss.qualcomm.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 10 Jan 2026 13:03:46 +0900
X-Gm-Features: AZwV_QhMXanhtxvUY1a9f2Zu9D6Y77eXyKKzmP_0rDRPiP7b2vD0NAhLFhC1j3w
Message-ID: <CAC5umyhC_zN4jFTTfz0DiJuZAd_8eC=E_a+aPiBVXDPhGToa3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memory-tiers, numa_emu: enable to create
 memory tiers using fake numa nodes
To: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=889=E6=97=A5(=E9=87=91) 13:44 Pratyush Brahma <pratyus=
h.brahma@oss.qualcomm.com>:
>
>
> On 1/8/2026 3:45 PM, Akinobu Mita wrote:
> > This makes it possible to create memory tiers using fake numa nodes
> > generated by numa emulation.
> >
> > The "numa_emulation.adistance=3D" kernel cmdline option allows you to s=
et
> > the abstract distance for each NUMA node.
> >
> > For example, you can create two fake nodes, each in a different memory
> > tier by booting with "numa=3Dfake=3D2 numa_emulation.adistance=3D576,70=
4".
> > Here, the abstract distances of node0 and node1 are set to 576 and 706,
> You mention 704 in the cmdline but then mention 706 in the following text=
.

Thanks for pointing that out. It was an obvious typo.

> Please correct the typo. Btw I am not entirely sure if this example is
> required
> in the commit text here. The Documentation seems to the right place for
> this.

This example is also included in the next 2/3 documentation patch.
The same typo exists there, so I'll fix it.
