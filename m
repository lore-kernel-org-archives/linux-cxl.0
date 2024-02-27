Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFD48CFC
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066471; cv=none; b=h2+JUkEjSZIbyxRcXglswThReUFI5MTwUvPSukpumBa3J8cdQ/Dp7gEB+pjEjyUHx2qnz6YOR1wVERVClyzC4ubJXJ1JhCGVTJ0dZv5PbAfRlGiS6RxUR6IBknYfaGr5RTEwhLQ5bU9o/OWVDra9sqSSjO0001CO7TDLPJ427I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066471; c=relaxed/simple;
	bh=Kc8/DnEIqj9ihyvhHXZRL9D2xQyaeIUiwEE9a//D3/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHtNmjJ7p5jpnV+kOH4z/5z96tHS3EFwsoSaB9AgMjSWBEP3dYOEbDfG8R6fdfmiVYwZaxrD9/kqIwtNjK0hmTUEu9ZWvEseoHDOAcCslDRssEG4Xn9FoW+cQQKnzwxZq3CjMUx3oftEY8scHb0ySz9S/mQ5G7wujYPAzhKQOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PlRbB+Co; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PlRbB+Co"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so6057819a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709066467; x=1709671267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=juAeacRch3k681Zfd2bjBuM8kFMkd14jsXtMgJ5fuGM=;
        b=PlRbB+CoW7stIw9cye5TOSecpRUaGisFcwm3tEa6Pik5IoTBEh+3IzDopQhTLHKkNw
         Pexm7VxxFYMASzhPoM3KvT6yyul0FUpNlJUgNjsfal2e1AxqDfObyLiCPgcCYnHTN8Wg
         nHgwMVEr0ZrD+yGrZ8G0c8FWFDdRbizKV5hKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066467; x=1709671267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juAeacRch3k681Zfd2bjBuM8kFMkd14jsXtMgJ5fuGM=;
        b=cZ7xwXW2gsUV3dmiTsLGw7FNeYGQzDLuXawOH5qK6f2eKz9tvidEDNJFvXBocw0PKv
         hDvpAHNG+58MKtGj5C7MaIWoVVXCx+TNXuGEL5nPfEejHn3Iug9m3Nxa3LKg0z2S/tHs
         IPcqZj/h6dEL/4sgcICiSDJT0g2einU7oKloyqIGkmPQn+9zQ+rkAetu7qlBzD3oXrqa
         iV6i5VQ5GyjSM9fPveSiXlo9Dd3P2S+dPQIT3Wr2H0Zih6u+A69npVxNZjumvzELnlEh
         7WL4DNgerg356bIl9lnctJw+o34aB290U/NY6b7oOlLZT9magHUf/XlaT3HeKHuFSVVz
         208w==
X-Forwarded-Encrypted: i=1; AJvYcCWdI33ciMfNtveUNHNogatXRFAqYCMDatWGQDFLlyUJLofa6XuTxzfg+of0HgPX+NB+2njJ+69eMd9xl1b60sKn3XOqCbWNWK//
X-Gm-Message-State: AOJu0YyEmNe7khdz6SRj6HhhJ6tYXztdW0BsrBYXCjf2YSJm08FBYjWR
	u8FATd7nolR8OXW/LELvv9YSv95jM7QiPUFvo1qXdemnQHwkoowcgdtoqTiglIw8Ez4WbtHMyHB
	2iFZ+7w==
X-Google-Smtp-Source: AGHT+IEgNQW9eGt4a/cNhFFvMAbKeczujPdV0seFZyi4Qdri0VvvNTEZcvaOBD3CgmbO0SQ4MPLopw==
X-Received: by 2002:aa7:d0c9:0:b0:565:7d4a:1d4a with SMTP id u9-20020aa7d0c9000000b005657d4a1d4amr6985226edo.8.1709066467181;
        Tue, 27 Feb 2024 12:41:07 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b00565671fd23asm1150071ede.22.2024.02.27.12.41.06
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:41:06 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a437a2a46b1so259983166b.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx8vqNpVwfzAmMvV2+iFPoZshT6dQa9EOii7n0xq+JaFYxlwUnSsjCXZjyryQbJFcffAOI69Cr0JWOs5MwU7xQ6oypi340DkRk
X-Received: by 2002:a17:906:b349:b0:a3e:fce7:9393 with SMTP id
 cd9-20020a170906b34900b00a3efce79393mr6662120ejb.10.1709066466422; Tue, 27
 Feb 2024 12:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905253897.2268463.13371523233762430828.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905253897.2268463.13371523233762430828.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:40:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJJf+FwWNcWEv15hXjK3v3VfPLabj-SqQpMk8qLM0xAg@mail.gmail.com>
Message-ID: <CAHk-=wiJJf+FwWNcWEv15hXjK3v3VfPLabj-SqQpMk8qLM0xAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cleanup: Introduce cond_no_free_ptr()
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:49, Dan Williams <dan.j.williams@intel.com> wrote:
>
>     5/ cond_no_free_ptr(rc == 0, return rc, res, name);

Ugh. Honestly, this is all too ugly for words.

The whole - and only - point for the cond_guard() is to make mistakes
less likely.

This is not it. This makes mistakes unreadable and undebuggable.

             Linus
