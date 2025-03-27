Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430D19D07E
	for <linux-cxl@vger.kernel.org>; Thu, 27 Mar 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093395; cv=none; b=OU82gKwHhOIiDYPzgftpHGbD0bHWzCaMryHz9NPGrI/VW83VbNvM0GCwwhrmJ76Xq1Nia+QesewHwIxu3wHMLxrFX06szUYBxhF3UGEvg01atRonCEmnk236tEyEE11Kqk5FAwoArRktKEufAACg/YkE/zLyqzGPEcHobko4vhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093395; c=relaxed/simple;
	bh=nReZi+VOeU0Ba5miapQ8WL6XYIaNx00NZdiZI3kjEWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amH2QBG40o5rpXKMUXnM3WS1WCPJhPy19ckb9O6nRB0QbKrfTJPFgcum7VTlZnVHb+hcsQg/7WHY9AhMGLRMcVQUURkgurnFsWSahN20rflT7T9ltPkTDzwM09ACSBdcFWDIUkpkckEwCGy7Ts5PR+yIu4ZTxxPb/OSCEuLQuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MN9inE9y; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MN9inE9y"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476af5479feso10856391cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Mar 2025 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743093392; x=1743698192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6nmPtMcFozMVlKfXWHui9y98FPxfLmhj5/nXxFuAmQ=;
        b=MN9inE9yHBvXHZaMVm3yJ2RZJYm/z9JErkboC5ShGYDeCpTqJXPbCyWe6WsUvBfe5k
         YMq5DF7q8BSvMLBglQ6+VXc99xH58gOnZj6d8Md0ANkd6Q/f1dxbHtBi9n777+cmG3o/
         KB6aLwDJInYlAu/OEII2WU4CLdODhGSu8IHVSWCA/dJu6EORcAG3j0+qjyOdILOY2Qv5
         0ytBtWsXFKjkGHJ+qsewSzdgZf4aYgTX2R+yGTB+UnRKxMyfMVteNsU7+MHnn03qkB/3
         PBEkZxmNEqGHcEPDwpAn0V2YNEjxTtmUHndOIEvpApGxY/QTqHhhS9B5+fI1TWUG2TZW
         XLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093392; x=1743698192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6nmPtMcFozMVlKfXWHui9y98FPxfLmhj5/nXxFuAmQ=;
        b=V5AK0NNLcTuqE5DHSqLSqkcrHMZnsLcnYlOZv49nUONbAU9VKQHrGD5AdLbJrJrmFZ
         1KwKxHmjkhO5H+obEugjfSS25DhAky+TlIyMDLW5ukDiQNg3WziCoTmxj9ua3yJWP9EQ
         76PLcBLt+FKFsOQM1miwXCugHD4msNTqI1/YOsfTyH6MJXZ2ze5Y5td8/0rHqlQjRMfn
         KPycFYl0gAnWMeNsZMVZ5jcl09PhJCofFgC7eBxaYOh7Da/THT9aYpOn7Qa1sToNnE37
         +e35WEVTHx/vumLL2G7EKD9JBkLbT4FJd20y2M1K3uHGc3YvpuTEyQUtFj2VLrF/bS9M
         sXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW93GFsD1bbuxDwhPVbef0jEHO4aA7ckgFIXvuexm5FTa+8VJgwILbGC9HaraDLbE3Bl0B5HL09DlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+N2tmfBymlKJ1S1VfWYrZLZlLkQdaVG9LmKgEOZViq+0Be1aC
	P57xLefxth00muFzeCp/Lh0NA1xOYx8YggwIWNIUJcsnWzS4ORj6j+JmNmYJZYM=
X-Gm-Gg: ASbGncvoAhmGU0GYOfi2X3UjJXitj14ZDZVVi5gMl0ziMFQqi4jt9HVQE2jzfNI9QmT
	p20lKMYXlEY2WyOa+0jsTgMF+Fjz2xOor4Mj1QMSA8WAqQIj2NJQ8uDKu9BG3ZPR6Xz+H3ERRNT
	DICUtWRcSQYbMaA3VvsTVkXtbCKttAVUs4wce6M+zfcS3KI22rRDd7XNrD0V3mJj6Su4Yhv3Nhv
	mHJIEoKZwz9hte2fG8vEg4iunN/04p4wi53Hya8yVtDq6NLBxWH0GAf+r5reyRiHChZzCn97I0A
	mRv2ApV90mk9QI6OOckZhqatWhpJGNv0lLJQy4LGVWcXTzQFVKqq2L5uVmYguWfy8M4SLbe8riC
	0PbmadIetPCK/8CL4BvAuXQxJxms=
X-Google-Smtp-Source: AGHT+IEKDp2tVzjqYEf/u9Xf5dq7fgG/yV3w98pY6ajt4Xqr/WEW1Ke87vrKun1BWfCdi8hBKkoBkQ==
X-Received: by 2002:a05:622a:540b:b0:476:a895:7e87 with SMTP id d75a77b69052e-4776e237a2emr74047841cf.48.1743093392404;
        Thu, 27 Mar 2025 09:36:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d520103sm86026311cf.58.2025.03.27.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:36:31 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:36:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z-V-jXYsOfQDvCzc@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
 <Z+Ubvvrj9DovVs71@phytium.com.cn>
 <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
 <67e550f39d57d_13cb2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e550f39d57d_13cb2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Thu, Mar 27, 2025 at 09:21:55AM -0400, Dan Williams wrote:
> Gregory Price wrote:
> > On Thu, Mar 27, 2025 at 05:34:54PM +0800, Yuquan Wang wrote:
> > > 
> > > In the future, srat.c would add one seperate NUMA node for each
> > > Generic Port in SRAT.
> > > 
> > > System firmware should know the performance characteristics between
> > > CPU/GI to the GP, and the static HMAT should include this coordinate.
> > > 
> > > Is my understanding right?
> > > 
> > > 
> > 
> > HMAT is static configuration data.  A GI/GP might not have its
> > performance data known until the device is added.
> 
> The GP data is static and expected to be valid for all host bridges in
> advance of any devices arriving.
>

Sorry, just shuffling words here for clarity.  Making sure I understand:

The GP data is static and enables Linux to do things like reserve numa
nodes for any devices might arrive in the future (i.e. create static
objects that cannot be created post-__init).

If there's no device, there should not be any HMAT data.  If / when a
device arrives, it's up to the OS to acquire that information from the
device (e.g. CDAT).  At this point the ACPI tables are not (shouldn't
be) involved - it's all OS/device interactions.

I should note that I don't have a full grasp of the GP ACPI stuff yet,
so doing my best to grok it as I go here.

~Gregory
