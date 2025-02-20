Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A471FF7A5
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067254; cv=none; b=ANQo/mRKQIDCBbme4tpsLtSHutwW5hIf2Hm/f7L1h0TL11beeO+k7SG1G8L+4c+5WrDu7yd6EF4OIWgb9fMTNLtL4wkyNGppoEYhYFfCX3nOKogXJndiHpnansyxs9m8VbYXuWC3hNXVshKFwGJWzAxZgqDjikdjrD4rToUQm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067254; c=relaxed/simple;
	bh=PFLJoqT/cNJyDxWt7BAfFDChIabrl8XCG2RAweqsZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY9iWphRbeIAaa2m6hqkKHM91LdT+21iOEp9su7AWqKzYdoVp2pxJxLYSlX3RHQyEruzMNNw4F07SEowngoId3nT9rJFWUzNXWf7SMX4jcO+NfRQmo0c9qIyM9UOCthFAG+HAFzHlde1WHhQV67GclxyE8/9bU4+mLQ9VJuABvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PTIAMy8L; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PTIAMy8L"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be49f6b331so110900885a.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740067251; x=1740672051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb4nDnsDItCK7e2FGSDzpODPaEsgaUkyUWraQucTKeA=;
        b=PTIAMy8LxYVf8aveDl5GB5cMwya9FqrCY9wMiL8n/iI08PT6HwUCig8mDDm9P/c25B
         BD8lWth2ZDFG0s/Gy6f2qtV/kuDMsSGbDccTs6S6PSPVwC+MidghrKZ5G7dRTguOdBKt
         r2PfUJSpAjS5MZ0t3Ikb/FZGbU8ev/QZIbcdzn8MUKdXuIeeMtWf1vcPwA58dMLb03+Q
         8+eNXMkc7clNsazlploVuNrxMAgRSXjsWNls3EzGIYttBIL8EK8B01xl5Ko7ZNiu50BM
         UgznjqrbapOF2ZgkLJXfmwGIyS5XP2lG1LgSrI08bvG1auda/fDAfDyS8KhBfvizgchf
         537Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067251; x=1740672051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb4nDnsDItCK7e2FGSDzpODPaEsgaUkyUWraQucTKeA=;
        b=CtBwjEJ4A/ptzgfiDZhuTbJrizgSdaz9kQxLP143PwUecWaB1Bd8jdyb7T+FAM5sv5
         DWgZSMeY+VhqoTbrSFsvAjYf8wx2SU9tS7N0f1kd07O/4Oj8Oc+5yx/kwEsZfFxhr0ky
         +r0LmuknjUa724UNAKNg90K7bw8Y8be2atbLVi05g+ynp/ZlaeCOrQj1SAE85nCJ2bER
         SPfm4UrxdiEnDSJA/ckOM8lUrdblS+xlo78r96yTNMBsTTA34mxxoF9cG7bUg1v7GCo7
         aSG1C0pUte09GU6DbkCiYIXCutMbBme5hUDNUp+/l/3uEeY1VtcngxirTsf+V20O8c5v
         HwtA==
X-Forwarded-Encrypted: i=1; AJvYcCUnOfg8VF9D+YE1MNl7yH7suJQ7tH/ewzBwW+vwmtKB/SqWxQAYR4p4nES6ghTpRapVgn9EPF/Lbs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3JFiOZbOC6IZ5VGob6CDvT7EOsurxc848tjCSzx+GtDyYOAc
	3NSb3hRMeSFZL4tfJoknKCu0XMnAEFA+gxMn1NMsHd2z78HeZwxiK4iuy2ItDUA=
X-Gm-Gg: ASbGncudvMjFBeq1cRxbVlv1n78NvotaW30zK8Z4zYDCkhPYJn11mZVLdIRYCHXdoao
	Z+s6OGDoTH+5ih+VQzq0wAtTrozTNbGU88y9AD6dMspqtcwLGXjVJcBzBfnPclHKO8xNyrE6oR2
	+vtQx72GuGfZ1XWuh9twj19nyH457PW6mTwaiWMqz76Jx1469F3emTWk8NArn/2DpAZWAdJ9plE
	rG8rgKfBpIZUktEAUbz3pGofpephz5UfjsXAppUTqbafFZusenCNDM0+sQ3q7qy4cdBdDxyFmHw
	TEvkJ4K1wjAGBNmYMsnHZHlqO5C2ydCd1TiaUptrGWEMjkZ9CrDLucy5CI85Ci2wEDVxSfigYQ=
	=
X-Google-Smtp-Source: AGHT+IGphiYX9yy9vqSy5vgpD7h+lkSFIztYChgp7ux/RvE6ggnd/svuGRnDHeGWZqk5dNE4JJcfTg==
X-Received: by 2002:a05:620a:4091:b0:7c0:bca7:1a34 with SMTP id af79cd13be357-7c0bca71e02mr770969985a.23.1740067249836;
        Thu, 20 Feb 2025 08:00:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720670039bsm25311111cf.18.2025.02.20.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:00:49 -0800 (PST)
Date: Thu, 20 Feb 2025 11:00:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: Modify address translation callback for
 generic use
Message-ID: <Z7dRrz9D22p3urfI@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-2-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:42PM +0100, Robert Richter wrote:
> The root decoder address translation callback could be reused for
> other decoders too. For generic use of the callback, change the
> function interface to use a decoder argument instead of the root
> decoder.
> 
> Note that a root decoder's HPA is equal to its SPA, but else it may be

slighlty better wording:
"but it may different for non-root decoders"

> different. Thus, change the name of the function type to
> cxl_to_hpa_fn.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

