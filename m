Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B22110
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979448; cv=none; b=gVZf7PxaQdLKfntY1OSUjeQRGh0oojRKQF17hUB8TNaBPd30TW+wMynahUtICt4JD+PHErA/iLKR/fhSfowhaOCHsaib0v2fPCSI97bvvMXmpXQIWyt3AaN6ZeICIpJzrailg8zvvBXLbfB7ookI1GUtu+6i7A7KYBk7KXiJ6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979448; c=relaxed/simple;
	bh=NyjvJLCsBhlNw2Ibrf52ASwz7KJTi9jxZNZI9YNILhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI7VBZFyBsJ8132cjtl2QSkvtENOSc9PYeMoBF2oilT84eOOqFL7z2+Yph/MxMxlNsd3/DrnLsvBW9M3/nQmnx+WFESpqgNSgUnFgyvjbXY67n82aIoFbXUmIxh9kujboh+gCKwJ7Zk+cPXOUd97g5xhp2cg0pzWchtBqOEml8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VfNFRkKn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VfNFRkKn"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5b8d13f73so873217085a.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 19:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745979445; x=1746584245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzc4zJvvvT+R0NRZat82797TVJNRgtoEukK0z7pxQnI=;
        b=VfNFRkKnTsXPY92rUR0oQsDWlpq0BLXr1swyI6/PNKAOcFtM7c5fRs3u/T2b97oEp3
         hpKgKtuU0/IHYUYq8LrJgEBxWtdBcDiN0TG6keowLwK4pXJa8JVNwfXoSqc+F1Lreae2
         Lphm5gl87pn0r4LLUPaHFc1+e9P3H20iu5a22ncDqBn6i8PFMU8v4/ii3DiwSg7e6o7m
         XXzsnf6DUCgo1zCUPIliMomSfto1kUXaEQdAOWfiGSBRFnZZ3M18sS/cs205x89xmOgE
         ZSkMl5ol+c7nbQipfiJpqDDB9U94RqhsgngEi/Vw3vvoX4r6uCR2SYBFPfJeXpgl6Vuf
         U15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745979445; x=1746584245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzc4zJvvvT+R0NRZat82797TVJNRgtoEukK0z7pxQnI=;
        b=q2li3aaJvhavZnDhDyVfFgQ8eoxANQw3qdbC5bLAqWWXy3xx03Rj6qmKWKf1u9vnvU
         /u7orYGaYdvygpohz9AdeO4Ykm3eqtWvN6LwF7rQwqTxiyB9vyImQvkJKYB8x/BfOZSQ
         9sT3hYOi5KTuw0mMhW7mf0aGATh0lRAySB3j0O5SBlDO7pCD0pO0vUwVPOo5U7lJp/m5
         Ux3qoYzNwaTSEM+IP2EbQv6DbqeIFgKfb/cadsNbY/SetWB3KYT/2vnonN7XA7I9lv4H
         sBSmov+0xMTc3TLKlw26sc50uXyv5zpsi8xhwTeHFaoEw0SldkCduoMN4sBVpqIFlOhC
         vFng==
X-Gm-Message-State: AOJu0YzhqsnfMtRMvQU7YcqJTScppUQjxPnNWdgRUYhvsGLTcXs7FhSQ
	WMc5BaqlQoYElqgXq69cNJkMfH6ka7/iFEns7D6eH3LwD4+/LgnKr2P5/CAJBpk=
X-Gm-Gg: ASbGnctYm7FecGtvTr3hNbqBgi6S56n6UYmN6Ut24mmf4yyvRKcgm6wbb3+dJEdV6Sz
	4k+HtASmwlFgH/+sEJ4GoKh92CBeP9w5yU6KA5tpSkfxYoZIB+R96ZZy7AdcH6A1S/EjPRJPh3T
	Nje2zYnUNtFzjV0cBrppLTsSgDiz4dTaSVtcayYBd09rXxNx614ldwe2Up+a0PD0ozjaEiWZegP
	KKTuEjx6rRZ1AqU5tLr9zDvzGZXFWb606R15MOTKsfaMEivXqjt/7AEruaUUqEydTOu0nN8g2/9
	8xJ8b0DlypvAen+NfSEHp55f6fHhxOJ6vS/9JqBpX9MJgGYe/i5N55se0+7+owGdYdycxhFBHk4
	gI4OyndytYZyrFtR7kiaZuOY=
X-Google-Smtp-Source: AGHT+IGeM9v+TJsH9D//e4xqgx1SgQZRFhPsRlriTHS9B28keLWtIOl820J8G6QPyqu2hnxlzoIMiQ==
X-Received: by 2002:a05:620a:2722:b0:7c7:a555:8788 with SMTP id af79cd13be357-7cac7405559mr213547985a.2.1745979444919;
        Tue, 29 Apr 2025 19:17:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86bc3sm799917785a.67.2025.04.29.19.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 19:17:24 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:17:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Message-ID: <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430012915.295136-1-lizhijian@fujitsu.com>

On Wed, Apr 30, 2025 at 09:29:15AM +0800, Li Zhijian wrote:
> During kernel booting, CXL drivers will attempt to construct the CXL region
> according to the pre-programed(firmware provisioning) HDM decoders.
> 
> This construction process will fail for some reasons, in this case, the
> userspace cli like ndctl/cxl cannot destroy nor create regions upon the
> existing decoders.
> 
> Introuce a new flag CXL_DECODER_F_NEED_RESET tell the driver to reset
> the decoder during `cxl destroy-region regionN`, so that region can be
> create again after that.
> 

My best understanding of why this is disallowed is that firmware/bios
programmed decoders need to be locked because there is an assumption
that the platform programmed it that way *for a reason* - and that
changing the programming would break it (cause MCEs for other reasons,
etc).

So the appropriate solution here is for the platform vendor to fix their
firmware.

But I am not a platform people - so I will defer to them on whether my
understanding is correct.

~Gregory

