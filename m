Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2218E05F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945260; cv=none; b=ALbgdg/rdyyxhN3781n8ioJOSLbUAEcWO/N2u1Xn8ncjOCdDOSFrJkzeEBmgTGUHk2HRE1ndMWH22Do/OXP8Kv7tV5mnx38DxvQTPP/8sxMyJDIqa6gDUTixBORwIH2j1RXvJ+YaOVCi1lqKfTcRQ81srnC0cuxzXo2MLtozs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945260; c=relaxed/simple;
	bh=bwi1mR0efbQ0atvsf4qyXQh1PcxIKVAfo5HJr4vIwBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo2t699E0pEIK8h7imMjpvah1q/9Uxm3EY/yg6xYjDHnwnleu74XvzbYSGwpMVCGhGmclIXLqyaCmuYN5W3yCmD1meqL8qsYQoqmkXK+7w8MuwtCKM/93130F7d8a3ncOHskbtV3G6IY7GIE8tKLU/QddxjDUn77uJJR5MgLeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CYx9opYh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CYx9opYh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46c8474d8f6so18287511cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738945256; x=1739550056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh9k4RZRdW11QvhV/2SGJLjBOH6F/bON3N22ZTDSXWM=;
        b=CYx9opYhl31q/2AYWjYpTqcdTHyxH+OLIynlUI46WOYqRrnxYlGhj1rPs4rcg8xuck
         ti6YhnO7NmzTUYciW4kPEp+WjCYktggUgRXczvuYl/UwY8I3lvEpYCUXxDWCxfugS5ER
         sA2Gge3sZNXDjVjewX/oAC5li6RukBD7D2wmdk+0fYBrl+OWmDTjZwC3n2FsxYBTrQx3
         OCPTKpZErF0vxgPRw01/Qkqnlz/+L43NNcN/3i5D7v056e6W1NN2ci2/+U9ik1UXOlq0
         lXUndeXKh5OoF2p9Sy82tGxhRl7QFBfoU/wPTR0IZBVmL5ka9mr9xA/nwJhV65VVwdnx
         GZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945256; x=1739550056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh9k4RZRdW11QvhV/2SGJLjBOH6F/bON3N22ZTDSXWM=;
        b=iKOIVXBbABgiAd1hr3L/MPeNH3aFzWJAfgj8FYqjyP2rDYPXm3Rt3Y3ZiJ0x5Y78tn
         HmJ8gpmfSP+zF52s+EgO6d4oEg8Aw1ct3vRQYkCnI6WElVkbQZq16eKXs0NB6XTUOCSR
         Gb4lOkYkajpxm9+JJ1Fxgej7QMcfoWpVkz0FkH8vntXFEsKXFaC0eG7FAGpr3aq1atmB
         dZxaw3v8pYjhyQyNM2enoHfeB2DWW87HEPtPMWbnfo+/pUF3f0hrhgh7dNlMEjuGIuOP
         ITUPrS4F4ZdKqBrSVppFtedmEAMu7QyjuZGR0uW3bBMK7qOhmnDtHWjHtOT3rDbhE9ag
         eosg==
X-Forwarded-Encrypted: i=1; AJvYcCWqeexAOgm7o83eH+IeKCOMnoaRpuM/+UpFDEm2N0x4KzHRNO0hlE6NfE8yIkVrbdhy/GrIUk3WEv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49YeHk4/F4ttVaQ0oWWA+phJSkqZ/qXKZmQWCI4Fzm7w1v8+2
	t49XuEHZ/lkyrV59polJs0MuHr4ZepR8OSOkDKp3bBSas/iYmkJqim/qhDq+Mlg=
X-Gm-Gg: ASbGncu4OaW96tLhMyZ645iDvIK16/fE/1H+lyQ1soCJQoLYrVTIJMLMn4BxkjlSaFe
	PAd5PxSSieclGJzcSlvEyC9cnorEerSzcruMQfwHePn+daQH6PLeoA2DPkMY5Ki8uzzI1SwzdrB
	zqz/4RHMtQ0a5GvmB99++jQBuL3kirCtjsSVZqNIvlMNyXHavhqbb/m+hlK0KCTpUxs3OGYZ8SC
	9vDQ/3EwawKKMRfecC1C8DdQJDeJPXZwNBxZxzp+XPVPu+P0VTjElZBpzrF+qHbvq10xgNFgPXB
	xZAo7mZx4tF4oz4Trsk1FfWo+rzNDKxgdE6syFWJeDNwMJ7SrfqnD0TCehp9ySgqnwInKMbZ7A=
	=
X-Google-Smtp-Source: AGHT+IHfuMkCN7VI9i7zAcNVQCDg6hfiIOa2gJKTgYg7HpSOH5m5OFmnvpJ9q/S/aX79khHSIkkimA==
X-Received: by 2002:ac8:7d13:0:b0:467:6617:2ed4 with SMTP id d75a77b69052e-47167ac37dfmr45777701cf.40.1738945256394;
        Fri, 07 Feb 2025 08:20:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc6b76sm18119641cf.59.2025.02.07.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:20:56 -0800 (PST)
Date: Fri, 7 Feb 2025 11:20:54 -0500
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
Subject: Re: [PATCH v2 10/18] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <Z6Yy5l5xNanh7o1N@gourry-fedora-PF4VCD3F>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-11-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:45PM +0100, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
