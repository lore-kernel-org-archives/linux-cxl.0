Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C436920F
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581610; cv=none; b=mfrb1hhDX6ZdRI6xL9GSzZSLlnse+FJ4RY+xwWx6VyGyNtmZsfKktj1lAsrMwlvgcZMw5MXDiQsG+Zl9xpvtYyH9NQajPlK44eTuCfm54SLMTO2BGk3n2iIBzXnS5muZV0fScSEr3NkTUnVzDbj/7KDF2+6Zg0JCXVcw3gLsz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581610; c=relaxed/simple;
	bh=m8WwTgftG2JlKgna6dB4RrLuV8Gh7o1MW2kFmo8oT5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X73UnPjavlkjGAqYX3B82HoR2fqQhsj2bdLQ+HF5W9sdZ3CIdzTZl/qnxSmvS2owM3GOQ3xAYPSbjfkgI/SbfC6WlJiHuLDeRtvDBwsdh807eYY5QZI5GC7RDUWUJzBYaT3Yk/Jn0beR4IAW8pCld67WxIA8FxocoM5sFkR0B8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MjT6rWCn; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MjT6rWCn"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so9838421cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789581591; x=1790186391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qaSXRzWNGn6emHBvIsSosEqvWlO+uc/lCOi79BlbLRY=;
        b=MjT6rWCnhWexKPrFddP4i888pdNcSYvziSkvek+4c9OmUjMdNR4mPgDzbCt04g/BjK
         rhMvuIVOf0VICS8x0UXEzqyBbcS3h89gr6sKysFI+j/tcNIdhTFpdUN1dkDM1SHvbbt1
         5Bkhjwo6EGD3ENU7QGcVRKzR4y5tOx7G4B6LwB4xS2kEYKTZPKcs4WsaH7zsAPQkmrj7
         Di5awy5gT9Epe7rMVdTbTiMvWNRQfpBvtrW7HEoQ6DmNTUgHYwJQkapqImnHkyO1v2+q
         uAyu0wtkQA10Z5+ltNxpQ1xFf7qrKD5NPs82lHb01PRayZmvjzm1I1Nuqk3VK8GCAU9/
         3zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581591; x=1790186391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qaSXRzWNGn6emHBvIsSosEqvWlO+uc/lCOi79BlbLRY=;
        b=cAZwlziqYyDRLIq1mxY/XSrLBbA06Q4SP6bdGR2+RJIjHZhuQLd+aOaSrsqsyUL1gb
         ScCB3SH6Dsb/A6gddLCxjsc4KXqQkJRnxSHbdFGEZP/ZmKHpEwc1pxk8PmsgzvZXgxsF
         2s1B1bL2zEB4u50yJl+z1XWzQ0bKJlHPLfGBb4+sLYW6WzpedfOJb+oxhhFMvAidjRMg
         w4lx1uMFCKLNLjGKhzUpa8EPi4sAonAKGd/aLglffKtExsP4WsdWOTakYwAtAYk3ayjJ
         ju400wF/APQoA0YvUHKeZO3u9ez/9YGUE5rWHZ86/fNEoOYPf1pfaaQnpLTfMMnrFge+
         xyAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPTS+ix7sd2ONq/6b3h43eUNl40P19TUFbrLOdnGono7GRWHnx1adQpzSxy5qQhFDcbx1BBWY4q0Y=@vger.kernel.org
X-Gm-Message-State: AFuF++njA/3oKkZ0HBQ/bAQPP9M1B1jy/CSgTg+rktQIWFgcrnubgxUg
	t9K/dF2IPenfPAjDYRvyu6yCFapVgOFm+WTFwBWMrmzKr/6f0RaRSp7PpJLZVZsLxIA=
X-Gm-Gg: AYBFou1OJjWo2K56A32UqPgBAZE7OpgvxZ1gQYYUvyHn7gnbyLHqPnUIcmN5kqMv/8s
	iyMuV5yU2AIK2oTRc/64uuyi0tQutdfTJXlvkqK1/BRhwE8cTLPeLxN9xt+kVdOBjt+h+5eMV8m
	IMjzzSgAJTP4Vlnxa5gLUAW+p+V6Lx0QpItIxaYDu7OTH9r54HIr+V7/cglTHgq1dBvnjUpIMrQ
	CaoDaRX3Kse1QVG5cV5GpsAyusLltdthQO6Tt60gupHhoiGZiGwu/Y7MDYGtwT+eUysLud74Pkt
	ga/dbY5cYMugEIrIJQCZcoWhqRgFv5Ws24ya9VU1LLp1vXtOQzer8OSfUzZRyER5bzIly27wXc1
	YT6n/+HMIHrNa49xhBi7irg2VyIx6b+nrHG8JqvUqCvwVsP1WCzEJsaYD/vsGm8C190WQRPflz/
	H3hlA+ojPtdkEzlA1QvQ373Y26x2cNh1H76afJ86gjmQLgyyvRPR3ndNeoBBIle4k3xaZwor4y9
	1l7G/KMxshfR/wKPXqmFSbVQL4woyNXxvy/l5E17uX3kEvImE360MI=
X-Received: by 2002:a05:620a:8014:b0:939:fce2:d4b6 with SMTP id af79cd13be357-93bb78f9565mr724457085a.38.1789581590697;
        Wed, 16 Sep 2026 10:59:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b78255316sm265847785a.29.2026.09.16.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:59:50 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:59:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
Message-ID: <aqrYws_qG92cdXHQ@gourry-fedora-PF4VCD3F>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916120338.369436-1-kanie@linux.alibaba.com>

On Wed, Sep 16, 2026 at 08:03:38PM +0800, Guixin Liu wrote:
> Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> described by SRAT or HMAT

Sigh.  This keeps coming up.  (Not your issue Guixin Liu)

It would be nice to actually fix this in QEMU rather than make QEMU
specific fixes in linux.

On any other platform we would call this a firmware bug.

~Gregory
