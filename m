Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787A1AF0D4
	for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627297; cv=none; b=JYBFHeYSgVs4w+LY3chz36AI34e1jVTzObg+MSUDFXkZYiIyqsmjR8B5pr+hUphiZIyRWuEvhFuN6s+xnZAej6nMLI66I8whWUTWow/ixtS5AyQkYkG72Rh/BqPJiCCniCsc2/fYg9dlR6k5ko7NVXvD8bU8J3IXgmnNrp2Emv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627297; c=relaxed/simple;
	bh=BxhXKIkCgeLLvxtl5K93NzMA1z8x5UhneGfw9LIbk8c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac4xlWKfEY4G34JZmlOS+zW4QcK7YNURAq9j45y4OPZ+FOE5GAJil+CuFBEe+3Mu8iB1e2Y4xdDy4yxUv+djTs0EB84W+PZqIxGrzvqyKxuPb1euYvugp53kwSk8hBr17uStPbVS9ZDgZnaJkk0MRLtp1Zkj9I5RMx6IX0Z0Zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIKY+T+Y; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIKY+T+Y"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f4324503d7so904002a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627295; x=1732232095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkHmJ0EQwkwKcl9eGSBpXHOSAzHLSzBEonsbRApDFUs=;
        b=kIKY+T+Yz9skKZ06qAtirbPaBCWodIV+E4n2GjwOIrDd+R7dg8cJjKj05/guJTdaAw
         fzxBEf41H/J2gDyxSTxsy79TxGI8QsesJhJaEBQLYJ6IGhaK1zosq+h7oOyGIwTHQlEq
         ZPYg8Rs6n60j9A6o6+7BWUHEsDxTUj8XsVW0G7N7C/5rffWjxndDuhlIkH57Up1NaTKG
         oPD9jIpQaQeyquedzIAXQGuakuHetrlo8M3foF0YAP3F6gLlR+FqzKastS30EFmWW49L
         OSBjQ0ew2IcYF20p46Wa8npf+RACsed5KzQZxr9hyooK5kXLN2yiEdNkgoP96iu0UMEU
         Qz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627295; x=1732232095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkHmJ0EQwkwKcl9eGSBpXHOSAzHLSzBEonsbRApDFUs=;
        b=JYHp6BP6Mzt0qhoXTSZnnLZXzRixoHQZRc2K6Tbvh2PkgXn0KucKO/Jz+lIJr3+y8B
         2bAJ5nGxa9KnALeyHaJeuHGqxzOOkncXL0n+jCXdMwlK8FQNcyLZkPrsucIsAvPpqule
         GVUebvDHy0wnRExV4fYGdOByQDy++FPzeWyNtpV2TGdqGdBswU4MuAfCo1ymL+CPLdIn
         Jbf6/rMz4urBsOhXuzHNUIwdV15Oh5N+6lTEnlWqZQnDlsjXev/AEz9pN/a/wkiT/9NK
         mrWhJ9zZorI9K+qF1qrcRVLQX+9n2qDNXBQJTBVJhlj5IOsGs3zkvq81kGzQlkMwJb+J
         U0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXHVBVLCLgU2sWcYL8mYoHJ1OEiDumitV3zwcw5RL52kRLTNbdQJ1wV71ejEL35aRrcBUxwn3hkgEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5Csu7GepvUU9dbmd1X5FAR6LOXSJJWqIniUP8DtJ05Y/tUIx
	/47I3ulvREa15PSRwNKZF97sxZrn0BaXC4h7/9uOwl/p3leqphSJ
X-Google-Smtp-Source: AGHT+IHU5VRPd4s94u1ZgrC+m49RHuhiHA7j4LoD0tW3hZr6vP5JRDant5vx+VQuUFNZ40qCGoqraw==
X-Received: by 2002:a17:902:f64c:b0:20c:7181:51c7 with SMTP id d9443c01a7336-211d0ee65f3mr7697965ad.52.1731627294915;
        Thu, 14 Nov 2024 15:34:54 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:c740:506e:c3bb:ebba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f545f6sm1753645ad.249.2024.11.14.15.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:34:54 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 14 Nov 2024 15:34:51 -0800
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <ZzaJG-WXnxGLzuEd@fan>
References: <20241114213439.6022-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114213439.6022-1-dave@stgolabs.net>

On Thu, Nov 14, 2024 at 01:34:39PM -0800, Davidlohr Bueso wrote:
> If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
> returning that value, instead of zero. Found by code inspeaction.
/inspeaction/inspection/

Other than that,

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
> 
> Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..01092e5b3b46 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -948,7 +948,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	pci_save_state(pdev);
>  
> -	return rc;
> +	return 0;
>  }
>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {

-- 
Fan Ni
