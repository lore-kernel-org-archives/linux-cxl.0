Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B974D5A3
	for <linux-cxl@vger.kernel.org>; Mon, 12 Feb 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775723; cv=none; b=lNrIE7ZaolaGCXrXffbjbGwQF/41TNoxcF5VmbtJU9Qu4YKMxPbsg6hdmOBmpMqnt5cUeD5bil6RxPyAajvtdJqfkmIgNYv7m0mmVW2LOi+yqZh7bZaYVYquAsI5UgKre6L3VFfxDe5jN/j/iXj79v/2O98Aa3qZ6yLXy18orxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775723; c=relaxed/simple;
	bh=gAbe+DaZz7ho9Xs/O1+sZUd+Q7Ss16k+L7gT59qsNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ5bCJOA53EzQlxHh9DxrcU3h0FTEaxAta6kabaTASGKPZh6P1UqlwmeisyN/9tVRBJtkexGiJ6G+Gdxa8qdiuaNgmgMi0J0gX61t6FADihCaYpzgqpch3upTJp4reNfkGB4ImT7uBConR9aaSg4V1ihv70RH0tn1owHTn2LPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uin792MN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uin792MN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26fa294e56so497302966b.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Feb 2024 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707775719; x=1708380519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=Uin792MNjE0TRZnpj2U2D67WjrUmFSXtD3Q/ir6YODqIQtH0gzeSGrurZHjIjayIsi
         fUxkxJ5uK6DZs+M5lySFGq+r+U4gVbSN+3ER81p2+EVre0TRetvLAC2D1CdQw2jp1Vyy
         8e58BQPUuzuewQz9M2ykJ6QIvxcJoL4zRQ1Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775719; x=1708380519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=NpgDQ+oVta9fGwBxnMBiEtIWcd2XoE+SSn4FN9SIufJ/q4q2bMoA08rm+TzlhIepo7
         h2S1YMvCTyeVr9pdkOufdHJ8MrQbREOJSkshyH2UrP41LTVk4/lIQ3wD8OyU63KORbQ1
         VcuyhT87hHlDAZZBxeBhcugNxJUc057CxSJbBs7sRv2eMG/+2a4tXun06Lridp/fFXFF
         l1vYUnW2KK5Jcrcd1e12fJxZX2ohyJ0HfsSAR4oDvzBsdsUuYi/bkk0cuSrc7EK45bc3
         wdtKqmuGbSydpAQR8h7bPEbXeLVNV0goB8rbnWfQpcAHLM606Xws0LHbbDWu9AokUBqz
         epQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/oXuhX6vXW7cXZVmR+UPflR8O/4CdxyclP+gN6oVwcYQ3P86PmcEDF+GAf+LDtuttIlnuISyaBOK/umE9K2uhhWB3IV5cIBwV
X-Gm-Message-State: AOJu0YzaN9CX2DtG3KHLaymwSlLYffD5wHsC1tDb+77QTYT6mofitkZK
	IKwPo1LETe+4gSlTZSNQPbTQYwyaoA/LYpCNHz5VXd4EpS71rWTKFNv3LO7wQTpI4bcqQVk2Yat
	97Gk=
X-Google-Smtp-Source: AGHT+IH5a3idkb2Yb19tBvFD8lB2aOBO3cksa0KKATtvI7DpFrjw9rvNLCBsGjbXfI2xqtwuC5Uhzg==
X-Received: by 2002:a17:906:b855:b0:a3c:1070:8054 with SMTP id ga21-20020a170906b85500b00a3c10708054mr5180095ejb.10.1707775719514;
        Mon, 12 Feb 2024 14:08:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxMNADx4LMB0uXaYefOKJ5ZvnpycrrJFczMmD7u8xXKEiUJLb9+sxPsNV7CF8Vom5NXARvnkdkXeeDgTRWKTqcTA3Hq0P+HlK6
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709067f9100b00a3c89e226f7sm611452ejr.181.2024.02.12.14.08.37
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so4125546a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Feb 2024 14:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd/UXDznZmnl+Ywf3wg3V3bd4uQ1/0jodwZluaKnWcC6CoyqZ2iLWR6LxlwZviwyJRDQVMf4JGGTQAY5wRtmwrcK5rH99HHpvO
X-Received: by 2002:aa7:cd66:0:b0:561:f173:6611 with SMTP id
 ca6-20020aa7cd66000000b00561f1736611mr60172edb.35.1707775717604; Mon, 12 Feb
 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com> <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2024 14:08:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
>
> This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> and put_dax()", know how to handle a NULL @dax_dev. It is still early
> days with the "cleanup" helpers, but I wonder if anyone else cares that
> the DEFINE_FREE() above does not check for NULL?

Well, the main reason for DEFINE_FREE() to check for NULL is not
correctness, but code generation. See the comment about kfree() in
<linux/cleanup.h>:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
 * kfree() is fine to be called with a NULL value. This is on purpose. This way
 * the compiler sees the end of our alloc_obj() function as [...]

with the full explanation there.

Now, whether the code wants to actually use the cleanup() helpers for
a single use-case is debatable.

But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).

            Linus
