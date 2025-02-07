Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF623907F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914349; cv=none; b=n7/nZ3x3GlWSPK3f4bAraVg8nsF/+rI8qghfUdse6jtkCLow+QO+MlCoRTSJphxm0rBtyI4p+YuWHBZutoG1nzzwcWMsFWPmaI099PB3hiak50DqFXIxzrcDDecsnGfCZyyJ0CH9/DkC9H5nHBkL+rdrCuLNhjPucJjxiHNNUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914349; c=relaxed/simple;
	bh=ypUvBmqeSA5zmnvQEnD0qriNJ7GpCmT00dwkj1UgV7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfAGhmgPADdtBDSFMct/1KoevtHHFNZVlZIkO+BN/nUF5UEHhES9CgSSOuEnZhHoyN3/WZ2COv8zjxY6KhchVnH+3fctXNGuUgA0m7kwORYqEuLpifnE9LBEazoE3au81EOHVrOF0rfdUuyE0t5IiNcvG5DnuXMnsfGGE8qL01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YZ87KQj/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YZ87KQj/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f75f61f9so259510985a.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 23:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738914344; x=1739519144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITCo0zOF3w7fSYlcXsHoFxkXnBWTFovbLH+EqkDvJfQ=;
        b=YZ87KQj/2Wz2//tCO4yiUVNBh+MZLwMQRP01c8zikvLiaW+Fw59EXFXKxN3HQHrqAA
         LrSekBOj2fWJ9ol/XdsvnNfXqFjF+RMW2Lf9aCLNXqiKtoj0QurHuWlqVdvxV9IegdNl
         E09ZdtIIP3MW568i+MAa5fwW3OJz3Nj+qm8G7R2eEe2isPcNRZSI3bzEBzvuPEpacSIu
         yBpU0DZFoprMkLVKfZ6M7/UWKfUG7zZ897WbSDztsNYgK9b3FWI6s/hj5hGvCcKhfpyU
         sYSP/1N5HreUWfwNAgWN5wtLnFOaEgL6OKafYex1Jc3PKuKFy+YbL+lxH7GHPpDYwIdb
         N/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738914344; x=1739519144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITCo0zOF3w7fSYlcXsHoFxkXnBWTFovbLH+EqkDvJfQ=;
        b=ShPk1xl5z+2MdKsgeyu07eFSWGW+KsMa/06opdDeHZ1Vdynlok/Rlgn5pkznjZIIyt
         GOvmDvir50HEetE2Q7Dfw3YxeqpKSrGVft2dmYCwAoSvGiPKt0W4mnfC8WZJHdpiMoJ6
         2TP440kDUfEPbcvkuVKFz49czL3etytUETozywNcyLg1eddw6GpP5X7/PHNiPQbYleaY
         LMfY57MHf9mLygusltbEheCXmw3tRTuVrWV3EKrZczUVgb+fRH/M8KyI4ekZskH/r24Q
         ooHff4cRpm77bvDqYpwLR2qoaDY2GY2iF+qlTN+BTWgy49znW4gdFZWzJ9sSxq4O9/UK
         VYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWmyHXwvidDtUDrQ8HF9bwI3RVeB3eDmvr7iH++W+lOfXQQXXO7fNEiLkXWvWuhFGp1ro9KzqLDR0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsP2NhSmLrcV6npcLTsGsYCJQoxy6QNjVwhfhzJTSZ/SLCv4KB
	zzMr0KBiQY9avk2ekZhTxtL0JBQiy1deUiTK9Tp74VrdU4SsYqAeaU42R68hbKU=
X-Gm-Gg: ASbGncsHk4Zxs+EUYY8kNht/FSkZbSFzeGYQ0+SvrjZgWafvttxIEtTkAtwOmWktKWn
	wweaos+1IQA7opdFERROVIw3EHB7otoDFFuAjYuDCaMkBn2uZWjG5pJDSNqTPbTj4UBd6xuOw9e
	fC4FBt31/fz0v9gaLiaRhk00VfMkXtNEei6b3yAlDfxYs2JBCnNcsewEgNn7rJa+cdCQz46YCEg
	oayvI5qbRxMwAgox0Wn7LdqQY3/yezwbQS3YS/wLJkShr7F3/4qb6bB4742fTyl23cOKxA2mMJX
	athKWGCO26zF8pvbegtePlQGMHiyzFsrkMnxBJdAy9jlYFtVmL0tsswNqc7dm0NJ1vbVVkk20A=
	=
X-Google-Smtp-Source: AGHT+IEEbQrgliT3+ZX90iWNqouIwlVzy6+xrcLd8rmzxealOsnm5pyXJqkj1L0uucgsijhy4P9hAA==
X-Received: by 2002:a05:620a:390a:b0:7be:3d02:b5d3 with SMTP id af79cd13be357-7c047ba6bbamr305582885a.1.1738914344599;
        Thu, 06 Feb 2025 23:45:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11bd3sm157511285a.51.2025.02.06.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:45:43 -0800 (PST)
Date: Fri, 7 Feb 2025 02:45:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
Subject: Re: [PATCH v5 12/16] cxl/pci: Change find_cxl_port() to non-static
Message-ID: <Z6W6JcRYjSOglSit@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-13-terry.bowman@amd.com>
 <6786e3fc8432f_186d9b29414@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6786e3fc8432f_186d9b29414@iweiny-mobl.notmuch>

On Tue, Jan 14, 2025 at 04:23:56PM -0600, Ira Weiny wrote:
> Terry Bowman wrote:
> > CXL PCIe Port Protocol Error support will be added in the future. This
> > requires searching for a CXL PCIe Port device in the CXL topology as
> > provided by find_cxl_port(). But, find_cxl_port() is defined static
> > and as a result is not callable outside of this source file.
> > 
> > Update the find_cxl_port() declaration to be non-static.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Generally I think Dan prefers this type of patch to be squashed with the
> patch which requires the change.  But I'm ok with the smaller patches...
> 
> :-D
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

I've read elsewhere that changelog entries should avoid telling
the future - and simply state what the patch is doing.

I.e.: "do the thing" as opposed to "In the future... so do the thing"

The existence of the patch implies there is a user for it.

anyway

Reviewed-by: Gregory Price <gourry@gourry.net>
