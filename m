Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29F15FA72
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929800; cv=none; b=hVi+lxZaFPysFHTyYfUKuR4Wxxf+h25NRgeYoGr9zTWR9dJIcdquSOOle4Jti3fQu8acYhQY8VQknM/J1LyjZ1kr/inwCIBr8AwfarpAjbGTNJrz/skEBcbrIuSyqAS5xcL0Jbk3fMsf7vDTDMotgpFo7cpQDd1ACxuobl8aDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929800; c=relaxed/simple;
	bh=I6C7BvaUdAdLwrh0Gvt52aGRJGIfDLorbag6PNqslJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9udRLyl2LxeSGs92nFvF9m3gQTljlEFISoGx7hdNgtU6pWFa7tLNbIVs+ky2O//BhP7/mFWDuVrTr8VgsE77PU3QMPq8noI1TpOb/TWyoaTHDtJnQwgQoNZR7DmvmyYSbYGBvbA9rQc9vogBoADMU6QnfLFq1kL12vjGks9s1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=PtsRP9V9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PtsRP9V9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a5809a3bb9so84736a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 06 Aug 2024 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722929796; x=1723534596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mk2bppyKJsnVJWowW5xQtdoiHCN7fHbxwO5CmO/0Bw=;
        b=PtsRP9V94GKLEOdXTxS0jTnkMsRheNAJ+V/fwndCWT3ja/+NkOXi4+ogCfFtH07jK1
         4cm/tI/asBN2sDvGAUzI2jrq/AQ0ECbKdl7RROXbggl0TBMbs2BaEO2B2M/rtyl4rNDt
         x064Q7MeBbuTQvzVCLrf/t3a2H7Q6pkZo3GtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722929796; x=1723534596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mk2bppyKJsnVJWowW5xQtdoiHCN7fHbxwO5CmO/0Bw=;
        b=O4YZLM6EeBKBPYPCTpjFaxeDK6hlDYtT6IxX+FcnXhBqpRgcyhhruGJoFyvtrGzNy4
         op0gmma1xAVK8O7Oy/SNFJKBwnDyMDiheAfdEcpmGlJFt7ZlXK95eRYYkwu3FD6RA9fK
         rBAV/nqAvDXuHy/KGyQKhZzGysSgNBu++nWklRjtemrxI6/2d5VIsCy9claHh+BQ9CBt
         7AZvSIj2ATZsLcfIU0xaoveRjJSQl/qg5j8uWqmutB6+tVwya9FfPjhpmUUVa+ZoR5NX
         PhHEycKS4k3rLojfWiVOUKdb50RcprcFcdPgDrxSWh+BXpgGLQJZvGjxLEthW/U8l1TK
         w+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUYyJPX+3DDh3h3tkrd/p31lZzpyFxaJuhGi9g9TnBOWQ8JEta1EoHGJm3UYUf2N3DKJf0wItkpA0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABCvG0hrw5BJvX/PVIjTK6o6q01khDYDUroD36mKc25t9+5pe
	Nc/Agn2NnkeMCODvAHA3o4YuBSnnv4LDHpNQl9pcOMW3aTIyuHcjtbzWUWhYE/M=
X-Google-Smtp-Source: AGHT+IHp36jwmXv281xIil1Gmq67KWIYfMhgLPlQxDUcljWG7XdWSCCH5FHUuoURIkKftUhg7mwqgQ==
X-Received: by 2002:a50:cdd2:0:b0:5af:85fc:1a98 with SMTP id 4fb4d7f45d1cf-5b7f0bd9e72mr6518502a12.0.1722929796195;
        Tue, 06 Aug 2024 00:36:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba8ddf4fe7sm3506750a12.92.2024.08.06.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:36:35 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:36:33 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <ZrHSgfzb0lz-Qa9s@phenom.ffwll.local>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Mon, Jun 24, 2024 at 07:47:26PM -0300, Jason Gunthorpe wrote:
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index ef4eaa87c945e4..1d9651de92fc19 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -11,7 +11,20 @@
>  struct fwctl_device;
>  struct fwctl_uctx;
>  
> +/**
> + * struct fwctl_ops - Driver provided operations
> + * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> + *	bytes of this memory will be a fwctl_uctx. The driver can use the
> + *	remaining bytes as its private memory.
> + * @open_uctx: Called when a file descriptor is opened before the uctx is ever
> + *	used.
> + * @close_uctx: Called when the uctx is destroyed, usually when the FD is
> + *	closed.
> + */
>  struct fwctl_ops {
> +	size_t uctx_size;
> +	int (*open_uctx)(struct fwctl_uctx *uctx);
> +	void (*close_uctx)(struct fwctl_uctx *uctx);

Just a small bikeshed, I much prefer the inline kerneldoc style for ops
structs. It allows you to be appropriately verbose and document details
like error handling (more important for later additions) or that e.g. they
all must finish timely for otherwise fwctl_unregister hangs, without the
comment becoming an eyesore.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
