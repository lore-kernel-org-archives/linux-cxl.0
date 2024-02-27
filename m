Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88613AA36
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066995; cv=none; b=UDR2YDihxcuCHDiwnofk8LcG8ZomDEtX+I43wj3y7qRVGuFhrmLa955fzBwObrQzY97JbbHZPlbtR2ZmoGtZrQTGkZMUqdwA0D3sb8v9U5/TUd7lu3Z9cAciG1dTCjOpbqy1hZSDJGQ3CakNud/1/LrsESHulo89ef2UxVQ7uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066995; c=relaxed/simple;
	bh=p9k/50J2fJtv36WtCUbSmzFiwVLwISsJpimpNmnaOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt7iAAqEyjsfI43RXyi5EVoFSXGFBSi3ZNybA4SZ1KOpRtZ3lacWT+xGLZO0qsV0KQ4CSP6KbY+rsV+Bh8fhBPjsFr/9xV1crOzFpvf2EGjLUzroE6cuWP/ez4itGD8VCEsXBqYLDvGkwwgG1rIqq1dq81CJ0wcnv211GDgEVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N7mHnDdl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N7mHnDdl"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so274812a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709066992; x=1709671792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yi/RZQ8KqnZwl+S2VL1o58Mg6IThl5Qs0hc2x6y80JI=;
        b=N7mHnDdlSqH85ZaFemTfQk9eMgpfdEUeRWT7CHXa8EPKcauFoDCcpaMVyu/YxebETE
         w1F9NBzgpidkkMvZtV0K9R22ci7jz1k7hBHYYhNZWdvRizycBwdPnE1h0s1h5cIBWVhe
         dQwhJd/0LKY7j/VkVx0yJN8rVG1xlBWDfhal0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066992; x=1709671792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yi/RZQ8KqnZwl+S2VL1o58Mg6IThl5Qs0hc2x6y80JI=;
        b=veRLEffdwviidtesJwO7ZhT3DsnV6FSvNxZQu6EB/GHvNWfcIYiB6AVaeJxGvAylqb
         ro8VzxcUPUpDVH5Eyole6K/vCF2KMAeMkBaGfYA5Nosbg8tyliBmW9ez4h7hm5FBUtHu
         gd7D/lIS0MJZ46eu7XsF8mEAQGU2q8BqPxRyiNUuFBFfWH/+oVhwPXY45fFxIzfEeG74
         LKVCXyw+s8HNy95fk4RICptA+azzRMvtZoilbTSVKbMuvCQ9ykLq4P967W5tZgETtAEa
         EcB5QYSLf6J0d7QzsohzG+bf0zwe9hIDJMS+HkxsmLjsM1ee90JXyul7UXuYEreVvHhZ
         c1jg==
X-Forwarded-Encrypted: i=1; AJvYcCWjmgu7tHmhpClZW1XOALdpPMdDVTcegiqOg0HKE8lMFbsCW9ZazEarU/cwDAHP+xe++Hj3tdF3t0jXP0dH/YyoAgZBKrr3ZY2w
X-Gm-Message-State: AOJu0Yy8qV0+mzEqHlZwdQyKLm+HLp5X5FN9AN9MRBr+hadWpCuGacQq
	EcoK9DOVMlqOv54eDnhXc0Y8wXb+LfSaS+NnYOl69U6IAq6EykbYNDFq44yNTFlyXmS/wXG1nTH
	LtkLfQQ==
X-Google-Smtp-Source: AGHT+IH1YagAKuKFsY3lFCnzTt4a0gqxFF9zb74WfxNxLBou6gaz1w6pLDgiEZFMV4W1nOFclXRFiA==
X-Received: by 2002:a17:906:2414:b0:a3e:c1ef:e1bd with SMTP id z20-20020a170906241400b00a3ec1efe1bdmr416500eja.16.1709066991799;
        Tue, 27 Feb 2024 12:49:51 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id ti9-20020a170907c20900b00a3e94142018sm1111470ejc.132.2024.02.27.12.49.51
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:49:51 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso33995166b.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzyJhFWUGzbOdAZCc55i2gg8Ha4e4y52Z2/M14sGHRfQyqPaWH3kDi2n/vP/6s1GdTXpdnN5tDudr4z8zbpjhSaoyRcU7VCk6J
X-Received: by 2002:a17:906:4557:b0:a43:1099:7e72 with SMTP id
 s23-20020a170906455700b00a4310997e72mr375001ejq.35.1709066990810; Tue, 27 Feb
 2024 12:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:49:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com>
Message-ID: <CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cleanup: Add cond_guard() to conditional guards
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
>         cond_guard(mutex_intr, return -EINTR, &mutex);

Again, this is *not* helping make code readable and less likely to have bugs.

The macro has obvious deficiencies, like the "_fail" argument not
being surrounded by  "{ }" (the equivalent of parenthesizing an
expression argument), but even with that trivial fix the syntax is
just too ugly to live, and doesn't match normal C syntax.

And yes, we have other macros that don't have normal C syntax, and
they are ugly too (example: #define CHKINFO(ret) in
drivers/video/fbdev/hgafb.c), but we should have higher standards for
globally visible helpers, and we should have *MUCH* higher standards
for helpers that are supposed to be all about reducing mistakes.

Bad / odd syntax does not reduce mistakes.

If a sane 'guard' model doesn't work for some code, the answer is not
to make an insane guard model. The answer is to not use 'guard' in
code like that.

               Linus
