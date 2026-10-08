Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32714455181
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465632; cv=none; b=UB9j/viq45rjouZ23+w3KwFWltWKAzoYOdZDIbm26xHfMH9y1HQQ3eG/KxGFHnvpGFOU2oSSCOdo0z9tX+idmrz/rbxMq7VKw3c0jWbgW62WFZsqd3+JU8oE4Aa44h1kQBxQxORKKG6v99/0iGMASVvHX4gIXRKBjgkBrxdIyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465632; c=relaxed/simple;
	bh=3Wr9/2480/aki5bGWFAs7IixSJIK8jk6h7T+74lKaK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4mVV8PSD3dXffbpB5F/UdNNhrGU06dwnul7oGiviB8rbPz8CJGQrear7af0QAFfTscFLX7MGB3FXdJFiQRchNsV/pJAV6fbTsqClwCCiTOClKI5w4Xj6QnWxpLXzBK8zZRr2vbmlcR/oQWcBUQOt0gmRQM9zwLnPPEJI7Uy/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Kl9Ziv8t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Kl9Ziv8t"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48afe75f055so4766208f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Oct 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791465628; x=1792070428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXt6zdr1dNJCoSR8LDi80DpeRm3wu09nw9+6kVlpfZs=;
        b=Kl9Ziv8te+TavyCjiutTv/7h7dsaNr2//5WM2Z1VKKyIaPKYTZSWV8wT2NTzCOG946
         +WEX/NmdkVPXKUgYTr0aWPz+zUFtXWTv24OmRgPHRT400ZyJOPywSx7aVeeOwqybpj6y
         yGPvoodGyU1/DifVBjizhGAi69e6MUvX2MxYOoNuJwm4v+HNwH77ZMZYqc8clomP5zsL
         cyBLMo9y+TpwjNYDxWpc1RFfp5PbAOyCtJWTypm1gFva4y0r8IeqsW3HZljMbT9gbyIh
         i6+J2MI/L5axiHNOJMHd7NNlWNV5U3ylvCwR1oPgJ4YSSeC93brF5ObQMTigIxKOUguB
         MPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465628; x=1792070428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXt6zdr1dNJCoSR8LDi80DpeRm3wu09nw9+6kVlpfZs=;
        b=at11u7wnT0QKa3WeSOLzAK2g+GUwr2OjiHb+PWBBypLZ4Ge7gMizC2S4kMjxQX6x3K
         Tx3KVwxAMh2fYE2QRH/lVsKq87T/pczvRuNJ64zFPxFQlKsE5Vav8x0x7YGVNvHRWcmI
         O5x1VPHH9SVpGDXAD1XbdL+YupflcCjZfYEXnGsIbb/4QrNv1ySEYH87MoCIfeJUH1I/
         dCPYsgzM3rrzkCEIcJr/wSxpOdsWYsEVO8VcXyLv9auSXSqTs12CkKRXuX5xIiEEk6UG
         0sF/UCTM6ZZUl7YR6thZ+5NQF4LE73IPG+uE8etPpCu4nTtpNptitaBxCuBlRGYJBB4O
         3k4w==
X-Forwarded-Encrypted: i=1; AKwUvBwPt2iFI9qg2SYLik935wPpYbkwt6s15AfVKcSxjuUWNuVo5gx8h3w50KaqZkvcEPAod+gKmHwnbYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ44AMbAtyvUB2vz15a8SKSM9WVeFfdEVhiB6HM3vxJZIav/5oV
	zautik7rodDAOeUAJPdW0Q8cE/GxRHTtLJ5hmv/MpyfgRStaHg6TuFU83Wb/hxOuy4Y=
X-Gm-Gg: AYBFou2+8D+NggVJaz6QkkeOHDG6z17lS9BiSorElylpCbcNRJy3hNzGxcGF8SyVsZu
	534j3U8q3w4onJMHseGjepQ9rahqwia+RnmACw7in7rmvfxki6oG6dXpiU5C4dtnK3IXVmVDAhZ
	gX43oXOzFssEmlKysq92do9C9Z+Mpi0zpUztzg6VRNWabmYbb3dObfIjDjVthaArXtafq5R6LUj
	hGUrVo/9HcVAwJbCaEHv8dJAyct05I9qMr5UOCsPfwAZ4MmawqlbyO+dHUnaPUCkYul0IQ2JCre
	6c9lECa2n3Jz0PhKXzgf6vS6KgIs83WS4d5iB6tn/htU3b6fXH8PmRCyMpOslbF05abzcW3hQ7l
	7tauldCBDzY8XFZt5VYAkt2oc2QeObLDS4tSZ1z7OJI8gG7WoSzuxj1VmIBjnhIbCu3srdr04yH
	Q360vG5cS+u5P9f40MKveFQyYeftf5cThxkf9fNyZVzLRslVHsLd/nP8PpRJ4rdp2Tt0kzD1NQX
	vHJ0mpNVOc=
X-Received: by 2002:a05:6000:470d:b0:487:c99:9020 with SMTP id ffacd0b85a97d-48c7272887fmr8760021f8f.2.1791465628326;
        Thu, 08 Oct 2026 06:20:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.184.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm11753893f8f.51.2026.10.08.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:20:27 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:20:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <john@groves.net>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 2/9] dax: use READ_ONCE() in dax_holder()
Message-ID: <aseYiJO0cgEamazq@gourry-fedora-PF4VCD3F>
References: <20261008112004.1899560-1-mszeredi@redhat.com>
 <20261008112004.1899560-3-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008112004.1899560-3-mszeredi@redhat.com>

On Thu, Oct 08, 2026 at 01:19:53PM +0200, Miklos Szeredi wrote:
> A future fuse patch will utilize dax_holder() in RCU context to make sure
> that the holder can't be freed by a racing fs_put_dax.
> 
> This patch just makes sure that dax_holder() works properly in such a
> context by adding READ_ONCE() (equivalent to rcu_dereference minus sanity
> checks).
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> ---
>  drivers/dax/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 25836f389bde..76e8d3654629 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -642,7 +642,7 @@ EXPORT_SYMBOL_GPL(put_dax);
>   */
>  void *dax_holder(struct dax_device *dax_dev)
>  {
> -	return dax_dev->holder_data;
> +	return READ_ONCE(dax_dev->holder_data);
>  }
>  EXPORT_SYMBOL_GPL(dax_holder);
>  
> -- 
> 2.54.0
> 
