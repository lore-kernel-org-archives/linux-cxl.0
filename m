Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD4396D09
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964711; cv=none; b=HfJoDZJepK3Qrgeq9d9UWvjtKkWbv71+Ng7ZJmJCx2Be9hPKG30IZPSRj7clVDyuo61yuKYvxifH9fnkrVScOzylE7HVlWhdquqk5/nxQr1ToE9223SeSnvu6Cuuz54DaCKm73FiVealp6cv0NGWUTbfq9qMcaDKcIDxUtpXj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964711; c=relaxed/simple;
	bh=0fCnDCLd6iW/Hx4ZfR2Qz6TSOkxkXbTnEZ0zIdBDbLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1QIKAkw4fwXckOWsa1o1CxW61eGvg0bAudAZfFGvm+xU5XgeDBLdab3y18EaikNABUloFtxqfK1u82ba/LxpC2xejml3v+MWQbqXiHDd/rxxNLpcQVjjh8M6DdjXUeTKWYTnVSuE0W13O3leuzDGBcz/RCrvGY4Q/zP/xSjr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kDfUu9re; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kDfUu9re"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so1000385e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790964707; x=1791569507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UWCAH005lKYUXfe2OCMNLFgIqFtAt9HIoWhdWHE78ZE=;
        b=kDfUu9ret6LxJ3yC4suWBmzx2AdOhqESr1AL8qCs3EYlazklP4QyDxEIGdR8lwi5iD
         9yeM9Y3rOXkLVDeCc/mIjTlF9wg18IpKzSVer0EgfBYorPCpF2eTX2+o+e/q0dGTqGG9
         J3yqO956n+B0El3FA9VHM82we2PD4oHUcD3WvpKsgei/JfrlLLFP1Px9lPr1EUl0hXMA
         p7k4bQdXXR/B2Y/5daltQ37f9O0Lh6UMiXZm41/vFAF5BlmH/1qdilALom+iNb+uj5nF
         IqihTLsQ23L7YyPfpHpf4KQ9k66UdrfPAwPV4Dq+VYM/CSFvPT4N4X4AqLcOT4Yh6YQK
         MwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790964707; x=1791569507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWCAH005lKYUXfe2OCMNLFgIqFtAt9HIoWhdWHE78ZE=;
        b=HbWWjzzu4uqFSDDBbiKC+dLgCTsLWH3vFBKmyOqaj73dywIYesyZ7toabwmRsddpu5
         /RkWkpqhmqyU54+w/beWpZz3h94hwCU8e40XvEmMULCcLVAcJ2LeiB52CDIaxN7OL5ga
         rNKZULxCecAl/JDxptElHBaD8oQVw8ES8pFxl7QFRySSEbu5nnqTMhw1eC/u2Q4PXJAA
         D00lgL7elnUwEiXivDVeJnsk0lEgskk4Ljyb2UL2Pfjh+kCNKqrqWaDLmst3hKqj0bME
         RtyAtubiufL+z2seRnmlDSD2J4PIAd4u+CxegHxhW1CG5WOt2tx+ErfcnGLj2iaAYh42
         aLVw==
X-Forwarded-Encrypted: i=1; AKwUvBz3nKHfaYla9YpKDALF+gSh+lfLGpHAnlZFCUIV1tm3K8oQACB0hoNa3bWaoFmQTNT3+cJB8MquPSs=@vger.kernel.org
X-Gm-Message-State: AFuF++neDYMHtuOvHim4o67om57CxI/+fVINs2WpOBSU+DrYsXVFeSF7
	XtiwRmIuX7ndXMZPnIIuLlI8UKxbWlOjIzeSxthvDW7+LhrLJ2q/3DilP012TqVEReQ=
X-Gm-Gg: AYBFou3EyzZBYz/G+S9qXTt0vEaAnd6538TCnhqnDeolWzINsSnuOS0Ba87MlPq1CnT
	GDs+MorgLSXRfPzVKs2kxD4sAwceQy5ckYT0vi6JyVwVlnX+Y3KElLuhFtDt33MweBTg7KEGv6u
	4om18JzUYzZRKrJTaCRfqEGwkLogf4JDAzCdsfmm81wVmF2qMtzoyEPqQ0ARW4h9Uw2Dy6cVyyn
	j9QJr4LV/YBSA8aso6eeva+ftiJeas+LpvV+GrdpVF72W20sabvBAY7951AV6HON3UgZVXdJAmi
	ysckaQ2PX1HQMLENFMl7CtLIxY497Zc5AAp2WxvyEryFstYkDnkidIY905lJHIGtzxeqpCypIVJ
	FK92rdk/KXTckxOCJ7arDLDuz4/QQx4DhgKHEI6A6qkp8tfIedtEm07g2ccd2n8xVbtrDvbrLm/
	RXKLNP14QRhO7KY7LCbjVn+Lmt7lD5O9rV1ZGP/Ck8WwjiYPSg4eRcKKwQBc8dFQ/cyFw=
X-Received: by 2002:a05:600c:1546:b0:4a0:1c43:3c04 with SMTP id 5b1f17b1804b1-4a02756e5edmr62895155e9.13.1790964707327;
        Fri, 02 Oct 2026 11:11:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:9b19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm104420865e9.8.2026.10.02.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:11:46 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:11:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: Poor memory bandwidth performance between NUMA nodes
Message-ID: <ar_zftIk5caN-5uV@gourry-fedora-PF4VCD3F>
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
 <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F>
 <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>

On Fri, Oct 02, 2026 at 09:01:27PM +0300, Anton Gavriliuk wrote:
> >  - Optane has like a 3x worse write bandwidth performance than read,
> >   so expect it to be significantly slower.
> 
> Single Optane DIMM (1st generation Apache Pass) has sequential write
> bandwidth ~2 GB/s
> But each of two namespaces is interleaved with 6 DIMMs.
> So I would expect sequential write bandwidth per namespace ~10+ GB/s,
> 6 times faster vs observed 1.4 GB/s.
> 
> Lastly I migrated (by migratepages command) Valkey pages between DRAM
> NUMA nodes 0 & 1, and got the same 1.5 GB/s with the same profiling.
>

I'm unfamiliar with Valkey, but you may want to ask how contended those
pages are if they're actually being used during migration time.

Do you get this same behavior when migrating the same amount of memory
allocated by a toy program? (i.e. known idle pages)

~Gregory
