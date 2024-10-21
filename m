Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2D13C69E
	for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524728; cv=none; b=MldB5ODucaYWnNGXxduQdsz4B26pUsCaAtex9opzFB11ndpkNhu+k8Pvk26kn/D6axINzfg6p0CsfAQxh7dO3BcWETDZ5vT2B7a10w1Rjat6UP3rZb8V1Zimt6JHRXA+o0Idx95TIwFmaM4UQZeDX/GGk9m3qoIjG/SSSe1SjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524728; c=relaxed/simple;
	bh=mX2jg1oLl7AUYwIut26GOsQVhxNshrPlFBvHi2hIXUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psrL2koicgRnPsxcXHPfZtOtU/+kxGSKDbhYRye8b8bUGMmVa08EGk6W38juGc+SzWwI+LYnvdQMDxsuZuuN26Iensiqp70f5pZICM4STgDiq3X21RevwZr32AHeEof5CTh5cA/avq5Ym24Vgl4RNJOAERtb81xyIOWgsuSHHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrbO5bX4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrbO5bX4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314a26002bso51318885e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729524723; x=1730129523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sw17opVwBt6bWflM0xMADPZdAKdC/1Qrzfm+uXql74=;
        b=WrbO5bX4sSqbIFzs037XzSGxju4Lc9n2D7mMpj4bI1dx5a/27UEMAQgsH25US+9E2k
         OeJ4LmnX4FU1woCfyWkNOfE4pEbnKh7XsCTBCEKKjnp6D6hGVZwgYy5w/56BsAAXSz3C
         W4Wpd4mW8iYsRcs2yxnaM7q36KWWrIMzf0Ubg2+fHjekWO1Vb2ipiAHHDBLtIOy5kJKA
         SDMKgqTr12v1U/CGMWVuGsGypynVbvb2FonmCXQFFcjZ2gSQ+HSbt+Eh//KgBXX5NErh
         oX5nU4XFmA4CmzdkLAL4tK9s1u7kakoJAp6YxU5Hkdif2apYJT79lGLEoz1MX5B0zEBc
         NUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524723; x=1730129523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Sw17opVwBt6bWflM0xMADPZdAKdC/1Qrzfm+uXql74=;
        b=WLwMV1qNeJnC972Y6zl85W0T+yWyqvYpkrMc3goYEminoeEy5nbXSf3mqQB6F5PjE9
         bjipVy+0C499/MUEAkDCl/n7+dzH8wy2FUP/BHdrxYnhJ5/lbaS/5EA+P8E8HCuAxnZ0
         ihpAq9gVuz9RC9sUEcYt9VHFuwOokcxAjuMX80T45ZVWiSnCiUW3cojvPszRG0UbkcP0
         Awnd7j6Gy2HOZIiZeuTLG+D5ta6HcoW+83dcL2z5Hq/pNdaixW157BehfTrvj3bN7yJ7
         7BY9zEj4T4BE4r3+MpFFAWxQfKa1FkraDoqSuLYinUIUxa89iLks2fts1q7jmdnJTQpp
         iqDg==
X-Forwarded-Encrypted: i=1; AJvYcCWSJp+xm0wm4E75x/iYUskatIv3p/x0lTr9bwKwERYw5/D3EcZa00ij7OxdroAtrIh3d7UmTPZDV0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+4HEVZnIvCOJxnCVxaWzB2e2GxAaaIKD92NrBmkX8Fh6aVcc
	KSk0irwib6HaBtT5jpfZRifat0tzrukenqkMgqdLteYQTFdtaQcqSPgnMDGCOQ8=
X-Google-Smtp-Source: AGHT+IEoR2d54DJGTrjrHFcVcGXL++rYN0s7z/kZedhal20EZM7JTRjw8advU+JT3gK0AW6eIIL2og==
X-Received: by 2002:a05:600c:c89:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-43161632eb2mr98222425e9.1.1729524721972;
        Mon, 21 Oct 2024 08:32:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570da9sm62372375e9.5.2024.10.21.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:32:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:31:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] test printf: Add very basic struct resource tests
Message-ID: <ZxZz74WSRh4IsSbS@pathway.suse.cz>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-1-7f49ba58208b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-cxl-pra-v1-1-7f49ba58208b@intel.com>

On Fri 2024-10-18 14:46:24, Ira Weiny wrote:
> The printf tests for struct resource were stubbed out.  struct range
> printing will leverage the struct resource implementation.
> 
> To prevent regression add some basic sanity tests for struct resource.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Link: https://patch.msgid.link/20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
