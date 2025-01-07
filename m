Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97818A6B5
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270614; cv=none; b=ZI6rhCvJKpKpE1FeIwfYKG/vVJPvj5N4zNjUb6svktu/EhBvVzOONpRqElD4fD2Gt5U8oJr8GUn00OGNMbCj1gpsHKNGXncwQGHHIqYjMuLCN1DW6japJU1rnK41n9/lqeiJH8BJs+It3LoYcnBHTQkVMmqilai68jpqZUvMFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270614; c=relaxed/simple;
	bh=DQv+1q+Z81tQ/MYglXf6t/KPEF6xQnG3TE0bZTAtDk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkmIRu9iueOrwnnfHMjzJWmmNL7UQxOON3tm62zTTarcWkFOLxQqGcJ1J4nft+n1pwJgzgIxFECxMCwxgE+hRCxQyMomyi3XnznMInZ7M8+8a2+QWvHU8J/Hfieo+K9leC+VhU7s9EoqvgkjmHrVeY8myWcLEXBAZSioizHJ39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U2mLyXic; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U2mLyXic"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b9bc648736so1285677285a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736270609; x=1736875409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCI/6o8IdmX+g/XbIA/XAGJAG7KCLSPUDk2L3M7TMA0=;
        b=U2mLyXicaibiUim/QDKmW4CSb+SKf2fYp7U5RP99p5AW03tkoiNpNkRzRJG0tysblM
         jdY+BOu3BYvsulB4W+KT1/BoJ3Z1g0MUGRS5hGx6HS84XPPBH+T4sgPNxZOOf+dTf1TA
         HuBi25wp+VseKH3rl29yIYlHJqnDsGoJi8C1e7CwQo02zHnstzU8ePLRGNhj4M/ejU2h
         wgCKK49quEmJbXQiqgnjp88iB+G7TbwAQu6HND/MSmFtMNhL5yFBMfRZkZyLwzaF9yIo
         Cw6ZftIJFLgy4IN10me3jJkG2BIpk1qXjr5fZ1ckt2rnQBMLLifzDecVx69Y+XzC3H8+
         H5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270609; x=1736875409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCI/6o8IdmX+g/XbIA/XAGJAG7KCLSPUDk2L3M7TMA0=;
        b=qDpaOPA7UyFGNJqL/GJaCw13QnqPSe8ynVfRhVSxqXlSJwVR62ikzV2wivzLJLxcrO
         tD/HESK6TI5p//eLkS0VT9qQwW3yIU+TeUH6FirHzNgmMR5A0DBjwx1bClKnsoSgQQsG
         OYmhpriJjfGo7CHf6d6GkB/qm9mlxlzNiTULfDuBA0/0gZ9V1wyk7tprPaMIgRFAZqdF
         jKzNbawj/JUBtXBXNiHFtlSO6XD128NUOWAtVEzK72YX2uWhDNR7vPg+QQptH+XU24EH
         mcMYGaYqzCIzn+4TRWyKxEC5pmsIJC5kfUAg6v7ksiXjLulPXA0CJ8h3ICOA0ra7zsW/
         k9CA==
X-Forwarded-Encrypted: i=1; AJvYcCUTo6mMJzZZveJ/EadbKrZAfNoG2Wq/83kg4l+0VmCqg2cJjDDuQaYRIhmEofgGG021rBjREMTFZlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhvaCU7hfgNFFuO5Q7NG17MxAeASCBnqXRPH0DoLB+ofludJ9
	Km6iljwwC9jFkYxZ3V/lqj11PEzNjNRCnQ6kkt0MfimjKXSKqxLPwXHrXLwD2YE=
X-Gm-Gg: ASbGncuvyKL5goRowv0K95ZThoO6Uqq81DsMDxj/MUSYm+74M0ta2z9tXB9LecL+SOA
	TQ2MijaG8eIqDo9qiGLNmgqrHY5uaq7VDWMoRjzNZ2gsPD21X3AaR6U9wnWKtYqrEFSadTWADJP
	uev16SP9F+CkWiD7iowHv3CPXj9onHW9+lbJ8dltOdZxjlW0FRZRJTzyuNE6N35u9cqd61Ig4Cx
	wjguuT57GDsmqblIk5aP3C5CqQq8g3oBWuCWvIgMhQmjuHiJU6Y+QK98DG8ZK/7WZlhPaKPWDl9
	TApoOySA7eq76mZblEd57xWZF5CFdTcwFPRSUA0=
X-Google-Smtp-Source: AGHT+IFlSzfLIxqvJmg66dX5P+CG4jxZ6/BkmuCFgvz8O2tR7TEROnyygAa+3zkKCpY8ZyOVEAfH/g==
X-Received: by 2002:a05:620a:4045:b0:7b6:d237:abe5 with SMTP id af79cd13be357-7b9ba75c3f1mr8639280085a.20.1736270609144;
        Tue, 07 Jan 2025 09:23:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478e33sm1601045985a.76.2025.01.07.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:23:28 -0800 (PST)
Date: Tue, 7 Jan 2025 12:23:26 -0500
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
Subject: Re: [PATCH v1 09/29] cxl/region: Use iterator to find the root port
 in cxl_find_root_decoder()
Message-ID: <Z31jDnsvCSh7DRAf@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-10-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:55PM +0100, Robert Richter wrote:
> The function cxl_find_root_decoder() uses find_cxl_root() to find the
> root port. For the implementation of support of address translation an
> iterator is needed that traverses all ports from the endpoint to the
> root port.
> 
> Use the iterator in find_cxl_root() and unfold it into
> cxl_find_root_decoder().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

I wonder if we can expose this mapping in the sysfs hierarchy, because
I've always been frustrated about how confusing what decoders/endpoints
relate to each other.

(I say this not looking forward in the series to see if you did exactly
this, just spitballing)

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5132c689b1f2..5750ed2796a8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3206,13 +3206,18 @@ static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct device *cxlrd_dev;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
> +	while (iter && !is_cxl_root(iter))
> +		iter = to_cxl_port(iter->dev.parent);
> +
> +	if (!iter)
> +		return NULL;
> +
> +	cxlrd_dev = device_find_child(&iter->dev, hpa,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
> -- 
> 2.39.5
> 
