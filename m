Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C618399A
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063664; cv=none; b=a+PiZJr1+dJI/imbydHzx0r2fpgHA/Cl6wFdAi3+NMqhrQ3SSXZZxCtbOKaE6HAl7uJeXsU7I7Fv/CrnFJXBNEl4gRSAVF7z/sXEDcRw9pe6QSPxAzMba1igoh+YTIsaKucJ/F6hLscLASLYjg4d7U9DM6N1yMUe1nGQsNYAMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063664; c=relaxed/simple;
	bh=vfoNxOaXa4hC4OBNvcSsQLI/m+dsd/42KQNM9IKZJ/4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/Xy1f5R51u1v57xamCmO6PApgMpX0IPpnP/30Bp8tnM7wqLDUl/eNYl5hlS3vrrDbAUP1k53WWyF8TckYmtRx7kq0b0ZLHwXuryvZwL3hlR+PfUExJHVMvlBimisLQRAf8s2+CasgMkeSf1IcM02z31Kofr8o4Eoe7mex+yRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cyWKd5D/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cyWKd5D/"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b7ca4ad02so703880e87.1
        for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063660; x=1717668460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLZUg4xxjbbci4WFVYlF6LST9L5GfNmEJ+vCvpQ6BCY=;
        b=cyWKd5D/CjYMX5GVMlgdhP9ZeBXnNT7UtJXSuq+xwhOVGHjuW+oRHvSxFSjgO+f4/X
         BwJmJ3g9DVl3vxD//6d6sRiLSpRR859rvIyEhgi7LdB0PYPKBKkwghHWsflDb4nHnjOL
         Q0yIlblyzNg9siPJXr0W/7E/1RO0cfYhDuI96EKDsWvQHu3R4aSTpY6MUaKtyVITJlJf
         +8ULjQNRn/D3lHxeZcz9nMeI1UQvUFmCWVOMXeWKgMhkejKS6W38r8ZOIIFwdIQiFUm0
         /BwumjRTv0GKj512N+n6QIZ0DK3ct0QiPFmOVfk7HZK28VIb9z2y7CsrfJB4KUeWjg4N
         4ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063660; x=1717668460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLZUg4xxjbbci4WFVYlF6LST9L5GfNmEJ+vCvpQ6BCY=;
        b=Bw9Op2lqUiWLVog6h6bEjoqOIDB+pxYDD+vYxFLCCOTowfkGo7wPcJLwsr34+gcJVt
         +tZ0UYBwpaAU89JLeVLDl7Spb8VFy6yQriG4/q4C/A4mPzltgG6BYyL4E8UCzmy6YMLe
         Z6PrMSKnRUEIdmaWICEU8QBLg9fQaDfcfB///MoJod9GCx25VjqK0lCXmNTfdcP16h6e
         RVqfQMRYjoOLizRBAH+cE1QEVGggryw2eRXYa3SDJ9EqiyIUUB5UaXnxG9sJ2r9ylcTI
         xUSXABrRLxkvYz4rCyC3USJVFnC0Mn2wAEesbxnIgu88rXogJof8L6B3DfgxVueeBnV6
         7P/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwgrko/upEIaEYKFUXWCyAsIZsRb1NZdsx3vOBfoHfXdEUSiKdmR3Ns5Qkcnz3/r8dI4rHAgGhCGjIpdjYc94NzQrgTwR8IA9U
X-Gm-Message-State: AOJu0Yw6DY7Xlpz2Z5M+Xbf0r00wJNm2ZVUuoUFLqEEFya6wgp37KWhN
	hXvG/9oOgdkrAQcKBQoHLmX7ToLSZqOVez0tRi/iK4IIBwRT+82jnmsMTll44zs=
X-Google-Smtp-Source: AGHT+IHuZom72MS+DlLBVAVZr+NsBhcRlIEYTeYYYXrroztEc7NL8xilH1SLOPXekWX38QZ4U5NJwg==
X-Received: by 2002:a19:6902:0:b0:516:cc2d:f6a1 with SMTP id 2adb3069b0e04-52b7d479c72mr1116532e87.51.1717063659996;
        Thu, 30 May 2024 03:07:39 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127065b52sm20447875e9.13.2024.05.30.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:07:39 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Thu, 30 May 2024 12:07:37 +0200
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Jia He <justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	linuxarm@huawei.com, catalin.marinas@arm.com,
	Anshuman.Khandual@arm.com,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
Message-ID: <ZlhP6aMUOjx_EziA@localhost.localdomain>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-9-Jonathan.Cameron@huawei.com>

On Wed, May 29, 2024 at 06:12:36PM +0100, Jonathan Cameron wrote:
> I'm not sure what this is balancing, but it if is necessary then the reserved
> memblock approach can't be used to stash NUMA node assignments as after the
> first add / remove cycle the entry is dropped so not available if memory is
> re-added at the same HPA.

It is balancing previously allocated memory which was allocated via
memblock_phys_alloc{_range,try_nid}.
memblock_phys_alloc_try_nid() is who does the heavy-lifting, and also calls
kmemleak_alloc_phys() to make kmemleak aware of that memory.

A quick idea that came to me is:
I think that it should be possible 1) create a new memory_block flag
(check 'enum memblock_flags') and 2) flag the range you want with this
range (check memblock_setclr_flag()) with a function like
memblock_reserved_mark_{yourflag}.

Then, in memblock_phys_free() (or down the path) we could check for that flag,
and refuse to proceed if it is set.

Would that work?
I am not sure, but you might need to 


-- 
Oscar Salvador
SUSE Labs
