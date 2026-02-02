Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E901DDC28
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047299; cv=none; b=XPVQALG7ss0ep5ksc4faCJFLPNqUwqr3oKV2qag4Hu/tEl7iiPO8gen4kzPKv63lZvQDM9u6Np+JqixTln6OIQIghml3tKCfD1Bik2tOhGffPPSXGs87+Xz4jcom4vRemhXkc9UHGQnp2wS0Vkk4Fj5Fpx5JdEBFlcZLICDZ7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047299; c=relaxed/simple;
	bh=Afj17x91EXbt8Deh0bJOcz5m3G+WX3CU1VA7oRQAHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8NWSGLGOqUWSVJF3HuSfXvVzWySTQERnJN+jq1SAxeSAqEUojUU0PIgMusXgj0h0mrvn2RX9HWNv4TV7689pxo464Y5xJCsY0HUg1fWU9hy0FUUw5f0BIHvQuXL8PIXbNRshs1of7ye9EDHH1Ns5ZlRQqg73tdVhoq7b87uYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NPtfqoEs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NPtfqoEs"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5032e15525aso48219831cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770047297; x=1770652097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lZnq3PJuhpE/1cANdV/zFSL+6ANg7Z+AIOF3gGB5qA=;
        b=NPtfqoEs4DDq+ywwZLt5DS2h2iLv0IqPwXJvq8tw/8ty2OLPZj9JA5Ai0NM8JX/z70
         ekZINBlJ4YkqOrdKJ/ll4EECdSastaOfTPaeXiQWVsJvXELKnb8IfU8WnbN1l9YwP3pO
         2aBL9pOLKKM9Hrk2nHL94O41NhK9mIsyD48k5StsWF+REQHb72FvVy+GzpqjMSTf/nW3
         bNhLN3UqUWwXzgFamyqDh97SHsdEiLtmhlD/1vuNU5i2reM/YQZUgKI2irxT8BzQoYIH
         0em/3ZyXxJCfw78H38Eb7B2EdkblU+60VZjbNfmiqoCymV+zkh+JR33+PcLFQb2lpOAC
         urFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047297; x=1770652097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lZnq3PJuhpE/1cANdV/zFSL+6ANg7Z+AIOF3gGB5qA=;
        b=IBuHR08MlL9/J19QJLXh0pWoIp2YiFygPNlfPFDB/+qRaFsuyx2BXOrDvH3NCjvCHC
         b4s/z9YkU6COuSsAUJAzDyIlY/3Piy+lP8jm4IYUSTCp0mh6soDLjnR/Dd54eZL2GRxr
         +23b2rGZdDBsv0NZtL5yCQjJNKMk6uVSiC2udxhTjUtBb2bjqAr3SrppY8A6KiAxeXiJ
         u2JUUVu8Ih1+Z/vOI6WWq0sCeCZ9Qx7GWkcg5gPBtGqeVbv1enxFUuH1jC4THTIJi6uv
         plzw6kv95e3+Z9YQI0sdAUdak2vLqLThzpVer+57qgnmjJ/45cct4uUZxCunokY0PkIJ
         c2SA==
X-Forwarded-Encrypted: i=1; AJvYcCW5xv1paPVkXNeC2R+vuBU5y7+8rKlS4rQJe5y6f0hCt/c6zGgYQc4IY6VdG9ZulI22dlbWFzkqgHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx172FO29kn3q+g61rqMXaouqnNj5O8s75zfpG2atlbH7UUlDSd
	Rf1SnKWBS5SYf24oz/mdJRqp4XfaqnFOnlasl9mjCMQqlf7xM2tCEmp8pSKifAeZQEA=
X-Gm-Gg: AZuq6aLGLqtsVFeG8xgPe3MpZxSMenEjia9i1gLwhaGTKbreG4OvhggtyKJ7OGkCEYr
	UE0tCqF0KrHFnlFiYM9UdFhIUxKLgz8Ar3E9ADpYtQiAd3pS2DX6ib8l551kGT55Mlifh0BJIdV
	BIyugvdCffIKXdS8Lxp8Z9TojlHKSGDSK8nWxTr6yD9Jblqt1jdGTmsmQS7w5yYP4ghEr8ViO0G
	IKrMhaVUUg79DeiAcAZDKejI2/bWZYcQg20qtFblPt24T0BaWLPI5ZyFD3ClFKbB1WpM5UBJyvo
	UBo4toaxJfBmWMmIGFwvgTRnV1o4cp/vZKCD3i45B/Tt5fgRB151XHa9Jr8ns1iAOo2cS03xOgm
	oGSBsGzkXQsI1UvT0NVOdHTJfQw1ocbohPUH3vzv+LBBIWCSkeGc+KzV3yfM0XaeQkX6HLzcjr7
	wD0JbKWRYLH3II/iDvUd0X3T6IYc7rvBDkYRusj/Qoq/I33oi0Ab9eP22foGbMbBIGUcXl4A==
X-Received: by 2002:ac8:5950:0:b0:4f1:de1c:dfa8 with SMTP id d75a77b69052e-505d2190592mr188572491cf.19.1770047297079;
        Mon, 02 Feb 2026 07:48:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cbdc24sm112264261cf.32.2026.02.02.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:48:16 -0800 (PST)
Date: Mon, 2 Feb 2026 10:48:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Message-ID: <aYDHPhun61wkw7Fi@gourry-fedora-PF4VCD3F>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com>
 <20260202144103.000016cb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202144103.000016cb@huawei.com>

On Mon, Feb 02, 2026 at 02:41:03PM +0000, Jonathan Cameron wrote:
> On Sun,  1 Feb 2026 17:30:01 +0800
> Li Ming <ming.li@zohomail.com> wrote:
> 
> > CXL testing environment can trigger following trace
> > 
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
> >  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
> >  Call Trace:
> >   <TASK>
> >   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
> >   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
> >   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
> >   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
> >   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
> >   platform_probe+0x9d/0x130
> >   really_probe+0x1c8/0x960
> >   __driver_probe_device+0x187/0x3e0
> >   driver_probe_device+0x45/0x120
> >   __device_attach_driver+0x15d/0x280
> > 
> > commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> > initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
> > However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
> > valid endpoint.
> > 
> > Across the CXL core, endpoint availability is generally determined by
> > checking whether it is NULL. Align with this convention by initializing
> > cxlmd->endpoint to NULL by default.
> 
> I had a look at whether it made sense to use use IS_ERR_OR_NULL() to check
> for validity of the endpoint, but it would be somewhat fiddly and I think
> you are correct that convention here seems to be NULL means not set.
> We don't need the error code.  One comment inline.
> 

doing validity checks on pointers by checking for null is a pretty
common convention kernel-wide, I would consider setting some structure's
value to an ERR_PTR to be the aberration.

So yeah, good catch

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
