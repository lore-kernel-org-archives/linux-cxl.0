Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B22EF67A
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760387; cv=none; b=oel0AC0ojKkcftKDrDmOZiHL6TLlFpvMLZ8vgs2gtOKt0ere8mvVJsJSa+iFrMBAL0eDKRhQ9Tg0BWwv5TUovqbW1wOXIUdcnEl0c9Sgx3Puc99SjtwqxuQ2ExzGqeHGXZiQttgplmvLsBVLWZBgCb6Lzs+/udAnvwivRWiGjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760387; c=relaxed/simple;
	bh=vbZimUiszU34rQ0mqTPQeB4ctHgRPKSmotLmCplwI8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcVYJ04VduVV3dOV4sMK0ViMVNVQOGavBikmVakuFx9Az/g6SDVnJVf5GPPbU00f3lumMzH8/DzUE/tq/xCUt3COYjGG3/nZ8VD9QtxGpL75AvCaIzBh2j4TIb9zXCyqLA40bOvdt5BfcU/xtTil24sRy8iC3pHmE+mEYn7DyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXBRf1Ev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXBRf1Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B091BC116C6;
	Fri,  6 Mar 2026 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772760387;
	bh=vbZimUiszU34rQ0mqTPQeB4ctHgRPKSmotLmCplwI8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXBRf1EvtXhHS8XlwwPKtnk+GfTxbkczSs5xj1SebClec6K9hNHzKXXf+EIgHQGZC
	 FYDHZJHfuV143vZH8nqdMGtGQVaBDNkmg8SeEb7m+57zMJmgwmNXLTqcpUtfC9Fo/l
	 5RopTfNuFTD5sfL/y7NHbEX3S4ihMcOibTzKHm1CoPH932deZFDZOSZz6yxNvmO9xw
	 yqigXuKvYlYcB9LWluvHHw5vGzQQ1LMRqmhTD/alM12PsmyiqBhrx6O9DEvy5OZr7f
	 L0ccqhL8HpXIm3bvdSYLexsQaAKLJPWhjzAVu0jILZBaioWlAALzdprZQFuSejP94q
	 oVzLsX3FmFPEQ==
Date: Thu, 5 Mar 2026 18:26:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: dan.j.williams@intel.com
Cc: Keith Busch <kbusch@meta.com>, linux-cxl@vger.kernel.org,
	dave.jiang@intel.com, gourry@gourry.net
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <aaotQCg0TspiiaDH@kbusch-mbp>
References: <20260305204057.1516948-1-kbusch@meta.com>
 <69aa28d0d9076_6423c100da@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69aa28d0d9076_6423c100da@dwillia2-mobl4.notmuch>

On Thu, Mar 05, 2026 at 05:07:28PM -0800, dan.j.williams@intel.com wrote:
> > The call from cxl_acpi_probe() is guarded by
> > IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.

<snip>

> So I do not think this is sufficient because there is no
> devm_cxl_add_nvdimm_bridge() stub in the CONFIG_CXL_PMEM=n case, right?

It's called from a preprocesser "#if 0" section, so it shouldn't be
compiled in. At least it seems perfectly fine in local testing, but is
that compiler specific? I think this should have been optimized out.
