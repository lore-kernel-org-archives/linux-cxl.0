Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701830EF9B
	for <linux-cxl@vger.kernel.org>; Mon,  6 Apr 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510531; cv=none; b=qQhsRukqm06xyl6oaii8EH4F8k4diRm1Lzclr5m7+du+4/rmEjht65F56FkiAmizK3zTVTRxGt8R9bRSNmY40mfi/4Dm9oARoHBIdYiKPmd2PAPY3BxWoTr5ry4SpYV9EVDSPuEwd14RGRdvSZi9s491nLUeXxBwo+yw8aAYJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510531; c=relaxed/simple;
	bh=JZ+dyehG8Qui1SICa3zEJ6W1VNS5Q/aJb6bpEZfCTNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reW6uF/7zV4Kw8tjz+P5slHuZJZ19f1Nmep525JJZBXYfRhjrn96WVYc8fzTTa68o4QvjHj12pn2XDv//Cp6ZrcSkUVhIGipoy56UsL1mm3+iAg+4fL36njaXPHhpZZR2GyxacI/yEUqPuDXFNsz9NM36MoPOqyd/+H3Qw90xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NIw0K/Jm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NIw0K/Jm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d4694105e5so221370785a.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Apr 2026 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775510529; x=1776115329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXvsaUDHCUG7ebT5AoggGp8dnlrhLarXhjXHf/nmguw=;
        b=NIw0K/JmjEv0pxtjM5k7PT8qkK3QLbCkmZAgmHqAo2lFfIpKiw0dATM01jgqB4yq9Y
         6djEzHkfx1REn9rboDs003ooAoeugKXRfov6KKuBSgj6NsqlqM52pRbJo3LTbUheX3U4
         EL36XEX6gg8MGT1qP/nP6L6idcXeHWM44MmoJ/OBaBefQt6HPxrgspbapZ2orqjHiloj
         H0IZ5zBOhKGKviZcg+RKd37x7RvjiCsc8//2IeIF+OMaimq2Gja4X0xv7RITOOvuLmPa
         SYb0ipMJTkX06OFmNkU/gb+XpbrfCiFQ8OsR2xTkS0z2BgoGtQbWNIDh+RWorzC6DpEl
         mPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775510529; x=1776115329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXvsaUDHCUG7ebT5AoggGp8dnlrhLarXhjXHf/nmguw=;
        b=dcc9+x6IQvE36weO6cqb0/ala+bA98Eg5oSLCHDCHmlNjxGnZW9yDSw5cE8RbR8psp
         K2lxyTDABAmRYCquEqRjJ5CCi74v7X0vnqmYYJaTswumUH6o+K3KztTvc/Pdh+juyG64
         5ohkgjt4tSZ6zO4YJYU2S6RofzNkCwcy79PaI510hJ+GxUA0gALLHMOE+Nn9x49f+GTF
         NoJNgj4c3s6VPsAQtdn30fPy/lYaUeF6W3hId5Mg6MiTzX6DxBerZtfjQuGJM+LJGgoL
         MS1Comrr7oc5mbNONQZhHEX0RZa8NoYSk3ef4/FN0C4d/Bj8YahHYyxndD3znjho3R9K
         Z2CA==
X-Forwarded-Encrypted: i=1; AJvYcCX15GKMhUXLtOTzpGJBOWaF5QTnCGrB3enK9MujHFqPljegQpzN2BlQw+RywxyUan0uneud5olFF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/0bzI7+7mT5Al/tApW5SDZ9QeNvttcXsL9uodXmGr88LG/Kh
	uPiA1PSQXWxNUhyN+f8WToGM7uHz+CdSnUnqBu7NRsGd1wOU1DiPP3M9bvQPGPCJy0I=
X-Gm-Gg: AeBDietlkTCeBWH1p4vlwkI2zMHNl5l2wB8GG09XSeHdj0ITTvuCidrOaWC3ntz02Dv
	q9HzNWoNLvDhbLe2TSFAW6woA9QG1nb/XkgIIKQFIbwDlVZjmMuAhLR6lbJ+1iBaNJHLxCMFER8
	grra/TTCQ5kSSvFvvmBenlMUyvokO8Ix3uCyF2OONvvQZpA9SUyxWxTulcvnIK4hbCrqQdU9uPa
	Lbh3awIievNMwoiKrIhaVazky+Mvvsv1QE4WU2DFQSf8MNreeqDsJlHVYLuj1ufwaUWXX4E/YKT
	eEUfT1rUtby36R80cTSBbSVAD2Bfail4xdCxZhrYItR8UyHeqaFmHMwoUuSXZRo0HvYkY8+3MrC
	pnSl9E6KSw8e3vDnyeouXcAf4yBoBzXs5I6vW4k3r6IqreaZPQthkU6DIfc3h8HVnwU8KJEBAXY
	fr1tV4SXH+pvsnJ2O2saul1N1fqvhYPeQHgSL8kypUSjoK2eOf3Wrjoo+BUw2an4fCrc+WAIeyh
	UzHX2F1RO1n
X-Received: by 2002:a05:620a:7112:b0:8cd:87aa:e3ed with SMTP id af79cd13be357-8d4190971a1mr2109957885a.19.1775510529130;
        Mon, 06 Apr 2026 14:22:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5f48acasm1175604885a.21.2026.04.06.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 14:22:08 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:22:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <djbw@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, mhonap@nvidia.com,
	alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, dmatlack@google.com,
	shuah@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, ankita@nvidia.com, vsethi@nvidia.com,
	cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
	kjaju@nvidia.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Message-ID: <adQj_gxSzjA51Q6n@gourry-fedora-PF4VCD3F>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
 <69d1685538f45_556821002f@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d1685538f45_556821002f@djbw-dev.notmuch>

On Sat, Apr 04, 2026 at 12:36:53PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > 
> > The entire thing needs to be mmapable in a cache coherent way since
> > that is what the HW semantic is. If you try to do something else you
> > will break KVM support since it follows the VMA.
> 
> Then I assume it matters that memremap() sometimes silently falls back
> to the direct map. The "VFIO owns" expectation needs to guard against
> some helpful platform firmware mapping accelerator memory as System RAM.
> 
> At a minimum having VFIO fail to map in that case helps with the
> argument I have been making that "no, EFI_CONVENTIONAL_MEMORY type +
> EFI_SPECIFIC_PURPOSE flag" is not suitable for accelerators with private
> CXL memory. Those want to be enforcing "EFI_RESERVED".

Agree - in fact I would argue any potential user of private nodes should
have some kind of splat saying the memory should be marked reserved in
the first place, otherwise it's a firmware bug.

I need to read up a little bit on this area, but i don't see the "needs
to be mmap'able in a cache coherent way" to be an argument for one
particular method or another (hotplug, private node, memremap, etc).

If this extension starts bleeding into special-casing a bunch more mm/
stuff to be aware of and handle special memremap'd memory, that's when I
would argue maybe we need to take a look at whether nodes apply.  But if
this just wants to pass a whole chunk from driver to guest and otherwise
the host is supposed to stay out of the way - memremap seems like an ok
start / a reasonable existing upstream solution.

~Gregory
