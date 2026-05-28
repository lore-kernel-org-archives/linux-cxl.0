Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D1346E44
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985952; cv=none; b=cyoYL7YqzOpaqq0H/BGIivGd+7iK0ceb2f2XG1XkxHwVr6E2awi+sgYjlAAND4KOdzWAuC12ICNQeqkc/nD1atfcWyd7JSNKXb/iJG/7NKY0EZ594aDw92VwbMynFB8IZuWr+fEv3KkNvw23ePYjKZkUjkfihgrYjAuS6BQLulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985952; c=relaxed/simple;
	bh=JifQjjeGTYkQYQF9OEClDLZwk6+0Cv5AfpxwRFxUgAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzoiJ0ZsD2ckpMeuuW/HkHLDglLeB76pEuHuvmM8X5KuDULODU5RmYb/cAzytcgKZPmbbA2OzrjN0xTwtVJcVNwdeiW3WDjzxVt1SrU+JXLvXj29bzRvL1teOGLG8icAcL21OFaMCoiSXr9ZyxWCinNYHFeQ/RzQScS5XescHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+LNozkZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+LNozkZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so635ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985951; x=1780590751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=D+LNozkZ7z8RclW3sK7QxICZlV1/2u+s7GXoX2Uo8ijedFsi7LX18lMvy73rHrDfrK
         49s0Hnn+q60xtPG+P05y4rFJgrMwi2y8FmfV9TQdnO2BRcCpUC88zFi1Gm1w2FTyYgdk
         14+iVNkEqIWLXyr8EY28jYPFMYJ/Ty1+HwVho4uy1oIynWBQpKwBEREtVFMT7bCojjRC
         9hpMal3u6F9QdG0uKLOXC+3mFk3FslbjqKNyxV6tRZC3gTH8/dGYXKf9NmSz3AtdhQ4F
         Se+T8tNdy6jPrw2VkAwxn4gySTVWa9WtpAceH3ok3gbWqNTtVMYoVSlQhjTn0ftEfSy6
         owRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985951; x=1780590751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=mTMymenDqRUt/7v4v0VdfoU4PgWgKb4S23m6bGO610zv+tFYz6zRuJZ/guGB1/XHwq
         40KErKKtaAF3hc2Dk45LYtklPLlH5FWK5DRvsp9xWVKor46A1Fcuk35dyaPRVxU16n3I
         pmnOKOVz95gAyddN05ELEfin6V9S1JGzpOLHK8HjRxf7yAGDQsmirQHiiBEwbc0zY4xc
         IWUopcFog06+I+dXtFfSWsjScAAbeWLG/WPIn+eavKEp6eWKyV0jNRgAnaGV/9w23izD
         Dls67oeXerV1dgmg4IMthXhPdpYMe1DlandMpyUxiLL9DeY+cSXLO8ZGo3fmbYs6GSNL
         hxaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tmeeTqQj8CdPNzNB3GQHPfHzYpaz5EfDANk58hlzeu+YaAwZ8IfCs1MS1FmvlCYf4+vDPnoOX5VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VyxhTjCS7GffYicrlpy44gg95Vq2t4Xg8jkdZMK4GQ0Dv/Tk
	IbrtJP+s7mRgT2+9UII3100NCV8wAfLNu3k4fOhqiYXUA3RKqG9TuEnFS2pd2KKL4Q==
X-Gm-Gg: Acq92OG7IxUafUnOvUAqoixLAzoPzJ854znSMZZKXQXXUS13+xJkDLP1BOnicdcUZ//
	2PcxYSxQyL8b8nsLDqTYCUs60HPBLUdW4cy+fj5h91/h4qyDRKzBIDa99QnrtdNi5lCem6dwj64
	XanX4xGFWsjqzVD3WH9PMVxlNixvZNSkFXpWEPZOpm3FYWLg919WF8gkO9i0TDSl8KMlJKR0d2d
	xJ7SBdAxm4QtB2pHP9iwe12Qq5AM9JJnmHXrYAyKvGPLhhPlE4bdYv8E9hYLG6q/wchL+gZSdql
	pW6KdCP752qcUjZ8rVsysRysckN8TfI6phmqfS0AVEZ5HTExAhIMqewS+VVKnLrj6xsKrdUkIf0
	oSvFuFiBJYVAnHLDa6zU1kbQ6BExmlHP+NjusWbcKRcs3cuzUQlGhKHC8w4t6V/7DrqUXbTCG9/
	Gp59qTf59K0Kwx1XUVe1p7/GRQIGIPz6lvlogV7fMNHr9GZG1QW+eRQ5uWsT3tT1AIJWobbSMPQ
	w4ypl4=
X-Received: by 2002:a17:902:d50f:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bf0bb6f798mr1542415ad.0.1779985950617;
        Thu, 28 May 2026 09:32:30 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90c032fasm2002365a91.15.2026.05.28.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:32:29 -0700 (PDT)
Date: Thu, 28 May 2026 16:32:23 +0000
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
Message-ID: <ahhuFw3ZJpy48xkH@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528152930.GA3195266@nvidia.com>

On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> 
> > > +	master->ats_always_on = true;
> > > +
> > > +	return arm_smmu_alloc_cd_tables(master);
> > 
> > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > requires Config=Translate with S1DSS in bypass?
> 
> Yeah, basically.
> 
> Effectively the ARM rules for enabling ATS and Bypass together require
> a valid CD table pointer.

Ack. But do we expect transactions before attach_dev? What'd happen if
we don't allocate CDs here? Am I missing the fact that CXL hardware
could be already active and using ATS after the device_probe succeeds?

Thanks,
Praan
