Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8111CBA
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616043; cv=none; b=cvUl+uznvQqIB1nqbx1whxBMtgOBWm6PVt20jf49YAlEc3sefz25bcExtUxUtCMkV1RqqJgo4Vk0jXrTnnOPTYuZl4W5lsWe7M9LWx0fVAxeTt6ufmqN9tkjSxEjY3qeOa8r05z1iZ+g3/IBC1/q4YZjBMTho8mwXODoEBj1v/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616043; c=relaxed/simple;
	bh=JXlBdC/oGfT34DzCWkMSZHv/cX67/loWh83AR1KMxx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aesczuf+W5jGOAjsDqHpXhIOM+DxLJr+M5P0ZWzRjKnIC8GlDF3p0OYPdIDb2hv5FZDtgU89At10RI/SjNCfhWGpOrgKbH8xjUxbwYrtxUwkvQbXCxJGNF+BGJ3S3oS+GRGr+lc3TRYs7rmLrH/74qUulGXRhptipOe/WOK6oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Gdh3rML0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Gdh3rML0"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fce04655so31432786d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616040; x=1742220840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2QQbIeD4cQaKmx45pyfbPUk4fjoi+bF4+SKLo13d9A=;
        b=Gdh3rML0F05sZ55CqSR5lHtJNcR9btWLactBonbQGsYdNjvJeyJ9vIMJobpdU4rS0y
         mxX2O5KiOHo9NhmXuK5p+KubxcbmR8trcnxc+qDHt9bMgPrqYAZTdMfS0qelDIAzz5Y6
         PGth9SqREzKd3uzVS1xnBaEAXJ4Kuvs5dn3xLWiv5OFqPwNrY5G8zuuVvGgfK/MKREcT
         1VQpHk9xelVOjFEfpTNWpRNfxlJ/mLiPH0KThr9O3/xSFtMLIDROPartkI/iirLjEGSv
         juAnQlJFpkYoQOejjfKtPPdngmIB/0heY7JwZTNmWLDp4kBOO3D6pLzJ/ZGyF55Dwe73
         2m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616040; x=1742220840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2QQbIeD4cQaKmx45pyfbPUk4fjoi+bF4+SKLo13d9A=;
        b=VWHZ6FYNJJQpEM1kvAMZcL9Gh88fvdvM5GoAmLwDaKsxe8sbwf7tix1mbzWMzZm1+4
         EmRz3rHmkc8Gfa52IuTnHQLSMQ/JOCyRkzKExdyPRh7/qF9BDtVggsBcOEO6ZLfmLxKe
         7rwnnCVv4y3mpbG+fWvJbAMiypNho29+S0P+cfx3uszuY83GGe68z9CoQjRgogajdm0F
         xO3EhNXta2SG+VYZfgV4XTruyIsgspeGDT2ed0tIgrkbYsSFew+rZbpp0W40hZXd11Ke
         u+XXOLThG0FZ0yVQPPNNAG1zy+18a0lzCiqSCHt+Uw8hA+aapAGcwPfd8dGUm44DhTsm
         sheA==
X-Forwarded-Encrypted: i=1; AJvYcCXFgW7vJlm85Nq2nQ7/2mIN1b2g6sc00NGBX+hNT2e19KjJLV8vp52Jh72ZpaVIJ85iVDjK4g67hmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAmXCTw/Q4ov24oNiBa4GJHI6n/6S4fHV0nxT7jdn0JmZbG3m
	9IwTdEhUEogKMVfNNie//5RMPOhNvzYK+TZln+H3FNxPePxu5AHU14XPFKynCcc=
X-Gm-Gg: ASbGncsspB62vlltlFxJdMD/O9Sn58Wwx29kunZYunOn0rB+luSAQqVFKf1aOoxtZeM
	u4ho1uEvEYiFAz+hJmTH/H2QC5+QHUeBFnTnwH9OqGUADP7gsg6yVo217OhEzWfy4c+k6nZELbI
	ome6P9PbWHwYaOK/LifEosdWhMVY19AI+ZJBLSdsgAYyHuwnB5aDlC7tm/WK1b4cCCJdQeBaOBB
	OayDrEpoSeWVcIub5MZPXEolKjUaqkEjjMmgWIDM5XfrAdPzjpHOf1cPwma796nIHPL/y6CPWU0
	Kx6oCuKmhnQdcrYL2m7OTGx8X2jAhT7YlxQ98UT+DQ7BWYFLpkgqxNXdRuPUnEv3yuecpj/VZP4
	KMtloxejn5nEeG/UAQJiwcVmfwgs=
X-Google-Smtp-Source: AGHT+IFN6VZ2IHHBSsb69yUP7fxuzrwCQQexzV+7LFNHl1uZTcqZ49b6oNFCgCagXAeNdn9nLbaiZA==
X-Received: by 2002:a05:6214:258f:b0:6e8:fb44:5be2 with SMTP id 6a1803df08f44-6e90063d670mr159078896d6.23.1741616040409;
        Mon, 10 Mar 2025 07:14:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b475sm57816386d6.75.2025.03.10.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:14:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:13:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted
 interleave
Message-ID: <Z87zpg3TLRReikgu@gourry-fedora-PF4VCD3F>
References: <Z8trXFxJVlYI9LAF@gourry-fedora-PF4VCD3F>
 <20250310090407.631-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310090407.631-1-rakie.kim@sk.com>

On Mon, Mar 10, 2025 at 06:03:59PM +0900, Rakie Kim wrote:
> On Fri, 7 Mar 2025 16:55:40 -0500 Gregory Price <gourry@gourry.net> wrote:
> > On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> > > 
> > > I think the underlying issue you're dealing with is that the system is
> > > creating more nodes for you than it should.
> > > 
> > 
> > Looking into this for other reasons, I think you are right that multiple
> > numa nodes can exist that cover the same memory - just different
> > regions.
> > 
> 
> I understand your concerns, and I agree that the most critical issue at the
> moment is that the system is generating more nodes than necessary.
> We need to conduct a more thorough analysis of this problem, but a detailed
> investigation will require a significant amount of time. In this context,
> these patches might offer a quick solution to address the issue.
> 

I dug into the expected CEDT / CFMWS behaviors and had some discussions
with Dan and Jonathan - assuming your CEDT has multiple CFMWS to cover
the same set of devices, this is the expected behavior.

https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205

Basically your BIOS is likely creating one per device and likely one
per host bridge (to allow intra-host-bridge interleave).

This puts us in an awkward state, and I need some time to consider
whether we should expose N_POSSIBLE nodes or N_MEMORY nodes.

Probably it makes sense to expose N_MEMORY nodes and allow for hidden
state, as the annoying corner condition of a DCD coming and going
most likely means a user wouldn't be using weighted interleave anyway.

So if you can confirm what you CEDT says compared to the notes above, I
think we can move forward with this.

~Gregory
