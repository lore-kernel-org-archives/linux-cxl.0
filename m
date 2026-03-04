Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E836D512
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644565; cv=none; b=BBtwdh7ycsm+7GY98g/j1Rd134HjtEBbeIuRYpG8T3G0PyKBfUQkUm56tQ8KxeVJq/1dVJ8dmHNvpSJ+g7YTxpBABSGTQ5/bnJR8spDwLeogl4CQGqJw69aE2dDQPevbcgyaYLPHIdwMbqHe4AjCbrJPzhXbNs4a9Hjk9vIV2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644565; c=relaxed/simple;
	bh=tcgxSU38eCGKe9JKypqd0oWkYktTm4f5HZFniG2DFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8lX4eaRjqcPXjl9q/37a2JXL+jTjNMqluOrFjeYoMS3EyJhCuFOoLxL4I+iexRfkit1IFgbBDo52UppEGkBOWiBTpc5avhc9sbBqM7uYreyxir3vZy1XAM+BWJjOfgI7mHAAVs9y2VfFKIIEyrGDXcv1oe6hH0ctSsPv5a9Tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g7jcjjMW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g7jcjjMW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3a8494c5so667345985a.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772644563; x=1773249363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgdgDV2UNN/IZvvLYsVpz8+nq13Nj0KqwySIzPBQZ1Y=;
        b=g7jcjjMWKF3oD/ALftkhlaLG0ZGsLUXezJ7C+Z2hfmOxu2XD4wraFktqQgheD2xD3H
         b1HZe6fFQW8niJiBY2PjWXMiKb9sPnfsbMHk9VOEcmtwiXRL9Hq0n4oOlGuWmNvu2c8r
         HukbQPec0cDCWM/rTtxyoEupYWB6YZXCvzfTNK/JI3yExUax0Zs+RKkKyLS7kck3Xz4x
         m+cmrwPybgyeLuhjvWhwLhq3YA/l/g4eWkdQXKelZ7MUETxeKJLp15rzh9iiNlf+2dt1
         9bFsG6cS1XZZxkLCm2WVHugiQZUBNjCI+gHKNYrjVVzCDQVxCzDEtwVo+MrN/3r4VLoC
         tmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644563; x=1773249363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgdgDV2UNN/IZvvLYsVpz8+nq13Nj0KqwySIzPBQZ1Y=;
        b=wNBpAqxOW7soh39J7epJ4oISMUUTTra3Pj8q0IkPVQhtrviAmckYzRN2GKjrZRvZvd
         dq3pdN0Y8RdS7njRj+oeU9UbEVPeefjODp0ydshEFU873X/GHaf9B4bllAew9a6Oua1h
         +YTn3EojTn9iJYYQwrdVfhN/aNoWrjglA2DhTsb+/bfeZ6BCjDP7T8vmPQ5dN0W12hxJ
         w3ExWjL6oxDPk8A38ffmYoZeS/NCpaJ/LwjdxRBfgRIKJBXsRQrPK0lq+LpfQyh58Gl2
         wf6AnnfkN4EYrsFob2aiLZqQ8msRxQUhgJeq4/IBTNnoRQM+IUuTQ0kdOwWBRQaWATm/
         8MFA==
X-Forwarded-Encrypted: i=1; AJvYcCWcE3xo2PyUnZZB4nW94QBhcG81duaz3GCIMmLXzZOq8yOL7pGY+LZ9W64sgpJh4A/hkYYvHVsK4rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITZx78bkdVaz0J9U9BQxHMkKiVY6yeAUlVFsc+Bp6Xn4QqJPG
	tMMMBp1jFlhPZFXtbhwwwYF0HLspT1Wrfsto5oxpLa3MuSNa02AoEes5x+s0yLOFW3o=
X-Gm-Gg: ATEYQzxlrYY/l4nYV1DDp4ZkURAJXJM5ta2yFSz+eBthaUWaZ3hzH+Ei/7iJ0yt4aQJ
	Wel6jlS7Ren33IUF6v0lBJmOlb1+4XPiNFpH6T8N/B1Rs+G1Px05Z7Bd0FqhlhQCyErIoAoVoYt
	8V1VfzV2Zs5b2MkprZfIXJtGyk4eOEJE3PEBJWn0vfK+pYZrNp/X8kkUPYE6+tW7UwHY5P2JoFh
	BLGcriup8yFQBw/iSNz2N+mIMed6K6Mzgb112A4S+CHEDwNRU6vI6bDA87XHcGz77qYMpDNK41Q
	M1jcgEReoZyb7Tusmejn4O3lQF8eYkhEPrpAbKZMwreAOC7RQih74jb3/bfgejIna4k21HSL1nv
	l6lYeCvKWYHQAIqZlRIsx14eLD8U+MwPactOPTCRYDjkY6CSFUyY85RsdMYBai1l7NHC6LM8+9B
	6WzL+DALM3e1uTMEl6yYA6EgmArGjUTf5rXv8RG5QMoCwNvtIKZMBG8Ng/1kbofsRqQiD+3Z82+
	b027dwXlw==
X-Received: by 2002:a05:620a:3195:b0:8c9:fb0e:ca43 with SMTP id af79cd13be357-8cd5af1a395mr339023785a.24.1772644563186;
        Wed, 04 Mar 2026 09:16:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf678156sm1865798585a.18.2026.03.04.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:16:02 -0800 (PST)
Date: Wed, 4 Mar 2026 12:16:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080647.169434-1-haifeng.xu@shopee.com>

On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
> the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
> have memory and the rest nodes (2-19) detected by CEDT are memoryless.
> 
> The problems is that when creating many pods, the shrinker map size
> needs to be expanded for all memory cgroups in expand_shrinker_info().
> If the number of possible nodes is too large, the holding time of
> shrinker lock grows significantly.
> 
> In this case, there is no CXL memory inserted in the machine, those
> memoryless nodes are useless for us, so there is no need to set them
> in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
> time is reduced from over 10 minutes to approximately 150 seconds in
> our internal test.
> 

This seems like the wrong scope to fix the underlying problem - which is
the shrinker lock holding scope.

If you're not actually using CXL, can't you just disable CXL in the
BIOS?  Then you shouldn't even emit CFMWS at all.

~Gregory
