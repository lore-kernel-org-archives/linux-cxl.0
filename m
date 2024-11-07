Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671AA1EF087
	for <linux-cxl@vger.kernel.org>; Thu,  7 Nov 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982907; cv=none; b=TMQzEFm3o7oqMos0vBkuUiBpj4ywPsmzCXjJ0/7UNqAMHAO8pLCSB1gcq0KJFkGMgElKXxf9vgqzdzrsQbyOjLsXzbwBTzJH3Ex01MFqGSnPSFYecKeFF4iPsybJWk8SxwM1DiO74h1zAkfX9v/6riTBqHMMvSZjf6UG3UUZ/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982907; c=relaxed/simple;
	bh=Esda7sxbhP4fmYNvQU/wAslDDgX06gVPKFPIdwfsU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aedCyhHORekDpqFF0QJ4SM+spj13l9px2o1NMvqfAVxZ+S1qiJM2p2rAPQpUVY5/TIPEaNdgZ5wFvLwtR9jxgIt2YGZVHvJo3XZpb3tpw8u3PoMlYClxEhD2jQ4HHOL6o+Ba7Sv60HiC83WzBRcd7GyMW3BuxhGUhqKZovFwIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/i8KB/e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/i8KB/e"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso7643145e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 07 Nov 2024 04:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730982903; x=1731587703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1E1HnzW14p3ky9k8ykLp0FSr/w1f40YmC6K/07hNjw=;
        b=T/i8KB/eFyxCVOLSP5PKRigER5gise95lorYfWRq3a7ivXoa/8je4UVKYQ+GDhGUJZ
         o5FjBVw72GkKE82oknX9mHyl/hVCPQJOEh7Ao0M7fa/L4+e1FVaJjyyDOBJbr7KsoCZg
         EzKvM7yAgPG3ORpajHmifSdWODITFudOfntxFy/WeOJxV/hlBJu2Uc49f46l69uLvefK
         G+ha8qw2HKGsrMQ/VmNa9Axg0IppqFPvCSDmHrRSpBK8xS6tKo2p8Y4RYKDvHlTNGClb
         k6VnulrYWsmAXkAk6gej0TVQksuhYniHePVvPKNR3qma+TRlxveI5vmbiaHTaiEDn77Q
         NWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982903; x=1731587703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1E1HnzW14p3ky9k8ykLp0FSr/w1f40YmC6K/07hNjw=;
        b=BQFVSMh05Ud0iUuE+nuMJokSdJoTXAObH/O0SGGpiVsIkG5k03x4eRoi7ejEKqc0+I
         biHzYsX4a7rC/7ZR6qZPRkm7LndLvp3pNSbgUt9E6JsuI6sqWdI2p1O/4H5Kxp0iWDOE
         +27jOIKdJwI8Lkeg3BWfdwi/Msyiw0HY8/k+8wR9nt6zOyPkSauXRnhAHLzBpiqr5pmC
         fZfd5BeOJOLhj1RMUKY9gcCgxho+cuDw1Z+YzshrOEeJhCwxc27L/88FzOiBb/QuXFfg
         //HjXN994FgHnplMGUpojslnYo1IwP6J3s2l48u/a+dihnk+WZRLKuGHQmhA0UjY1xiF
         C13A==
X-Forwarded-Encrypted: i=1; AJvYcCWw2puLu/6P+Q3l9o09ixAd5G1av78Sf0LYUZJgWUuGkKzModHLCJsehpcB8q+MxTzqeX68m+zPGTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuDQ/v8yjvVLYWfMKPc8j8XNWtqZd6LaBkmVYvk8taomcB7YI
	BCugG/NXNk/xwv8vc8w/OoTjAI5kG9ZQrPGxHF4OpjPGbSfElarNcWGJCKRT+Xo=
X-Google-Smtp-Source: AGHT+IHN/1L/dUoeYcgUToN3r4u5BpldBQGtGvcGjc/Hw9fcK0iHSssfgI0Mi5Z6DtlW3jdu9v85TQ==
X-Received: by 2002:a05:600c:5618:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-431a01782c6mr381936165e9.22.1730982902712;
        Thu, 07 Nov 2024 04:35:02 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970d10sm1603880f8f.20.2024.11.07.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:35:02 -0800 (PST)
Date: Thu, 7 Nov 2024 13:34:59 +0100
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
Subject: Re: [PATCH v2 2/4] Documentation/printf: struct resource add start
 == end special case
Message-ID: <Zyyz85FfUuLv_oo7@pathway.suse.cz>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-2-123a825daba2@intel.com>

On Fri 2024-10-25 19:46:54, Ira Weiny wrote:
> The code when printing a struct resource will check for start == end and
> only print the start value.
> 
> Document this special case.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
