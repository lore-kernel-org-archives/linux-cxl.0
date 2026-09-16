Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB873655D9
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521080; cv=none; b=bwJ60ADiq7Wql9+Uy5YTPe6t5vddFOEbrZCCHGkm676MkPh6y+Jx3q4VKakVm2xJuqoF96mWELblSM4SZ2bulnjxvGpZ9B/58WA7K7qrnUcLJ7dH0lesBwVd2qetqci1s+9nyLI2bsRx/qoc1YH4PBFQtI7we6o9ii/GzBcxco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521080; c=relaxed/simple;
	bh=sfdCxH/F921sRGX0BbdNLcbYrWk1ecR4k8Z3K5uqakc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2FbqRot6yhJ1pDiCLMuS8hUU2vh8Zme6Pk9tajewwKXvCesrBhtAwI//ByoBBgN14xsf4p7QezkJ42zILRQ800i9Z84a/apVSThBYrQkfvTkt98celngZgrhkCsDltVzNOyKAh2N3uTy5BtoMmDwK6Ft/xHLgwBBq161mL+i40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3PGCYRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3PGCYRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8059A1F000FF;
	Wed, 16 Sep 2026 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521077;
	bh=zr6vuF6/2Ig5pJM38LllK9Oih7noS9O/ZWgqU5nMA4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e3PGCYRe6hipnZxBSbcdSK4p3xG/66VUnt+8fLa1AvhaQONXjYID0E7kFqSnTTofs
	 Szis/Ye7knZuFQ4x+LWVyHTh5sKW52XQjkYYCfbbJ4aNFnnsEHgyVrWHlGi0UY0BBf
	 HtTVEWrFO1tE6pVLF2EyIiU65m6XQ2nnutUG5olMZuVnBEUSsKLrXnnZclJhZZqhEE
	 f2Q/u2J9YBsBF/FzspVgBNA8cZr+qjgGeLov2hhImMmsKO9jHjaLg+caMv6iH2yrvv
	 Ki6x3tvkVMuAxxIZBIcqcZWjRCs8eEEE/18TVjYdsupJxxJo6Bn1Fq/ukHGWFqJ/DW
	 G9fbhbW8JZ+ug==
Date: Wed, 16 Sep 2026 02:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, dave.jiang@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA
 partition layout and ordering rules
Message-ID: <20260916021112.55ccf787@jic23-hlaptop>
In-Reply-To: <aqhLR36uRTXlqAUz@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-10-anisa.su@samsung.com>
	<aqSaZaaWaWUfKrC7@gourry-fedora-PF4VCD3F>
	<aqhLR36uRTXlqAUz@cxlqual>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 04:30:15 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> On Fri, Sep 11, 2026 at 08:20:40PM -0400, Gregory Price wrote:
> > On Tue, Sep 08, 2026 at 03:15:12AM -0700, Anisa Su wrote:
> > 
> > Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> > 
> > one question here, but not overly necessary to document because it
> > instantly becomes the moment the code changes (for reasons).
> >   
> > > +
> > > +Linux follows the static precedent anyway for the partition it maps: the
> > > +first DC partition must begin at the DPA immediately following static
> > > +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> > > +a device with no static capacity at all.
> > > +  
> > 
> > What is the reason for this requirement? Just easier to code?
> >   
> I think so. Although I didn't find anything in writing from the older
> versions on the mailing list.
> 
> The current code doesn't know how to skip over DPA that doesn't belong to any
> partition, so like you mentioned below probably just left as-is until a device
> that needs the support shows up.

Just the Linux kernel developers CAMpaign for Simple Hardware (CAMSH) IIRC.


> 
> > is fine to leave as-is, the first device that comes along that needs
> > it changed "for reasons" can fix it, but it seems an entirely reasonable
> > restriction.
> >  
> Thanks,
> Anisa

