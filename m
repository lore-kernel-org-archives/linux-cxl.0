Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7374199FAF
	for <linux-cxl@vger.kernel.org>; Thu, 31 Oct 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391800; cv=none; b=EzYdZQXHcg8cvhmnSsV+UO9W90HRp/kCdO/KkIq6FBKblAVLWrzCZeUeN4iMEXJZhxTQ5vzn7YGR3XiS9jAera+JFgH+gyDhwYWy6SVC8860FrsIiJqsqP0Cip7xEH1bv/EP7b438ZBZEHIkgl6KjZ8gAn9FYKLk6A3nlUhsOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391800; c=relaxed/simple;
	bh=pHyLyRq9icEl7h1hajof/4uWohbq3D4kb9tZ1Q3TxCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVq5/dmih9LIEPNIoG590N1TpoahZkhpeLPI0e4Du2piHIkGaN/hI6YhDfybFJLNcA4aV8xqHG04xXOJ7XhB66YAK9q3OnyLg/sYWxBITFVHBTlFtr10Ca9aygrEAd0tZdiQkhMRHZj+bbZS5i/ujs9ewvUV5WtK03qJczNbqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A4qPUJdB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A4qPUJdB"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b155da5b0cso79699285a.2
        for <linux-cxl@vger.kernel.org>; Thu, 31 Oct 2024 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730391797; x=1730996597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=A4qPUJdBc0zjzPz59IM7rTHfXyvkBIURVIMdaOLECvzsczBDu9kG7T4zUuKhn4Oa1j
         59SqusMgAemTsGgSuAjquTbuOCdOMz+N1ebOiZMAXUxCV5BAlikhw/FQgBmdJKSNc8Mk
         /btFMqhC2rI8z5M/gWqfczSjg/aC9pNnfz/D0MpFQ0IX7r9Givev7q2sETHKXKI9ek0G
         nGWY/OXevb+VnSE+r542TUqy2vwnJOcbTty9uTdWumpaBP4zoYBcY8i6bFjYA8gKCcwK
         ffBlWEs6WeAM0Vcwwo4XmwRbSNaCDc/RQplQ5v0fY2E+TO+8yR/EdETbZviBJYg+004d
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391798; x=1730996598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=T700YuoO9AlznZEpLxyFbxRGZr8LDD0wDygcf/HBXkSiJY8nyzA/Gr6c6IlQnJEcI7
         HK9iTO63TpxdKbzVkbaBYqhqtoJkNp2zXojH51b1vuLqE4/J22fCNYa0ZzIczG9mvBv8
         5IcIfVsxVqmDhDMRRVe+qHwSWVdXwqVQb81eikdwKO3G2iKMQflSwn6LoAr7f8yei4gw
         qETwiNyk0UXidyRW5lsoknOvbdRI1GIm+Gl01uUuB0n9L0KDReapM2L4QcKs3oDQmr+W
         ewQ8xUeAldGjry2nA5KFciEiTom1Pm1JUCOVHF4Po+EST+K+c+I90RKetURNwMG8FA7+
         dVMg==
X-Forwarded-Encrypted: i=1; AJvYcCWA6ydt04zhSrOVdjjK9v+qUcya9s7XDb2xzZQGtKHbBm/uZKNzX6JNXd5Kpvc1dabrGBUmQT2bW0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBU9KHHA0EJG3z53anc0JJLr6AGnE84q4IQH+ZAliCNqI83gpC
	/e3pvHP7lEX3amWSUphZmgW6xWrTjyF2QOpoevMTp9AnZKFwM548Me8n9d+nK+s+vg2XyOcSY7Z
	o
X-Google-Smtp-Source: AGHT+IG0mJPHTCww3DZQuqv9nxseKwFokKX1MWnv7+XcE4NElcJk7zAVUMyfqkFKAZ8kX5Mw9dP5qg==
X-Received: by 2002:a05:620a:318b:b0:7a4:d685:caa9 with SMTP id af79cd13be357-7b1aee2c038mr1047669385a.48.1730391797615;
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ebab8sm83428485a.8.2024.10.31.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:23:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyOu-7MeTYGa7tf9@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
 <ZyOUp5Juz5x3Ivrn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOUp5Juz5x3Ivrn@kernel.org>

On Thu, Oct 31, 2024 at 04:31:03PM +0200, Mike Rapoport wrote:
> On Tue, Oct 29, 2024 at 04:20:39PM -0400, Gregory Price wrote:
> > + * Return: 0 on success
> > + *	   -EINVAL if size is 0 or not pow2 aligned
> > + *	   -EBUSY if value has already been probed
> > + */
> > +static size_t memory_block_advised_sz;
> > +static bool memory_block_advised_size_queried;
> 
> kernel-doc will be unhappy about variable declarations between the doc
> block and the function it describes
> 

Yup, that was the warning I was waiting to clear KLP.

Learning new things n.n;; - new version shortly

~Gregory
