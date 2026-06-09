Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D148B367
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029154; cv=none; b=I9D4yd77hK5qu0PwVNIQIygpw8FypDdbfl+rJefOaTG3gCVZm0kGAVqspf1U8+rRGC8dFtAKkoiv6GVB3Cavd1tJYahVF3FtDqfqrdPsSlRfb1UP7ChzFn3+b7K0A+dDdXV/FTntzrHj8ES5Wh1U7sXj7vMHkZdL33JNB4f8GuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029154; c=relaxed/simple;
	bh=yN4njZ8y4hk97P/ujuc+3D9afHqUiRM9TkBrBVe5vEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMtw1LZ3OA3OmLl7wy9nNoZhxePHJfjJkLk4DyAY/DdGqnlEvIs+EiDae5EO4yFWeMMDG6YR9RgivaA/+WDDf2WVOer3FXR5Sl47DAIGQhz1lt89r1Bk9XenswHfbwIh051KRwpw+bIkWQ2CBDJn0TcLyxy0ecsWJCrgvR+qiQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oCXGg9gx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oCXGg9gx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157d3f2098so699679885a.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781029150; x=1781633950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KqE8R583ndPf0WEv0mevB0HU+y2IabL7k8Ouzc21Xc=;
        b=oCXGg9gxUSxcU5GesBJnVhLKzHF4A0e2Bc8hwzKSN9CrVWmB25ESUcabVOr/JpwPte
         XoSrPOYZHtG7BS32cdUfzPx2Gb2Qv1G8ElmRk/Ph+ST6qug8X6KhCY7pYGjEf8fv7a44
         fbeLi9nM2XbarEJbnGBrrUJ2WxYw03wZ/MMTZ84nfzAFFnXwtAK0ixBOxMRpiT2MPorb
         yZR7U+alB/vgodJv2u7Apy1yGRbY5d+Q5rz1EdUrBFta8I25uCS3nxmzyZT82MmbWOdP
         7+u46AV8GfSTbvb33RcudVS6CLTwsHfANId0JnqwAutbzBeAC0LrZ6klL81ZRS97KzPF
         qJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029150; x=1781633950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KqE8R583ndPf0WEv0mevB0HU+y2IabL7k8Ouzc21Xc=;
        b=kqMr43Bv1vpMfrDtOmnW9aX+4fn2YLqRZczohQEI280oI0I+LelwtdWZRuXAhLBXa/
         yfzqck44O33rbCkPp7edhRbEconEuyO4iOZMmEDTDpFEWlKsmlUc7pU9svr3+lJaHwQM
         juXkLYTQQfh9Gln3VhhXE6m4mS6dxsIzdQExXNDtUcIL+0EyLBXg/+On5Z2zKd7JDiPx
         ALsolJ1Pu8TVkkg3H264dzv94ROl2mChxyTwmGjIMBk3hjVDPZcVOEgWd4wLG9+/yROV
         Wjmcg2faLCuKFCZ3ahzSY76rkjMuHWKtKZPzpcFdpiOhsmGzoieu9HeKIYbYxEfYWSs4
         k01w==
X-Forwarded-Encrypted: i=1; AFNElJ9qAr7e9gyWcal/Xs7nQ+40J/6XJRBSdz7BRS7yd+geFkQGIP6bpePvs8wzYtbSF29jOMaruK5LWrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7qdU5DziZZ1oxD3iJNA0Liu/fsH0aNWBarfTv9YJI2MbssMU
	8z1d3U1jf/r+ZCU+6HaNYgqFz5sLqRaClAcanoYMQPfg+c4xxGxsEyL3sGPstzzoQJQ=
