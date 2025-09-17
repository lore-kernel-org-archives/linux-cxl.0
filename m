Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1319274B37
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142379; cv=none; b=faFZc+GC35GhNHWhSkI5+fAN+hqENH3rg+Z4RCzjh+ijs3c819ahNHfqi6cDFfga/wZMQlAQaCgEfszRjTQnTgVwMVDW+2Wl4EDV91+E7Bzdmpb5FRCRVXOSVCu+0TCGIPWcWV32HfcgJsfKrD6WufDBNAVlmiSrmzGK67+aD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142379; c=relaxed/simple;
	bh=vyVcKrjsi5rK4rxpJ2J+62BpiNtzCyvjQ6i5MbvZYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5vZR4TWwVJaYJdS87+jsGmyJPRV4UAt7S/mZjOD8NEK0xnJuMNe3WQEeNW3smERoonWGFKNbpO6epye9Y3yz9l7LQaFNa3S9xOp88KQVJNkeOKNoSQaf6vzjknPszDjS3WJpbfTf4mYVu5oR3/YT29oOgjOA4YuM4vaPdRTmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k3FYtjxT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k3FYtjxT"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-807e414bf03so35996185a.0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142377; x=1758747177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Slb/89aiZWbtb1+MHqNTYU2kFl97qu67CctbxFKmgbc=;
        b=k3FYtjxTHDzwkMPd5GJEkRFr8fdqAFbPuulkg7EtXvq1L/RE7LwKWgftqH/Yy46PTD
         LT+pO7ts/6c1PJGya3k5GHHNOu5GvFoiu0Nc4SoNzoex6PJkcuCL2aNUVDDkffQgpvAf
         xv7vMwOyoa1qNv62Q4RPOL8ceTscqZFadhb2il6VdAROU8c8hoDptxn2ZidGrZ1pYDX4
         H4cwgCe1fsdumIi8BKK61VjSvh4rJc+Hh2o1HlLscuJbqL4pPXzUVBKU5qmuC39tlwIp
         eHXbqkLV4oThR6CXLSbWvfwiMwLQl0castCemdAht4dtRbUgx5wrJvb3OH5s8VTfUVhV
         tqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142377; x=1758747177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slb/89aiZWbtb1+MHqNTYU2kFl97qu67CctbxFKmgbc=;
        b=d2vI+QFtP8NnyoH6pEkomFZstftK0ZE9WRS8dWuGFaS/WE/u+VRzqXI+N7mcIcuZGt
         bOUJXaGU9jcVGdk3JGOmyFQxzEOkYDPJ/ETA47qmBREXenpm8dINcVPU0uW4TctxXubA
         RQ6PByxtU+lGCnroKGW9LcQWCMZaaP7/HrdyzeLEg8fPnsgnMowQ2WC5FWL4M1lKhmpW
         0cJkZ9LPZjMxi65pbc2OLHpRCAEfdgikZurKgAfcJgibdagNx8dGPEkWZlOkaJMHV8U4
         gErNRtW7C/sriidS4Svs4P2Hd6PYF9vJ/Cz8tRqxkKlsozNfznjBsfo9+4YFr0UdiD64
         FOGw==
X-Forwarded-Encrypted: i=1; AJvYcCVEKOlTL+7ASDba7Ome4MrjZXeybhE0PpR1ABktlfZWrX9jWoba08RnhSRlQDa7WAFANNRkT56CUxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHZ6pFYS4pScYTfK5ka9Mw9Ho/+KmKBI6wDpFiE0kUWvj88uE
	LOKm809CaCidIWHAfJ2t379i1ca/1xHaHMljDsB2JkmXAZS3W4qR+m3/Ed5dvh4mHNQ=
X-Gm-Gg: ASbGncuuN0YL8oZH/JGJra7Ixb0Y7g08p7UMO9IZRdiZbJL3FRy1VcBvbjDjLT8Cihw
	3ONTlEzM1YrTL+CAvkn6DWSA3DFtA4tYACcSimsuXLAYftC80gDYimFOaS7Uq2mOZPpKJZwOzJE
	CJmwNmcf5n+ESyQ43ZO7gNMU2sfYnTquYjNeKdst7NmRW7EkkbaIrUCoNxO1V/63NgNYmkt673e
	EpKdqssOZYv5RKvRWB6luytRgyx8HoKjoiO5UyUPbqWKs/IEmpsjyUExPkZS2STVkdkPbBS7kNL
	Q9Ckn0UFGSVaqFCGLGZ22N2KJZesvDvtt7v1yTrJmBxJ+cuQO0g7YFpuNUeWG6/EYJzssxOIVZN
	hFqBULAp0gvo4XgJVy12+irgfRZenZjHcpJUKrXFt1VcQoUK4dfeDlNzVBU/mQg5jzf2Th3KqPL
	XmcQjNJLaQ+L7txg==
X-Google-Smtp-Source: AGHT+IFdINzcp5ACzbS6sICuhrGg2dW+wCoDRQzC+nV6ZAWpS7tnpWl27o6tLSuka8FSPl31p1uORA==
X-Received: by 2002:a05:620a:170f:b0:828:a0f7:7aa4 with SMTP id af79cd13be357-831085ac45fmr515569585a.23.1758142376686;
        Wed, 17 Sep 2025 13:52:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b80bbsm44715585a.25.2025.09.17.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:52:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:52:54 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 09/11] cxl/region: Lock decoders that need address
 translation
Message-ID: <aMsfpvHmTlfJVMK3@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-10-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:11PM +0200, Robert Richter wrote:
> There is only support to translate addresses from an endpoint to its
> parent port, but not in the opposite direction from the parent to the
> endpoint. Thus, the endpoint address range cannot be determined and
> setup manually for a given SPA range of a region. If the parent
> implements the ->to_hpa() callback, address translation is
> needed. Then, forbid reprogramming of the decoders and lock them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9fb1e9508213..44ea59252ff0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3497,6 +3497,16 @@ static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * There is only support to translate from the endpoint to its
> +	 * parent port, but not in the opposite direction from the
> +	 * parent to the endpoint. Thus, the endpoint address range
> +	 * cannot be determined and setup manually. If the address range
> +	 * was translated and modified, forbid reprogramming of the
> +	 * decoders and lock them.
> +	 */
> +	cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  	ctx->hpa_range = range;
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;
> -- 
> 2.39.5
> 
