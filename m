Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C013B599
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746157; cv=none; b=ngUN7Yb2Lj7hWJdAoELlJbxjQUvjobnY+Dzh1JILaZJ0NuKcZnYS3HShey4KjOwy79lRiIausQL+GawJn+LBM6Zb8B58kHcossZTxoeSbhed3cpIA97CRqvemdwASAeFeDHOB0/CRNVsDdiJrtv/nCu+bhEFv4s3KoEZpfaebXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746157; c=relaxed/simple;
	bh=D/WnwQTW9BFVaG/Xs5CjUVRukgZHnyylEbhaayuJB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMle/4u9AsWpA6QjaSYqxb3y2WNDY9IVKeal4lqp1BYqGYF1OVmGJeeMOj8tTVvXyX1KaAjffg4lqix+w05rPKAY3/RIJtiyIEiEGsyUe4n6ZR+X64PUnlQjiUtTvTkVccwqzA/AncoCDrB1ouLgMi50Vz2R6n2Lo6lCZj9wiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KqhEj8lj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KqhEj8lj"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0871f82ff8so3271056276.3
        for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721746155; x=1722350955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HF7Q8BYVpApn5PT3KGRPJc84HSwFTLHmpZNdfKhD7M=;
        b=KqhEj8ljztHAcVYelWEfGYgYE+6Lid9oTyUXtpBkGCglU/heroFUoD0GgPtblaLixR
         NrdAuDRAUFJB8792mjbVwLeZwig7uC3oeCts3njx2OsEXEpCF2PtkHnJT+/duCn6v78Q
         62mqlaVPxeO4B6f0CPHUt4wp05bZg4CeWdFuY4DWLuU+x8mjAko6PF/hi3TBOvJpPwYe
         T4mLF/WWlz44JHP4X7w7pfzYEJ8jc4AwYzGj6jA8ixZ0hf995SmZjE/xS07Zx/VNHblB
         e9vJIfPuOAXxeRVkU1EMDOBImykB/WG4WGdAMfPTafI7kTorYL32pgW3OWOGZQ150svc
         kY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746155; x=1722350955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HF7Q8BYVpApn5PT3KGRPJc84HSwFTLHmpZNdfKhD7M=;
        b=QE2EqRzy4SytHCiW3JRRLppigo05V2STfklzu5Gl7jHlO1BoIajTPAFF0tDwJ/4HKd
         Mzl+s1MlCZ0l5gRiJLlsm1uOBQid6Np5cKqLOq9vs1BpYBQrKosjfuG6cFPj79lNcRPF
         DLtvmOeeBNqOgIEeOe8JidKVcHnuBROOU7gdvq42YdF65PKrWZWyq0zBpYW0B+GO5d0Z
         tW2hshpwvkavkvXkmaiVeaTOa8dh8bsYINYm8bNFPKqzPXpTtQa6PdYIfrR8sQw0fjrh
         aS6IsF2NnPhS/o+3tTi1woTlEy1nYB9w3I/1Ii9bbxGrMAhee0bt6yVx9ap7MB3cPUDD
         WxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUohHZaSarQAa7t5L7Ke1G5AMSe148FCs+ZTYTAGXUFWGk1LaMJeZaABfZf6y9OAmnKXQDHeQIMMZEQd1XYTTjYT6p+e4f4Ejyd
X-Gm-Message-State: AOJu0YyuXo2zhScs2aGu6YN78nTBYxWwfr5qivsUs3vSsIK7xHSlpmvf
	V9MupSJe8XqCGDo20N39byFfL653VVFAu3jA9gKBZcdNe3t3Z2VG5sHua/HaHic=
X-Google-Smtp-Source: AGHT+IHw8bzuJOKqHhNWSkL//t6fUYsEYjxn7Hjm93jAzR3sIFR1CZp1IMh8tpB9hciLHpE5Kdag+w==
X-Received: by 2002:a05:6902:2611:b0:e05:eabd:62e4 with SMTP id 3f1490d57ef6-e08706a4df0mr13359623276.36.1721746155371;
        Tue, 23 Jul 2024 07:49:15 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e08609f765bsm1891063276.33.2024.07.23.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:49:15 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:49:13 -0700
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <Zp/C6YgwiK9r0l4w@devbig133.nha1.facebook.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-3-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:38PM +0800, Huang Ying wrote:
> An abstract distance value must be assigned by the driver that makes
> the memory available to the system. It reflects relative performance
> and is used to place memory nodes backed by CXL regions in the appropriate
> memory tiers allowing promotion/demotion within the existing memory tiering
> mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
