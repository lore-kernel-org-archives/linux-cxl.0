Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E916EB71
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864778; cv=none; b=GhrjxVl4U5Twgy8kZVOQ3jPeueyb/g13JvwtvQwW+bHXabYTDGQjgajmzyCtxjVxhdmUlY8TmUfG0G7MMwPgDuzQqiDvcQPZrpl8KvMHPiw6jT8J11uLPhPSMBt1XAea1tTixILofaTW5oaqLbZUooZvrevZSXRSPoJ8Ld4jk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864778; c=relaxed/simple;
	bh=JWW6i10o14tA7nKq1rdC26BKhnHK1mj20kxFbGnYJFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIKwE+vSysQ6JICXy4rt3pRpMRN+mplfou3i4Dih7n9l4116b7j0SYCdGDAXnzYQ8+rmxrSYjD6JXUNI5xYkVaJn6T/FpDRM/BhZM3bCAehJJJK6jbQMHuwF3j8Fw05iYsCn6zKAMbqrpz/8E7IV9tiCwp/ODLtNOYDEe2PKvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZvIkGqhh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZvIkGqhh"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso97918a12.2
        for <linux-cxl@vger.kernel.org>; Mon, 01 Jul 2024 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719864774; x=1720469574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WvzBRS1CMcVWEfQoOMswdRT5WevnjDPPSLpXskwxbWY=;
        b=ZvIkGqhhn99ZXuvqiVMxH/dPaXhGdCpecXryQp4NRi9kzqkMG9duaMvBSMu1tqE8o/
         KjrzKnfjLIFJIoHzpx44YEPzpxAANDUsgfVKVHDkEiUu3LYMqvPfvKdDCsL3eA8P0n2+
         UcjgpPwln6zSu7j1FCJwhmbIha3vAnysV3njU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864774; x=1720469574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvzBRS1CMcVWEfQoOMswdRT5WevnjDPPSLpXskwxbWY=;
        b=aNNbg89a4i/os4qcEdNRVJOhkhvv+9y2KtaaP0ufIJSUzuXzwsr5DAh1wZRfrdFu2K
         0F3Fk/A4bBktqCqS2UogHUO5nNF3798X33tIQD/vFLpfdG1/GAct/asQUWSlyCiuzTeW
         3rxHfcjRr4Zm7JD9ASUY7W1e+ywr/zfRSjiFLBCbtBOczWgcX2W/8uIFdmpqP46mzahb
         Pfde9qmnPrql+tebA8r1wA2nRJ2CYCNNq5PUSt4RcwerfFhrM6BGPRCB0ixFHTRdpcEC
         ZSbla9V5EmRjJ9P4KoVRIbLXFsSkhetUfxxmJpLZkSoBSs0+QGP0HpDU7iIAK7Qi7wyf
         d9Ig==
X-Gm-Message-State: AOJu0YzjIPUBMJcvzA8fCxSpk4ij/qkZa5PbA2Uol6ZklJlgM6zrBoeu
	NihyIfxvV3tQopz4S6K7s2B2LyxxWIrjbNJLm8iGYt3aCKWCHQcVJdPvbmOTM9JXQD/ePojzl25
	X5hxrow==
X-Google-Smtp-Source: AGHT+IGoUGgGvdgMSYHZqsin3nkxyA0CGq6BTuzxrSBSZXW6edYha6xWZHVkTqwnrOmeOxoTuJ3RsQ==
X-Received: by 2002:a17:906:4696:b0:a6f:c43b:82ce with SMTP id a640c23a62f3a-a75145626d4mr506278266b.75.1719864774304;
        Mon, 01 Jul 2024 13:12:54 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7516310768sm219224466b.218.2024.07.01.13.12.53
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 13:12:53 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7527afa23cso169897666b.2
        for <linux-cxl@vger.kernel.org>; Mon, 01 Jul 2024 13:12:53 -0700 (PDT)
X-Received: by 2002:a17:906:81cd:b0:a6f:5f8f:6c43 with SMTP id
 a640c23a62f3a-a751451373bmr508949566b.56.1719864772813; Mon, 01 Jul 2024
 13:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
In-Reply-To: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jul 2024 13:12:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ1LH40w-iSkXq7EbCDfnt5_Z4rLvDa4awrqMOTZqy-Q@mail.gmail.com>
Message-ID: <CAHk-=whQ1LH40w-iSkXq7EbCDfnt5_Z4rLvDa4awrqMOTZqy-Q@mail.gmail.com>
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc7
To: Dave Jiang <dave.jiang@intel.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 10:53, Dave Jiang <dave.jiang@intel.com> wrote:
>
> A fix to add proper checking for CXL region interleave capability during assembly.

I pulled this, but this should not have been a post-rc6 "fix".

That code is absolutely new development. Any interleave mis-match has
never worked in the past afaik, and this really looks like a new
feature to me.

So I think this should have been a "next merge window development"
thing. Fixes are for things that have broken or cause acute problems.
Not for "this never worked and nobody even reported it".

             Linus
