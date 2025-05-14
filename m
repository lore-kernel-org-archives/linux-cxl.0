Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB917A30B
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239332; cv=none; b=ZlxEMsGha/a4lD5irVUMLzAjB5VbEG248vdvgkka258EJOu/oTXN67HSPb/YRzrOhhPe7Ywq9BCqi626FfunWLAytQOXBIMnzC9PMceRNDYbQLd3NSJFiOpZ4FqRbsUqT8jMtfmZTBY7p16kMWV6lLqzk112vxsTJxyWdMVYJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239332; c=relaxed/simple;
	bh=MOxyHWl/rJy/DNY9tEcIETZJ+6vujk0CnPvehoMYqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK/7wF6RWSSSZAFFR8H7Fl40HY/o4H8MQlp0K74bqVF3CzKISfmq7G7HwXALkrVi8YaTbvNmrzd8X1oI3Kz1YhR7RMWmQMshNK3n9KMdE4MURprucj1fk4JNNMUfPFPqq3YiNEPwDgknLJ4xIr5r1l95epKcWSZFakm4/ciFz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TVfODUWU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TVfODUWU"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so372216d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747239329; x=1747844129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vevGlb8uVwTNYe2sjWvbHQgWlTG0WG0pfGd8aEcQ1vc=;
        b=TVfODUWUog4X6zm124Uh1ejhQ8HioUEUJPWC6lXhnS+ZblQ8/JKEWKTFgufdCLh2JI
         P53pExqgaVup5LLDBBWpIunX+hUS5rkbjY9LhCn6shX6FdNhY7X9+wg5RSiEcOCT6S5e
         9ENLT09pNSG3zO9pv/q6P3zDfmKcV8WwR84eRyexp4gVtbiRkqxGIwGrmCw8B0pco2EC
         5C3G+rcfCwKOgB/Nt48rqdx+5x/fANVZcKsGQcOgXy9nHCRek7Ef4hN6E8g19bXpxWnv
         CrKp06eRAvmR2eL3iOXW8NmRJBz+WWR8x+NJ3S0GRGaqHyiaiS52VA6VuudujXK/Qb+R
         wbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747239329; x=1747844129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vevGlb8uVwTNYe2sjWvbHQgWlTG0WG0pfGd8aEcQ1vc=;
        b=QaBjQdSkepwNOUDRdfWr1z1qwepJ1pXWyAylY8H7DRAEqj+wobbNI+Gg+FfT8s40SJ
         uI9TNMP+NWnYX3MJ0JpfuA+6vfHBMIb4YssIo8yI8zMBNxWICxS2MdtJICmbEa1e0yXw
         Qu4D79jet5iwUFTl9nibnbGbj/tW7UKuSJsJi1FYQkBWGs/1ze5RQFI2aWQ//YEOygZ1
         a0HuSQ86dkuiN0DmEUeJupXvsPznbPHLHqNrmOUKjFaEhKjzTVuVTo8cE4f9Ts0yEGTG
         ES5exY0S4gj6/BviNf0k2RTbeUNfwG0bzt/QgxIKXbcXfpI2flDVaE0swHunWYaOgIvF
         Xt1w==
X-Gm-Message-State: AOJu0YxtQ8LrjK6UBcCkRZkceyC9EfKUcbOyfhes1yJIYwuBbcgS9VRQ
	nOJBO53wBfm/V0SCTrwE0dy7dSwOTRytxnKkWc7BJh/6UXGjlnzCZaw/8idyxBk=
X-Gm-Gg: ASbGncuGgHATA/DEeHcGGwFLqaUNuYdwmtYFrRcVc0KsexDT9PZ5g0dYj7wbx8llK/C
	jNK1AQHLh6LpIK3GPjVKqf3QThIBI1hdH8TOD5ZnvGOg0Liv6tmGHZPU/8SF5xrYMEu4mXP3eQF
	JomvbqM66fg73gkRT71q+RqVM9DTdfAxqJKonELYFCQh70BIHCk5WBxbmHhDy3Hd6c2pF8VxIK9
	TuEMAA47u3I+pOGkscIN2xVfeQyn5ElLnok+XMrOQcBUpTIVffJYfgfIPgA47FvMn+l2z4R+vhc
	ARXhiZI9QjcUWzqWyzbzN1wAJv0HN0dZ2Ckca3O/2HMCw1Kd3Qf4yoWLwS49qxMdbXPC5odp6yY
	2Qop326sZnZ6xqJRRjBFRNNLKazTJ0mo=
X-Google-Smtp-Source: AGHT+IFa4sPpeXUPRMA0DeCDP/EJF4h7X9Ub/2caveFR3SOldzSSGjOYO0/8BJuO7IYI4CBkM2Z4RQ==
X-Received: by 2002:a05:6214:1254:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6f8a31e9146mr2080616d6.16.1747239328871;
        Wed, 14 May 2025 09:15:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a539f2sm83279946d6.109.2025.05.14.09.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:15:28 -0700 (PDT)
Date: Wed, 14 May 2025 12:15:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 3/4] cxl: docs/platform/acpi/srat Add generic target
 documentation
Message-ID: <aCTBnrSwBNEvTDZF@gourry-fedora-PF4VCD3F>
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514003133.584401-4-dave.jiang@intel.com>

On Tue, May 13, 2025 at 05:31:32PM -0700, Dave Jiang wrote:
> Add description in the SRAT document to descript the Generic Port
> Affinity sub-table.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

one wording nit

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  .../driver-api/cxl/platform/acpi/srat.rst     | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> index cc7687645de7..500413b96e70 100644
> --- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
> +++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> @@ -42,3 +42,24 @@ Example ::
>                 Enabled : 1
>           Hot Pluggable : 1
>            Non-Volatile : 0
> +
> +
> +Generic Port Affinity
> +=====================
> +The Generic Port Affinity subtable provides an association between a proximity
> +domain and a device handle representing a Generic Port such as a CXL host
> +bridge. With the association, latency and bandwidth numbers can be retrieved
> +from the SRAT for the path between CPU(s) (initiator) and the Generic Port.
> +This helps with constructing the performance coordinates for CXL devices that
> +are hot-plugged and not able to be enumerated by the platform firmware.

This is used to construct performance coordinates for hotplugged CXL devices,
which cannot be enumerated at boot by platform firmware.

> +
> +Example ::
> +
> +         Subtable Type : 06 [Generic Port Affinity]
> +                Length : 20               <- 32d, length of table
> +              Reserved : 00
> +    Device Handle Type : 00               <- 0 - ACPI, 1 - PCI
> +      Proximity Domain : 00000001
> +         Device Handle : ACPI0016:01
> +                 Flags : 00000001         <- Bit 0 (Enabled)
> +              Reserved : 00000000
> -- 
> 2.49.0
> 
