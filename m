Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71128CF6F
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550166; cv=none; b=TBDfC8aCzJRBwm2Fq+4uMZEcIAPOqAVVJUxzNWmzi0zRLm1qFET52E4FBQPnfVtVnd+hKx/kVyQ5GUDwaTlOtAizmTJLMKTnZlW3q0kPKEy4jUIy2QJMT1XzUibyORhsEVocG4TLMtou056niU5fmhe42fB7YvlyoDb08mE+VNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550166; c=relaxed/simple;
	bh=wOC4ZkOYUETFCbDrcLvD0xJHaN+L2/CRl5PQ14lPOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/XyDNNRXSJGpcq2oTHRgW2PXXDGBTZi9KsWuhKeR/oBdILARTbrt1c5P2ZmSWSxOmC2vqQ0lyg3LohsQKjfY1cxhqckw7Y6ozxpov/tHHEuCBYnXNRd6gKMIKZbRjXUsUmRKVNsxc//GOAvzrIC1nGFd9d7F9K3m2GcHavfmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OPsQgNFo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OPsQgNFo"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a7638f42so866151685a.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769550163; x=1770154963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5CEx45x1VqBdZR0C8+OcuXcE46R+qBWE0zGdFKjM/s=;
        b=OPsQgNFoKTwIbjGQdvezFt/MNA00FbZ+TJHGhv/s2btqmLEnv+SVjJvrwxnNYaZUmD
         cUFLgXxkkT53WLQx0FEiTx2F3CabkcDOQv0roObf/TFe2kRkYSlQfBNC3IvshdOJytlt
         5eh8Nz8fz73aeQJVnU61olazNWq8vyyzqaZyhZHJHFnE5C1Xo6XjVnzvELOVX7Mf29jC
         i7nLsTAXsW00AXVWGlC1BFG1IAuTkENEJ5o5aYwbaK5qdHQrA8ZEoWYcvOzLHToph9RB
         Z8OmSWIKmChx7JMjsZ90jbMOoeSKwWEBFjIeTbweoJv42t22FmV6MUpCwM/N6CMyz5n9
         2OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550163; x=1770154963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5CEx45x1VqBdZR0C8+OcuXcE46R+qBWE0zGdFKjM/s=;
        b=HDgfQ2QzCPCH5kn8uSuE+Boat/S01tSA4Ssux7RSygyS6pFl2UhfRB6d8ALO2CU1bg
         K5mX8OQ6dYBBe0KKU8v5G+aZpIDwceyNi2Mp5IakYry3KyS0nxcSHuUj02ybQhfAFgWs
         ZAG9+fs1VQVtTKTZt5fjZw/DFi/CLqbQhrVbVkEG3SSxE/FVAzxet1/Eeeap7JyXi9C9
         /Z5RDW7RFYsdYu6JToJwIKKW07S+hB4Csj/jN9rhZW0or6Hsn8stplqaNeE48SYaqLqE
         /IStX9jY3D3ivPHWzMYF7A9orlRBjllSwlVWjPfubDTd3XP0YVMjOiG3SAVxPeluy0Wl
         3cZA==
X-Forwarded-Encrypted: i=1; AJvYcCWPjI2sSCycN8vHi2LYDonp/Ka/93DLqiLS01XLG+7KjUrWT/k0XnvleIGrinYviQf79DJg6ch7/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyuUfOsCwTt0kEHQUEX5Z3oEy83ObGUQrTb3a61cAwmyYVzsN
	3F4sSA+EiqyYy07BqYpR0nR7blw66+VNpspGlAnu0Jzx46+pqAriBrZXygfBgaTSI5w=
X-Gm-Gg: AZuq6aIyFAdVH6ND6dxpACNEaewVlyE9EHklNsJmtyngRUpQwzOxnp+rJ/pLuSRBGN9
	Wv+aMFEiiKy9ktfdgCGIRhv6PqHgslfsw871cr1cK5sbbo362gO6hDMqQoBl3MpqWKRfczc2Q05
	DjWshEbKXLjKAuJq8577cxZmB8QQfuYJ3/A0tHf0mu3CAOzXdqH134UNNbFgnBsvLK1FfOAoBoU
	b1g3+Htpts2TjQSFrLuQG2DITOvLiMAgR3O89T4ICbHJ4cK7b9rqzqgRWKX3SXMzjlUil4UpKs4
	km4gloPnIznTu4ipC5E+UCIJ5WOoGN4lVeCKEF/g4zGFnTvJGzwakYAKaTkWgn8P5KsQ9IoYGii
	sW9RaK8FJpcijZGyXaOLKSMAVYGSuKRNF3UlQ92WtZhpkahWHbwhnQNny1vxMYpmf2MVX3+ZgQO
	k8z6QLDiMwxKZVgw185p6FDDBhQ6zaCix13y4EqvbpPIVq+UJB8BgCmgL2IlUV2GXQ6QUbhA==
X-Received: by 2002:a05:620a:46a8:b0:8c7:1317:142e with SMTP id af79cd13be357-8c713171495mr79844685a.85.1769550163585;
        Tue, 27 Jan 2026 13:42:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm56868585a.18.2026.01.27.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:42:43 -0800 (PST)
Date: Tue, 27 Jan 2026 16:42:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, david@kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de
Subject: Re: [PATCH] dax/kmem: add build config for protected dax memory
 blocks
Message-ID: <aXkxUR2By_GQ9Qqn@gourry-fedora-PF4VCD3F>
References: <20260114235022.3437787-6-gourry@gourry.net>
 <20260115024222.3486455-1-gourry@gourry.net>
 <20260127133431.671e4605eee807abe84f92f4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127133431.671e4605eee807abe84f92f4@linux-foundation.org>

On Tue, Jan 27, 2026 at 01:34:31PM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2026 21:42:22 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > Since this protection may break userspace tools, it should
> > be an opt-in until those tools have time to update to the
> > new daxN.M/hotplug interface instead of memory blocks.
> > 
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -78,4 +78,22 @@ config DEV_DAX_KMEM
> >  
> >  	  Say N if unsure.
> >  
> > +config DEV_DAX_KMEM_PROTECTED
> 
> Users must rebuild and redeploy kernels after having updated a
> userspace tool.  They won't thank us for this ;)
> 
> Isn't there something we can do to make this feature
> backward-compatible?
>

This feature is likely getting dropped in favor of pushing such policy
to a driver if it cares that much to prevent users toggling memory
blocks.  

I will likely re-spin this series in a week or so when other non-mm
changes flesh out a little clearer.  This will be removed and some
of the mm/memory-hotplug.c changes will be changed to prevent the
modification of an already extern'd function.

~Gregory
