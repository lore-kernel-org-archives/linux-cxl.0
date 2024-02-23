Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE613B7B3
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711702; cv=none; b=WfG70knaq2etTinw3Cm8JA4VNYj9nK8ebYQLr51hqfBw6TlFGcGNZ053/IyX6kU+5Hcynvc86vAWZ73Z8/yN8TcU7HJBNe/jTbm85AfDNQtx5J08T71nnLZz89tymwmlXLjc/DjP/gbQBZxyFzVzboW7hbtucT5jK4ANRLMxb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711702; c=relaxed/simple;
	bh=l0YhZsByWIrxNq0o1lBKwz/lo3bLpTMXWwd8oAy0WqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N54D8wr+4djganE+C5KqnKmO9IF7sLeShsf4X9elgfRC396kJut8ZZgmjCuHKznLAbVflsTvnrd69IPVk94qQTznoWHyc+qETRFX2lDYIxUj/3uASN0zNPSNE0uyOJxzQWm8h/kEOZ7TAvGI/9dZIaPTyYaKoGNo+t/cEh6FnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwPx40oR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwPx40oR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso1725910a12.1
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 10:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708711698; x=1709316498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4KlUf4NvI8CaEz8acJMhi7UYxE8P+SRzNi66VI/NLA=;
        b=AwPx40oRIcBkN5D9MSJV4mwPos2myC7Wub+pQUG48x2gJ2o6jurIaskMu9QvnAYtBN
         F9buu9T4YqDxflIcsHUsNu1A9LSC40f6Z08CLKdixMnmAaKgDQ8L5jdLnvoQOScsdVaY
         Ypb+/EXWXEiYYuamblzg/IcUDngXX1Jvumm99fllA2VHftGmf6OtH9iKdX2GCPZpGEkn
         bbC060bhvSaEuaqSdb45lmvY/YWvHTWfvNRgrSxTHK5seF4zYEtlfZICInCMARDz/CDx
         4xerXRGlfQbMgdydLDlY4JFIbFfzvbD+qxIyx1ssQPD6ZDRCcZ0di+fwLDWNjJqknHQG
         0eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711698; x=1709316498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4KlUf4NvI8CaEz8acJMhi7UYxE8P+SRzNi66VI/NLA=;
        b=RI/ketTs+0jWpcJyOd8pBHWTqckqBxZY+2ziitbzpoU8rvUQ43crZA6ji6liWdONQu
         Cg5RLUR9pD21UoMm21JRFT+EOLfaXRft8RLEZ9bGD2ZD5YYDiuuJK3+qic6IN/YjTsKG
         HYc94AB02zWdG41wprek/ckIlaOMtoPhI8RLTNST4gW3SKKpTdwLhjgl3J9pjI1m1LeO
         4M4ETvNucsRAsarmWXA449ggHiG2his0/d+jfM3ya2GeL3uncuwTx7TKZuOPwKVwATmp
         98hbCRFJ1uHpJr751IMrpi5m+HxzlxSRbEhGj89PDtqyA7rmDZ8rOfUFAUsDmTvXmlnl
         KB3A==
X-Forwarded-Encrypted: i=1; AJvYcCUTj7fsUCZoRF6JcBBDZX1arGTrbw8ho6GHldWoQ+NuCdO98w8i+Achf9cz6yIPI7gN6GiZBgxO0BircS5MzU4A5NoJWi3u+Pq7
X-Gm-Message-State: AOJu0YyVV8eiV4jY9kuhIgEZbN0t5W97nM8s/vNqoMbaPS4RfBuGDaFC
	s5ULVE77Lyu0omlcIJJOFAmimi1Pq+GYojd2yP+zxwb9jKezzPF0S3xyrvhncOKeefPBxgWo7UV
	UAQxKvQD2lrqug0lSi9vd5I0gpDdXJ5U1WpdQcg==
X-Google-Smtp-Source: AGHT+IHTtL/naajQPWYkAVKf3/gHgybRpPeodwPovbg12I0GwByOVkI3/m6D/uRGouLZG4+LJ1fgbRlNKd/0v/A96rg=
X-Received: by 2002:aa7:d0d4:0:b0:565:76b6:920c with SMTP id
 u20-20020aa7d0d4000000b0056576b6920cmr349720edo.9.1708711698452; Fri, 23 Feb
 2024 10:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
 <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org> <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
In-Reply-To: <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 18:08:07 +0000
Message-ID: <CAFEAcA9bB5JVtRAu0+P+6=DzOXQSzLoFJaodRR7Dh80RpoQ+gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
	Gregory Price <gregory.price@memverge.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 10:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 22 Feb 2024 at 21:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 2/19/24 06:12, Jonathan Cameron wrote:
> > > I'm far from confident this handling here is correct. Hence
> > > RFC.  In particular not sure on what locks I should hold for this
> > > to be even moderately safe.
> > >
> > > The function already appears to be inconsistent in what it returns
> > > as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> > > value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> > > the previous value.
>
> I think this is a bug in the TCG_OVERSIZED_GUEST handling,
> which we've never noticed because you only see that case
> on a 32-bit host.

Having looked through the code and talked to Richard on IRC,
I think that the TCG_OVERSIZED_GUEST handling is correct.
The return value of qatomic_cmpxchg__nocheck() is the value
that was in memory before the cmpxchg. So the TCG_OVERSIZED_GUEST
code's semantics are the same as the normal path. (The comment on
qatomic_cmpxchg__nocheck() that describes this as the
"eventual value" is rather confusing so we should improve that.)

thanks
-- PMM
