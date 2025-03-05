Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C671E7C20
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217680; cv=none; b=s6zZwRbKYKwXW0fae7vXaQJBfZWtUfu5sF7SK+7PBCP7F7/99giVdIqk6B/3gLTuvt9W7k/l/mqcBwdV3rPILVm11RghbvT133grSuFUJj3UnE0zwxUkXmi+2Qhyp3FKcOMkVbMEN4R5xeDrQJp6IBQM+KVmS0MaVg9kNmvPNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217680; c=relaxed/simple;
	bh=D0G3orN0FV57c/IEBWFnVWoFV7eaqnMV66Yy9wrY8tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzwHgvtVeybYEyDXumMnDVEnBi+kNJuUSdWCArRuUTsy6LUKJoJvvFc5H003/vdwr6WHgP9EZ68NjdKjlNPN3eNLkA9Hl9L0JO9FKdmSJVkWbmiZiGwRCD9whC+1Y9+HUaOGTscOgbzIqdfsOv3pD3ZVAYtPyhTxWerNOYV5RtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EOtUQ7G5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EOtUQ7G5"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c3b63dfebfso5014785a.3
        for <linux-cxl@vger.kernel.org>; Wed, 05 Mar 2025 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741217677; x=1741822477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3To9d5/aMTyINoeQC3tRz8KDnflLypArjPix9jjnpE=;
        b=EOtUQ7G5VdaEjAVgErsms7+1vND7Ggf132L57q5yyIR7/YJP+rZkFOgSncU+bJv5If
         A40gDYrAEgdcMcXvdPEm4sCKanivfe5yHgqCScADJ70WQItUP7FDQuQ4WDBN1IqO3bQy
         myrAAl1rFroFW6E2yPH4Aw2JRxEVaXtmyvj8G5VByy6OA+cTnqRhZgzZDrA2isU6ZeHO
         2cTZZ62rw6RlpweqG9W97D5lRfy4AeZljSYyZypqGR2TIjl6/PNJgaZDvnXsN5qCdx4s
         bT0de/x4IGiwI3oEVx9kL+/LoQLdFie62haqK6DUADnJy7fKR/1p5dm/HpFcWJ+BA5Vi
         BaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217677; x=1741822477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3To9d5/aMTyINoeQC3tRz8KDnflLypArjPix9jjnpE=;
        b=osL394YenoWO5K2Ni+HvkskkMd/eP3HTw81HzC+ft+ZnDyDNsjddFwsI0DejNKd6EE
         V7nwY+WzADJgG4/1f81iW+NGvlElqYy+qpCjts/MOnO4rAjmhIyTECGkUX+mw2Iw1vhw
         htbyxSlmpJAEHkBX2AKEMVc1oANNxx2q0RbFGKCDaFQPLbBDGiBVPDfHf0UMPAAKICj5
         409qQiv/UUYc3ii9TV/CiCcjBPoKgnnbGGe2C/P0NuP2GmJPQBdFZmP8x3wLwUsH/nn2
         cM2Xs1AwZ9Tct8RpzT3UCHEThgtqPAMSOy4RTSJ4+ELrMY8B5gdZOBhe8KZ/+fqNg5kH
         wf3w==
X-Forwarded-Encrypted: i=1; AJvYcCVciB4w8k6pqg1KTN2MeefgwdEd0wRNIfeZ+EDJoz6AT9Ol03V3ei9XEDBt5vIv9+0GIZrhRYjiOi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/+Kl58qX9jKo75Jz0RYJJ0xv01s8giXWcs56sWQ+FV1YwGRS
	hpWwUnHGuJOGShgkIaKkzMP5GQHgrJ9hxVLZyhLhuoF1/oNdSIYa8myZBmS4DYwK9KebPdgYnkC
	Y
X-Gm-Gg: ASbGncu87WPGE/YqvZ42dnMJysvDQxwhqblMxVEPWi6iY6SQ7w73AnXc3zktaRXECTt
	cka5PHRfJynQg4aUrnieL2JmC9ekLA3CVVHCIqQGXqJa+eWMyS26tKDMp8FvOwXdcvruPTNg/xL
	KgKsLGhZ6AcOCfjS1XP5CBD6o1mO3D7wLVGqaLgPkeFXS8p1yWTQumAHRPqmQuMEGkLEA08D6yr
	dPCPcM+ndpwYyNhAtNB/39gxbpHqOoTcVX4ZiKgoFn4OqPF0EGQR9EwM+gSrVNca6FAfMW+Wevi
	Mk35/4Oz9RgxfUONg9/HJ61VYz0NfanGVJvvwwAMs3+hfNnlvoaechU4NOSJv0C99DY8eOjfbBs
	T6rkXLJR+HdyoOTElyKMra4hUj5o=
X-Google-Smtp-Source: AGHT+IGa5Xbbltz240JyaJqJHDwVfX/4+rVmQ/jVLJ23LieI4+LZ3OVgysoT1v/qozkzc4U2h+acdQ==
X-Received: by 2002:a05:620a:688a:b0:7c3:cc36:b5a7 with SMTP id af79cd13be357-7c3d8e7a2acmr842523585a.27.1741217677301;
        Wed, 05 Mar 2025 15:34:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5389d57sm8108885a.64.2025.03.05.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:34:36 -0800 (PST)
Date: Wed, 5 Mar 2025 18:34:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <04e77063-5676-4435-854c-9488075114c5@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e77063-5676-4435-854c-9488075114c5@intel.com>

On Wed, Mar 05, 2025 at 03:44:13PM -0700, Dave Jiang wrote:
> 
> 
> On 3/5/25 3:20 PM, Gregory Price wrote:
> > --------------------
> > Part 0: ACPI Tables.
> > --------------------
> > I considered publishing this section first, or at least under
> > "Platform", but I've found this information largely useful in
> > debugging interleave configurations and tiering mechanisms -
> > which are higher level concepts.
> 
> Hi Gregory,
> Thanks for detailing all this information. It has been a really good read.
> 
> Do you intend to also add CDAT information and device performance data calculation related to that? The SRAT/HMAT info only covers CXL memory that are already setup by the BIOS as system memory. Otherwise it only contains performance data for the Generic Port and not the rest of the path to the endpoint.
>

Probably CDAT should land in here as well, though in the context of
simple volatile memory devices it seemed a bit overkill to include it.

I also don't have a ton of exposure to the GenPort flow of operations,
so i didn't want to delay what I do have here.  If you have a
recommended addition - I do intend to go through and edit/reformat most
of this series after LSF/MM into a friendlier format of documentation.

I wanted to avoid dropping a 50 page writeup all at once with hopes of
getting feedback on each chunk to correct inaccuracies (see hotplug). So
I'm certainly open to adding whatever folks think is missing/important.

~Gregory
