Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB11CF5D9
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572404; cv=none; b=FTCoTw53izGvKGQ/UGEGcogLCcf8jQYf+CryVgRoixrVZlN+VlRNi9AL8sv22pvH5IiaGPWR7uLwAHwcWNz9ns33IloZ2uGezePRKowLmb9SxPjTb+p5dlyDqDC1/1Rdwg/CT2wrE03TWNM6TZk5L59ZQ3foEhvyaD6+2qDQiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572404; c=relaxed/simple;
	bh=b7V2f907wC3gpJZSILtBNClfTtCPhHfEFBQrnjR7EFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlsSyRHU7FODIr5vi40N0yAXa1l1YHjHcX96W4SWBYZFYX+ZeQMJ/c+9rSjtUQvlhkxGUGJyxMsLo4Liu5OwGh11VEj0gB5rfLFfGY+PFPoE9LyaTpvSBNdORl18j0e4V2Nn+TAWxC34VqOWV9YbaGS4VNUcBUYqxCF6tbhMhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1pqjfce; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1pqjfce"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9982159d98so165014966b.1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728572401; x=1729177201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQuFIVPgcDNzzP5dDQ9aPllAbgUFYGZeYMdHPf9KucI=;
        b=E1pqjfcekZD+wFAqLPzmveISV4CLHLku4vJY01Ee0LDYYpBb6O1o95TKO1rJ2Ve6Jh
         mkcU9/pCYYlowq1eId62oV/ID8wzNHB2MTbdiaIop2jOgaEa39il8Srg3QnXCNhqDUMr
         lDvLgn64PMRL44oc2Hd6XyUIKt3m64VqK1ApX5+4CWxW1g1pkQtgn/e72o70j+17LaiZ
         izUycG/p9vpR3fhL9EMl/TTbVhnlttapPsL+6H4wuRdWecn6d5DHoJE7wJyTR/i2XTqO
         FTVXlXdRZu9mYsxJ4EW+iaJUIFprW4nr3nz+BEFtoVn7GB1Dk+AdTtYtL7cLEDoa/HcX
         M2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728572401; x=1729177201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQuFIVPgcDNzzP5dDQ9aPllAbgUFYGZeYMdHPf9KucI=;
        b=m7/hNLjhDYPZA/qmkIhjKXlfvefvB2rpjzm6y2taoGju0qz//Sl45FhBkRGJdP2enJ
         lUd7fD37rOuyB7rWrA8wH/Sw1GH9CMZ2lNZ6XrQdSuWyF1ThDU8y2FnZ45itfzem48vd
         BubieDDAMYTS3v/KLbJy8HSpIj5PhgHmaKFOudox73vMna69qAcfSWHsrWwbsQdzAc7Z
         QvcaQYcyyEyS56UQJygTs4jiWOxiui0KO2B/g+/cATWQhDztXwM0lw8jIUD9N5StBDJC
         ZeMhAxG8dILRZybd4EKJgRrPQ0QCMBQk6zkeo+WqGHVKej1myZXq1RwV4q84vmSMWGpA
         gIlA==
X-Forwarded-Encrypted: i=1; AJvYcCWclBXMH7v/16sESFaBnh12kBEkHTqQo6zC0x8KThbUETx5kFeMc29x98oNzjVglEMWfTw8afoysTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWTZAhfn3T6+ydoyY8irKHMpWZj7iu4Ilw4LrtsG9mpQ1Vt4z
	wMdQaEfAlBEUhMYAJMWgBR0DQOB7AIam3hYk4s1SqDFO5hSIvb+L4zzko0ZM1uo=
X-Google-Smtp-Source: AGHT+IGW2A85HxaygCEijBG35Zwt3g08r3KbMHbf8XGM1RPwC0Ld8GCukhWd13kxEHGSwGXTGCl7Iw==
X-Received: by 2002:a17:907:e654:b0:a99:585a:42a9 with SMTP id a640c23a62f3a-a998d117cb5mr585547666b.9.1728572400859;
        Thu, 10 Oct 2024 08:00:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef972sm98465166b.193.2024.10.10.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:00:00 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:59:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 01/28] test printk: Add very basic struct resource
 tests
Message-ID: <Zwfr7na62OKIlN8b@pathway.suse.cz>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>

On Mon 2024-10-07 18:16:07, Ira Weiny wrote:
> The printk tests for struct resource were stubbed out.  struct range
> printing will leverage the struct resource implementation.
> 
> To prevent regression add some basic sanity tests for struct resource.
> 
> To: Petr Mladek <pmladek@suse.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Thanks for adding them. They look good:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
