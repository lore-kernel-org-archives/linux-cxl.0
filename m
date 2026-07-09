Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECF3AF656
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634933; cv=none; b=hbFVS+/lZJCMxUq5DCFHysVdFzztmOAXORK45Y0h/QGMHtqkLtc1IC6OTC1NlKju/sYYavUjIbEGnTNB8OsVEUxy8WkrjNDS/2DHhxXiC1PyOGWUTHX18eWsi7K51vpfkKd+NfXOQrX2unDM/FtMyH8iAO9kbTQwMXPUA2g1Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634933; c=relaxed/simple;
	bh=6RBF0jp09O3guB5Q86RDVYGXWp7JXTcPagL5/X5HeO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucA83JSM47m5nKXm7VCS8egKpApjX44H7RYJQA/65E1z8XYI0zU2oXxHykWapxLsKsHFoQRUpxEX8QTD/YUYg7QWtFRyeSaIwkjqCRXfi10G+6rVjj1HEUrPtSTArMvMqBcEdYeDahV5k+Ok2EpHQDxEt7/R122qwQgzVN991VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DWqIjK+w; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DWqIjK+w"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so2687416d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783634931; x=1784239731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5hy/40qOWrDje+rO1HwX24k6GcjiBFx+d8whX1kHrQ=;
        b=DWqIjK+wQP2S9P9eDvz+eifCekOeL5ICmp8XDSO63D9iIeJ9bpo31x+iZ4b9X9mtJm
         qw91+Xp9U0JYB4q+7pZprbMLRJhqqvcuJzoeCzrkLF8T6FkhJ2sULWx04ZQWrYt+QzSQ
         IGTG2hxZjb8YFa6rBwoC2yILH/XaS1Rvd/OWfhMj5pn8cWfKAKJJA9JciEuaTEDeUGBj
         HCd/FoUkjV/qVzg52zrPYFM2b3JEkp2xBOPu15zpY9VMz2qPDG5xPaDDhcpdIX9NYxNM
         0jfW455Ec5bew/JtVTztslE2bH7jkqL7XCli0x819iGHCFfxJ5EEYcmFydhwLVUAsnbq
         3YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783634931; x=1784239731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5hy/40qOWrDje+rO1HwX24k6GcjiBFx+d8whX1kHrQ=;
        b=mLsGPvIEz7PMN6lH6IjX3gnU3PinnmIAmSISffiPFInapMGZ9wlBNEk+R91zI2qo0e
         5GEBnCAeVoi9Z6TduM6LDpm5pXUCLDeum+NjK/Lfz8SYWSWRCu7vbaM22K5Kmo4+1yCX
         sy0hMDTXURm9ehIwGzJAp6AfZy7BTkv7Xu5nkTMPiWLrMsvqJ3lV8PE7VjOYVTYVG1kf
         0HbS6GSXu0InEa1reeCSFMTGUq8h8eoG+oO+w71q785Y3Gq/dKM0/LsZcauCpCS0WgzT
         YJg0BE7rUqnfl0c3mjq9A1iMw1jNVO+xEeaqdBJhWA2GVIKrXWd0qyJ1YhY5AoUA3iML
         FE+w==
X-Forwarded-Encrypted: i=1; AHgh+RoLGkOemDQmp0hkPfzvu8QykTpEO97osdWQd8ovwvajz15qjUQsFYM/QcmYrLTJAjlQ3yXqodL1ZD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx52VzI8C7RLQCkqj0cA3Fb4E2tMzO4qC5ZkA8l1RUJin+7iQV
	cnqyPolZtXB8pe65qJ91LsuSNtDbk9jAt17sVF5XcsScI4nXtmLwLxWs0xZcHAqbjeA=
