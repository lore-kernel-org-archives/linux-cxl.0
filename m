Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7ED225414
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920460; cv=none; b=VoSRZovdjhWpnYF1xD8suhV9LKwtQZMT+6/ugeETLCy62M+8/MmCNANo2BUR7xwpEQoAtMbtneoYU86KMbwL3rSka9wyN6dY7gdB2dFYQewcqYJUtRyM7W67A+/rYLP/8rbxrqC10OIQo3+XfZcGSA1Q/kcvd/4KPwEX2giwNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920460; c=relaxed/simple;
	bh=3AqXyu8QhBXw/UQQykwq5g1AnytLO6aRVPl0NqOHqRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMxIo27kq8/UcLNx8ziTdayBpUZTMsjYYeOEWo2xDvBC2J4WYA6ZiXTKC90iAhpPjW7XRRiuzV3DyeFVO95lXWVvgATgRlrCEi812M/UCjnSCqW2IM9FxaiWaXYPoExvXeRjhL60vjKTM18djSv4Vb9o69ek7Xt5EcxSKYRdKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YDddOy1C; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YDddOy1C"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b8618be68bso164533085a.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 01:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738920458; x=1739525258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/uMI1tK22C0XcXmMy8inP8Xd5AMUl+UVIdWHN2SnCA=;
        b=YDddOy1Crtv4WIa2Yc39bYwcYVpWeLobyJcNUyot1lwBQaD+nxjS+JAUAfv+L7Zrkc
         W9MecMmyCUYlDbDEM1+JXybz8gKB4yQdOWmsfCco8X4/0D1RS9vuXgqsAho4qSnkciF2
         DIsZejxqxbD8MwPgXCT7K4NIIFKuKmTU0ieOIXwSCKScfTU3ZhLozEKD8vQ1dE/HlV5b
         8CSgtNVXFDm0JUff8ubS8FRYjuOBTFNzK+TPlpOYPTIJPbbGDskZdDAlmc86Twe3EQwJ
         3OykjMsB04C2j8YER3cy/2rIUewrvweQCDxYtYjp1F44JDyIPp+s/lj9ACJYIooNAK1D
         cbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920458; x=1739525258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/uMI1tK22C0XcXmMy8inP8Xd5AMUl+UVIdWHN2SnCA=;
        b=qThplSQo6EdZ991fdsYuNgHx+tJZSu5Otx7da8c5EVGBuM7PMAqyknOCJGvg689qt3
         Yn2tVe1JRv5qNI64Wrhqb7U18LZhP0PHR8FD1K9++olMa6OLwf5OY/ysr8h6C/x0UCdJ
         ypVYgDOc0f2YApcAHipo4WFMEKjb2H4X3oDZwhEfubqv4FWKtheqGPCG3Ko5sazeR3ua
         lqi2mXBnPth+Y0EQQXZ4QNFMrVnpBhfUZrWgv0Dg15rFe4rMA1HBb3pQhR8yJWupEv5L
         tNl4W3JApuFJajEm8XIoyErJ8YnxPzHvmK6/qJFCAiXICRoier7LNVh7f/QWHTrtwu08
         UvSA==
X-Forwarded-Encrypted: i=1; AJvYcCU51BHOlnNaM2siG11r76/kxOlGIPP/nQrIuYq1tWKOOvWR8G0fZBYaN+7sIhIA+M+0oiNRFCTl3LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nFit1MExZC0/LxHfbdyJ1JrdrRrGPoxRCa+IJ6GC7bbJIip1
	t0DWfHRkRt/1pAUta8SmmoXXis8ab9fOJNExk9Hw2dQ1GYrU9TQUqHz1io6JD+SaluEfTLBX3H0
	C
X-Gm-Gg: ASbGncvPbbRWBgN0ZqTU+UJs8psUsAWZnt0LjPXRsJ/lYlm2w+KZg6yibLvKAmGj9Zz
	lg+uBHTtJcpYQJGJlkNVCFrnKF3Z0PVFZbLSvUjEyWZWP+cueqeCdiRerGff1QUQohG16pSJtKm
	iLaUDUHtSoToDn29yrbsO+4w1XpWDwTq0oCHtgxoIttYEgAlpLPP/Y2AZPddgoiLm5841burDzN
	RjPp4+KxghE9/l0Gq7Igsxq/CA+NNDk/eylZMhpvYPtiMnB7r0E64gz0KVjjonwBu/Rh7EfeA4J
	hGJMpuhRuTD3TqcldmiBrdMA/Cg4JABSieHZEIB+TzcBu3DxX9IDtoUPiQep8ugp7UD9oI7oVQ=
	=
X-Google-Smtp-Source: AGHT+IFJRp2jaR2qZ3cXfvTiU/3UzYoJIEOUnTN1p8TBNt5vL+bmEK6odcZXSkWnX6trVbJ5K/6Q4A==
X-Received: by 2002:a05:620a:1990:b0:7b6:d65a:d6ea with SMTP id af79cd13be357-7c047c7891dmr406314785a.46.1738920457766;
        Fri, 07 Feb 2025 01:27:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dedba2sm166192085a.16.2025.02.07.01.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:27:37 -0800 (PST)
Date: Fri, 7 Feb 2025 04:27:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Byungchul Park <byungchul@sk.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6XSB3RcRpUWTcOg@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>

On Fri, Feb 07, 2025 at 03:57:45AM -0500, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 04:20:24PM +0900, Byungchul Park wrote:
> 
> My thoughts here are that memory tiering is the wrong tool for the
> problem you are trying to solve.
> 
> Maybe there's a world in which we propose a ZONE_MEMDESC which is
> exclusively used for `struct page` for a node. 
> 
> At least then you could design CXL capacities *around* that.
>

Dumb question time

Is this maybe not an entirely horrible idea?  Even at 16-byte page
structs we use 4GB-per-1TB of capacity.

Maybe a memory device providing additional capacity SHOULD be made
(given the option?) to service its own struct pages - but maintain
some control over hot-plug-ability?

At least it could tear down all the ZONE_MOVABLE regions and finally
release the MEMDESC region when finished.

Seems too obvious to have not been proposed already. :shrug:

~Gregory
