Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146911F63DD
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275686; cv=none; b=AjhgqRqtWu5IIGLj/EjxfP0g6bUdwtC3pt2GNxxIU+oTh9/apdyr+CA8n8Lc8NkPqDfZjYn0XlvO6iG95+OQUJkpd7/xvw+rkdSM3RkflDwKRDRH1TOBiAvgYT7u8zBlb2DhH4uzvwO4b5/ingVCFbFF8rg0XGQpcD9c4jGKkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275686; c=relaxed/simple;
	bh=JlaB30Nv2rxRTki8fHtl8f7BVdCKzpX3Egg7XDNtDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njaBqdXP7rNPr1330CFU5MviHBjvuZnEKnXvZIvmxM3cukTt/SiKmvkNFGFlap/ajyVJkDbiKh8Mt+xBAL3VjZFjbx+TlrbPTBUljbmoam2HvtVLTN0Ue2C9FBlaeLZkuRuwrK57u0jemHkzzD77gLIBBWM/j5CHY0yLQ9PoRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=plMxIw2R; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="plMxIw2R"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d88cb85987so710926d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736275682; x=1736880482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGEdKSbQdPOKC+EVnDjilYrIiGDkhrjthNwhu3fZDJo=;
        b=plMxIw2R4x0al1R06xhZwwbUOZ6uHVqNtxI8PWSm1aCEbELDIEKDNzEDV/sgiPhkOt
         3UhYAs/dInqwWrY2wp2nXK37VZe0DXBSZYAJ6ln51bmGqHSb+5sjv3Rv960DXwXiDpsf
         nh5WzSsIG7sEe+Lw1fvep6SIpEjdGb+n8QNEkvDJL31zVUdy8pX1h94DMcsIgfXJR1IU
         Q6kWKHlr7tBBACwwzI98NrTlGpt4KFuUwgFStFhuXAGpHBHJYGgPq02oFs2IYRIj6va7
         UY/SK5YIZvTcKF9HYeNPMx1GQzPaRi3Tg5A9l/7Orh/Tq39EvLkoqM76eVxFSY7Bqe7y
         oBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275682; x=1736880482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGEdKSbQdPOKC+EVnDjilYrIiGDkhrjthNwhu3fZDJo=;
        b=Z8aOrt2HgSm0VOxCDosBao9wnAsbKThYvQc77wijTy6f1IGxOE1uoNIAhBGu1s6TCM
         NdKikVnCYr9/kjJFMaVr19GTC94hobUMHsHFYDttA+ncGsz4ebGgl0LgQ6Pb/fmvZjJQ
         0rpq3oPuVeq9UP5y2VpT+W6tHqA99DEJEod27DWHoLWVQzKteRuHbVN59pemzEm7+7Q6
         /bPGmtMoUtdtOUTAnE3obiFvk/jmHxuzcr5Q5xN/O5/FwvJk6m5CvmviG7rxfA5q87Cx
         qCCYW5u9E0sg8l3Ik7E6ZPPT9t+ZLGHxS8s/T6mXBmHJqp3fCGZBvtKOUjmvj+cfsnmJ
         QBmw==
X-Forwarded-Encrypted: i=1; AJvYcCVBIsdue3HOwoykVDW6JjUXt/oIlIZ6GuD5L6VG5MSkqGIpzRH5Ez64DzoFp6x4gTB9xeYO6yY2WaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu0EjNAr8nnoemjKI5PIpyymHpkvfy0jyNQ7KVwU+fBvudCgy
	c0VMzPglLRqLCVRQKdFS6mswOB2spCOpOhdSIB3oOLHl0V32fFgovk7KhkNP0to=
X-Gm-Gg: ASbGnctL50MZmspizv2buiVhDs2cO2d58ljQjfWigbnHW19S5+NRLdXhovqc6Qq7Gz6
	IauWBmyHoFgT4QJABnbCrzPKSkZ7FDs0c2Q6ao5UqZvDuwI0FfiH5QgmE3U2ZMRtId5p7PO5t8i
	ffWkQB5S3M7R0P4lK6fV+uwSRUbVSYdLzcmOXSCL8ZMZdkb3pzbx5pdGRMtuOGtmtRsqKQaRXmK
	LTjw3uZ+FnomichidKW8HAPNLqEaAP9AUHnAUq+KnXemoPDyBsbLOG4+6BRLf75C+ZIhXs5dZhV
	xGn/EHHy3PkBJKzkXGE8zyh8ClOQirfQMW80bEA=
X-Google-Smtp-Source: AGHT+IEUkODvRJRsxlaPutYLF7wRzsj8KCRmrPi29Hy2fHonKlvhSn5RqwI1S6R+hWRcUIq5eEJ/8Q==
X-Received: by 2002:ad4:5be8:0:b0:6d8:b81c:ecc1 with SMTP id 6a1803df08f44-6df9adf8df5mr3250186d6.13.1736275682069;
        Tue, 07 Jan 2025 10:48:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810d4ecsm183456586d6.31.2025.01.07.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:48:01 -0800 (PST)
Date: Tue, 7 Jan 2025 13:47:59 -0500
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
Subject: Re: [PATCH v1 13/29] cxl: Introduce callback to translate an HPA
 range from a port to its parent
Message-ID: <Z31230YAaz2OtoG3@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-14-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-14-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:59PM +0100, Robert Richter wrote:
> To enable address translation, the endpoint's HPA range must be
> translated to each of the parent port's address ranges up to the root
> decoder. Traverse the decoder and port hierarchy from the endpoint up
> to the root port and apply platform specific translation functions to
> determine the next HPA range of the parent port where needed:
> 
>   if (cxl_port->to_hpa)
>     hpa = cxl_port->to_hpa(cxl_decoder, hpa)
> 
> The root port's HPA range is equivalent to the system's SPA range.
> 
> Introduce a callback to translate an HPA range from a port to its
> parent.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Assuming prior patch holds

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/cxl.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index be7685fe8a23..49280e0f8840 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -601,6 +601,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -621,6 +622,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	cxl_to_hpa_fn to_hpa;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> -- 
> 2.39.5
> 
