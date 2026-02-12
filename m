Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C512CDBE
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916736; cv=none; b=hW3Wocgjyc2VVWPRrPSd8bxkSgFCFEDl3APZxd7OGItsjS5CZQcduZ/429H0WPjRMnsdEuajLxsytKtWmUOJtQMRV4SCmrRtT78021npq/51OdgWvFvIuYyx8P+kwN0W1YZ3j8+uCjlIEEaKx/3YueHYD3HX4tBXPaKBqX4OT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916736; c=relaxed/simple;
	bh=8X/C24U7BMi2o1vPvQYMnOWbJmz1A8R15UjmuCGNtCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7wGPBDE+x9Upg+UljcFsXg+NKXKEtlW9ct9Msp3IQs5LMDVRuuJS9xg5FivrogJztzkvMYU/+FvBCC5ql+zYVjuGt2Hj3XDCxfySJ/thaTzxnJHqs8gYL+N+qVMowawwmK3hQyCRGIGNiDuc2A0tjxHHwXTkbG5fzohnsnX7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SoxkhC+2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SoxkhC+2"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c52f15c5b3so10349885a.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770916734; x=1771521534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYnwfZ/nuQDcCg8JnXL2WuEBZDR49q5P8akUX204fmU=;
        b=SoxkhC+2lcHDJCUeLhINGOONHdz6ZoQivet+sQUMQRS2HB+8TCSJlOvXrb+XOu+IA8
         qHcqK2U12nLxXUKtXimqrgjTUru6sH/eTi+PlTwkTPYLnxcIdDJ+fa3Xy81holkX3i/v
         GnfJT+mQyKiBWvrXjw8mcJaM6xAXJVzZFUMR5itsVH7KxU74LMpRIU/vHr8zOWKJmETe
         QtA9al2IIEEFNPGUvJU+0mGj8HFz1Ndxdh0KqH63rOwJzmC85rOTdmgXQKlZmyPZTkYW
         3gENBt5Bk/WC08TBoy7rxBt2njjemcXuMcozi66vMoW6kCx3wbw0XeLa0fnDLpUbFxpN
         sdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770916734; x=1771521534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYnwfZ/nuQDcCg8JnXL2WuEBZDR49q5P8akUX204fmU=;
        b=pJY3VugRWq/P7EH3P/xcZSOAZhIUdJy9oyQhGtOgeTR2wrokgLGeh7+KFE26hmFMjm
         eu0wZrWu5JF534UpdExYf1q9aq1dtx2B+Mwo4scfMWreN0pAFSOJTARPaXIJAdGEIe0M
         qCk7OkUpn4UQKIVwhfhFA9FKDPwCNPPeTcfv/35W/KPAzSsA25IL4iF8iWGDqApKclWM
         PNs/g4Othm0Sgpo9j6qGLvHUyvMRg90f64ZrPir0dmv8EScmj1jVcpTEUizj8zADKcLi
         jZZUJt+qtBBY2/O3NJKnxxs0eeJFebBr9cdNSsZDdbgvGrmcttKMFLUnUnxOfvFJFxrn
         14qg==
X-Forwarded-Encrypted: i=1; AJvYcCUrD8ayw1oyIJ/JeM2KPFcR4V4UEiFe7M84cMzLZzdIL3X3trwZJ0OC7c92uSLBrq2jfpATvTTc9SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2nDkfNJUi0G5TtHNtQBktItWzF4L8bKF44hgdGp7Efs2YEZ4
	MrhUkqTzug0o0QyK6nP8nSI9JrH8xyBu5m6MPX0gcBUu+ybn/Xzp8jJ+AwJOdyzZrTQ=
X-Gm-Gg: AZuq6aKHVUKHi2GgT1Iw3JWYMmui+4+Wetua1JCFo4bJ9MGAxstSLrdcXBPkleicTqd
	O+yG5WWOWwldzZ8E9up8MIJaj072erl+BZHIm0OO/zdIMaQjI2gJZc95XLGxo2WWt8Al4Ruflu5
	EjUEhqcjyAkW1hNFaBiBbmncoQo+ZZoXw/3vkFa/4acv/QJqZD0Tpo/Kn7cRx8NEb58hmbgxEY4
	m2D3eq8IFEWZO7t983p+IiZ1R2nGI1p5bX87RvyijRy0lE6KFedD6wZp2DmdRXoPL1L5XKpoYPo
	iRNx1LuvGgocRdxzq7GEfM/f8YI6uUAEXFn6icvL+Fda0d9NLij6yz6ZQo8BiHyGI0YzWhFH1Ma
	czdWx8oAmVIZ0VHvgO5Lh6pbPLns45Q+CuS2nnGAQo2dxXNYQxzXYkhgP1fa2xVlNGmXgimJnCq
	h7nk74yy++1Yb304vnI5IRYZSEHNU84tLlTujgeyJei1Yr5/HYhNpPzfZsWteaZGeqtbYGIxjd6
	NFop+YN++aZFic2r/wj
X-Received: by 2002:a05:620a:bc2:b0:8c6:af5b:d50a with SMTP id af79cd13be357-8cb3313a921mr471027985a.43.1770916734136;
        Thu, 12 Feb 2026 09:18:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0ce73fsm420412885a.11.2026.02.12.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:18:53 -0800 (PST)
Date: Thu, 12 Feb 2026 12:18:51 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Delay inserting iomem resource until auto
 region commit
Message-ID: <aY4Le-7V5IGKVupg@gourry-fedora-PF4VCD3F>
References: <20260212062250.1219043-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212062250.1219043-1-alison.schofield@intel.com>

On Wed, Feb 11, 2026 at 10:22:46PM -0800, Alison Schofield wrote:
> During auto region assembly the region driver inserts the region
> resource into the iomem tree when the first endpoint arrives and
> region assembly begins. If the region later fails to assemble, the
> resource can remain stranded in the iomem tree, making it appear like
> a DAX region is a child of the CXL region, when that is not true.
> 
> For example:
> 68e80000000-8d37fffffff : CXL Window 9
>   68e80000000-70e7fffffff : Soft Reserved
>     68e80000000-70e7fffffff : region9
>       68e80000000-70e7fffffff : dax19.0
>         68e80000000-70e7fffffff : System RAM (kmem)
> 
> In the above case, region9 failed to assemble, yet proc/iomem shows
> the DAX region as being parented under a CXL region. In reality, the
> CXL region is in a disabled state and the DAX region is managed by the
> HMEM driver.
> 
> Examining /proc/iomem is one way users inspect the memory topology,
> and with this patch that view remains accurate.
> 
> Delay insertion of the iomem resource until the auto region reaches
> the commit state. Introduce the res_want_insert field to track whether
> the region's resource should be inserted into the iomem tree.
> 

Can you show the before/after of the iomap failure case just to make it
explicit what the user sees before / after?  I think I understand, but
worth just having the explicit data for the failure case in the
changelog.

Thanks!
~Gregory
