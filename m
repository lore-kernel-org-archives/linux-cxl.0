Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9E2745E
	for <linux-cxl@vger.kernel.org>; Sat,  3 May 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746241848; cv=none; b=UmETnXC6D43AMgNWsNMz3GlaBD6lOr4JSY4oO2bSTOra4b8PCOZ9/nXCga+Ck2QuDB+mKbvqjKZQ7a6qLDoREV/5JWtL2kQ0UIRKgr3ALrAHNd0L1vGA+3TU7RSToE+hYCtC9o7adeSzJgZrRrLCRaSVv4J21JHdGE4N7hGbhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746241848; c=relaxed/simple;
	bh=EN0BXMQbblm2pZx5uSSWX3+lP5IdQKibivkWHlPTRMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDQkjc+BNXqWx/f3XBwYMhX06Ybb5Bl88KQXy+tTswtEM3oBZv+eUSzG7bEZHITFcHGzYwh4qVIs5fgbA0U6kpTxeslRE/M31fZlGgmtlUZSyek2AGsmCW7mFwthL9/+YDZVu1rQ5FCVThneT0clKaJyebY8at4b14Cw0nYfZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e8o9ufC+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e8o9ufC+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3b12e8518so459967066b.0
        for <linux-cxl@vger.kernel.org>; Fri, 02 May 2025 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746241843; x=1746846643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHHi6z+/1VZ4HLperPawMVsILx8Z+1OmejAc8QEltU=;
        b=e8o9ufC+Iw8FJZPnwXWRnlS5Shp9ttRzRxUjCPI8gBqXXNIKMzRDpNDntv4FGOEVPD
         dNUkS8Jcy04e0/uwQt3Qdfww7/dOGE6Nc9QlUNUWVZ4ZSBRxI7vah5/eVokVlWP1SCHI
         b4B4ngiNi2I1/25lnqf1BTejM1xWZcuXebhAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746241843; x=1746846643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdHHi6z+/1VZ4HLperPawMVsILx8Z+1OmejAc8QEltU=;
        b=SjfwCt3b+/D1u/bsWKcg0T7yWeu+9WF0jviedt6VflVpUMxGGwaNmIgjmSOnPhWX+4
         qcwgVU5WVSWQ+Gq3iF45D20rabTQgRsLCEoqs2Vz66caF2oxLT1Mov3XxurvWuLTjGZk
         SY+NM9Ig/pj8AFE2hv77LUKyLJd82h2HQ7TOVip/oYrjQwHCBC9Q5a9VSfhlDDUBFKw6
         HhK8mo1t08Mv/ZfO/EbFQ4/zlZgwc331aZLza28MlWpmctrYvlyjCHvD82HaLec4ZXhN
         /RJhyghAJnX7cUIoeoQ7CmBoUe2K+aRx+RF3boVoPevy3Q6TBzqfYfF0PhzOP6hL8wnD
         ojfg==
X-Forwarded-Encrypted: i=1; AJvYcCX/WoCF4X0vaa88/aw5ygpQpaoRJQtibPQCKjju3T+2sptt2O9x+ezT0MEfi69O1uRnh4kM2jOHCkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYP244YUhfbz6VTVZwFnq5ivM85xNlGFb0IEi2dQLaWWp9XkI
	ZZBmm38O0/l/l0Cdu5APxXnAlCMPBkJX6p8CGAyaqLSuqZc8M7jYFWv1KP1LkDvY1uum977VZOe
	vfEN6nA==
X-Gm-Gg: ASbGnct1DHhmywHRWOFlp7yeXThv2VcmYBOpTeH9IwnsUD1IrlJ/jgSuGP1bHhV9PEY
	gxNhEQCZnRdQFS3gIX01UKJ3M9nyuEaAPUdw2MQAyMee5xeevHluBZDBigIzXrWZBWVkOH//QlH
	izVLi6UIN+g5A0EMC5f2XGK8Mcl/vxS8sW1kQMHF7L4bIhlVoC2E0+oetfpMTAGw0Ag3/F9uJHR
	/paDh/VbU/MOOkgnME/kTovmW8tTS1f119v7nsaLssuXioES84qrQu72vqbJDhC5hOUmCv/WdQh
	orEBuoMRfbNNkO0+GcxpgrUkzjJO7l95NEYcQwS7iNUcRAle3u9999hOgWy9clWCfUJfDj2Ux6q
	C4FnyKdhX1Uvx4GQ=
X-Google-Smtp-Source: AGHT+IHwMzegq1fYvvHicMnFrHp37pCH9/6ofnsOXORDHlN3ePLtsutxXuWrwRng9vZ9VFpzAgD7sw==
X-Received: by 2002:a17:907:1c18:b0:ac2:49b1:166f with SMTP id a640c23a62f3a-ad17afce5damr490521066b.52.1746241843255;
        Fri, 02 May 2025 20:10:43 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895090f6sm132373566b.136.2025.05.02.20.10.41
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 20:10:41 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f861d16622so4433645a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 May 2025 20:10:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjLBF3BTp7c6H1IsHkWGeKlgtOpD7gTKTDUmw0+B+GV3hNYjOtZ5QpdvhpOMJ4GjitgU90jKoqo8g=@vger.kernel.org
X-Received: by 2002:a05:6402:354d:b0:5f8:8d24:e344 with SMTP id
 4fb4d7f45d1cf-5fa78948c40mr3967759a12.31.1746241841468; Fri, 02 May 2025
 20:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502234818.1744432-1-dan.j.williams@intel.com>
 <CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com> <6815790674f6d_1d6a2949d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6815790674f6d_1d6a2949d@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 May 2025 20:10:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcd6BDN6=SHpf-=BdNfXab3J3p+vvAQAwfsfsemHh_gQ@mail.gmail.com>
X-Gm-Features: ATxdqUFjtXBFQdQ9SDPRybWcKcvnFj1aGEgrY4P5zeumMUtovlIsLe5tI7StKNc
Message-ID: <CAHk-=wgcd6BDN6=SHpf-=BdNfXab3J3p+vvAQAwfsfsemHh_gQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cleanup: Introduce "acquire"/"drop" cleanup helpers
 for interruptible locks
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, David Lechner <dlechner@baylibre.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 19:02, Dan Williams <dan.j.williams@intel.com> wrote:
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e3e851813c2a..cec9dfb22567 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1394,8 +1394,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>         int nr_records = 0;
>         int rc;
>
> -       struct mutex *lock __drop(mutex_unlock) =
> -               mutex_intr_acquire(&mds->poison.lock);
> +       CLASS(mutex_intr_acquire, lock)(&mds->poison.lock);
>         if (IS_ERR(lock))
>                 return PTR_ERR(lock);

Ok, so this whole CLASS-based model looks much better to me and fixes
my concerns.

Let's see if somebody else hates it, but I think this might be viable.

That said, I have to admit that it still looks pretty odd, but it does
look like something people can get used to.

               Linus
