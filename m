Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FED433C4
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886426; cv=none; b=tnUFVKLtqDNfGWGh/BDVOG38AAPfz2NXqU1kudQ4as1IHL3tl03AF9h4HduKCSTFngd66u8V8mvimXV172AuysZkKkvbwq0ceTOD6JL2vfpCP8zPLn89ylhLBTntqKz6b+gIX9AV/ZRA23W64LnRA3odLlhxevmYuG0cOGnP5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886426; c=relaxed/simple;
	bh=ytKnJ9KP84KTImnJGlrWYjrWTIpLk3zRxii5NGsffng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBXE+GNPWfsSFx0nr3fR0e0IiU46PdpoNP2W1S8UXCgFzFAG/ltux+PmbftDnH6PsBjmuIlFaWVB34s1siMNEhZ7l2+1CsLVyGaIUGviocEpLHkgJlUyf1UJyKI5suq7AFiv5jo/WBC+OVsOkZvv+89NDGRf6EDqBNiR0I3xXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IeYVjt4q; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IeYVjt4q"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so11004816d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741886423; x=1742491223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9es5s5/MUGI5ZSuPglHG3X5LeltCJdtthknEMRc3Xk=;
        b=IeYVjt4qdD1EGKP5UuMVPW4UuG6dSwkhkmnpO2cqni8gKXWg4ZaCfh9zo3FMrZQnoU
         CCsWw1O4GtJ8v2/8noMxFHMHqNOL6+y9Hgci1ycTlAtZ6+0v2axGDQ6QPyx5aEOq159J
         0RokqF3eHulH9apvmG+xtdSXSwRYgH2io4uVqrxZUPtRcIlCYvEoLK2HjekTsEzB81fs
         +DI7m3DYdAk954K/u6xs3wJK/9adwzUo1hYH1bpyLolPd87Tb9uRnWIZojeIQjhZUyxe
         4d1JoANyllWrPMn06F6gV2S9Dq2klqMCGCpxnDG5n0CVnoR0/aBIPMIyykXyfCIJyTTO
         yuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886423; x=1742491223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9es5s5/MUGI5ZSuPglHG3X5LeltCJdtthknEMRc3Xk=;
        b=lXxrZ3l7tjlX7Ic0rECVLumEBlp8B4KkPLmB7Fkl4l121cnKdCXZC7CWz6jphtvVf8
         DnfPNmGMZXRfr14zU0aHoYeOmws4KbxlJIp/BsuPuNPOjF9ff/YMy2WIzI0OmGM3mMRj
         1TNzu4+ZOU/BxOnCUIvCDUeCXTsSfUdML6R6DB6VAMszcg12+R6neqNTvnj1cZjVjwdu
         HnxoUdRT1Zu6ye5KlO+qVth/H5I/mTaBHY8Ag6d1w3FxBsE2qLyrtdNjvbwLHZsswwvV
         qTAmdZgMtpwsIP7rLJv1ohkbesXqQHfdkhd/inaGvBQU6+3W4Zmoo2JayNkG/S3cd+Pr
         pT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDqrHxmJvb9jXlR9rRUjePqBvYjnH86dwVyAj2FNQnPcTUM4FlnD8J2Ns17SQF/NzZw0Uq2ayJc4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpKRPHOERds3KR8QY7bgfKlPXDAUqU7sVMfh/aJKYWxCVE9Ek
	efMI6i56i5CzX3EAAnIYaQfHyvuUzfWrsASdmJNfWVsTqiWqNoQdX5nuCRPtQs4=
X-Gm-Gg: ASbGncv3AWn7j2qgiGhhvUmeLq34VMkZfj1S2U+IeRyDMY7tjoljDAiDc6Z1aGqHKSr
	3fAnrzK+0LPZQC4PCPI5cd+kdeBAHL2C2XL+rgRj8asn/FMPg073b/tb0jnTtrIkG7QSrpoil+f
	Ptc0yDbHuTXs3s/v79cbaeRITxPIb5FBSEbrc4V25d/wuqal5v4B94PuTDZe3Epxx+rGTqMji9l
	GowO3/5Qq1PWpZ00rwJ0RzjnrHdnI33/B5Afhqm7FhXM6ntZ4YqYlRtPysiwPcONvz4wdDBAjsP
	IEELkoCE+LtJ79cBeQ1DoyUKjsHuxROmE3HHNPAbE3wDRSTeOSJkUub5Oo/hgMAiTAvBVkfXUaA
	ppveASxZriSEuffzdwbHdZats/VM=
X-Google-Smtp-Source: AGHT+IFdpX1W9er/zHGcaKcZDK6P6IdlPFmMWpHoDJmGALEDc3Dy7cqy8u/Hi7dFktDcXjTw7QG47A==
X-Received: by 2002:a05:6214:27ee:b0:6e4:3c52:d67e with SMTP id 6a1803df08f44-6eae7a11135mr7201476d6.18.1741886423325;
        Thu, 13 Mar 2025 10:20:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209313sm11867186d6.19.2025.03.13.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:20:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:20:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z9MT1fIKu0v1r9ss@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z8ZKKwDnuAjtyohz@gourry-fedora-PF4VCD3F>
 <20250313161226.00000038@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313161226.00000038@huawei.com>

On Thu, Mar 13, 2025 at 04:12:26PM +0000, Jonathan Cameron wrote:
> On Mon, 3 Mar 2025 19:32:43 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > 
> > SRAT entries are optional, CFMWS are required for each host bridge.
> 
> They aren't required for each HB.  You could have multiple host bridge and one CFMWS
> as long as you have decided to only support interleave.
> I would only expect to see this where the bios is instantiating CFMWS
> entries to match a specific locked down config though.
>

The further I dived into this, the more I realized CFMWS are the
opposite of required lol.  Platform vendors can kind of do whatever they
want here.

I'll be taking another pass at this section since i've done more diving
in to write the interleave section.  I probably got a handful of
comments here subtly wrong.

> > 
> > If SRAT entries are present, one NUMA node is created for each detected
> > proximity domain in the SRAT. Additional NUMA nodes are created for each
> > CFMWS without a matching SRAT entry.
> 
> Don't forget the fun of CFMWS covering multiple SRAT entries (I think
> we just go with the first one?)
>

Oh yeah, I guess that's technically possible. And technically each SRAT
could have a different proximity domain, because you know - value.

The dance between CFMWS and SRAT is quite intricate isn't it.

> > 
> > CFMWS describes host-bridge information, and so if SRAT is missing - all
> > devices behind the host bridge will become naturally associated with the
> > same NUMA node.
> 
> I wouldn't go with naturally for the reason below.  It happens, but maybe
> not natural :)
>

Yeah as above, I got this subtly wrong.  Thanks for the notes.

~Gregory
