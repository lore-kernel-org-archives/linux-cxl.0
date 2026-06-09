Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B3331EAB
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030039; cv=none; b=NWiyn+OamCzn/1skkggSGpmzj48ism87cWm/SGPyfEK0bI1V5/T9jqq+E+CvrxnrCU4fDRFLGxccfnmoP9vq9GLQWy51ZUmmqIwav8Wf96fgVPjixf4abWLk1Ff846Lgs0Czmrlrs/oeavHX8VL6zT/8Bs7n9c0NhRl+jQbPVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030039; c=relaxed/simple;
	bh=YPBILIJB/sXgdKpxBDocoTsa5FDZwh7jmpWEGCgXIzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnUmJzLUH5ImpuaLjxB7REuqa6skMiXAr3P9Rkmn7f02of54H1ZmHG1b/w8Ux0uR2Kq6yxM+2OkiF5u5y1s1G8sile6Rqe5hEEgDfhuH10KYFFFFZbu6vTV31V64oDPhTBeId+7rbruxWhYmZYjr+NjNKhpK+v+7e9C/3nA4eA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cmEBbWi9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cmEBbWi9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91587626a3eso683473885a.2
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781030038; x=1781634838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OySD+ExhHPCEiw9aOnLHfgmqMe+Ca/7oT+zDoVBuOjM=;
        b=cmEBbWi92Wbz522rBYJQGkJPku6c/7g5/AvRQqFIQopotI2vvtpnI5NTKyrfqxNuIR
         Kdi7/zeqjL4VSHNr9BNcxZzN4FBX2/pXaJSn5WSlPI+ntggWDxeAUDSHOWNhZhfntfTB
         x5HTZlcoVSPhA8BIdK6b0+QiGGsK3sZdyopSb0CMvtdlvjDKiuZgc57I3nKrPdurzxKs
         zSoKv5WA42KbXP3dCdfef09GbK28iVTi05SyC6vTACKHVFw6WuY72QXHwUDJE6uaUh/X
         RLxl44lBi9+lk5biFRE6TftERtjCAqVkXeQU/Pf7W0UoTZRLIvnkwv9day/rRUmyr3SZ
         DwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030038; x=1781634838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OySD+ExhHPCEiw9aOnLHfgmqMe+Ca/7oT+zDoVBuOjM=;
        b=cdrvUe/6UNUzgnSLqQlBi6e8PuqcayRzBM6OMcrAuyiwNNTFKGrT3cvSsfssDDuPjq
         9aiYX5SOB4BUvMY2+furcv5g2A1il3kfKfYZs1yaRnY15ZNd7l7X6UNlw3xfD+Ox815q
         UxCYesoO4lMXocP8ZA/FsMxslYwsSf/3ojROA5OfXk2VcBe4jcb8KGxOOMN/ErhPN8bh
         5vXgUmHlX68UDQrC4xbAbpwf3ao+q82wPdI1j6I+Bbwv9dwuWzjPYzlCzLSDnr0hiLXD
         vWOLR/qaQ/T91MCaknvDrK1JU2qhTDoFmoHLxLbO4t0WDpmcL/w++1yjId9cv8C30bEu
         i7OA==
X-Forwarded-Encrypted: i=1; AFNElJ+pt87kBhLCg4GARBH26ic6RGQc3xC/MT0LL5L0vtMAj3iLF6s76Xodv8Fj53PXibpbboL9AD9bpjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQppxgV/2OGyEm/+rzMJkGoFyBu8IEZm9quLIwtyoqk1saih6s
	ryvlSGSKYtlgPGMxM6OewcBpH9AxdIlUHZQB6Y8q8ukk/rz59/mI32skifNz58tjins=
X-Gm-Gg: Acq92OFLNBgg03ZAydQR4f8mZ+vMFRURUNImgBiBTBgbdjxUnto83R+5axRC0QqRCo8
	4ClV7FfcOGtuzi3LdOwlfUWUth0qDBtHu/XBITpfgxnLemBGLsF2npsgXzu37dK5BPw75tDtq/U
	I6qdFMZoHTwCyCwjrjSS9aZ7IYP8L2gJr4LU3In+BwgCv6Hd/oNQUb/5Dt+STnC05PE6vdIQ4J9
	beyBmbY2lb/7KQ95CK3+GNFJzloiskCTIn+C9KFqxFQaPBRBDV+JItf/yzsIq1623n/uqqQ190m
	+pH+pn+pAcjDyYkLrsQqVTDJs5LIsxMAPyRylbuyZ3teGU1LkXG25jF1FFAxfttzKUk43vzKMXv
	JKCeVZfovlUJKsmsfqNdoL1zlFgeAPoTQhK4c+gjEpxY6YNIVNnYvVqIsyEKLzPeG97k0h6KOlk
	Jf9Cx5rqKigafA8KGWvkyclPU/yDhgVMNwvcLi2EBjtrMwSbd8YdrXlDNk0sDvUBBMyq+8XZEZZ
	rXbPBxhAb1W5F/b6A==
X-Received: by 2002:a05:620a:1d01:b0:915:9e84:85ee with SMTP id af79cd13be357-915a9ca7655mr3263727985a.15.1781030037611;
        Tue, 09 Jun 2026 11:33:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3eea49sm2158492985a.44.2026.06.09.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:33:57 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:33:55 -0400
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
Message-ID: <aihck-U9nyne98H0@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-9-gourry@gourry.net>
 <1cb0514b-c753-411e-8ff8-80fa29837441@kernel.org>
 <aigy0ut410TItkgB@gourry-fedora-PF4VCD3F>
 <e6e7453a-d2af-4f1a-8930-5e5e5c5879cd@kernel.org>
 <aihZG8WKVSvA86mA@gourry-fedora-PF4VCD3F>
 <06bcee07-5e56-4a82-95ff-2a8e75b7154d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06bcee07-5e56-4a82-95ff-2a8e75b7154d@kernel.org>

On Tue, Jun 09, 2026 at 08:22:20PM +0200, David Hildenbrand (Arm) wrote:
> On 6/9/26 20:19, Gregory Price wrote:
> > On Tue, Jun 09, 2026 at 08:11:42PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/9/26 17:35, Gregory Price wrote:
> > 
> > Was going to propose this, but then I thought... well if CXL detactes
> > itself from dax and does this same pattern, maybe MMOP_UNPLUGGED makes
> > sense.
> > 
> > But i'll leave that for another day and do as you suggest.
> 
> Let me sleep over it :)
> 

Have some other sets i'm trying to break out of private-nodes anyway,
i'll let this bake for the week.

~Gregory
