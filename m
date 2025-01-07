Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6F8F6B
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266226; cv=none; b=bUbnIb9+Sc5nSHEcUQEGSx7/PK3QKMx0adAHnaiGVXU0Afy32YUtMKA90iLQFQhKKZmHHXO9t1O9PuNbO7DPlgJlFH0AA53SiHkugyTP5eb5y/t+gNku1YM8jX5HzdvHGx6SCakOp7BFRBZT1PE/oD7iHGqDroUxqEwtP+rGsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266226; c=relaxed/simple;
	bh=Z+a220bEzvkUZDMPdeGh0Jmq/q0JSIutCHtjx3eKdyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9uS8+jEy0ei3mh2corVpwCD4i5NI5rXgxGz63G/gpzOLSruvDgdbwpJSzauI4IJXzqUrT6TMu0AaZNnmylzB8Bb9WM7M58/0PEnC9q0hqvN8eGtAuBT+C4rvBR/hRKxvmolT3+Tmw0NqOk1j+EYJsG0/3Tul+RcW9lrz2Vf96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aX57QeY5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aX57QeY5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e8814842so1355417585a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736266221; x=1736871021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTJeNa1aTQ/Sxp4yHyNIxmCqVDcHaBtn6T7q6asLp6c=;
        b=aX57QeY5wzLk2fAlrfVucjAnBVBewS3UwDxrJ0FzYc3qF6JWwfDRegAbhqAaWvfLh9
         /ARk/bUAZm9PTqkExFfb8Fm+VCWCLXar32w4AB+zc/BGpFkN1tgIhzW4lHOFc9++LIwl
         L/tokcmbzS7Y3CXGX7htOcypdLvwe3bOCLrYsdOOOMmbwTvE2mzMuJYnI8P5+gi8yumq
         YnEhTAvQY7xgeCQb/YVUnOzcOwoDNpt7qSmwin0IGFJv8BrL/+NdTj25QEaYeoxWR0Cn
         v4yqo/2sO1KmGyVGnNPI+CwzYF1IEzsr6QTIrBCObkl4Q6ukQN3nCY25ELaiL7D5y/c0
         KM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266221; x=1736871021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTJeNa1aTQ/Sxp4yHyNIxmCqVDcHaBtn6T7q6asLp6c=;
        b=OwHno6h7ZNNM3Ji+YrQFMx/SrhwRbv5ywjEtLOLFBWl/1j5TBqbPIwXlfzmzpCWhSF
         YOdAczBKGS29onPjHsrb7Vv9zBYWaYaD9NFFmDVsCyPbsS3gCSoXG9hX9dP//Jtzy2GE
         Vqm+IDYIu/RQWOrWO+SgEWjoho4swiRD+mGlWdbJZwMLGvf+0Nr0K0EccZ6ZoP3/ek66
         hgctopDzdZFdo6zq+bzFSY71b8+724f068/4pmW6mGnqIdR+7ZePSvLUagEw6rcaRTXq
         80vZ8HUxusdpDyBl6c9dh5u/lsmmFK8MQ1WdubfStoIiCsCGB5fMtuJvxLn3oBAhHcbD
         X/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUn4x9JF+qv5W9up5U02jLHIjDphiRhd8LOSXFMsEu3G87xqYY7V9vA2mRhInAgD+JkC60UgpTrCgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBkKQSjy4jpaZAT2KZgqgmmOg2UEoe05gyLU3TH8vQfT5xg2B
	PYTlczLY/IeaVLmMNp0lYNO8WhfaWr+s6ApU65916uM7Nmi1PnMcqF1Iu2aSZeE=
X-Gm-Gg: ASbGnct+Vt9yfz9NAm7/KYfFezvHKi22UC6VngUxzVIeA0UmOWMPjJg9usbecGvKGUX
	cAoSzziJScgNAOfTFAWNeN1oxXEHokriNpbsW3uIRGb3Y21cSJAiLv5T8QdYmVqaEzgsiTc8+ao
	3YN324EGqYgYPUi1ZtVFf+cbpvsVufbK1NhdZ0nJ07WTS+Exx7BFHnEWa7RxPsVz4TeeEXt0Hbo
	FULmS13snMGxwnODyd3/Dyjot9dw2JkD4foMo0weiQ8Jw8N5NaoHKYJ0Hh9EXNhW1+bF9ZOGb2s
	jMKj8xPxicd0/HMyVjMjUKLMkU6P0I0cJw8Ed0s=
X-Google-Smtp-Source: AGHT+IHdbB1XT0ah6T76fTo4l0cd5XWFZmsYewTEYo/NqhqBy/H7jnZLfsGhmFaviz1GpN5yR434aw==
X-Received: by 2002:a05:620a:4399:b0:7b6:dc74:829f with SMTP id af79cd13be357-7b9ba703164mr10958269085a.7.1736266221265;
        Tue, 07 Jan 2025 08:10:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac480ea7sm1604331785a.94.2025.01.07.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:10:20 -0800 (PST)
Date: Tue, 7 Jan 2025 11:10:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 01/29] cxl: Remove else after return
Message-ID: <Z31R6uVy3G1LjMvY@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-2-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:47PM +0100, Robert Richter wrote:
> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/cdat.c   | 2 +-
>  drivers/cxl/core/pci.c    | 3 ++-
>  drivers/cxl/core/region.c | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>
