Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC6128368
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500327; cv=none; b=FqXLLhbJR5I114fiTopepFOQq4IzWv80tXMTbnxR6f5Phyefmv3ctrVLrdqkmsuxs1NYrJ2CFVGJ2rayNCNXQGq1Do52sdZ//ggJqF19LGYmVjeqeiHDVJMHLTv6L+XAMo9+0e4qOABXkanujai64RhRv0fm7Oorrs171IBLEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500327; c=relaxed/simple;
	bh=Q+c2YMjmO8vdN8QLrUTZXTqHR1EGai+s5B4KneGQlB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPYQ/Kh0SDFCc/U62loshVvwsD5roqTn6fDyQqYH6/R6lR5J6hfXlYqlaAV8GLrS7dlcWS51GfkEFtqHFOtGClgj1vWd/Rd0w49y9h/JmVXKSKFrJW9mrYp28GWTg5cUOY/NG9C4M5IHP7Vz8e/1jRWBWHe5RTu4+xmPM83UJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7sKBiYa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7sKBiYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716500324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o5HP+0MqX2z44qSHTea3mYaXCgoy62GX3CuvevhGFI=;
	b=W7sKBiYajFbEUcmU1p/qJx2wtp7zK3PuuBORU7naEul6Q3eYoh9FBt7RdfHWNXc3vowB75
	MNq/Hf61Y1kO4/iDXvEg4f7n7jSZGNvk/FiVv34y6Cx67CZ7q/M6UuOKiEn4vFMX2LCLoZ
	rfkOWcLZZxodjwJAAhDtzt3l2wOytp0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4Jb_Su0AOyiCsTJ7vI_1-g-1; Thu, 23 May 2024 17:38:43 -0400
X-MC-Unique: 4Jb_Su0AOyiCsTJ7vI_1-g-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso220539439f.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 14:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716500323; x=1717105123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o5HP+0MqX2z44qSHTea3mYaXCgoy62GX3CuvevhGFI=;
        b=Xif1fPE95toXnhBwWizZpZzV7hx/6gbfU5iDcDcdWzXWbeXsJhO3Q1fL6tycJVvP14
         28GKGTu5lwRawqNcYyQeQ20Dm1hKmS4eIKvbXifzxx8dBUdlxSztcoHtekmoduxlTCbt
         IfUDbVRbX+GaL0m7nBW4j4Bh5u7uE0sfbfgD7+PFSooQrMR58lIQ3w9GOLwiLsrHLExp
         7tD2+8xDpqmF2uW6MTWkRkwG2edJtZr68DQzdeBO8JvEZG73nq0if1/EqdNeyr13CyJ1
         EErqZw5rK5L4VXYeLPOQIuo4qo6DkHVrWmVodLx07lsTBx0eMfTzGqJ5ELqR03Fbk3Pm
         vJBg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJ7P5tUNcW3HnkCo/ZhE59Zw0LKyFF8vDwwCJM5rh9b6YLaSDBTG+aqjgkipM5zCzuWhpx8LUAxWHJ8oG+TE4H+KYyPdyTPak
X-Gm-Message-State: AOJu0YzaRaWMFz0ogIuc7sjqz2S4sY9bBIBe5n1k8hscnJ06ASPo8yKj
	QCs1uY37uh0C/Eef4MNWKaaniV6Pmj3YFd4uc8rismT7e+gQLMEsUaW5lBlEIBYBV/uNTk6oFLt
	HqgZFSAYgAbrllhSKGKFyX/MEFYvuL1ByEzNldfoEZI6UXxN4LA6IWBh3Kw==
X-Received: by 2002:a6b:7e43:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e8c6c183aamr76820239f.17.1716500322703;
        Thu, 23 May 2024 14:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGifk9d+MfD2AFHnMnI801S7v/LhgxyOOXqYOMCa4unB24dBRc47U2Lkk9AateT6dg+Xjo3Eg==