X-Gm-Gg: Acq92OGJbXCszIkcEKKwe3VhQzkkiy1/s/wRo+KCNwaDM3GP5dnKH47FzMzw2O0RYId
	LIE5uVSpVt0v8Q2du6GBEC3DzdncI3vt50g4shLeaAIAKCsx7WDofRwkvWO+1HBLWrCu9aH/HHG
	Cu6lSW6IAzn7ouYkt+YSXzJwW28r36gSDc4bm7enHLNtdLb9K9qmevYEbSL4QgH6YfMaDzwmynS
	OJEW2m3bYvrBZCg1efhnq93AMNsBAx7XxT/tM99i3tGLSYjmp96aDQFewVzrvUzqM5GNFUxeqOS
	YnN/byOI3B8Oqnb3bX9NaIAn6rLAxW6hl1Ug0H158+wMMlx4WmKnoUqVirI00Y7PRgtyQH5pCQk
	jrlpAXlzjdStt71tmWE9GgDlU3rWQZNxTl9OtGVvJDDhnFNvFyOgZZOhiMvbjHvHP3F6ywtZF5L
	eWhYfmDmOEEOyIvOZk4/OOBmaZrJ4h9Z94PEJEhImSfpxqiCciajifEqUcrdIS7QsolQmcpW/4x
	BLKzqCgppC0l3UtTQ==
X-Received: by 2002:a05:620a:17a6:b0:915:6758:222c with SMTP id af79cd13be357-915a9db8ab5mr3329361185a.46.1781029149586;
        Tue, 09 Jun 2026 11:19:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a402ff9sm2211734985a.45.2026.06.09.11.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:19:09 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:19:07 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	linux-cxl@vger.kernel.org, linux-kselftest@vger.kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, osalvador@suse.de, shuah@kernel.org,
	alison.schofield@intel.com, Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 8/9] dax/kmem: add sysfs interface for atomic hotplug
Message-ID: <aihZG8WKVSvA86mA@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-9-gourry@gourry.net>
 <1cb0514b-c753-411e-8ff8-80fa29837441@kernel.org>
 <aigy0ut410TItkgB@gourry-fedora-PF4VCD3F>
 <e6e7453a-d2af-4f1a-8930-5e5e5c5879cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e7453a-d2af-4f1a-8930-5e5e5c5879cd@kernel.org>

On Tue, Jun 09, 2026 at 08:11:42PM +0200, David Hildenbrand (Arm) wrote:
> On 6/9/26 17:35, Gregory Price wrote:
> > On Tue, Jun 09, 2026 at 12:26:07PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/5/26 23:19, Gregory Price wrote:
> >>
> >>>  
> >>> +static int dax_kmem_parse_state(const char *buf)
> >>> +{
> >>> +	if (sysfs_streq(buf, "unplugged"))
> >>> +		return DAX_KMEM_UNPLUGGED;
> >>> +	if (sysfs_streq(buf, "online"))
> >>> +		return MMOP_ONLINE;
> >>> +	if (sysfs_streq(buf, "online_kernel"))
> >>> +		return MMOP_ONLINE_KERNEL;
> >>> +	if (sysfs_streq(buf, "online_movable"))
> >>> +		return MMOP_ONLINE_MOVABLE;
> >>> +	return -EINVAL;
> >>
> >> Should we try making use of mhp_online_type_from_str()/online_type_to_str()
> >> [possibly a nicer exported function for the latter] to avoid duplicating this ...
> >>
> > 
> > In patch 6 response i point out adding MMOP_UNPLUGGED
> > 
> > If we add MMOP_UNPLUGGED as a state that is only use by callers of
> > memory hotplug to represent the current state - but not as a valid input
> > to memory_hotplug.c - then we can simply this as you request.
> > 
> > Although we'll need to add a couple lines to memoryN/state parsing code
> > to disallow MMOP_UNPLUGGED as a valid input (otherwise you could
> > permanently unplug memory without the ability to get it back... unless
> > you want that?  Seems useless to me.)
> 
> I would just special-case your KMEM-special value, and then branch off to the
> core helpers?
> 
> static int dax_kmem_parse_state(const char *buf)
> {
> 	if (sysfs_streq(buf, "unplugged"))
> 		return DAX_KMEM_UNPLUGGED;
> 	return mhp_online_type_from_str(...);
> }
> 
> So there is no need to add a value to MM core?
> 

Was going to propose this, but then I thought... well if CXL detactes
itself from dax and does this same pattern, maybe MMOP_UNPLUGGED makes
sense.

But i'll leave that for another day and do as you suggest.

Thanks!

~Gregory
