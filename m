Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE3381AA
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192321; cv=none; b=IV+BFuO46jG/tnsZXOo+DRXsYeTbRorFrZetnddQkzHRTC2fH/ZqGZmUqPQseIdW7Me9opEW4GbwZTQKq+RtZdNS4bRkcfJOeFrVYOTvlHeIpNILxo/rC+OQYnC30VyCDqBR+cEWJNah+xAgT+EqriTNjy9BOErWGjqJvB8WWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192321; c=relaxed/simple;
	bh=BVso8IuAy5dBmLZsREfuE4BAwErCtB7p8q/pZTatU7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLw17Hnl0cUtA7/7RlEZwSKOQChV83RBz2zgtkr+RZnivuwfpvbgc9+eL27jr38jVeTBv9g52zr3lr82qwesOtkamxgac2vs32qeSXJAboIR2ALP0YLSwQ8gQGex4V2k+c/bsLvpZQWlgJQ+UDYC4yTRY5WjwpQFe/IFVO3dhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A3muE3nd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A3muE3nd"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3311598a12.3
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722192317; x=1722797117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8VS41G7xmJBjiU0UxdT8J94Fvsi5TIerksY8XI4jAE=;
        b=A3muE3ndEeoYvNwK4VHzUHpi+fAlofnT/JYrPbJ4K9B0Od4lrDZI4oNMh4KrBOi6Ra
         oQukymO2+4bBFPG5w+WtQT8AexKZfdlGrGbnLCA1ls0YtTs/B+Jl5I+/Tl3MIe7pI5LJ
         J1Flfj0zppoNgNOY01LnRSP9rELTahB8mI1F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722192317; x=1722797117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8VS41G7xmJBjiU0UxdT8J94Fvsi5TIerksY8XI4jAE=;
        b=nzbiLGEvLQiHlzqIQAFkx3X/luHuhei95aRE953KgCg+gPm7DmcFztBdMBxkZ67Pvs
         NMG/FQYbW3rwgxTrnhJbgw1cXnXaZpxesA2RCX+90tFP9lngStn6qMU+Y03eeIHYKFSN
         MZdkgQNBVGdVxbyKX5rbtmiAMGDcf3qqxdWbegWtD2ATJ/bqdhsfeS4fhG3jqOcDUOu5
         fDf3FRgOuendhGAqCX9Z1uL3TBJD6NgnXvcE5X0U5Co4MDaoqjBWfoxuaBUblprJs/OC
         JRHJfVZbd8J59MlVWJ6dAJLiZ8MlgIS+u32Ewm9JVbn+me4el93lTNbct5pyvaStJv+n
         elIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdp1Mk04uHm6suzU/cleU6Z2x//kkKKlePJHOWhPsadzJW4zsc0Yod9SOMN/75hBpCnhqDkzBORhPO3+oT4u6ccrC+5unZcL80
X-Gm-Message-State: AOJu0YykwrCyqv+o6JL2YmGGoTjeksL9s6NINbOKODfPd/lKB2dgxIef
	Bl1Gg5EY5efOdR89kPanFvfH3BpGREqHMmgH/PliPc9f99zRcbHbfdfGRzErmfXCDTsPKcELbZt
	Cj6h/0Q==
X-Google-Smtp-Source: AGHT+IFV369A8RPWDuJfFLvCBUUFdOT/xDzIx3MXyGZSC6dbrGhYtyJfJa2HevjJWxJLaVl8WtvWKg==
X-Received: by 2002:a50:d658:0:b0:5af:4c54:3a43 with SMTP id 4fb4d7f45d1cf-5b0206d2239mr3159352a12.12.1722192316733;
        Sun, 28 Jul 2024 11:45:16 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afc05c7a44sm2948761a12.6.2024.07.28.11.45.16
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 11:45:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5afd7a9660eso2477485a12.0
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 11:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJxIXa5vI+RKM7nfzeNWKf2eqQiz6a9tvIr/kuIbm78z2ierJg20YqpvomDZexqWQMhON6ASHARlqfbuYNz6VjG3qdi5msHBhk
X-Received: by 2002:a50:871b:0:b0:5a1:7570:8902 with SMTP id
 4fb4d7f45d1cf-5b020bc19cdmr3414903a12.18.1722192315913; Sun, 28 Jul 2024
 11:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <21dca9f0-639f-43b0-b858-a74317954835@intel.com> <66a68ef9a3798_2bf8a429499@iweiny-mobl.notmuch>
In-Reply-To: <66a68ef9a3798_2bf8a429499@iweiny-mobl.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jul 2024 11:44:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxN8QgA05-u9PHpDQJ=4yttOsFUMSfA4yR3F4EUsWbPg@mail.gmail.com>
Message-ID: <CAHk-=wjxN8QgA05-u9PHpDQJ=4yttOsFUMSfA4yR3F4EUsWbPg@mail.gmail.com>
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.11
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 11:33, Ira Weiny <ira.weiny@intel.com> wrote:
>
> Dave is on vacation and he asked that I look out for this pull request.
>
> Was there something amiss with this or will it make the 6.11 merge?

Heh. I literally pulled it just two hours ago, I just haven't pushed out yet.

It just always ended up being at the bottom of my pull queue..

              Linus
