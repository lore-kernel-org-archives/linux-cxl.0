Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116010A0E
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719807882; cv=none; b=AoKmdbN406U1ilbXFgGoX8074ETcJFT5qIHwu83ALEZu7EEzCMWM1WU4rGxzkiiXbF3TwVj6Bd7R4STVfr0JzaWhQd2JGZu6vUTIL4EXP/fZmacd8XtN1mT1BNvPXz0Xbh8JDOWsMy9N30pYwGpxTUc7oG0NzDlQxuQwzsxpTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719807882; c=relaxed/simple;
	bh=paVAf+8j2Ao8wNZ6d9H4Go6mO+YeHszO+g9YMet+gN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtBdSnh0AyZjxYAiIb6ISjmTr+md5bx/hEUSsB5/dvsJi78zZvPaTvp+ZdWah2/wuWuqLwf2dqZlxPaQRqotJWJXFOn3OKA8Lm1SOZRVo3pQHakWY78IEPA5ms1Ed2WyO2v2DekDNNmKnRx2myRL5ddOE6bxV0g+wVHHvE/JpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xUdX3f89; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xUdX3f89"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa9f540f45so12818035ad.1
        for <linux-cxl@vger.kernel.org>; Sun, 30 Jun 2024 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719807880; x=1720412680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8FaXxeW49XxQjIVoOOnJuKPW6Isofg2ljkc7tdAOtU=;
        b=xUdX3f897Grs5cWWuQ2CuoY+jfH5lwciBkIJtBCf7XHn5Vy6PLpf3Y0oEYflVH6KRZ
         cYzqRjL46Mhp7NxfpjavH3SLzSlx/uSa+Ln6e3xWzWkLpvU+SfWd11Q1NUXSphwk/a55
         6NmKjcHlf15ki8DBVRvoXxG9iAS8BoybM1PwJHIm2FC/Xyljt+0GJqf8Ngywja2J2Ww9
         D7HdBC8qSbQMyH3T7iDhdnoO18ctAczp+b2l/XZzsQNlAQ1DbgvNmMyhXtCE/zKg1CQ5
         RXhY8LPV6wTdbxdJutRYXNqMgvPmIWb0wLA295TCggO7vn7bIjBeCllNLk12n3yQw1Ko
         M1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719807880; x=1720412680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8FaXxeW49XxQjIVoOOnJuKPW6Isofg2ljkc7tdAOtU=;
        b=a1pKbMPvi0AAlNdF0uh9WB7s7ZJu8aBeweJ6hIiL8kwRVqk2WLf37Uau4nsKj5IY5W
         X2aorf06HeqaBRDkt4Mj80QdgKwLj29x/OIbgqhEmkNctrmfzh+XhFj+VwyaYImXg4Dq
         uZsLxGiGND+l4SLJyRknQaiDeL9Oo+sUqZdgJV1GmYgAWmB2L0HrXLlU0mAU5Xzq5eWF
         Vm9JSrccBXMK/I+Vq96unsDxLbdLCEY1i27BRInIkr9F2NmxHYjVC/cpcbVFf/MTchsf
         ckbDn0iGbwEvaYRwKosg+ex7tY6olvZ9MIKMwfu64iVxIiwNgmyJ7ssQBfpqLEBTYHGg
         s+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVt6806zyB6iaZ5n6zLvGEdnshX/PWTjjHGt4LyReFRrBZ9u1TCI5kfj58MuOqGIA51d1bTFu3l0h9nTlTPAK0LRACL9DhjdfjT
X-Gm-Message-State: AOJu0YxpJjC+6WoV/81+iWdjWytyUn/kryoUJ4kBbqmkD/ye+0qVnFli
	ScRik/Nc16wN5t2Hu75ShiQDJG+J6so3f/Mw4XxHZuCIZq6D3j1WKWjl5xXwRuc=
X-Google-Smtp-Source: AGHT+IFKQ7mlIRHK3qLypxLI+wB6C/xuRboouR5zOv5/KrFwuLBxwDWk/1+R28Hzvt5tq0xC0UW+Zw==
X-Received: by 2002:a17:902:d2cc:b0:1fa:2d0:f85b with SMTP id d9443c01a7336-1fadbce9d59mr26040185ad.49.1719807879574;
        Sun, 30 Jun 2024 21:24:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569051sm53926215ad.215.2024.06.30.21.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 21:24:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO8ai-00HWNB-2Q;
	Mon, 01 Jul 2024 14:24:36 +1000
Date: Mon, 1 Jul 2024 14:24:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Message-ID: <ZoIvhDvzMCw28VBI@dread.disaster.area>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>

On Thu, Jun 27, 2024 at 10:54:15AM +1000, Alistair Popple wrote:
> FS DAX pages have always maintained their own page reference counts
> without following the normal rules for page reference counting. In
> particular pages are considered free when the refcount hits one rather
> than zero and refcounts are not added when mapping the page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment.
> 
> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
> the original RFC it passes the same number of ndctl test suite
> (https://github.com/pmem/ndctl) tests as my current development
> environment does without these patches.

I strongly suggest running fstests on pmem devices with '-o
dax=always' mount options to get much more comprehensive fsdax test
coverage. That exercises a lot of the weird mmap corner cases that
cause problems so it would be good to actually test that nothing new
got broken in FSDAX by this patchset.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
