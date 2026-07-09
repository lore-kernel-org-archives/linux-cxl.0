Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97661342501
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609625; cv=none; b=Lq0wDPlWtB/EcOgANHAxsEw1khgoSDWdeOn6Fq8CQK+xO7YIhaBuAYNYUcL3nFEJiTRY6lPw5KqL6J0RRQgA2fhvmHesOvka/Bl4VHbvL9NUQKqZEd2wnh0F3UIe2bCoQ3EHCok670EIPhMZfC+cNFS0IK0KMnVmJVhOd0Vsesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609625; c=relaxed/simple;
	bh=/grVSRUciXotV+M5DyGJv/gSDKzJoMKn2myJZvg9YgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR2HJSmmvWnPuS2+7pBTGBzbCGls25S86N2WQyPyTeEA3b6Cu0heotlIrGJv/5HpyF3GkG8jAaofGnpxYMMsY/AZoYN5nCcRGhUtR7yRbENSADzHN9b9x5hQv+vlP5WF2tuPEFm1VXJHsOZsX9mTSb1XaD/++Va2qOX66PKCLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KgZDfzEV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KgZDfzEV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0c68aa31so13653321cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783609622; x=1784214422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LA4FqejTaFf1jVYUF/eNvlLLZJZ5tRpTNigHNeOPvho=;
        b=KgZDfzEVrSihwClIha5vLHr7gLsNnyeQqcYHGIdkMpi7tEj8SqpYCn0XECKw1bhxcX
         yNLWW0PW/Cd4/BjP8l8jOyjsK9N+8tKkeLG6FxKIuhJUmcOkmdmXeRV62p/NKrEHu+Iq
         K4spBhoXhSjSPGEvFM0J7Av9oNHz3OWaHpLozVega43cShCUdxyJ9C149A6Y4Vw8IuOO
         RVySdQslv7NpErUZrG9VzAUOmwrMD1lXcZpAGkrVglvRyT3OiW+6Ru93fHAU3KNjpPi4
         GiwnWhDvUCl1sNL9HDBu3nKjD6bqZqcA4JnwHWfErw1u3UI+HnFjGVrin4t+4k2qV393
         NfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609622; x=1784214422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LA4FqejTaFf1jVYUF/eNvlLLZJZ5tRpTNigHNeOPvho=;
        b=h1SckmWNENQVFf7B8flCqTDfIndEyH5RO2yU0Oao56sMsqOanAl0RVgpKMtcYb5D8y
         NAuLPrkMSDeLrjCgBmZgcQBNeKrUxmhTSbZ1IhCpjTf6dnNsRVBv2HpCY51OQrSNXXpC
         bAlhN1/1sqxlOtPALrbtt+RAz5Wf0Yegon/bfQcCaBfZAENbGQ5o1JVqqOgxWxSBBRAD
         PSp+eIfvxxdjK0aqKx6PlwiJLiT1DbSXNRkilS4MO7O5SVRrQ/gjP2KBn9+v1bLXMDFp
         Cw+B7GmNEsSxOefryrPuOgYa+VpinGCl1wENbbHFHMasCPOEkAuDz5DXDqU7ODsNGIEn
         yyfw==
X-Forwarded-Encrypted: i=1; AHgh+RrdDJLvroQAZWvosuw6JzfC0caGLV1Jcszg0VspSAkFnvSUPzQ7rxoWKayLIs35YBmqxiOrhulU5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffRODZ2nA7MV930zXL8q6zYHhY3ZFE92TroN0D43W4R1iKSRj
	3Me2T/42dDa8tNODUnNKGqhjMryPvHYf1ytTEQ5QhVbWgkTa+6XUxlZ9s49T7HS1bpU=
X-Gm-Gg: AfdE7ckitju4GNTE5D2ystmM6YCYcCCEkR9tgGjDdso9vPvHvgDyVpqF8ftXrAMwsIH
	mCRWIjRaEWCQLgo/ZBlnh1jyFs5Mwu3eYFz8gA5OjuCYrJwKDwodHpVP5mKdklxPIOTyf0zb1Ic
	zuie9ip2+/JNgDUasUCzvMG6jIOD0dOa/HIdI+Px7aaelYEAxo35PJfjPuKsK6tJzsDhIrTkcZC
	bIAnT0MbehsvUZ9aZWH9eBLLZmgc4F6ApPy1EfAR63xRWzZx11KK82a309jYt7Zm3lS/Q5YyLGd
	DGh/2DQt9PZ85rLmW0flivhVN6n3QUCXqTLypBlYxgkWoP6S3riNxPZEEs8QqZErwahWkXJqJDK
	inIjGgamwi3g1g69GZ8WsNjEfM9ehdkWT84i7AlLiMWAhOQwrj9EKoh71suiOhCVt3SWixkO6Ow
	qhRkv6sTRTaa+sq0K2GMzqChuwcB3qHPoCgRV/+lb+Mj1tk2nqwXRCWwOEsiE5uOIB+A6u6n/O+
	Ifa3rw=
X-Received: by 2002:a05:622a:1791:b0:51c:7b12:5fee with SMTP id d75a77b69052e-51c8b40f651mr77711651cf.74.1783609622533;
        Thu, 09 Jul 2026 08:07:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c42038c4bsm160321251cf.31.2026.07.09.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:07:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:06:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 06/10] mm/memory_hotplug: add
 offline_and_remove_memory_ranges()
Message-ID: <ak-5EXwL56O3G_J_@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-7-gourry@gourry.net>
 <ak9ee95F7pJpCKMo@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9ee95F7pJpCKMo@MWDK4CY14F>

On Thu, Jul 09, 2026 at 04:45:51PM +0800, Richard Cheng wrote:
> On Tue, Jun 30, 2026 at 05:18:38PM +0800, Gregory Price wrote:
> > +/**
> > + * offline_and_remove_memory_ranges - offline and remove multiple memory ranges
> > + * @ranges: array of physical address ranges to offline and remove
> > + * @nr_ranges: number of entries in @ranges
> > + *
> > + * Offline and remove several memory ranges as one operation, serialized
> > + * against other hotplug operations by a single lock_device_hotplug().
> > + *
> > + * This offlines all ranges before removing any of them.  If offlining any
> > + * range fails, the entire process is reverted and nothing is removed.
> > + * This provides a fully atomic semantic for unplugging an entire device.
> > + *
> > + * Each range must be memory-block aligned in start and size.
> > + *
> > + * Return: 0 on success, negative errno otherwise.  On failure no range has
> > + * been removed.
> > + */
> 
> I think this can return 1, and it shouldn't.
> device_offline() returns 1 when a block is already offline, and phase 1 passes that value through as-is.
> 
> Easy to hit with patch 0, offline one memory block via memoryN/state, then write
> "unplugged" to daxX.Y/state. The store returns 1, userspace treats it as a partial write of 1 byte,
> and retries the write with the rest of the string.
> 
> Maybe
> """
> if (rc > 0)
>     rc = -EBUSY;
> """

Oh weird, I thought I'd solved this problem at some point.  I must have
botched a rebase or something.  Good catch.

I'd originaly had some tests that race memoryN/state and dax/state, but
I dropped them because it caused long testing cycles (mostly because i
was testing force unplugging).  Maybe I'll re-introduce some of these
partial tests and just avoid the destructive ones.

~Gregory
