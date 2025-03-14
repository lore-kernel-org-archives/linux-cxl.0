Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3712FF6F
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960005; cv=none; b=kVSRoReZoLKkwdYJTDGGoAuPj6Qr18R/eSDCgrfKR1YZDUCmGvLqmsX7gRFCjGywbpl5K5uYAV7giLXzFYCSL+MuxIbcOx7C44GKRUFiX+/THBhzg/HikSbaVjIGlkSR/TEmZ7hkxa949A2rz7WxEOTGZgAUYWb7INB/GOHM7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960005; c=relaxed/simple;
	bh=qsF+GCSSP1hKNdJdQJMBEH9O2/UfBdYkuS3yMvSb0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjQiG39iaBmD4sZ4RzEunAShoYfc/I/0AtRGHjxS4wZ+jDWQkPNaY+9pQc/Nlg5Kbr/LVWp6mv32lMz4C6cLbq4HY8aKeLwTvWn/nympguPXlHrUVoFc6vAxBS+4FfIeMo5Ts1tIH67ywviz7mjWx8BjsV5qFP4ysbWi4GzEUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HnMhbbh5; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HnMhbbh5"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c546334bdeso169311685a.2
        for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741960003; x=1742564803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rcbULF3LHd0+z4mfmpPo+xxeDyKnDv8t+oi3P4Vssk=;
        b=HnMhbbh5M3OD+hE7ogrGRbRRNb/XMlihPuSLhTcpEoMtSFnFYn4KZKz9CpBaCV7SwO
         CaLdskppYuvDjjL5rLLARIXEE85kyxDP/GrTQGUiELM0j0zVqOFomnuslMfIlyCVr8Vs
         2PeDPXxONxvgBy9wgb/HrCbWtLn+xQ/GpL2E2T11L4eTJLaJho5oWrLBP5BSnXGCTm8E
         Qy4mcXABN7pgFBBNHtmi1F1CGzhSsng22WA7DZGSFzb/JvWX/HMimtETM9/pRlQcAOux
         BTWVTl2a6xPYk++uKk/twBFqux/p9+/ChGrne5uaF+BcCj5ynr9bdCtZAn7YfmjcDYb5
         8Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960003; x=1742564803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rcbULF3LHd0+z4mfmpPo+xxeDyKnDv8t+oi3P4Vssk=;
        b=e1pIC9nNTeILS1tRvYy2QirRkxB03EJgXDcN1dwSw+9rn4xZFrSJca2apseLoauFi0
         pmzo54HWQPxamUJjT+S5msTBELU8HoTfOdIFTrjddS5a4f6kwDqtrrxVECA+JWgUBLNP
         7TPFNoPIExuN7wmONpoRumYG8oRYmEyLw1mTuv7+aox82TyTJhswDA59WAXhPQh+tybe
         0+QQhFeARao2vKXrF+4vwT59dBDTFae8mL5Fwq5yObQnDEFQeHDnj00MwiN5uzzZaKdM
         ChyiKrSz7cvruX+4itSdCqENpuMOgE8jG/unlh3gPqu8zMbyxZFov8qcb+yQIPyCrz+H
         ZxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX77Dmk3JsImv2hkmQCzcUvzIfqLQB1VeaCOw775b6cXRxfd26/uWIUsT4npyNjZGZdGcxNt66xeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXY9xkQbJf/dk1UGTksXEpilckiLpihc6PaEVVnd6n9gT97syb
	WMW3N59S4SNd+e8+rnsmWA2S7vjcjHxAEroBNtaAQOyLLDqpt5YhY0Ilcc0vCrI=
X-Gm-Gg: ASbGncta5G1UcjI/F9lIM6+A3TZPNJ+BYc5POY7KSxVewSeXKxb2e0h2d2LKmPQtsV8
	mnIH4WPg0xZMh63VbGoVQDDY3+Q1TmtWBbQ6GmxlSYB59NT9ZjPC9pCdhnwztpt9+C7jtFHGdI6
	ewHgmrp+jxKBuSCaWZR+TAzToq2FX6YaD/+xYA1SZfSB8Turu5chOTjxRSE7wzZcATtYIk+8QPQ
	KRg0lWMURIlfxjiBF0bV21YQkNo2U6Byu+1QmUzYEMXPqmcn1bH2KLQDRhfx6STvLqe6gTYEtfi
	6YyLtAeV9pD7jba3IWzWlOihcnWBXf6o2tbFYSALVg8sHI5EVYlR2oy7YjK4KQWVwiWo2wR6T1H
	3/JNOF9jPuRb6qnAUy+phS6oMGbs=
X-Google-Smtp-Source: AGHT+IHVQBuUbLZtTeB8fDk67fek3JEC0e06LBLUL+yeI3ow/ytEEdIxrurvEd3+ik7VQtEVYcYhqg==
X-Received: by 2002:a05:620a:40ce:b0:7c5:59a6:bae2 with SMTP id af79cd13be357-7c57c769737mr291429885a.4.1741960002746;
        Fri, 14 Mar 2025 06:46:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f31f0sm22865331cf.64.2025.03.14.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:46:42 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:46:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA Flexiblity
Message-ID: <Z9QzQEzcpHjZQI7U@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
 <20250313172004.00002236@huawei.com>
 <Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
 <20250314110942.0000476a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314110942.0000476a@huawei.com>

On Fri, Mar 14, 2025 at 11:09:42AM +0000, Jonathan Cameron wrote:
> > 
> > I was unaware that we blocked mapping persistent as volatile.  I was
> > working off the assumption that could be flexible mapped similar to...
> > er... older, non-cxl hardware... cough.
> 
> You can use it as volatile, but that doesn't mean we allow it in a CFMWS
> that says the host PA range is not suitable for persistent.
> A BIOS might though I think.
>

aaaaaaaaaaaaah this helps.  Ok, we can repurpose the hardware, but not
the CFMWS.  Even more pressure on platforms to get it right :P.

> > 
> > Along with the above note, and as mentioned on discord, I think this
> > whole section naturally evolves into a library of "Sane configurations"
> > and "We promise nothing for `reasons`" configurations.
> 
> :)  Snag is that as Dan pointed out on discord we assume this applies
> even without the lock.  So it is possible to have device and host 
> hardware combinations where things are forced to be very non-intuitive.
>

Right, but i think that falls into "We promise nothing, for `reasons`".

At the very least it would give us a communication tool that helps
bridge the gap between platform, linux, and end-users.

Or it'd just makes it all worse, one of the two.

~Gregory
