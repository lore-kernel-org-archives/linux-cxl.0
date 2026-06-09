Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87D48125B
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018146; cv=none; b=Tfcauoi77TJqk3jXXXeuPINX3kn4KSSSz9LGvMgRqZj9qoks9SdIDS5SqQNRENbIsjPrj7VtuKAxvAG0Z9Tq1TGTwH7kK0/HwcGTA+hCHpNrkBzZKrvHalhI+1JyMtf/ygeR2us0aaWi0PYRuUOLhLy7zRNnr9Qxqp1NE8gD2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018146; c=relaxed/simple;
	bh=4Q3lUCN/K5ogiGNFPWtDLaQVmKDt2aFt3PTUh0S3qXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYpDxCVlMmocznlGDVDAXRInqzJIksjF6AAIYbywVrf41Ph1wW7v6a/MBDW7skavVbW7laf8JEnd53lTdlRN04GEv5JV+m/OtTumlIz3Dr4uWhKBLzrpYae8xZE16btkSlw42N7ffOLLmfTQdNlUxPgWOR1xmsHYdr+EVa/uBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QYKlEwp1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QYKlEwp1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9156b74006aso410251285a.0
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781018142; x=1781622942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01y5Yp7Lv2fsZ0TiFN6M9m/RLD3dl7/dyTYKRdYu1dc=;
        b=QYKlEwp1NAeKXFH14vu88N/Jn3kbwlP3nN9KftlyUwc0sVPeNHbrFcKvdMCfxsTZwZ
         7/utzHEww1ziDVO16OsAdJvAz6tNgEc1ODsGpNhP4TPipcWA59mg3UyV6JlsmIaSZv4u
         2YbMRZ7LzVxll6mm4gBXF24O7wvKumb25xSRVDzQCBvvEQpoifN9VjHJmJeJsapmrbQk
         GB1xfENxYm8wHIAYyLTXx5++1Ise24d1xQECru8Qzx2O1GxkDlUAMg3/r3l7DY+w/cnK
         ZLRt1jVYnLZ+KpKEneVxmUrXNgglHlFV5MLkhbs9hke5TB4lybkrgoj6Zak8biTtcxHa
         v5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018142; x=1781622942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01y5Yp7Lv2fsZ0TiFN6M9m/RLD3dl7/dyTYKRdYu1dc=;
        b=CMrNRLnhv8DZSyVz6lKlZ11ANgDDVgQLquqCCNJGphG8pctQKZpmD57OrP+iZGQgqJ
         0eyxjXAnghKdx4o5qv+/LiVL4iwqmIX+tbpB9VuLTq6XF7I4eWTdxiL4RoPyklvECpjz
         Hi6QcbeU0PoUoHPXrsjPoxLPIkDp5TZK3t/VPB7ztnW9MihoYq0vppqx5VY2dqXi0Vrs
         QBJmSySLSW3XZ8Hds09+nhCfg/55v+1IskMNeEwcg7Dqt9jrSuyXh5iutRu32dBM9AoU
         6q72KcGzxa2+mOpftddHvKmFmx42dP1ZiwieyO4lxVI/SKQWvnefuu/571K0bUsyJsR1
         VFUA==
X-Forwarded-Encrypted: i=1; AFNElJ+nxoBmPHLCj7ICJQsK5jvdlFxpeTW3i7XdhDFlBLXJjcFatRSKsL/nDGGntme7I/AFEkll7NIUaUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ir6FrIdHOi2liNtXyM4mZgVdiB5H/fQ1cMILAlonnGczfDL4
	+b5QejfNXqJlEOb0EEd+aSOWcagmpy3r9JOnIU+T5C0TVHzdKLPldnngOOpoC0JCpZM=
X-Gm-Gg: Acq92OECIm7FHdQFtt1fZ2iGYagkydef2pEbpXAVxQmUP+ajdjshbMUgJ+Zf+OeeICE
	ODTbcWKXzWAe0yGlxv4+czW7MZ1bztDG6VZRVAYvQQzozr8hS8wUXqT1ax5SODaaPxK0xZgPRwy
	y2D47ffMZ4jo8i6UYCCW2C/p7c8j+Bm7ATlY11MPtX/HC08I80l0Z4kuPd83PBcx8ATNhF8BfEa
	FUdhDFmSiyrp3otiJYks3IfV8IYckXVGpNj3FMTJPkXGtZaWuu6dvVriSNuTy0mcQSwUbjtxfzv
	ZGzjIkzLcsaTcphBcrwB+dBbOX/zQAT00EuPaPEM25VfrXDHFxQnN6boikEB108DeZrlZ9H0PJG
	SUwWoa5uHPWvtg/9vISNag1Sb30WDFgzNHXcovH08jCIuBmEz8/6W/V/NOgVB/G9Ql5SgTObFqU
	6uB1cRwvzOyc0Gch1UboGfgorl3NaUZzmZD5YcZcP547bm0N8YeVYiMjdDobR0NMMtLZURFA4xR
	aBrtjhdKCloL3uz6Q==
X-Received: by 2002:a05:620a:2547:b0:915:9972:cfc with SMTP id af79cd13be357-915a9c7bba3mr3335701585a.19.1781018139752;
        Tue, 09 Jun 2026 08:15:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91589ea0bcfsm2153439585a.0.2026.06.09.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:15:39 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:15:37 -0400
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
	ira.weiny@intel.com, apopple@nvidia.com
Subject: Re: [PATCH v4 5/9] mm/memory_hotplug: add multi-range hotunplug
Message-ID: <aiguGeKKfSOu8haT@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-6-gourry@gourry.net>
 <b62e071b-9dec-423f-9b4b-e3c34ea0a409@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b62e071b-9dec-423f-9b4b-e3c34ea0a409@kernel.org>

On Tue, Jun 09, 2026 at 12:06:38PM +0200, David Hildenbrand (Arm) wrote:
> 
> >  EXPORT_SYMBOL_GPL(offline_and_remove_memory);
> > +
> > +/**
> > + * offline_and_remove_memory_ranges - offline and remove multiple memory ranges
> > + * @ranges: array of physical address ranges to offline and remove
> > + * @nr_ranges: number of entries in @ranges
> > + *
> > + * Offline and remove several memory ranges as one operation, serialized
> > + * against other hotplug operations by a single lock_device_hotplug().
> > + *
> > + * Unlike calling offline_and_remove_memory() in a loop, this offlines *all*
> > + * ranges before removing any of them.  If offlining any range fails, the
> > + * offlining of the ranges processed so far is reverted and nothing is
> > + * removed, leaving every range online as it was before the call.  This gives
> > + * callers all-or-nothing semantics for the offline step, so a failed unplug
> > + * does not leave a device split between online and removed ranges.
> > + *
> > + * Each range must be memory-block aligned in start and size.
> > + *
> > + * Return: 0 on success, negative errno otherwise.  On failure no range has
> > + * been removed.
> > + */
> > +int offline_and_remove_memory_ranges(const struct range *ranges, int nr_ranges)
> > +{
> 
> Is there a way to just generalize the logic in offline_and_remove_memory() to
> multiple ranges, making offline_and_remove_memory() then a simple wrapper around
> the new offline_and_remove_memory_ranges(), providing only a single range?
> 

Yeah that's reasonable, I'll look at what can be done.

~Gregory
