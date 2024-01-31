Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24FEAD7
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669326; cv=none; b=EqrW3n8MmXq58hFANq23pvXyO8BKDWeTz5YSaQL1UqiNAxJQkwxHWAMf1i+tdFRt6vNqlwQpdfjj287CW7XrHiYlDqjCx8Utj1kBMUiHcrxv6VDFMgUsWkeRk8YIhsEj0Ur0EtMEMNJPqM1a4d4c/po+J0vexTMdQ+sTOKONcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669326; c=relaxed/simple;
	bh=EQL375dfJ45QKL20tEKFWpifQWW4xKqbP46PsyALWuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ2mOmwdj74df6LIlCZJPeifaJZCNwMdT15Ekr63JXyYn05YmsWrgZ8VNnYrdgn+YeNIjON6sCmWoDMdB/hS4MAwVMp2GYC3EM5mtfpC4K6zmIBMP1NNJphad4orCcdZxRlXgmcSEGnj1fX/JoLQxkI7Z6pdmuGspm7WSH9LAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=S3+MTq/G; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="S3+MTq/G"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so360886b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706669324; x=1707274124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXPQ5XtJsAXFNxQJCj+inZTl278RjDiJDDTKJAOYW4w=;
        b=S3+MTq/Ght2lQuX59vGnggaJv7UihUGdyd6+qQaW83bSLHHc2JycN25FXsYUBJYYe/
         rwUTg0zJ0yWWsLX162/FRaN4OI7RihICJmxPvo7g49J5Zud/2d3HKbHKnzDH0ZvnVPOW
         NTXaMa8zkwzIGAmkDPRo7MVG3Z7EMAEqB1ea856kuhZIMKzyMeMrmuCGcJqZNKwy6Kdi
         UzKVv8d0pvxOz4oZEw5bC8zvSJ5DZVXPrtVGy00RVeNwNKM1D0IzH729QgN7jneQ8mp0
         4xBnJD3sdESQFw/0ZZITSPLPkd3UCRL5TMW47mjcttkkdiKtW/rrfyg+v1ey5lQhcV4V
         aKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669324; x=1707274124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXPQ5XtJsAXFNxQJCj+inZTl278RjDiJDDTKJAOYW4w=;
        b=tHvIUSkdnjTKKMZeEhtrgY4XU+ecGk98UkdrUCh233H2EKMtrQoXoq0X4+mwjW9tYf
         gQhLkyHpUznciduovF8vSg5nt4LfekaDuu93RRXPUagvjZWz0XTWzziJCOwPbrd0gTTD
         wj1uO7efxgwYBOYVAxEZniyx2EhHThZIeRxZo4JeUqhvdeREm8WwSBTbJnO1aOM6JNfd
         yVnEGRtjITN4c8fMlG6GrLtePilWfu3+I3+ulHZmWJRByBW1SmjHYLulFjg9DuBbZKnt
         rV6DKIWfntkSn42Qj2c7Eowmy4Lqj+3un5PKp+2AhhYi0DVbgWCdL/oaAmH3PhGr+k9o
         O/bQ==
X-Gm-Message-State: AOJu0YzDKpU9QiTp6t5tPcCKoppmPOwzlZeUT4MmXWiQ1lnAXm5IxKxO
	j+cZfuAvjyaJePTa91vLnEcE1k2vat7JUl7UXGiigIB8bG89bNFXzYolrWMxljk=
X-Google-Smtp-Source: AGHT+IGIax+EKntkIgHYl8yak5r7GR0dyUWQMl80wvDvveadSoiMDe5xxcs2Y26+s2lWbIwhfQlPNA==
X-Received: by 2002:a05:6a00:d66:b0:6da:c8b6:6dc8 with SMTP id n38-20020a056a000d6600b006dac8b66dc8mr333189pfv.13.1706669323865;
        Tue, 30 Jan 2024 18:48:43 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id r6-20020a056a00216600b006dbd79596f3sm8582748pff.160.2024.01.30.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:48:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rV0eW-00HZlT-1P;
	Wed, 31 Jan 2024 13:48:40 +1100
Date: Wed, 31 Jan 2024 13:48:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/8] Introduce dcache_is_aliasing() across all
 architectures
Message-ID: <Zbm1CLy+YZWx2IuO@dread.disaster.area>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-8-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130165255.212591-8-mathieu.desnoyers@efficios.com>

On Tue, Jan 30, 2024 at 11:52:54AM -0500, Mathieu Desnoyers wrote:
> Introduce a generic way to query whether the dcache is virtually aliased
> on all architectures. Its purpose is to ensure that subsystems which
> are incompatible with virtually aliased data caches (e.g. FS_DAX) can
> reliably query this.
> 
> For dcache aliasing, there are three scenarios dependending on the
> architecture. Here is a breakdown based on my understanding:
> 
> A) The dcache is always aliasing:
> 
> * arc
> * csky
> * m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
> * sh
> * parisc

/me wonders why the dentry cache aliasing has problems on these
systems.

Oh, dcache != fs/dcache.c (the VFS dentry cache).

Can you please rename this function appropriately so us dumb
filesystem people don't confuse cpu data cache configurations with
the VFS dentry cache aliasing when we read this code? Something like
cpu_dcache_is_aliased(), perhaps?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
