Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6732777FE;
	Tue,  1 Jul 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384306; cv=none; b=q9ILpBFofmWnkjj2q1xYiyV7vKagG/OdNC0jlCKMvwSf2ETn/iB6yysBu7RW0cMVfFdlvDvU5f3662B6cp0Ssr83qrqOnLr2VscFD4gejQNzvxCcvtTe4b3+M7QQGEKP+e8sKyBJ6qGYNOYMRMqFmFc0tz5Mr1VlXaivZ98zFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384306; c=relaxed/simple;
	bh=Efny278f8eo2RpFyNoMpyNcPdptiAswE6zMNwWzIXY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVRQVDbjNVCy5oV1rpi4ePzre8vgLqFlf/Pl8OscSVG8eVf7Pes9dbcOnKpa7H7kzTbg3h340l1jxTj7QSFGXLtJwVMYFDvhxxShp+MMiPSBqgrYuEvzLbdD2JxaXNfcSEo59yJ0seExQXoqA0NEiJ7cdiavebSQJjw5zRQhUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl8pwGHI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl8pwGHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD03C4CEEB;
	Tue,  1 Jul 2025 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384305;
	bh=Efny278f8eo2RpFyNoMpyNcPdptiAswE6zMNwWzIXY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wl8pwGHIKOO3EcwA+OOmZFWC3zr0vkjqhM6nwMAcnejhBilr0WXZAoAd9NES9k83n
	 hn4+mJS2rtgf296NH6PkRxpmFJ3ikc12WUE5CPUVBZlb2mwpvcXljiHw11FtVWEn7/
	 tmo2PDg1RrM6PtshufO77pboytSGQnf4Nd+h4xG6NvkjULvIOsxoWgUleNZHXVYDoG
	 qLGBH/UvGyzIzKKC9NM+vglr3hoLOYq54sYHaibbiuuXyWAIqH6ymqBR/o96PMzVsF
	 NJLTKvK5h340lEQV4A+iNdCf7KM6qOyo76xlBNo7nPrli/CjsXETyzl7eKPYVtS78V
	 gfJt6ATpU4MRQ==
Date: Tue, 1 Jul 2025 08:38:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <20250701153820.GA3922159@ax162>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
 <6863fcb649c0d_2ff1fe29428@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6863fcb649c0d_2ff1fe29428@iweiny-mobl.notmuch>

On Tue, Jul 01, 2025 at 10:20:22AM -0500, Ira Weiny wrote:
> Nathan Chancellor wrote:
> > After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> > range.h may not be implicitly included, resulting in a build error:
> 
> That said, I'm not seeing this issue.  What config caught this?

Fedora's aarch64 configuration [1] is where I initially noticed this.
Fedora's rpm site seems to be under the weather for me but I have it
mirrored [2] for my own test setup.

[1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
[2]: https://github.com/nathanchance/llvm-kernel-testing/raw/refs/heads/main/configs/fedora/aarch64.config

Cheers,
Nathan
