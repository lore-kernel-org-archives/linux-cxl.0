Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009A1C84A3
	for <linux-cxl@vger.kernel.org>; Wed, 26 Mar 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993602; cv=none; b=XliPw3BMeLIcmzoxfxsQdXfaDALUDqKjNhgRUAWmG+qxW/MtL2+iYJ0RXx0u/EadJTLgPORTQxm8Sqqq6K8n4Q1xlZXnkzqCaeWIS31y6vT14P4wtQ+9iJNFgj8LkvBhOSGQVfd230yfOswJgB6KUyRKT/qisX8ZelnQ31eSJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993602; c=relaxed/simple;
	bh=8HHp1uBdC+4gdzNJZq59DdfqIQAiw0gMCqs4ThMiGLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paRq3cT+SzMVSDNZ5unf9RvffTX5rQLMwEKfC7xI25+AUciGkDQaB0G1XYzI95+eD0pJaNYisdmrX8AWAjsrJIKbew8hsxKPtRhZMD6r9xHKnlEsdhOBgn36jUF6dpyhAjj1HT1La91bUo+OLDFZH02kj5vDKhImJMArDqG3Oho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KTur8psl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KTur8psl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c592764e54so770844585a.3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Mar 2025 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742993597; x=1743598397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unBBZW4o0XvmaaTwB/+3iSkpD4sIQERsLXl81RTyoyQ=;
        b=KTur8pslGSHJ8IVvochTjVgBVpVZpF37vPvfn4u9I+ekOv3fxfxZsYWkQW86ryGvNX
         YIos6QbYkPgFaPLvnd+aJpX6D7tOwq8/GLlP8j4VzktsC6z3n/MtIy99sfT9/yltPlam
         pRNMIGzywkBN51M+PMSB5dEsdE+9JMqwjoAUwRTmmzcb3DbHPx3nHuk7Mh24HdWPoW2j
         8Imxch9Sm8o/IcVM/CCEJIExL71kutg3FWJB8ELkf0X6P5Yk5I/D8RIlviCgiTnPtqbO
         lh62y4N5dewBMZ77t9FkX9P590UkroY2HdRp7o5nKoNe6XPVXZURr5k4Ac/HnUH9fUIj
         ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993597; x=1743598397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unBBZW4o0XvmaaTwB/+3iSkpD4sIQERsLXl81RTyoyQ=;
        b=F1dIivYBWV/dCw3dcquqc72GjLjsD7My6oNFsVCltlQVJhYQXz2itKBOMS8QOJeejV
         8+Dkuj4kMoyHAEVKBjg7CbqhfYnFgH+0MfSICDzN3qdPVllLo4DmO5LToAflt01AmAox
         mQZM+c8y9SStvrWjPP+SlUyuckBiSvW/vTy4WXc87wGnu/dTOngIrL1PYpJgHpjMayMy
         bytBz4qSzGr42YvO+pUrsJ+LMWg5wqnEI4BESp7gQd0rq3u4IWyK7qZN+IG6snRyQcTS
         kBKePYoe2lMySEvp9ZvgTbxdDTtDDgcFrc7blDua7zF4IZnzNFxwfXjNAuohubv2icg8
         NtPw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEDWMwhl6XL8WBrtlzfJCzJaWvDg7RkGMa1ahMHPKPhNWBr4SnxRTN9rfBSxzhjmz16R8JRSPI8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQ13CIZXkF7+GbEmfd/ZqCA6LOL2Vkf5MPqtqLmid5w/o8/XJ
	ZJypmbB9BfEZSbNSttR0JBmG5nqt1+4yIEeJgL6eSMlarcBVnPXxsrOtcQasXHk4eV+5A98afnk
	QsyU=
X-Gm-Gg: ASbGncuBkC2EXAJM5hEIK1gMtkqgV1aZPTAq9T4neORmOTzKMoaGVFR7Av0vIqw5ibs
	kAp9Lx0oI/MmU8TZ93vaL38ew0wYyO0tLeK31sQ5+m/ecYBnBWRuq2oBGEzg3mGi+SdkzXI0NVE
	GhwkwmGYZ1N646McZ6p78DEem/O45zsxESJRq29H7cHk0gfTYahBinqXfvwIdDWAdoQsEm9/HZz
	FubnmUGYWyrn0DwUh7kIUTciDQTYVjWaU/ASQ2OrApI73Cvt0mffHLl+HAvywEp7ErlfwqtFHw/
	VcuE6epK15mK4tWTTYyV2SbVClq92PLWmGkdrqIt5b1e94r/B2jccA==
X-Google-Smtp-Source: AGHT+IEyK007wueidBJdaxRdr4xRWmnbMteuuUEM+eIwVWK6Vpov8l7x9HZXE3tKIEMisQ/zDeiPqg==
X-Received: by 2002:a05:620a:29d0:b0:7c5:3c62:804c with SMTP id af79cd13be357-7c5ba157d0amr3415424585a.21.1742993597358;
        Wed, 26 Mar 2025 05:53:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec688sm760794885a.64.2025.03.26.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:53:16 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:53:14 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z-P4ulrFQAbJBC_A@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z+PIoAGgz33R2c3P@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+PIoAGgz33R2c3P@phytium.com.cn>

On Wed, Mar 26, 2025 at 05:28:00PM +0800, Yuquan Wang wrote:
> > 
> > Notice at both the root and the host bridge, the Interleave Ways is 2.
> > There are two targets at each level.  The host bridge has a granularity
> > of 512 to capture its parent's ways and granularity (`2*256`).
> > 
> > Each decoder is programmed with the total number of targets (4) and the
> > overall granularity (256B).
> >
> 
> Sorry, I tried to set this topology on Qemu Virt and used:
> "cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3"
> 
> but it failed with:
> "cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4"
> 
> It seems like the CFMWs IW should be 4?
>

It has been a while since i've interacted with QEMU's interleave stuff,
but IIRC (at least back when I was working on it) most configurations
had 1 device per host bridge - in which case the CFMWS IW should be 4
with each of the host bridges described in it.

I'm not sure you can do multiple devices per host bridge without a
switch setup.

~Gregory
