Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E513AA2F
	for <linux-cxl@vger.kernel.org>; Tue,  4 Mar 2025 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051975; cv=none; b=j7WMN8K69+DcdlmXAJVZzPF4eYduR3dG3LWCm9BkhLg5ztMpdxuTTKAoaF8C5kqjFumI6n8klJ9dWmWFlh8E5maS8Q9vCs/zQkep5y6CPuN+VRKRGyips+BWX0MnlHCHd8cfiTUi8Ku5QzplEc83sWLARdxOXlXtlPaHavIksvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051975; c=relaxed/simple;
	bh=v5/bYUBFt7ixahljwJAw2cD9ksUIJ1iHD9P7j1AbFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqsaGVjgSzUkFIf59Cj8m+XzWazLv6vBTPKGPHrNkM1fPC0U382kEwPd10+g/v+ZcYwMKNPyrC2+YtxAN0lqxQHzHCEQQSwgqhsPdqRtDkLShOUpHGvLKKPLrD+UX8PYhfHQpuLh4bIGCYQCGqW7pmTvVAkRnUj4rwxFh3+sAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XdbBZg+I; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XdbBZg+I"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c08f9d0ef3so279059085a.2
        for <linux-cxl@vger.kernel.org>; Mon, 03 Mar 2025 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741051972; x=1741656772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6xB6tZBkxBseJmMvpYQ2Hhx7HYfm01hEgI0/OHSmWI=;
        b=XdbBZg+I9bH7LQ2/qdjfVbSKeONUcg9+3Ft3PtqlqqIQzNPuRpi4vT2heztO9Dt9Lj
         v28fVEua0ENpzt+WOc/SIzO4GHA27iQZxgFsUk1Zt/Qf4CLuXZ18j0u7kq+AE+RcXuu1
         802V3MDWGbsQDe4Wja6bDtSJVfEkO6JakM7/60q2St0OF7drApZi+K1tXifkM5qPRUvD
         WJ91383hb1Z++nMsh6FKjmdBeS1QfA47FmkVrh0eYVeP50FjBsVRaVGk/+4RV3x6ivM4
         iXANkEKovhG0ZIOZPjtJrcDkALepTt2MBGff3N3bFosVoAcS29vwKqQrGlspRelpY+Q/
         9amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741051972; x=1741656772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6xB6tZBkxBseJmMvpYQ2Hhx7HYfm01hEgI0/OHSmWI=;
        b=juO+C//gZrQ2E7sA1PvHP/MwdyVktPHljb0G8EZB041Ft2bb/CuYhMkCCi7vbM/y7e
         dNEts4h38M/Ph5gNktYlP2zSs2K7cvo4UmzfTFPbzTIagb8VW5SVCQ5AcxmqnYwsMFYS
         80rhy8YpFD37MSE9mV3vlv+679AxXondjk+XMhgTh+z2k3d48yyMBmJ6P94LnyVEztdX
         +gXnJyf+/4QymlZcrb7RkhlxOlxAFhWR6PbiLYNYDdYru6+YIncneWvf+rIqGm8FLIax
         8i/4ud7L+JVAeFI0yayNNCxL3GFoqXbKqNBguJtsde089DtTQ5OglW/AtgOZmH5nAwmB
         BU3g==
X-Forwarded-Encrypted: i=1; AJvYcCWYKlAWN3RXXD7KopxHNdA0AmzomWOPSS7hisJsWGwxP6BCTgzioM915gYGsqL4p6ZxYMNA0bCjN80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EtH+EyjhGu7fc1IgkgK+/hc8l8jYBnJN3LwvUa/zv26eUTwh
	u4TQIS1ct0qBbGP2hTEM9j5TDYOGsoOQ33tiE340CuDx4yIt2VfuBfA18hLe25s=
X-Gm-Gg: ASbGncvFO+2GFk2pCQMOfo5OuYYpSg5TQ+I0qFOsj7jUqUg5ibeg6MCXV/IvE3l8Tos
	7dYZIq8rhJsa1ZkTq9Ri11l6nDx5xY7WZd3cX8vZAHup39w92u+3iSVPqQS2cVHpWGq3S3wMLzG
	9hWzZ70jzh/j5+aifqBmRCzNDE5ZPhIwLaT1a8EgF2/IQAFZXvTwlVdIDkcJGhyIvfNRYKyAK0u
	eeopg1BM0m+c6IvM0G7LApmXRxckWXWd06r1EHrEwkJqMzVKDUP/xkefRPEl/Fkgxod3SL7lRPA
	wwK557DVDx2qlQzSWqF5LTtfMc2TRMhNt7hMDh21nUE8NJeQOwNI0d+F4IK4n4F0+b5TYlNr+ss
	S0MoLVw5i6JoxaAyJiMV5564/Keg=
X-Google-Smtp-Source: AGHT+IG4dWln+CNbJieutk1fOc0kWi4nxKmsaP4G3WEAip9vevv4K/TkpbAdj3Eb+EfbBCSu65rNPQ==
X-Received: by 2002:a05:620a:4492:b0:7c0:9f12:2b7e with SMTP id af79cd13be357-7c39c49fa6emr2001696785a.11.1741051972460;
        Mon, 03 Mar 2025 17:32:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b7366e26sm231363985a.87.2025.03.03.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 17:32:52 -0800 (PST)
Date: Mon, 3 Mar 2025 20:32:50 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 2: The Drivers
Message-ID: <Z8ZYQqm_UxDDphSf@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>

On Wed, Feb 05, 2025 at 11:06:08AM -0500, Gregory Price wrote:
> ---------------------------------------------------------
> Second bit of nuanced complexity: Memory Block Alignment.
> ---------------------------------------------------------
> In section 1, we introduced CEDT / CFMW and how they map to iomem
> resources.  In this section we discussed out we surface memory blocks
> to the kernel allocators.
> 
> However, at no time did platform, arch code, and driver communicate
> about the expected size of a memory block. In most cases, the size
> of a memory block is defined by the architecture - unaware of CXL.
> 
> On x86, for example, the heuristic for memory block size is:
>    1) user boot-arg value
>    2) Maximize size (up to 2GB) if operating on bare metal
>    3) Use smallest value that aligns with the end of memory
> 
> The problem is that [SOFT RESERVED] memory is not considered in the
> alignment calculation - and not all [SOFT RESERVED] memory *should*
> be considered for alignment.
> 
> In the case of our working example (real system, btw):
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> The base is 256MB aligned (the minimum for the CXL Spec), and the
> window size is 512MB.  This results in a loss of almost a full memory
> block worth of memory (~1280MB on the front, and ~512MB on the back).
> 
> This is a loss of ~0.7% of capacity (1.5GB) for that region (121.25GB).
> 

Some additional nuance adding here: Dynamic Capacity Devices will also
have problems with this issue unless the fabric manager is aware of the
host memory block size configuration.

Variable sized or sparse memory blocks may be possible in the future,
but as of today they are not.

~Gregory