X-Received: by 2002:a6b:7e43:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e8c6c183aamr76817639f.17.1716500322062;
        Thu, 23 May 2024 14:38:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e8281b1sm66737173.13.2024.05.23.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:38:41 -0700 (PDT)
Date: Thu, 23 May 2024 15:38:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
 <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
 <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
 <lukas@wunner.de>
Subject: Re: [PATCH v6 2/5] PCI: Add locking of upstream bridge for
 pci_reset_function()
Message-ID: <20240523153839.16102e26.alex.williamson@redhat.com>
In-Reply-To: <664fb286639ed_195e29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
	<20240502165851.1948523-3-dave.jiang@intel.com>
	<20240523131005.5578e3de.alex.williamson@redhat.com>
	<664fb286639ed_195e29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:17:58 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alex Williamson wrote:
> > On Thu,  2 May 2024 09:57:31 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > Fix a long standing locking gap for missing pci_cfg_access_lock() while
> > > manipulating bridge reset registers and configuration during
> > > pci_reset_bus_function(). Add calling of pci_dev_lock() against the
> > > bridge device before locking the device. The locking is conditional
> > > depending on whether the trigger device has an upstream bridge. If
> > > the device is a root port then there would be no upstream bridge and
> > > thus the locking of the bridge is unnecessary. As part of calling
> > > pci_dev_lock(), pci_cfg_access_lock() happens and blocks the writing
> > > of PCI config space by user space.
> > > 
> > > Add lockdep assertion via pci_dev->cfg_access_lock in order to verify
> > > pci_dev->block_cfg_access is set.
> > > 
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---  
> [..]
> > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > index 6449056b57dd..36f10c7f9ef5 100644
> > > --- a/drivers/pci/access.c
> > > +++ b/drivers/pci/access.c
> > > @@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
> > >  {
> > >  	might_sleep();
> > >  
> > > +	lock_map_acquire(&dev->cfg_access_lock);
> > > +
> > >  	raw_spin_lock_irq(&pci_lock);
> > >  	if (dev->block_cfg_access)
> > >  		pci_wait_cfg(dev);
> > > @@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
> > >  	raw_spin_unlock_irqrestore(&pci_lock, flags);
> > >  
> > >  	wake_up_all(&pci_cfg_wait);
> > > +
> > > +	lock_map_release(&dev->cfg_access_lock);  
> > 
> > 
> > This doesn't account for config access locks acquired via
> > pci_cfg_access_trylock(), such as the pci_dev_trylock() through
> > pci_try_reset_function() resulting in a new lockdep warning for
> > vfio-pci when we try to release a lock that was never acquired.
> > Thanks,  
> 
> Hey Alex, sorry about that, does this fix it up for you? Note I move the
> lock_map_acquire() relative to the global pci_lock just for symmetry
> purposes.

Thanks, Dan!  Yes, this fixes it.  Please feel free to add
Reported/Tested-by tags when you post it.  Thanks!

Alex

> -- >8 --  
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 30f031de9cfe..3595130ff719 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -289,11 +289,10 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  {
>  	might_sleep();
>  
> -	lock_map_acquire(&dev->cfg_access_lock);
> -
>  	raw_spin_lock_irq(&pci_lock);
>  	if (dev->block_cfg_access)
>  		pci_wait_cfg(dev);
> +	lock_map_acquire(&dev->cfg_access_lock);
>  	dev->block_cfg_access = 1;
>  	raw_spin_unlock_irq(&pci_lock);
>  }
> @@ -315,8 +314,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
>  	raw_spin_lock_irqsave(&pci_lock, flags);
>  	if (dev->block_cfg_access)
>  		locked = false;
> -	else
> +	else {
> +		lock_map_acquire(&dev->cfg_access_lock);
>  		dev->block_cfg_access = 1;
> +	}
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	return locked;
> @@ -342,11 +343,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	WARN_ON(!dev->block_cfg_access);
>  
>  	dev->block_cfg_access = 0;
> +	lock_map_release(&dev->cfg_access_lock);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> -
> -	lock_map_release(&dev->cfg_access_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> 

