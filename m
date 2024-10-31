Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC019F416
	for <linux-cxl@vger.kernel.org>; Thu, 31 Oct 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397419; cv=none; b=FN9Dvm8U6gNQxXg7W41oy0BQDV5KEFXzaKssupRHdyEe5LRc+9C+kgZzgWqjDBurgJ8IbAFIASXZkqO2Cu+e1UL2DYaWbgfWjC5TaC0SUUfVOeKYmzpopV29QImPPBwjL1mGvnhSfW/AUqmU8EN+iWi+UCAm1ic4J+qVUiUwLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397419; c=relaxed/simple;
	bh=yUrGa8onY4ccgE2ialpFQmrSM+ZgSnzvmstuAkksbZg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT8W/UbbAoSSqsRYnsEaKA1sW/yFnx6dsvLqQsuvjZAz677FsWnCQg7lDuoLp0GNuii3Fxh45UIbUllvqoooWcWo+72WzBrNRDnkUvb6d3IqoEtSPafwuYajg0Hx2GejWdgi5XrapgrXc3P3bdwziEcYq/ArN+Ujy72XXZimAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cujkMlCe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cujkMlCe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-210e5369b7dso12300825ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 31 Oct 2024 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730397417; x=1731002217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPlQvdXSsJyU2fKdSpUte9ErFeNJjpab6hJvuIBFdso=;
        b=cujkMlCegywUMnfJ50HhLVNNGQyzmMieGSxucx+2NZeFpAW5DckMx5mfmLQjHk/oM2
         pVqsGUj0NVOWo4GCHc/AEInsIN/BG5bD58qZ+tUkuUljJbwn69d8u2e00+uGc8CJgnMA
         iTdU6jAp/ybxqyGRRVE79cHY1s3COnEShI5bAxiWPzl/GW/njRksq3HlvxC21JiXy6Kd
         20ydmuF86I/p2ADWhAPB8HLPBuG8enMes7gkDuRfMItiTkidiYSPNWO81naBoP025j/T
         K1T1cEoBKcIwfcN9t3U7acsHi+7TXRJlE05iPnOsHJZDHC8wc1ZXeXToR1xaRJhLN964
         3AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397417; x=1731002217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPlQvdXSsJyU2fKdSpUte9ErFeNJjpab6hJvuIBFdso=;
        b=TOq08uQtPH/yC/KscCuDMIobVCdZuQvmgRTGlqQDZ/OcVxlW/fGRxDC3YtwHMzWhPb
         1LkmzeIK7NK+vv7jBb5rI9hS2SPrsJpKpLZOYHHpDgSKtex3pyPO8pJ5N0sGxIkNXny9
         EGTJ+GckmqXMxfY1naPKT83Trn9EUuTJTAzQWScSzLzbHD4gQDG12BUuzcecI774qsL9
         BW4YQTRs2hLQghXW7NwSIammZZi/lLct8zrorhyB9PJeREMHZE4wLioQUOBnleTmVGFJ
         siTzrZCTkO/hwe3Sw0BUW1qgtPlryAEvNEjoVuzuXsRpsGoBF6INwIU5FoZ9vwnVU94d
         5V3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXBXn9zFngFcKwqEvQUpLWKNh4zMY6saHBpx20vr3aXkwJxkKkOlYZFAPQVBWafvKsVX2QRy0bdeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBknqdSGsis6QpxWBSecpwd8tt0SC/qmVSitq117vS/waLBS4i
	FOiOSgpNw5OJTnNrnsPVYmNTjD1FvUIWbRZusafmJ3z2U+Bz3bj4
X-Google-Smtp-Source: AGHT+IFJBfjOi6GCB1tdNfaLp+8634MByXEAM27CFxqvhbEMMGLX4iRgqvOmwaKG96MtpboAxtimnA==
X-Received: by 2002:a17:902:d488:b0:20c:a7db:97bc with SMTP id d9443c01a7336-2111af1756emr5410975ad.12.1730397416730;
        Thu, 31 Oct 2024 10:56:56 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c68d8sm11212555ad.227.2024.10.31.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:56:56 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 10:56:36 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH 2/6] ndctl/cxl/region: Report max size for region
 creation
Message-ID: <ZyPE1LG1LQVrLMwl@fan>
References: <20241030-dcd-region2-v1-0-04600ba2b48e@intel.com>
 <20241030-dcd-region2-v1-2-04600ba2b48e@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-dcd-region2-v1-2-04600ba2b48e@intel.com>

On Wed, Oct 30, 2024 at 04:54:45PM -0500, Ira Weiny wrote:
> When creating a region if the size exceeds the max an error is printed.
> However, the max available space is not reported which makes it harder
> to determine what is wrong.
> 
> Add the max size available to the output error.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  cxl/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 96aa5931d2281c7577679b7f6165218964fa0425..207cf2d003148992255c715f286bc0f38de2ca84 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -677,8 +677,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
>  	}
>  	if (!default_size && size > max_extent) {
>  		log_err(&rl,
> -			"%s: region size %#lx exceeds max available space\n",
> -			cxl_decoder_get_devname(p->root_decoder), size);
> +			"%s: region size %#lx exceeds max available space (%#lx)\n",
> +			cxl_decoder_get_devname(p->root_decoder), size, max_extent);
>  		return -ENOSPC;
>  	}
>  
> 
> -- 
> 2.47.0
> 

-- 
Fan Ni
