Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492C2C08C8
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262058; cv=none; b=MA5/bxE5lwNczNGzC4bV8cCm1utXo5YLKJ4tM/rG4ar1nyeQvNvs0gPvOZW1SER7tMGPi7UZI5iv3FC7yo4pKjFPAD9CLXfv6n1czb7Lv32amJLxmOs98v5viAq+sEwLETfh5dn1vRfKFHW6rEJi2uSEC4KXNNgsmkia/ifQqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262058; c=relaxed/simple;
	bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqbGLVugJbKqORILpa7G3pVbWtRTetBGx6gndnnPwPim2Vywkp7hB4YVHPc2NTsTedHDhyaLYPHo1Sas1udJYkHD9akSzWX02MEM+pmSUTtYEKBhajuRRK9fU0D6g+1j4xwQ2qvJtCGi1jfTJ0y2/fBCRMX+eA8qGCqToyKWb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HAWkep//; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HAWkep//"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee13dc0c52so60433441cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768262056; x=1768866856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
        b=HAWkep//EFhJW9wywQFy2dMaCD6x0rWanih6xdYl+a8hTir2qjOknoBiE1lYRxRgVM
         /whsUs9cl+Ycb2AwF8z46BlbbZhWzq2Pmk/lSOqE5IkoroReJFVjrZ+U+1szEvSK6pmk
         QuYiSTtT7Z/pq6rwN+f6YxFrG2KQnyFXY5sMHbedmi3Q642Ov5MBM/fOix+b27wozxUV
         VDzacX25oMKjSSCEjRbKUnkEQ0yhlLisnQCaTAysRvJTC6r6HiOKf1jTMCBX8OsO+m5/
         RvXYkVstXSGVKRf9ehh9ysEdilZPK5RHl2PY19gQMPVMg125ANzOIdNrBAYetGIAzsNU
         sMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768262056; x=1768866856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
        b=NGSv6mPOgDGvDS0j92adsYnOVj1hYsVn8JFFsfTKPmEcrn877+GIaHoTuYEj1CfjoR
         lgm1gACoDMqpI6DkdJ96lxCyQcxE+wsEEi4EukDPNl9P9DqaZsGMfuep7LDjwEViDTKr
         T2qmfMsDIZ2FNfARrgCYLkiOU9zLStxTpBvS8Lo2UQ2grKonykvy4eHadaE5XiZEABIO
         ojz34xs9C3d8eTlUqRNxGsy2qN2gapk+KQe9hdmNOfy2o8FgX91lOgYAGlVHiAAP0dBJ
         pq0e7gmzl1CIFi7MgDC+q8mpDeCV7lHuq1mpmb58dRLkeHkDXaOpB7zd3pp9Ej9oNp6a
         kyyA==
X-Forwarded-Encrypted: i=1; AJvYcCWJPBnm5Il6A96yshY6BIwUVCw4Ulfk8N3kstdyrrQB/j/1uCZ2BUKolcyJS+Qk6SiMYwxdTaYQOec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49K8YQBXu5n0QVxHryPHUlFPl2rq4aKA6bXdzlO1phkxV/T11
	W7Y2Yt1z5Uc37n/u4UJBJMPfXyVzvw9ByGhEZjqEAy1mkQJwD3Eu4nGHGkPtpVk8WYQ=
X-Gm-Gg: AY/fxX4vIYwIb2EwxbXcnL2whgFJRhT13/eAHDOwI/1pE3RvjPAmOW2GElEN+os7JRg
	VdPxO++AuVMWRMs2S3lZizdtFUEtncQ6Ixtkv/UpoJndUP11yiV+Zhw6onQoiCsWy8U+9XpaWvy
	ahrauK6A+S+m6gUFQzL0rjWr4Z8aY/tu56GLHOVniJKBu0wUkoBTVVKuT5HWS6Mn0nu8uLigoSY
	24+ML7AvKTIbB9FbYX6f7h5nsxpuTSbJxeKkUwkPvyTWseg/QUVZk0I1liwgTi7CZvyvCXZIRFa
	ChRALtsrsnbAcpMpdrl2uFkgTbSOXrH+fjs91YIQdAevdf/BtaDQAVDw30t0zqB4WZgWjhlpsdp
	jLeiwTY72DuALP7JaK6VRWtRHxjeIVqH0C8GwCHEFhMrJ9dOneR/3K/sjphYLFV1WX1Rp1mkm2r
	L2Iefb2epW8CQQW/n+rkf5iwegCoEDEskzj0q8HoMhM9IcNX0DjYH2CYjhSVRpGNFavbQ=
X-Google-Smtp-Source: AGHT+IFqShnh4nFq4FI+txOqV94h9FNeJmPa4/JUWRJXzRBu2Yp6JXhvTMJ52+U7dVhw4CMApET5TA==
X-Received: by 2002:a05:622a:8d1b:b0:501:3b8c:7d63 with SMTP id d75a77b69052e-5013b8c8686mr4698571cf.26.1768262055766;
        Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e35dbfsm129011631cf.19.2026.01.12.15.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfRji-00000003fUm-0uFg;
	Mon, 12 Jan 2026 19:54:14 -0400
Date: Mon, 12 Jan 2026 19:54:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112235414.GO745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <aWVsUu1RBKgn0VFH@lstrano-desk.jf.intel.com>
 <45A4E73B-F6C2-44B7-8C81-13E24ED12127@nvidia.com>
 <aWWCK0C23CUl9zEq@lstrano-desk.jf.intel.com>
 <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>

On Tue, Jan 13, 2026 at 10:44:27AM +1100, Alistair Popple wrote:

> Also drivers may have different strategies than just resetting everything back
> to small pages. For example the may choose to only ever allocate large folios
> making the whole clearing/resetting of folio fields superfluous.

+1

Jason
