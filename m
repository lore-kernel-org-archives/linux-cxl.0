Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8824B28
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171757; cv=none; b=lYQfvzchN/GT09iZa1R5622u/gpMC3oZhDbT6eKP+infcpKsYta89dR83bFJAK+nXmxbcCSKK2dk0/GPewhW3C7S6XLXBDNTE9R7zfoBZf0bLkh+mlILmAQn0jY3UBveRp2KvcKZ7aZYk4zVEQfjUvP9TSFDZoX6ye+CaPYLtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171757; c=relaxed/simple;
	bh=QUPMqaO08oUcYGlK+QKcnzTJ2vhWDlM7cXLXYxsDZ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4Ok1bvNZLHtfQBdxumPjm5cPnnruIBHVIum/yU6jL2EYMdItWm43s8LNS1s+m+lQNzqR5rYWFBP3sOsTNNVlljv1om8JuogppaTV/HZOA/qe5YUeMoiUwTIQEZiJrSVlsyphA6WRHuGJxejcBSYHAXRTqN7Ys9X6FYkJGwpY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J461myhK; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J461myhK"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so10477085a.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789171755; x=1789776555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/J9+qt8jWu0CL9QlZjJtE4DsxuQMJWCwC+piAz+7Nb4=;
        b=J461myhK3WENl9WYRnBOGzrgoMiH/Am2in20+fQ/5z8DX5CI9u4LBGQHygdpkWXzrP
         DF7ibP0jhSbvKvcW2eyQ+eLC7wMH3Gveau4PW1ViE9UrTKMnd2yeQe/0cByI7nUVL4zR
         8XDA1xSbsX/nGF4dwb/7OwwMVkXDE6m0gYhyxmxU2tjZk/bw8dNIu/cjU/LDN98394In
         X60w96+PBRd59VnOHntRrVdE2TKv0fI/JDdev/lhgEWjeCI9zzUXqlyQ2rT/dK4/KJW4
         sMHPHMTW2ze1Hmy4MZsdRUUaYlgNLp4yfCWdMexRNpYzKvxCTu3qWsU5k51hfo51bioh
         96Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171755; x=1789776555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J9+qt8jWu0CL9QlZjJtE4DsxuQMJWCwC+piAz+7Nb4=;
        b=gfosyyf7J6gA50QV0xeqRHqM1PgyY5CuGuy0PXyaLI4ExRZXvcHEoRFMf498oOsVc6
         RFNRvRlpmwT6Tv+nIiyMM1hyyhkZGn1AtR/nfl6MbopNfOtW1MvRlnCT3Z+kyKrw+M7+
         G6yTxYoMrZhEctdqkEsrZ5SCyb//m8MvrMu+Mrg9bYalHbZZT6caPmm3wdgWYOWVLfvd
         RrvESLrY7a1uFPqjI/fKoRuMrCDZV7jupWMTMm2bHKgcc5XFNBYUkdujkpoBIne2khV3
         XdgIwQUBlJjWsy12RdRXeolYQC//C7NaiJLz0BkGFoa2LkDmZNvVXM3zjTORLLh7N7ng
         Uogw==
X-Forwarded-Encrypted: i=1; AKwUvBx+1/T+u6pYlU3NNObL7LHw+5HlMZ0qYEm0zkKY1qJj0+Ji1RWHs9kScGbdSRvZxearYIwmF/VwIEs=@vger.kernel.org
X-Gm-Message-State: AFuF++mI2uGZfJg1UMUgl/govhxNOqs51pEsQT4SfhyOO9k4GwT9fXkC
	S12pjJAwpzCIsq9q2KPok6Xv7hU7bIh6rdFbKttXZjGmi57Ne4fPa9D1Q+T4w0FCMAs=
X-Gm-Gg: AYBFou0HYVyijK3kmdu8ZMQKCD9huVHaBJYt+50hZ7P1vb/5GkexeeSe02OxAWs272T
	KK3MRrQ/dkOEjiF1qT+eWtzu9iUaraXeZky97xrgk5fKgxlYEjVDxyqr1OMp/H4R4rAEqmTGawj
	LdJPlUVkMDdIR8MoRPzEU4FQdqe92QzjQdnH37oY+eMTexy5hxnV9vmIu/YSQvMlMGsJHOhQ6/Q
	akhwZ+adGAEJQX3xFdNdn2cD7fJ8TkaaVM3VtTfWLdQdw0WJubxIlahAA6NNiUrP2YArn37LG/6
	OsiO/6HfnmDRIkKlpsiT9wQ7tCYyUyBAtvH7FJ07ycmQbyl87cXr9XJFwpWqXL30lfC9LBptc0Z
	quEf0M9JZAgC2CO9jnHK49NvVFj7aYEZLLqjdgvq/QQGLiCrxPvLc4rpzA09QHYmbIrfel32gv1
	64YaQE/PUSqga84N6aSf5/mu3AtOdgoEhikjNAqpYwLDawngGQ3QQEfuNuAUU0Uva0R7AMCpxN1
	ScCact70Wo//nnVaMOerb9U+xRfsuF0tYcjRyByOtPVLhrLNjGSapE=
X-Received: by 2002:a05:620a:172a:b0:939:b43f:341e with SMTP id af79cd13be357-93a03671dd0mr109407485a.22.1789171755127;
        Fri, 11 Sep 2026 17:09:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e803dc90sm365356585a.17.2026.09.11.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:09:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:09:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <aqSX3OadID0REQps@gourry-fedora-PF4VCD3F>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
 <20260908104327.DF5E61F00A3A@smtp.kernel.org>
 <aqRuYaUt9qAvPA3W@cxlqual>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqRuYaUt9qAvPA3W@cxlqual>

On Sat, Sep 12, 2026 at 06:10:57AM +0900, Anisa Su wrote:
> On Tue, Sep 08, 2026 at 10:43:27AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] If a CXL device is surprise-removed or a fatal PCIe error occurs, `cxl_event_thread` enters an infinite loop, pegging the CPU at 100% and deadlocking device removal.
> > --
> Surpise removal is unsupported. Jonathan mentioned the same on a similar
> thread: 
> https://lore.kernel.org/linux-cxl/aqLZP3ORYzCLfSgR@acer-nitro-anv15-41/T/#m8e12567a42b07fae8aa307406e6e017fe24ad832

This has been my favorite sashiko response so far

"If memory is surprised-removed, the system deadlocks!"

lol.

(your series is great, sorry i haven't gotten around to reviewing it
properly, i appreciate the doc updates very much)

~Gregory