X-Gm-Gg: AfdE7ckZC2zzrdDZx9E2ei2dI9q4dCFIK5oxWjsTxpCQ1PsxhWog//zkuasRPfkLFs7
	2EKupnUsAWgKjqCsWaeknVnig9pBU87i+Sn+ZHiyH1/mfBh5TZkoJDDHZDhRi5Gpjt2zleq403Z
	girgBW2x0VX/gect7I8iQErnf3WSGg6g/vESvhk8PO7wGPEK62hBscpiGG/ZkkJoVCP+p0IVNTW
	VID5kdjV9ARnBbhJ2YQsuhvLlC6ehj2CiUr76UbGuPfCiksVJOntMSpApNywAkuijQqp4AYWWuH
	qIS/SlfF3HP3sLnwOwXA+RxsdAXXmE5sZvYs5HW94Q7dH8JkhKieMFRP1mo7ZfuV5VDdfJ09Hxt
	2ySC8mJumAu7T0DOisnstTw5PCGSFfRU7uBpht/bzNbGVjhnZKZ7c+bLtOTrKdQIlQuH44cVnJp
	S+Mc31SauntHzbtMmdqIc30m+9RNCMTRS4lrtAhFpxeWXKBK9J9ifaWi8/civZXL8PusRZ
X-Received: by 2002:a05:6214:1306:b0:8ef:1840:2bd8 with SMTP id 6a1803df08f44-9024204ca5cmr14984856d6.33.1783634930620;
        Thu, 09 Jul 2026 15:08:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm26797256d6.49.2026.07.09.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:08:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 18:08:45 -0400
From: Gregory Price <gourry@gourry.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 07/10] dax: plumb hotplug online_type through dax
Message-ID: <alAb7Q_Ku5dVRKZ7@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-8-gourry@gourry.net>
 <6a5016bf71df4_3b7ee5100b3@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5016bf71df4_3b7ee5100b3@djbw-dev.notmuch>

On Thu, Jul 09, 2026 at 02:46:39PM -0700, Dan Williams (nvidia) wrote:
> Gregory Price wrote:
> > There is no way for drivers leveraging dax_kmem to plumb through a
> > preferred auto-online policy - the system default policy is forced.
> > 
> > Add 'enum mmop' field to DAX device creation path to allow drivers
> > to specify an auto-online policy when using the kmem driver.
> > 
> > Capturing the system default would otherwise break the ABI, because
> > the system default can change - but we would be statically assigning
> > the value at device creation time.
> > 
> > To resolve this we add DAX_ONLINE_DEFAULT, which defaults devices to
> > the current behavior, while providing a clean way to override it.
> > 
> > No behavioural change for existing callers (still the system default).
> 
> So I know you have some future usage for this ability, but it is not
> present in this set. The only piece that *is* used is that the
> online-type from the new sysfs interface gets plumbed through to
> __add_memory_driver_managed().
> 

Correct.

I didn't want to cross three subsystems in one go, I do intend to follow
this up with at least a CXL build option to override the global hotplug
policy by plumbing it through to the existing cxl auto-probe process.

Some of the accelerator stuff is still a bit up in the air but the base
driver can still benefit from this as well.

> Are these touches:
> 
> >  drivers/dax/cxl.c         |  1 +
> >  drivers/dax/hmem/hmem.c   |  1 +
> >  drivers/dax/pmem.c        |  1 +
> 
> ...premature until the first user arrives that with the background story
> about how it knows to set the policy?
>

This was more a matter of having the DEFAULT set consistently across
the dax driver variant probe() functions to make the behavior explicit.
I didn't want an un-set value bug to creep in here somehow.

Happy to drop them if you think that's unneeded.

> If DAX_ONLINE_DEFAULT is a sentinel for "default" should
> DAX_KMEM_UNPLUGGED be a different sentinel than (-1)?
> 

They don't actually run into each other.  DAX_ONLINE_DEFAULT is
overwritten at probe time with the system default policy, so
`dax/state` can never perceive it (even if the values are the same).

But this is visually confusing i suppose, so I'll just swap it for -2.

> Feel free to add:
> 
> Reviewed-by: Dan Williams <djbw@kernel.org>
> 
> ...to this and the previous patches when that is fixed up.

Thank you!
