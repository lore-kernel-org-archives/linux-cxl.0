Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A62BEC43
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753166; cv=none; b=uIphhft4aQEaf41DMoOiA9kWXclNbqTrHuC6CtftCVNkrWt8jn6weXN7JCpEyT6vnfr3nxu83mE9Tv19e2hRGUkygMUJ3tkuCYwRNicmEKg9R08+proXYuqYAAzk2YlfwHoQkLWF5F6/WKt1EaArIV0yRefqXcZUSIf5xSLntVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753166; c=relaxed/simple;
	bh=zhicSgnEcn+rUlb7qKENBq/J/ZHYd9RtymeyHqJiVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8hXPkkJXAYPZo6ucrHjETIbFqBaGzquRNC7mA2Lam9xXVtHtWM06XxcQP4DRCLDOU74A883jYd72Gb3dqw7MMfgmQYEBZ+7ZhKoWNnV+3SQ75wTLIQ9IEvEm9rA26rQGVpliUBxS7G9uWy8L9+uHHeUxE6ez8JCoNiYLtCN4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOhgDky9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOhgDky9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1858C19423;
	Thu,  5 Mar 2026 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753166;
	bh=zhicSgnEcn+rUlb7qKENBq/J/ZHYd9RtymeyHqJiVDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOhgDky9aeGHu1lwX9V+umYKpEBFuo2LbD7m2xHrgJPwnkP/hA2vqanPSHKhpteYZ
	 zvccM/YJnRTy8Gnk5Bz5RWb5zX27ChqK+QRQ12O6EXsKEckCzk75ucJTPVAMwTdcpA
	 GBGtR+NNOKHeW4/dneZEBSMG4YQ4PynZzbiQp7HFPKrUugmZs+V8RHqlySllFbgjSY
	 4clx39Ro6Zyt8lSOk/EsDWhKsYlsbh2J5uuyezCqItPYuibc4BW79l2lbO1c+FzKHI
	 6fQI/rwrpmH2Aibrvj6M1Di6TgZCEI0TLonzvUpBkg4MBdCawJLm7wrT39+lgBvDRU
	 igEiT29LyGkBQ==
Date: Thu, 5 Mar 2026 16:26:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Keith Busch <kbusch@meta.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <aaoRDKvC2aVlECTJ@kbusch-mbp>
References: <20260305204057.1516948-1-kbusch@meta.com>
 <aan_z0psj080u1e_@gourry-fedora-PF4VCD3F>
 <aaoHBcKZeQpioh4d@kbusch-mbp>
 <aaoKBqP6pzAeF96q@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaoKBqP6pzAeF96q@gourry-fedora-PF4VCD3F>

On Thu, Mar 05, 2026 at 05:56:06PM -0500, Gregory Price wrote:
> > Anyway, my proposal here should force demotion to "m" for CXL_ACPI if
> > PMEM is also "m", where your proposal should force a failure path at
> > compile time if ACPI=y and PMEM=m. I really don't know if there's any
> > preference at all, I also just wanted the kernel build to complete
> > successfuly. :)
> 
> my proposal allows compilation but fails during probe because the symbol
> is IS_REACHABLE()=false, but yeah, i have no idea what we want here.

Indeed, I didn't mean to suggest your solution may not build. I only
mean the forced runtime error path was decided at compile time. And I'm
totally okay with doing that if it's preferred over forcing module
demotion.
