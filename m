Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AFCA52
	for <linux-cxl@vger.kernel.org>; Sat,  3 May 2025 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746232083; cv=none; b=KRFg56mzUU9br5FnrWEwW3n6SBoPK0W7Ujt+gguI45V0iH6HnUzrnuZvT7Ep8cHNbletYbM748zWTvrEjKhGBxw+zbTw6Mvw6CS4gx0IxpWPjXqGMouxx446NyemELpZQgS17yASNz7oiIxhSSnW2cIvdIW/k2pxRo/WmP2/FFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746232083; c=relaxed/simple;
	bh=gQqpjFEGTESzcQc3cHLIM8wYkUkAS2w/iH2qcHSYAB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAteG54BtE20GPayacreWKQAIJJwfKl4/H2ide6oQn+JgybjKpDCGRY9/ty2GDaJjCJjz8Zjm7eB1QktPPWwdbedwJkmlkiwF1Z14FLyARxQ3aml1nXYtQJ7r49+AcRKDrYudK/2Ti4FVIwDvdAxmuXh45dYNAjehL0IdfTOqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eMu15kIh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eMu15kIh"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acec5b99052so444170466b.1
        for <linux-cxl@vger.kernel.org>; Fri, 02 May 2025 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746232079; x=1746836879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SaX79mBWYN1pFOTN8Dl1qaA/CePLGz8VEzgUO+DZmtI=;
        b=eMu15kIh/d9ksgeEJFqSeI/Ga+mum8SDbf9WSgi+IBqjKrZEirDf9PrvmGtgwpG0fK
         MlQvVGXGLjOxn1WJ1/mm/RYPmRS8NRwMp/oH7KI7c8lFICpDYjGmSZwjL7TeZCUvuwVl
         nhFm/hGSsZCXDQ/eIYeilx4dlRSL0tO8MY9Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746232079; x=1746836879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaX79mBWYN1pFOTN8Dl1qaA/CePLGz8VEzgUO+DZmtI=;
        b=OJN3TQ+1exBLgGmaZ50MEFMwLhxZZcJ1l6p+RQx3QmW6dkI8kAHxoOP3XctNCvFBHD
         kxH/DTdb0wenmc7NPAlgM5QumAr3PHbQHWhd4r/nqyoY/eO7TXwm0X3xDE5TlAs4GUOY
         XNVHFLDNaPSO8mTESzFXXruQnWdsUY6n09ViDtM9ax80hG98Y21gY85KKzKBszxGFiDa
         ov0DXC0CtwmUfp+ulipQ0ESrDFbGnPcfXWFEKlOwsSz/1BWmDrC7ReakGwGa7DcudqN9
         LI8G5NVMxy7Y5RpH5bwPqxigSEuSES8m8uemrtvO5Ayqs/og2bfLaDb8SS85ld1JxJN6
         5fHA==
X-Forwarded-Encrypted: i=1; AJvYcCUIVirguhwTJVuyZiFIPjmlxhZaWZuixaEpnrDWKDf3tX/3bAm4Fbm671LB+8MwBixpcGCIM+k4F+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVji5TFm1FhxZDuDwY04fFcCD/PWIUYnXqb8roGuY1V7SL1m+
	1bXxEuCI+CASRBH/Ay5YmAHsNIP/yHE9iLuHGa1gcuv6PJb9pm985DDjfmd567qYZCgAN+TIe9L
	PYCQpwg==
X-Gm-Gg: ASbGncvF7rYIaEDM4zeAao7FxO0MSnMhCwMP+JNRV6N88jFab181PCiQMEbiw2zG+Rh
	O1UVHZaGbxpZS3HAwnjcIWU6/ag+P1KU/dNDvriDUUN7htXajNbfXcRB/Jwz7Xqj5wRROAtw0du
	euYJvtHVzf1qdNPULQE00bYo2smLgOWskltqE7UuRdbPlQie5jWcZQtWLGsYuuYrlXML1gjdV9k
	jTS9pBoSR1LmeXHn9h5KEm0axU61YfiZs4GiwcL/cyZXyxj7i5JNh7pyxjpJaPGwQpDXbfc/vPr
	VFIpxQmF0ZlV42W4ZhPZR47PtzB+GdoPn/3hzYSQAzk8u2gx1NHbsN5bKnSDVfbJZ9n1vo1Z/Cw
	T//e7rJz/qlEHhr8=
