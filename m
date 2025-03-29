Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF7320F;
	Sat, 29 Mar 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743286643; cv=none; b=lqfJstXsXgKe5KOu0Q93wF7E+seVr1uCd87HFwS5RDttI4exWHHp8FtPav8kQYonlYGbWiXYLIGTgTaezs7I+U4x0RBaHh1rZaPoFro/Hq0n82puziFXbxrylD6c35CWuWLyHuaDltbC8LI2S6kdycTix6+jI4egOVi2v6iRGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743286643; c=relaxed/simple;
	bh=UvIK/d4Xkha/D5KvLNJxg0oBr4V25FyQWDIw8sL+8DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oi+fMlWhsKWB041v7F4IKToxc7fh5nRkm0mh7r7O6vsUSv6B1LlYeOLvN2Pn2ykEuxpvbxcGnsO04NSDT6+LbLrAmHknyabbU34nD1Kfbw+c3MHaKGYc2pt6T8+6fvSe3aJi7bZllBEwY7aspt4jMAsG8oS5Ef9sDOiv3/QTQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntVdH4Q7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntVdH4Q7"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e91d323346so36250916d6.1;
        Sat, 29 Mar 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743286641; x=1743891441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvIK/d4Xkha/D5KvLNJxg0oBr4V25FyQWDIw8sL+8DE=;
        b=ntVdH4Q7VweXuTS8ThtSSg1CjHW+XHtlVI2Wu0p2ysvSpRtpcsD2l3vpNKTGqlqUDT
         gul+m/NvxMazcKyeTKRU+Ub0fk3Z3b61XREeCzIaH6ZZGsrMvcKO7DLHiKajkk+aKNWB
         SqCk2Au61Mru8NVaS3v4I792eYV8+FEZqEAn1cA5sE1XpZsqYQGcs7O3jPpzRbirB88I
         a6/FfWEoN7NI26zL+JH7cyONtTnkZqJsjN5Rx72lF7r4eXBMgBZHmwCYnDpFfXdMgBpt
         PybajbPODwtzG2Pj+X24cxISJQZq00p841h6gbldCVUwkIbt119Lnn7xVkHkju8JP5ur
         5iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743286641; x=1743891441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvIK/d4Xkha/D5KvLNJxg0oBr4V25FyQWDIw8sL+8DE=;
        b=uNfLrfYitmXY0kku+VwZbj94qO+j7rz1qGvsmPwbCQy7MOMeAJCh9GyfRDSWJMu88H
         zD2veTGY7655vthdoTdlnnq2NMf/zq3dsbDZmQ6IngH2jdKgO8rHpgTEY/fUXq9+imB8
         B20L3P1rYzVRknFLNLIT2BlCxkKAnYgnzdHWq/VBsZlyOuCk4SJvDPtMrS9WiCB+8fYz
         4ZQQWvap1bBJzkaS9pFbYv/NsgBzjwBcnnwDnFGgwGpWodx2bsSvqc10TlTC/jopCIWj
         ItsD6FbIeuIMCkKVc9Z2Tj1XvHdHknP6YOREQWQFY+tVaohwAlFNv/kuBAlpGwzTL/Ua
         XMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUG01mENjB7Flvva4lhXR8CUOQcJUCWlgnFjMj9w18WGPUR0USyMZkL/LPPLxBtr97JUYBkXpe4ypUUPA5r@vger.kernel.org, AJvYcCXxKqppRejK+9QT9M91NHH6fNjPY1owK4hNOnh7Ne5QP4MFEOq3eK6nRFieCcYgejFsZdsuzH5hAbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UX6BPE3LukH3ShjGrl9OICHXeM1bJ1QqPn+DZJgZq1cV9wMx
	ts7pi0WPdY7LU7jO/KR+6pO4wZdHO33F+0S/Iwhrxdx8wh0sotfvkIFzEM5XbIEweX+vHCB0FLV
	R1F8olecRmBv042dezMndH2NoEys=
X-Gm-Gg: ASbGncsA5gGKXhlbZzpfS+XT/FtuOhIcJx+5QXzkmmLCd1FMsqd3yg7mc6sPP8AiuhT
	h8imjZ+qn/yVlPYz5zmGF4Z9/qFsorqA2YBMBmcJPkPWLjD/v3CxLu2qw7V4f/8XKi/i8tPh5Tz
	hXWhwUI0OXizKIeRR2raebLf7FfaizelBSZPRNZkJo+miM2Ydh23Z6e29dPG6M
X-Google-Smtp-Source: AGHT+IFgqAnstVbpY5OsRqTab9sqWSD6RcWbVgLYmcy05pv5yGWMotMVm9cWpXpTEfX8SEZOslrhA5QU5vha2t4IEb0=
X-Received: by 2002:a05:6214:224e:b0:6e8:903c:6e5b with SMTP id
 6a1803df08f44-6eecb8b6662mr120067086d6.9.1743286640987; Sat, 29 Mar 2025
 15:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329110230.2459730-1-nphamcs@gmail.com> <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
 <CAKEwX=OVRaUcD8A4HkCZWisNPH+Q9VzOGMJeHnOi40AnHsjjjw@mail.gmail.com>
In-Reply-To: <CAKEwX=OVRaUcD8A4HkCZWisNPH+Q9VzOGMJeHnOi40AnHsjjjw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 29 Mar 2025 15:17:10 -0700
X-Gm-Features: AQ5f1JqX9oRtDWYhVg0RD6L3E4UdowlvThsNQru7euc3UURIohF_N1m3OhbP58I
Message-ID: <CAKEwX=Oijzw-JHrhONK-Fjm6DwC7NkEJbOkAh-2HTV47xxw4UA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering systems
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, gourry@gourry.net, willy@infradead.org, 
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 3:13=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Good question, yeah the knob is to maintain the old behavior :) It
> might not be optimal, or even advisable, for all set up.
>
> For hosts with node-based memory tiering, then yeah it's a good idea
> in general, but I don't quite know how to have information about that
> from the kernel's perspective.
>
> >
> > Or maybe if there's a way to tell the "tier" of the node we can prefer =
to allocate from the same "tier"?
>
> Is there an abstraction of the "tier" that we can use here?

Maaaybe "struct memory_tier" (memory-tiers.c)? Lemme take a look at that...
