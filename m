Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C313C67C;
	Tue,  1 Apr 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743470035; cv=none; b=Ppymt5knpGiIYqQkno2IjwrkW9+29ygVLHk7SkhVT+v7X2MKYODLG0gutsChF5v9H35dbGWgZow5ERv1i77+8S5ij7CF56Y3LB0cw8MN7qo7Ebki62pEmg+rm5srXhtu0TNyt/AxTGDYOJU+62f5Kv4gswr4rcoUDwraRvZowjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743470035; c=relaxed/simple;
	bh=9V6gALXQNYdhz5TmaBOH6ma6nrpJil+JKlbs8/kqK/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCA2e8Xnb0xi7tkn7kuSrHOIXpPqmvDoeZtrPsDxJ0bB/KV6E2GwERdplJCN0WK/BP+EW0Jw6R5ZVC0oabEQJFjOeUGvq0NVN9foWYsY8bm2EH5OsmsriTvxNJVTC3jj5DYIKZyFmmDZu6WqJSl/ywYylTAs3m1dIZyznNpo1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aySm72MF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aySm72MF"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e90b8d4686so44796356d6.2;
        Mon, 31 Mar 2025 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743470032; x=1744074832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V6gALXQNYdhz5TmaBOH6ma6nrpJil+JKlbs8/kqK/s=;
        b=aySm72MFisC48aB3IdkH+0yxD5OPMLxW35pGWX7DRs3FRaSzOBOD2cKNXBrjbiFApv
         xHCJwPrZBq3IxYS6YNHcKczP8mQaiAxhSQpsUIW0uTsBR0fuokAVPAPmQknike7ywk1I
         E1edDyJreLpd5u14SJae8wMXqi5/5WunBxsEkSMLkvtTn0jcza6+4VcDPrxvEyKRjZ+G
         uA7IGuvV1XXkAXMJDG7CpQAmmPemhHnDLWdlKh86tckQt8RKsnUMdxB1aWIK99cOJjhy
         tIdf1rIFmDC9Wtcu3w1YxU8rwcot5CV++aFtTQMykMBo2CzmmRrQccM9QktYVqxGMr4e
         SzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743470032; x=1744074832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V6gALXQNYdhz5TmaBOH6ma6nrpJil+JKlbs8/kqK/s=;
        b=JMPMul2SHqYSTCSjKiXSdzOiMYUkzwLgVNHAnIaXObz0FamfAXI365zg158IDAS/Nq
         zO+nIoOXENtr0YwasYFsjDZNtCGdH0i/0gHeNnh1MCaY5jpAmTg5JJFve/ynZtp3EhAr
         PMhn/Asy8XKQhSHf8n3vVAaGWJpdYbQ481GTBDR3qQ8q/vXzBcYHl/8ChlHE9wge7rEL
         2tf1H8NYSUPEabPbu+MKfzGq1R3mHnH+6mBCqzZuFWdXBKTNNVO99cHILRpryBcw0LNb
         I6wyrGGEXo88USXPBDFp3nNnEju+AiVmFNHLhb/ryA2dn4NoOpmcJbA91zDnH5MH1EJp
         /zzw==
X-Forwarded-Encrypted: i=1; AJvYcCUHYe0899zhYW9yfqPaSyOmmIhhc9nU8dA0kqJliUD0sBhCJJlJWaYR/A5bGiB1U1qjpcToOI6qdhATfcDH@vger.kernel.org, AJvYcCVjR0Csgb4vO8V9U29DQlCL5SjAvhQgNziDUNoQE++Akx4fiH0zDT9AypuV6UofD1mJki29Jq5KCxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqFNIp8uF/D1xIVRnAHIlzvO7AUTbPS+0T6uZINZUR/opLmLX
	L355/7kJ8pm7OvpP89AzTLU8RwnllRjpj0eyr3/3g4gx5wfHlIr7q+xXfTlsKXMncAvY26fZzJG
	xtY0xyUi+Q4AOOQ4z/rIcFisF4d/hkcwO
X-Gm-Gg: ASbGncvFHoNx4YghKXTyO/pBg5ck0xwTk370d0/u2e0GeOc87yoyPrK8M8dpyXzqbYO
	tpoz3YrM0qCft41X/J+wW2QhcBEs9umShGSNLvdEV8kTJ8IbZ1eS5O/ZHLsOZbTeUX8ty4Ikc2o
	GKbxr9dp0fVozKoOhEBpX0rQN/Rg==
X-Google-Smtp-Source: AGHT+IGczQt7n85+GajfuJEx43dpr5UsqwDzByhTbFO0RDOS1lkyVzr0+4hyaEsExSpG06CA7ZTG4IFeeibLL8dcmeA=
X-Received: by 2002:a05:6214:5185:b0:6e4:269f:60fd with SMTP id
 6a1803df08f44-6eef5e45d14mr20185076d6.23.1743470032357; Mon, 31 Mar 2025
 18:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329110230.2459730-1-nphamcs@gmail.com> <20250329110230.2459730-2-nphamcs@gmail.com>
 <67eb148e1f818_7baf294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAKEwX=OEQKdoWbyAO=LKE--ssLzBH0UVhz3EYaCiodpbMtQvKw@mail.gmail.com> <67eb23cbcd0b7_11987294fd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67eb23cbcd0b7_11987294fd@dwillia2-xfh.jf.intel.com.notmuch>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 31 Mar 2025 18:13:41 -0700
X-Gm-Features: AQ5f1JrJGOvy-PDvwAtqA3caAgZR_fWoNj40h_LFmhLE_INmWOy5f2BIOtp8Vgw
Message-ID: <CAKEwX=OpOrV+Vy1QV1wpX6QypVmP5wkjtQ7-5PMoF0FRuVD=zQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] zsmalloc: let callers select NUMA node to store
 the compressed objects
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	yosry.ahmed@linux.dev, chengming.zhou@linux.dev, sj@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	willy@infradead.org, ying.huang@linux.alibaba.com, 
	jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:23=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Nhat Pham wrote:
> [..]
> > That still leaves zram though. zram is more complicated than zswap -
> > it has multiple allocation paths, so I don't want to touch it quite
> > yet (and preferably a zram maintainer/developer should do it). :) Or
> > if zram maintainers are happy with NUMA_NO_NODE, then we can
> > completely get rid of the pointer arguments etc.
>
> At a minimum make the argument a "const int *" so it does not look like
> the value can be changed by the leaf functions.

That's a good idea! I'll incorporate it into the next version.

>
> ...but I would challenge zram folks to ack/nak that change rather than
> maintain old behavior based purely on momentum. I.e. add to the commit
> message an "exclude zswap from this policy for $explicit_reason"
> statement rather than the current $implicit_guess that the old behavior
> is there for "reasons".

Yeah I'll take a look at the zram code. There's no conceptual reason
why zram can not or should not adopt the same behavior, from my POV -
it's just a bit more complicated than zswap, and as such would require
more hacking. So I'm leaning towards making the minimal change
required to support zswap first, and letting the zram
maintainers/developers work it out on the zram side :) We'll see!
