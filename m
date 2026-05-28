Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA54359A6C
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000761; cv=none; b=nCEaZDTow+tkdoXCT4WcNvKvZm24q1NvLYgFwdAtcPLYZMXWVw2ixHUAcpH7/YeHyQxDG8wQCJFznemTtfHQskqvTdMOmDQYlXzxg/TKl0sPVNI3ah4TMIS2oNI9xEUnP55QlFow/YFXhfqjMNeauKUl0YQTkpKyWqUFNxbIszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000761; c=relaxed/simple;
	bh=KqExw4yVF8fFYi6V24rBae9JPYjDk4kcYZvI5BlVCOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTJkcDGhnoehsCRbDGVRnPw8Qsece0tKQ1QmVG0wizzRi36nbFm+9Y3YkPoDV/EQEbhvgdE4Iar2z5uaiF8H8GhtWqI9ZuM3gk3xD32+jHNfUVF1wDX9NwmSv+jPgas3ZxTyT79U02V4nr5rI7tSXpcYtwXsnnqvtEeUK7QyN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSLLlC07; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSLLlC07"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b46da8c48eso2265ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000759; x=1780605559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=aSLLlC07u77GJQTwuQxyzhP4+xahlBgRDYVON+pUV/Jcsz1wxnFI4rjObiRLovMYHX
         pH/ETFAfKr//tQvQCeX4TAe6D+vA+Cu9JpADVQLUycD9o1oyF39t+pJ/WUIsDAupMV1v
         0JG/ZC+SkFBNAKXrb+CtLQyW0A5ZbHtnKqBf6SRYBcjrLQrrgtc4dutAfBA0V7LH9r+d
         28aXtbPN66zkYMqNqUYd2N7u78oJ0kWYE8YgqR6nzXqgGKmfHoSQtVYEukWAl67nke9v
         kVBHceQseAn9HTvPX+9ZzWD/5xZLEXXcH6vm9lIlNSEE0uygLVOoHJFOpEl/iSnUVFml
         iaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000759; x=1780605559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=fQug0L9m5mRebyqdsPsMXq4FNhqYrHYrqxuzaCMASqx2Gn2Wp7FM0AIVDtWGdK0ITv
         rU0B5jU4QGtjdBJGVB1gnOOd5XAvJbOyCtuyNeSuUDmtMfJrHkAtyt1tQfvzX6dYVWoa
         MHHNSAPI3DUgnDl4S6nA4GAK4Cr8E3JwHtkGBG8/6VEMUswIJj27utVK/aLiN7mkhgEj
         5E5pkYfavtKowlwanA+BP9c6CyIfu9TsgwO6Jb6KQnfTgF1DMt87WnIpaBCuKrIgcT8L
         e77zEJlF2lQAIb1WYq+2H8PqS/YuO3ZioayTlvN1oEJVuZTFvVA2jRgjU/ZaOSq45+Ru
         spHA==
X-Forwarded-Encrypted: i=1; AFNElJ+/RzhyU2FpzLhY75YPPmkFrBOloY44kCI8tnuPOtPE/UBb+guQC5wBZtjry9rsUWgdJy0sH1vJGAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTOiaHAA0qdQL8b/LlTiFSqxlCrDnDkbTT23y1+Gz8K2WVI/k
	cVA0VgpKmBqWNr1N5UTZ5/GOLlF6O0AIfOCjCHPABFxgGinVEtqDB5j+z+L/1IP8uQ==
X-Gm-Gg: Acq92OERHkoB1Xt+17J/wKsDfaWlYiYKVHRzERJCDfvGkZTAllZESD8tjKdVWdr0KtV
	pQxIX2L6pqoRf2PWkNEEYBCCw6ntLYWyfZo74jWMXSAW4PmYJzZn44afEBNR3j/KeP+u0KADdvc
	+rH/ITLn4N5zPVlXHs4A8FH4BvS5aYMwWBF/Us6yYsi1wl7H+OqdmyjL1HMDO92+Cddj0qrodg9
	0Wq7bcVm9KGX7v0pwfNvsA/n5AUZ0cAk9sRzHeaHxSjRPXkF8VmfPZ+mLWQd1FYF93nKNXsUlow
	9KA42PsCMyh9x4M8eIn5EQPBB9cBPuEld6lBKSQOlqA+zXQpUseJo++cMEEiQDWMW+ZJA5/6Pkw
	wCFbrO7QS99B6CjaVAgk0cyti2hdDKmLe6oOuDGaR4cwoWFTFEV+ypD1LogWlnh0YDUttmltssD
	Ccp8cm21EWRWtub89baRl5CTMUkCuoS1NXDz9noKJGQXqazqM+Bl+oIhtE74lncLbJLVaK
X-Received: by 2002:a17:903:1a67:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf2046519bmr79225ad.25.1780000759071;
        Thu, 28 May 2026 13:39:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e609a0asm1939385ad.26.2026.05.28.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:39:18 -0700 (PDT)
Date: Thu, 28 May 2026 20:39:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahin734hJ0CSSepe@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
 <ahiGIUDG2uvA6usM@google.com>
 <ahiHc3y4wAxxtpLT@Asurada-Nvidia>
 <20260528200450.GC3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528200450.GC3195266@nvidia.com>

On Thu, May 28, 2026 at 05:04:50PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 11:20:35AM -0700, Nicolin Chen wrote:
> > On Thu, May 28, 2026 at 06:14:57PM +0000, Pranjal Shrivastava wrote:
> > > On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > > > > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > > > > 
> > > > > > > > +	master->ats_always_on = true;
> > > > > > > > +
> > > > > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > > > > 
> > > > > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > > > > requires Config=Translate with S1DSS in bypass?
> > > > > > 
> > > > > > Yeah, basically.
> > > > > > 
> > > > > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > > > > a valid CD table pointer.
> > > > > 
> > > > > Ack. But do we expect transactions before attach_dev? What'd happen if
> > > > > we don't allocate CDs here?
> > > > 
> > > > It can be done at any point before a non-abort STE is formed.
> > > > 
> > > > The core code pretty much does this immediately after probe so there
> > > > isn't much point in moving it later.
> > > > 
> > > 
> > > Right.. that's what I'm not understanding clearly, if the STE is Abort
> > > anyway during probe, why are we breaking the alloc-at-attach convention? 
> > > Usually, we allocate CD tables in the first attach_dev call. Why does
> > > that not work here?
> > 
> > It would work in attach_dev(). I just felt cleaner to have it in
> > probe(), paired with arm_smmu_free_cd_tables() in the release().
> 
> I thought it was like this because we don't have an alloc on attach
> flow for the identity domain, so add it there or add it here..

Right, doing it in attach would've been cleaner, but I don't mind the
existing way too (since it's merged anyway)

I went down this hole since the reason for the convention change wasn't
immediately clear.

Thanks for the clarification!
Praan
