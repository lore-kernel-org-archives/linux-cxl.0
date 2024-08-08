Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC318F2CA
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130658; cv=none; b=cB1M/7cv2pUyxcNoUS4sOSy4ilOhfNv77iCD0aau2Wm8zGLdeEGMinFWlsOL6eMJf6d2r2N9/f5hW7oXk25JryBwZ0cVLV1Ewj+0sKiD87c9rf/jl4nhs55L6tM+7P7ETHcc0xsyccl6RqVKdrWCI9h+pjRAAwFRrBYusDW9XMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130658; c=relaxed/simple;
	bh=kcznI73703eU0ObOZKtq7iR/3T9lbNSBrSC3WrZaDn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYxIZkp3fB4V5TzyY+I+pQGjoLC6aDy8yGhEiIlK1dTIveughhikNxoQXTkTVCOAMqHjdoidfqUXigJu7SLoC15qOC8lOWvAyuISRDndEiw1Yo8xLEDjE4NwTrLnwJjYVfpu7NV4qQYG41UuHVCKaN1jMFUP/iYtI9op/WFzUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fnci0RKG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fnci0RKG"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efdf02d13so2109277e87.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723130649; x=1723735449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx18uaar07tjK8QW0faH95Ubd3Yujuqs2CBIHWPUeWs=;
        b=fnci0RKG/4fjljLluLOX3a37meRVr+Pa6VipVb/V+o0z42yfmINbUAMpdb7iqYXczy
         YIW3lMoRG96uNKbi9PJFcO5fNu3RsXCvSoKSE5Gm/4eh8+0Hvdn4PBBGm+RlOqcq+W+K
         cu0mV8R8wlVcoayIwVJMjXHl2XQQh+xxnsJ7JuQlSSxgHUUbzPdc0A5pagC4G+zsIsmy
         yKU8JCEI+udgrnnbv5jGe3ZbFbh2FVGuydewhSe6wn8+bhdP6k/3c0CmcNibT53/8hu+
         a8qydugzMe84EsvJBmM77YNoTjtW/R44eqRyHgTKh4/uCbbLLdHGI46V03sWES+hng8g
         UH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130649; x=1723735449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx18uaar07tjK8QW0faH95Ubd3Yujuqs2CBIHWPUeWs=;
        b=dhQVFY2oRaMZ4tJLN9e8jGIFnMOc+bBCEkvqTd2Pi3ht06CssILL77YiDdKPWYY1fu
         +QvWAxC/CRi1xf1dE6mik6lxix4zdtXc2oMZTt7yFZPFZzULSxQZtDeUvs9cFfT6zyQ4
         ZGxe6VBiEVb3tG1PmInvuNe0xxRU/ihDb4fPnPZA5kBWetUqOHDlG5XKdKKJtQ6YhK2F
         R01lV9fptGe1mM9E6JiU3oMQuFw8EmWGBfbZmaXW8ONqeZMprn42jqBY3jdDdyqWovAP
         aEDWI8SHOXAbUe2lQMT9M7Xnr6mltEVtIGrjJKcTlv2Uq0yfn8Ygstr/tQST6WLsiMm8
         otLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD/H2AwxfkwczpZfGYlVoorS5VO8gNdQyZxLVhUZuOZ28fSp0D8rlMjICYkjCVWFrIT0fwmH5W2jTFuDOEU7zMj6HlMFe1pQqI
X-Gm-Message-State: AOJu0YzVhnHa3wvhD6V/F2pYdjtZ1Kx9MS0PGmjLW4jNX5UOpY+KFSyo
	AWfC2PUz1xPh+HRjbzXVjhuENrtsBHSHfGQuSmqGKK3O8gBWXid3COytEU8HdZHtRbbdDnWIqZk
	nOKLmaQe7tatHbHKNqPIG3O9HaaHWsN4A+YMA1A==
X-Google-Smtp-Source: AGHT+IHQfJk4XwPcOfo9+O99r2JxIMlQxBCThMQWtoh/L0V+CtPk6/Rgp2Ne++2MFrhPmJRgmXKE8nv3eif8DzEPJUA=
X-Received: by 2002:a05:6512:1107:b0:52c:c9e4:3291 with SMTP id
 2adb3069b0e04-530e589929fmr1646154e87.60.1723130648939; Thu, 08 Aug 2024
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com> <66b3fc8d39391_2657d52945e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66b3fc8d39391_2657d52945e@dwillia2-xfh.jf.intel.com.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 11:23:30 -0400
Message-ID: <CA+CK2bCrXqnGPvQP86FpFFfEiCpBSyq_DzdP1deyK8vQ_ZYjzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes for memmap accounting
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cerasuolodomenico@gmail.com, hannes@cmpxchg.org, 
	j.granados@samsung.com, lizhijian@fujitsu.com, muchun.song@linux.dev, 
	nphamcs@gmail.com, rientjes@google.com, rppt@kernel.org, 
	souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:00=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> [ add linux-cxl ]
>
> Pasha Tatashin wrote:
> > Memmap accounting provides us with observability of how much memory is
> > used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
> > It also provides with information of how much was allocated using
> > boot allocator (i.e. not part of MemTotal), and how much was allocated
> > using buddy allocated (i.e. part of MemTotal).
> >
> > This small series fixes a few problems that were discovered with the
> > original patch.
> >
> > v1: https://lore.kernel.org/all/20240806221454.1971755-1-pasha.tatashin=
@soleen.com
> > Changes:
> >       - Added patch "mm: don't account memmap on failure"
> >       - Changed from using nid in hot-remove functions to non-pernode
> >         system-wide accounting for memmap data.
> >
> > Pasha Tatashin (3):
> >   mm: update the memmap stat before page is freed
> >   mm: don't account memmap on failure
> >   mm: don't account memmap per node
>
> Hi Pasha,
>
> Thanks for jumping on this debug!
>
> We almost missed these. Can you update your scripts to auto-cc folks on t=
he
> Reported-by line, and optionally include the lists where the report origi=
nated
> next time?

Thank  you, I will add them.

>
> This is looking good from my tests, you can add:
>
> Tested-by: Dan Williams <dan.j.williams@intel.com>

Thank you for testing

>
> ...but I still want to take a look at some of the implementation choices.

I am about to send v3.

Pasha
