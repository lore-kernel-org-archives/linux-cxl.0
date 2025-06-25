Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C91FE47B
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893518; cv=none; b=Hrqwzl5gB8fXvwHVuu2GJKxHZA7t2WpCvqxRBqIRkRRYTjxT9bqjyTncmGMeuZIS3eaMfSdNS+rGlTFLqMi/kbqjjG3xIcoijL5ITcXmq5wcmy4XkhEJMIlTGdOnUaSnChN9oBTL1BtNCGqcy49P+hKBksGLgjfeOowj5U+ML6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893518; c=relaxed/simple;
	bh=o7nWOpB8g4zXrKnObOSxdMpT/uFNKTEpAMgxA33hsCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svyrS4mWr1dbcK4KI0Hyt3aEk+lceNQkP9M4sTRE/IoaHdJdHa6u6Xd6xq8N6lx8pd3DLDk9cIoXnP3Sx5lm1qg6DtN4T7prQXuCZ4IztRGz8anlJiL/SDapr+eHca00ff511RTXaRf/4n2sQXlEsuT7iCJXhOrhGVI6KHtC8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9da6tqT; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9da6tqT"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-40a4de1753fso254893b6e.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750893515; x=1751498315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3sVHvu6rqtfwSzthUoBWhxdxzvIuGv3z4vvAxvJak0=;
        b=B9da6tqTxZKgCi76jYrsE3NbCHbppkVYsBHEgRgO6HZB1G2Aw1jwIHjNv61b8VdOpx
         35fwFuwr3OdY1rwKlZj9uAhBYM3OltPHVGSnLGdqxeiHevkqH+liVoTg36RnEIfgaGGk
         MDE4sGotloFu8XLGpb+YGu2xCzsVMsskCSOgLcG3uAIttsWk6DHavIbBgPM07X7who7A
         5Z19xQ4lNhxdkhM7GHDqjlPE3fdjhMU+ZCPaJsl20RXcYj8Ptx8rWwxsWLmN6mwCnHS5
         6qjUpZb/X7gj4qpRdN+9wmsTc9ouT3t+JcEl+OssCGeTu74oEVnVw6x1RsZu3dJR1MeP
         CjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893515; x=1751498315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3sVHvu6rqtfwSzthUoBWhxdxzvIuGv3z4vvAxvJak0=;
        b=X6TFdAdQ/CFvmT66voKYaGufW4zo5n5SmXTTHQ0XuEwSW9v9buxLEHaA2DGVQcpCCm
         kL+H+r0OJQn9sKkcKpMmrW6xG6UpIc6rcXiQ0U/+1ban1Nhxuy8iXzFNke5ejA++ryvj
         Cq3XN57FvNH/fW8S8Ei79Wdq3wYcr9gN82hg5UKD/MpxuEj7Pd3KYd89//e2HgYjIAsl
         vdrjR+isxe6QsVINYAUusde8Gg93H95STOMBaJ1zgL/FuYO/yip0O2C3TtYTmOQJYl/D
         JqHuonZum0M3K2Tf7LJgwb36kgTk7kKYpYnjZ1jJjTmLUqvWWr31Hn7qf+ACiNAYGJZX
         DOMg==
X-Forwarded-Encrypted: i=1; AJvYcCUdf3IZdZXOhSZQuVTGjCXJGDLlilCkPKMjTyrtoA/DfG0OiJcCs4WMljYJWzFr5MdCj1xYj8ly+ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7l6GI+LWB7Oa4Rw9zxQFGXfcefeO4x18bwKVSLb/6QRSdXR2
	itsOJGoP0/9/YuZBBvvRHXTzIM5uG3b/5FML1MeZgtn7HzsY26khO4yeZgTS0TuFWSk=
X-Gm-Gg: ASbGncvCAjcGP9mVLA6WOo6NXFuXMaEx5Aazt+F/b6IwF/tBOjncSSk5+6mfHGJdUOu
	p7uKvLokhETuee8YI7vpWFnM90G6T6WzCdFN72R3dWqKQfhtiYuMys6YsDfciAIUoKQj783p/5C
	M0TMfeEGNabS3MbfgRX427AFhMh+JAYneTl31TanuM0uSzJGrgDCIQNy+o/kFoMvuoGGakq9hvF
	ROfHxkOCVU3qSvGSCymmZ45t4Fc7ve8BGNRP3PcLUzXVClvyQqV9jwytjUbal7ttNhHLfVkYeJD
	wUFdauYsqd3nDLbrLFbDnOzPM/smweYkdNvnhQRu2Lum/avuL6eB8jV0n32VA6VrAfE=
X-Google-Smtp-Source: AGHT+IGUSOTDcMhyXVdEI7yCPybwKm55wAWpHQBu02wApjRIvEjewZ0uBQq+qXkoDQPhGY+OUVDZ7w==
X-Received: by 2002:a05:6808:178c:b0:406:8a86:6475 with SMTP id 5614622812f47-40b1c98ee06mr1362483b6e.19.1750893514886;
        Wed, 25 Jun 2025 16:18:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90cc3dc8sm2386202a34.67.2025.06.25.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:34 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:18:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com,
	dakr@kernel.org, dan.j.williams@intel.com,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <fee97bfc-aebf-47e2-8764-e998cf9a9eb3@suswa.mountain>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
 <daa7eb83-7413-4b6e-a241-84d306db0d43@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa7eb83-7413-4b6e-a241-84d306db0d43@linux.intel.com>

On Wed, Jun 25, 2025 at 03:30:47PM -0700, Marc Herbert wrote:
> 
> 
> On 2025-06-25 08:20, Dan Carpenter wrote:
> > On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
> >> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> Great writeup, but as Miguel says, this isn't needed at all, the kernel
> >>> relies on the compiler to be sane :)
> >>
> >> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
> >> e.g. I see a similar case with discussion at:
> >>
> >>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
> >>
> >> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
> >> Move a variable assignment behind a null pointer check").
> > 
> > Putting the declarations at the top was always just a style preference.
> 
> No, "const" and variable scopes are not just "style", please do a
> bit of research. For instance...
> 

No, I meant it was a style issue for *us* as kernel developers.  It
wasn't like kernel developers had not heard that c99 let you put
variable declarations randomly all over the place.  We knew about it
and hated it.  We only changed the rules because of __cleanup magic.

regards,
dan carpenter

