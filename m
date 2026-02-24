Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F213A6416
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949221; cv=none; b=UOOk+3WQa9KL8btHMFZaD8PaYbxXjUJjPaIlYSmNm7WqpeEw/+eFQcTm8AySrR9zAQ2dNvlXXDbOcRBZHVCFgqdEEOvWjS2cWQRe8DUNqoXYCWdOfDMYSufz6cSTdET+O2bXJxSE1tSajP2eUk0JKtdGe0VaB/V/SCTEEQ26Ck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949221; c=relaxed/simple;
	bh=WFjqS3nLJaDBDy/jJqu12zVpH/7npRwM6fMelE5qVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRTy4LsYIt/gUbshxHSnMcPS3JogXMC1a6v2ovrdZdM/nI+Bca102RMS5e3Qj8tIdVsZ12ySWW0fkbiB9h9vpwd5NMTDCqTdna/EdY3PHwAuZv5HEvGmC3K7TgTqsfcc6DZx/J6TpoQjaZNSfcrrxAw41zsOuuk5Xn/vAV01g6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QVRszDqA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QVRszDqA"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so2873680241.3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771949219; x=1772554019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ1hc2xtJTbeWZpVPQxdTC1YLO/BmPns4vm1eEnrzwM=;
        b=QVRszDqA53jchcrNb5NoVxuOC08EHxp7Iu16r8zzSwDOxg3IlZ9a7vWs49SdJ6mzbq
         H7LfdupIBiPyUQQuDoh2zg7W93qOrFzaZ5RLJDoN1z1q2uYr+e3th0AFhKdf8pFiWG+O
         XSyGxM8yydB5+WS+o6NlFnfIMnC0lwRdUS4yRovWp87OeJY2P7IlltN5+lHMLKlW757w
         +BGLsWo+SkaQU58I5tuXhOgw3r3DDCESKnYnEXkSS2L0M0JWRI3XdB9FTcP/8UBsRAOm
         r5CisNS50oTwNTsl3Ohdfk8WzC1Dj9wwvX4toY6X40m2qpCc3ZwqME4Y2fiNQovGmGFJ
         YhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949219; x=1772554019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ1hc2xtJTbeWZpVPQxdTC1YLO/BmPns4vm1eEnrzwM=;
        b=LsMas6M5hETDpJoO6Nd/TZdMUQcIxUyI+nhrn3BNkiszy1cN8Yy2Pi9TOomO56Z/9g
         ER6bAbm4BYlyBSTLnUhWCy8Dygj61hiD46E1ILlTHM8qYu3YR4CrBALbXuJd24p3m3zC
         eCSwIfu1RWILXhDtit0YWArAE1w498To7SUSc6luNGXLRDeBSMChHJmNhXANk91mp5S2
         553EF/sTnTpd/oos5kyJrwqAdJ8yN6q7w84XJpa/OU6zoL9msV/kggBZ+qo1NEg4fu2B
         IHge2Is40y1VrAjB8kYjSSdhVeGSAkRii0cqYoCV+gYSlt4lrbCC1eP8yqLG8qOLQwy3
         CVsQ==
X-Gm-Message-State: AOJu0Ywoj7x72wvqjfOSrjAEGoialMuQbPiFvYhOB8+JrSgZe2YA+2RM
	pokBAwSzIsrB5p4/jkAI+BxgJk/aUbIeZip9raFtD/yMvN1NfcU9qbLUGLKEBn8B1Y8=
X-Gm-Gg: ATEYQzzQ914iMFg2UyHRUs84YxfrjDXeOrsTZsflFCmIuwk5f2q88fow+rGoqkLZ5ao
	B+k8j+XfzHKhJQhUtwF/B8KfyVc6xk3IEO/V+y/Yu0BtKkWW1A+anmDkvj4aQZyXqoL2GqCL4FM
	2ytDQrCzMshk2Hfppz53iKQj5GI1j3N6YlXRbQ8i+JxHbXgb7ZkyKCt50GvA/+MDlwUJk0Vj5va
	N7THjbfhqV6+/2kvQ1rZNWe6RcyeXEO7euRuamewvTvYXSrCnWdNyndLAQaUtgOg3oQM01TrTsR
	Dx1EpQw9xB1oM3LxF9qGHnBWE8UUGdOolyTTy8dIIADsdTmPIKo+QzkTqKH98TGaGJRkEAJTQyB
	DzpJNXSZlx+WzofEeokPySouFwOf8nRAghTfDAGEdFtPlO4Yi8hx+Rwpb9DA6+cngYiipnCByuk
	1eHIB/0gfn5amesNj17yq5+3LNtj4WLz4fixE8bkl1bVclUTJvDrPzkQRrpsj+/gxj6zCzf3fzP
	pVEaM4jhg==
X-Received: by 2002:a05:6102:5124:b0:5ef:8881:c8a6 with SMTP id ada2fe7eead31-5feb2f1c2cfmr5856404137.13.1771949218988;
        Tue, 24 Feb 2026 08:06:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e63091dsm97648116d6.41.2026.02.24.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:06:58 -0800 (PST)
Date: Tue, 24 Feb 2026 11:06:56 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v1 0/3] cxl region changes for Type2 support
Message-ID: <aZ3MoKZgs26C2PrZ@gourry-fedora-PF4VCD3F>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>

On Tue, Feb 24, 2026 at 03:26:42PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 devices/drivers support, these next patches
> adapt the cxl region code for required Type2 functionality preserving
> current functionality.
> 
> Alejandro Lucero (3):
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
> 
>  drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
> 

I've been testing with these for a while - the additional lockdep is a
nice addition.  So for series

Tested-by: Gregory Price <gourry@gourry.net>

