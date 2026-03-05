Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F985481B1
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750600; cv=none; b=mmhNcwE7yvMver6Y/6zBPFx2WyrL+txRpo7MnuA9H41DNXZXv+zM1ga+2oJywiCflwLkyJKYXZ+BFTWZ7Wrig0B5YMmj4rjAnw8p6trv1IMEytkAXkOG7drWZRzOnplTFThFEFivLWH3TzvkxR0sMrQkgtBhMtO/GEVSj8lpk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750600; c=relaxed/simple;
	bh=v2NC7UQVtassAnLYT0Ok2OTpT2+LNVunDKe0QL4zxFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiObrKScX/pTdIQHGex60F78wGyNcKbAx32s788Cp1IC3qpv4aAhv4FdY3GIWIggfZvfFYvxUeqtj42GcjDpzsd5nEly/Cvw7royTZIaSph5CgRRCgu9pgYHTG3QlvEu/QUKEh1C/cI5rHIZow7YeQMbbWXfH0P7DlVWYTFCPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Trw9+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Trw9+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22D8C116C6;
	Thu,  5 Mar 2026 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772750600;
	bh=v2NC7UQVtassAnLYT0Ok2OTpT2+LNVunDKe0QL4zxFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+Trw9+XwH2c2ndU+FkJXi9Wtk2NnqWutbsuuz6XLnJDJizrI40fVBxZwmTMg/za0
	 mBDjryverq7RvpJRuNP7TSWsZzkezmHVYXtj0c1E1YlBYiYZM4Y6GeA6k5dcFhcsdx
	 bxAMvnoIllTArHGMr3Qv/zx94tkEqI2i+8uW46vAvc7JXChaAgX8rRf40dzDnEs8nU
	 ghQgyNvujjJ+mi/uJ+TJZd0abzeBXqhbjr0+0lcJ9Va898TIIEPxsCKhNetn8GbQkd
	 8Vjdv7v7cEKyoOsHPV76X/X4h5PPuD+i3B7CpNlsh48LEAbsvEmP6AYHb7UqgapSu5
	 q3nvaA7Ev2GKQ==
Date: Thu, 5 Mar 2026 15:43:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Keith Busch <kbusch@meta.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <aaoHBcKZeQpioh4d@kbusch-mbp>
References: <20260305204057.1516948-1-kbusch@meta.com>
 <aan_z0psj080u1e_@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aan_z0psj080u1e_@gourry-fedora-PF4VCD3F>

On Thu, Mar 05, 2026 at 05:12:31PM -0500, Gregory Price wrote:
> > @@ -59,6 +59,7 @@ config CXL_ACPI
> >  	tristate "CXL ACPI: Platform Support"
> >  	depends on ACPI
> >  	depends on ACPI_NUMA
> > +	depends on CXL_PMEM || !CXL_PMEM
> 
> Trivially looking at this it looks funky lol
 
> alternatively:
> 
> https://lore.kernel.org/linux-cxl/20260302200429.803417-1-gourry@gourry.net/
> 
> Not sure which one we want here

Yeah, I found your proposal just minutes after sending mine.

I agree this is whacky syntax, but it's a somewhat common Kconfig
pattern (see NF_CONNTRACK in net/ipv4/netfilter/Kconfig).

Anyway, my proposal here should force demotion to "m" for CXL_ACPI if
PMEM is also "m", where your proposal should force a failure path at
compile time if ACPI=y and PMEM=m. I really don't know if there's any
preference at all, I also just wanted the kernel build to complete
successfuly. :)
