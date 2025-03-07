Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9C217F53
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361042; cv=none; b=dLLU8AeHhULgQBooZfHZovPwnAka9TREgv3XmG09VyjV68e2xpgytSrDGdaIXMXyK8pjlpKKuVbHEA8OdEfbR0twqkygDMo1LTxJxUx16eGke/sakihYUaKa+zk6flOMLsgWmcNktO/7wtj+K4Ib1xhSpIDZzV+CB3W6gGYUn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361042; c=relaxed/simple;
	bh=5Ddx+q/c8SbHR5ZT9xmJ6bE9u8Ymk7ZsCh7+4xJviHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp9iJP+04peoKEn/2wrVu5HkvmeH8/YeGAp1clZ/VYZr909WNoDPtgVmvKLlSBRHR8ero+xFVIhCK5d1pxdRLl2ymZO/PIuVZDWtd1DVGfIO56ZXgUb6YltMwJOLkQQEs6XHLZfhX7fzY6eIKxSKW/+0ugelvLe1unAe1ELpMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ieGIXdj5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ieGIXdj5"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8efefec89so15674076d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741361040; x=1741965840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQDpIx1LDvx0gmjHl2Xaz7imPvceKHnW6AENwjXSx4c=;
        b=ieGIXdj51gCe/pxJ48hZUboCeQrIJ8vJDBp7Bc52ENUyD0CayeSVkl40lUYLjibZou
         nGqhHYUHFziGL16GuhKEld7GXGF2V4LyZAq70idH3UyNb64RndbEovjC75iEkXSWeMfz
         M+Ksk7sGGKtLVvv9fsktX75bz9ygqba3XUPijXkQ6Ao9FmNtpUnlfJ0dDCLitpV2KX/G
         X+uzKEP0AVYeT13RE1ve2tXilVktPH9LAOHNW5/A/T6iMCgpH9WJBvzSZ0XQsNw+7Yt3
         SEE/Qom0BCHiiHTxKjNQTC3skjEYdeJZKxIrr+waIpikdqo9sSlYBe62BLexPs4C8CHj
         WVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361040; x=1741965840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQDpIx1LDvx0gmjHl2Xaz7imPvceKHnW6AENwjXSx4c=;
        b=IOkUZW4TnWlPtCJFPY3QhzejjotdS1LCCz66elylnQzb8ivxuPh5erai2kJbGl1Zdd
         Ukqg6qXb40gKLW/I2d+neN3KAeJkU9FmoF0CzOX6M8sINfsm8KZLnBsxxJoOBggPu2Ep
         +lnv/Takas20Tt7VbNYDTLGXYbKXLJ/eAjruO+yTl+/lIJvo9ojX7aNDk9eShicKwf6L
         nobR5CCIk15JyoNhMP0nRIfJvjCdcRGkUPsfLtf/1DI8OlwUGvGA+165lfFQY0fcDhoV
         mqUg0pp4bGwEls6+8eROAYO66BA/bgAVeCPtu2q9xIhjZDBuWObscnm2fwPOWWzEjZjO
         rMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/YxM9kbBjlgseEk7D2Iwz6pV8lwIOsLzynM9HWYqwHF7y9aKiUdszFp1y8PrHDuYfhDEFFZ7qEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SFN2ra0w3Pcmb9LiWFlW0O08XuZBwX1P+ekuBu+DOeXHJnxm
	MSKRIOwCNLEJ1GkCobKWbwpPQUuPQwwZkP9IeZsSMtRIK1tS0S63FE2JJo4MX4A=
X-Gm-Gg: ASbGncuSaO15vAef/fwidhMGvpks/zbOfgkY4Iozjv8AhH3hpoa+QlkRvk5Yr+qa1rg
	ztkmaY4kIz6OqG1OywjUoVxsxLZwz9ZGadODhNg1bRPd6+6Yg/e30mx7gSduxy4nNkHJrOJM2/t
	SsqYxKwGhhX0dNqb0y/O765lsKbiZ9sce92htmE/Zu3VULbH2ABb4N/GAUYX86iS5XbjITyMwBC
	CW1q2xaaK9QqTfd79LJhyqw+xt7UggE4LVxga8Daj5/IIn//erzC+QcxpNAiofNkgSK2AFQU5Rj
	f4MpYplFlJaKk+uhBEUsb22/FFtD/zE+qLgBMa0F4wBZt07cd+S6Kzak28xj6srFMlkDKP8UOwZ
	z73txxURcKUJe7eS0/NvZSxqLms8=
X-Google-Smtp-Source: AGHT+IH76rdNmbl5bYxxi2Ntlx+Q9KC5d6ItHMqrKmo47yrPqKQ+dtsj3ZlBapDNCUyzNnFJZtFvHA==
X-Received: by 2002:ad4:5aaf:0:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6e9005d4500mr51843746d6.3.1741361040000;
        Fri, 07 Mar 2025 07:24:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf64sm20530746d6.2.2025.03.07.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:23:59 -0800 (PST)
Date: Fri, 7 Mar 2025 10:23:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 4/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z8sPjdXmFGO9-y7D@gourry-fedora-PF4VCD3F>
References: <20250307063534.540-1-rakie.kim@sk.com>
 <20250307063534.540-5-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307063534.540-5-rakie.kim@sk.com>

On Fri, Mar 07, 2025 at 03:35:33PM +0900, Rakie Kim wrote:
> Improper cleanup of sysfs attributes caused kobject and memory leaks when
> initialization failed or nodes were removed.
>

Is this fixing something in your patch set or fixing something in the
current upstream code?  If in the current patch set, roll this into the
patch that causes it.

If this is fixing something upstream, I recommend submitting this
separately to stable and rebasing on top of it.

~Gregory