X-Google-Smtp-Source: AGHT+IG8jXQwG0S47wIRhVP8xwzWNFsZYeY0+Mp8pX50LViL4dd4hhfqiVTHSENXyvyZ0KUrUj5fsg==
X-Received: by 2002:a17:906:c148:b0:ace:6bfb:4a11 with SMTP id a640c23a62f3a-ad17adad435mr424278066b.24.1746232078628;
        Fri, 02 May 2025 17:27:58 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf3ec0sm1867674a12.79.2025.05.02.17.27.56
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 17:27:57 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so3865913a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 02 May 2025 17:27:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8R0mbPqTykopCd3l5Gh96cuLUwRvWt8/c0hA240fhbYZAb46Xo8xVUpnPOmPoVmQezrJVt49toPo=@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:5f6:2758:149c with SMTP id
 4fb4d7f45d1cf-5fa78012829mr4374591a12.10.1746232076465; Fri, 02 May 2025
 17:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502234818.1744432-1-dan.j.williams@intel.com>
In-Reply-To: <20250502234818.1744432-1-dan.j.williams@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 May 2025 17:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com>
X-Gm-Features: ATxdqUH-LQIXIc6u6p011Nom2TN3yeXoWHvmWULI7dubRZjGAyvNHQxUJyyztQA
Message-ID: <CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com>
Subject: Re: [RFC PATCH] cleanup: Introduce "acquire"/"drop" cleanup helpers
 for interruptible locks
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, David Lechner <dlechner@baylibre.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"

On Fri, 2 May 2025 at 16:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
> +       struct mutex *lock __drop(mutex_unlock) =
> +               mutex_intr_acquire(&mds->poison.lock);
> +       if (IS_ERR(lock))
> +               return PTR_ERR(lock);

I do think you'd want to have some macro to make this less full of
random boiler plate.

I'd like to point out that when I said that thing you quote:

    "You should aim for a nice

     struct rw_semaphore *struct rw_semaphore *exec_update_lock
         __cleanup(release_exec_update_lock) = get_exec_update_lock(task);"

that comment was fairly early in the whole cleanup.h process, and
"cond_guard()" - which then turned out to not work very well - was
actually a "let's try to clean that up" thing.

And the real issues have been that people who wanted this actually had
truly ugly code that they wanted to mindlessly try to rewrite to use
cleanup. And in the process it actually just got worse.

So I don't think you should take that early off-the-cuff remark of
mine as some kind of solid advice.

I don't know what the best solution is, but it's almost certainly not
this "write out a lot of boiler plate".

Now, the two things that made me suggest that was not that the code
was pretty, but

 (a) having an explicit cleanup syntax that matches the initial assignment

     ie that "__drop(mutex_unlock)" pairs with mutex_intr_acquire()"

and

 (b) having those two things *together* in the same place

where that (a) was to avoid having arbitrary crazy naming that made no
sense ("__free()" of a lock that you didn't allocate, but that you
took? No thank you), and (b) was to avoid having that situation where
you first assign NULL just because you're going to do the locking
elsewhere, and the lock release function is described in a totally
different place from where we acquire it.

So the goal of "cond_guard()" was to have those things together, but
obviously it just then ended up being very messy.

Your patch may end up fixing some of that failure of cond_guard(), but
at the same time I note that your patch is horribly broken. Look at
your change to drivers/cxl/core/mbox.c: you made it use

+       struct mutex *lock __drop(mutex_unlock) =
+               mutex_intr_acquire(&mds->poison.lock);

but then you didn't remove the existing unlocking, so that function still has

        mutex_unlock(&mds->poison.lock);

at the end. So I think the patch shows that it's really easy to just
mess up the conversion, and that this is certainly not a way to "fix"
things.

               Linus
