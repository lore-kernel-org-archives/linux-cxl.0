Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2068481674
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551309; cv=none; b=P+VxMsg9/jR0y8J/ZvYZNKXeR5DidGtom0Mx8QQTsMtTX2v1jq5WxhrkPHeyRKi4I2DhOEU3xKO5Pnt9Wn5xQstzCnvkGt1bo1ZSlllPvuV77x79yulUjxif8QFAxvwy9AczkDjRynmeZRf/u87RrilBJAouGXaKTx6Sj0RyGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551309; c=relaxed/simple;
	bh=NtsBp2W1pQybKA4UPkA2oVzLpNH//0FRgvlfLKcyKyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itI02pbdkaWETYtmGNqtsL5H6jNu0Urf16cyGhzyhl6HgnJg3mzyi03o5frFUpLgl62OlmoOC/+RTOkCF0L1lLXWWa3I1VI2oHjMkIwOXYR81F3O15t3+mrnVCnRpfMQ7q+hWDF0QhL9gNZKhRZJNss4UYzlM3ZDOLP7H9cJSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KxPilzr0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KxPilzr0"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c9f6b78ca4so766801485a.0
        for <linux-cxl@vger.kernel.org>; Tue, 03 Mar 2026 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772551306; x=1773156106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4f7AJE9Hf1AkTQ9xu88RkQP30gDThVvvbzKhqMXGvE=;
        b=KxPilzr09gPSV0431YywxjeTclVFlgtyEGz/u3mNWwCcNs2OUFh9A0W3Iv8xwUKgFR
         r+jZ3TGfRQ0iQTedEigVr5dN5A9yBFn5jmGrcC8R0eLCV4R4u90IBR7cdBm3917aFXX/
         mUx+YJot01OWr0+/i5UtuS5SQoRhAfBF44ZDSA2BPZSbRpiwjSvyozi/DKPfw+S77xzi
         xjo8FHpeTACz3tgllfg2lm+cyb3piftFZvUPPxBoBNZ8m64BomTv6YyTejxlFKaUW4L6
         puOdZn8UTd+3fjk2q8QFXaftEXWJaLrhCm/B5s9aCg1t1CIhn6awVXeqPyWDY2FBYYSs
         jxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551306; x=1773156106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4f7AJE9Hf1AkTQ9xu88RkQP30gDThVvvbzKhqMXGvE=;
        b=tQ9ZdMbTA+3YcL5c0YL2MJykgdF3MPMdPwIRn9llfaRcP1tHLY0Lwj7uZy91l5ITt7
         im+DYs0iglq8q82jiWZ+2zmK8iZ8pWDQQLwoe6X7HdiA07y4fVcvnwH7jBmy1MC2pSvp
         qNIKjShzghFRrCyHrR+YDytBwAI3ua28evPxKEATvCjfLtZS5Ya9Y4GC8fLCsojCWWVP
         tJ9hZctcT/7JP5OwiV79wfptZwmgV7PFn/2sLLV8aB61xtCswMkCCyO/sSm35c+cXIEd
         8gvRXnq7yi5u65swV7eUrcmShKJFWDuC3NSc9sVQmf7gQpOLOd7+EC5LhMv5KQT6Uhll
         7BEQ==
X-Gm-Message-State: AOJu0YzTMsF5/yT14hFCiWVskPYhykXdK34noAOXDckY2FnQeNO6rtRd
	kA4u/kpBrPwSyId9gHVzY1xQU69yDCF++KoCOHGJX9hJP7OLpb/Ou4Fl9raVAeK/Y3TbMfhSVqS
	s8LZI
X-Gm-Gg: ATEYQzxiPPCKowfCk9TbfBGDDm6PJq+FjeiuS/jS0y+i1fJn6nmVg65xmjoQPflVW1S
	Wv44qi4UBrCoH45LmQDjDzcIfaBl9b7YkwTc72yFxmbgrceE6TFn533meh3SaD6OfP/ttd/QFxT
	UyZSfqYXS51vQN1q1xeTHg2SOgCghrwnzMnJOoJ3FRAA5m1QVGKgTi/7jOvsPConuHBzTJyLiAC
	lYn8r0f90j4V7YMLA9yuWsv1o5PUU6VayUYbOJqJO7tUFpyltux1VwctX0H5hR4lf/wt1zTFky3
	VIU2ZyaRUFwULeURD5FPDvsj9Du4S+WQtAltzvDMpvGwrLR+dT8/5/5Z8cS025GZAnOoOnwrjiN
	+pKq6ItGELXLb2BaDAW9S484+uXr7wHfsKcU6IqCPd8qd7BVrvSWhv/p+U+b8xVUqoc0P8bF8aK
	wbaQFuwTKRHYCBCwLippI/6X0Gl6e4KNGzXeIuk7NZtbsElybZBgFeYB2fyWjOl6NLrUkIf/fMA
	nqifzsqMg==
X-Received: by 2002:a05:620a:410a:b0:8c9:f996:81fd with SMTP id af79cd13be357-8cbc8df3b87mr2141883285a.33.1772551306461;
        Tue, 03 Mar 2026 07:21:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66f31asm1381560685a.15.2026.03.03.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:21:46 -0800 (PST)
Date: Tue, 3 Mar 2026 10:21:44 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
Message-ID: <aab8iL8wz_sdVWyN@gourry-fedora-PF4VCD3F>
References: <20260302200429.803417-1-gourry@gourry.net>
 <20260303101330.000039a6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303101330.000039a6@huawei.com>

On Tue, Mar 03, 2026 at 10:13:30AM +0000, Jonathan Cameron wrote:
> On Mon,  2 Mar 2026 15:04:29 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> > cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> > cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> > 
> > When CXL_ACPI=y and CXL_PMEM=m, the built-in cxl_acpi attempts to
> > link against a non-built-in cxl_pmem, which the linker cannot resolve.
> > 
> > CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=m constrains CXL_PMEM to
> > at most =m.
> > 
> > Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> > built-in caller references a modular target, preventing the link error.
> > 
> > The result is if the pmem/nvdimm symbols are not reachable at build
> > time, then at runtime it will always return -ENODEV.
> > 
> > Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> What's the impact of this build combination wrt to whether the result is
> actually useful?   Is there any point in building CXL_PMEM as a module
> without this call being made?  I can't remember and normally don't care
> much about PMEM :) 
> 

Basically no, it's not useful, but it's some definition of the default
depending on your olddefconfig, so rather than fight with this further
this basically terminates the same way DAX_CXL=m terminates.

tl;dr: You don't create the dax device / nbdimm and you're sad... but it
does build!

~Gregory
