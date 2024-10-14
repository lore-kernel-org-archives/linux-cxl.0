Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF57145B18
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915357; cv=none; b=Vy0QqVGUFuByt56IjLL/hlkTByIDgdipeE2Tm+sBS/+Gu9lfE0E5YaDRvG+XdtgYOWt/JLeJP4T92IFGhR/8Ub0Kt2rKyhD9ZoSbGjcPEDdUv8Lq3DA6JRmFtyl/e/TGo7kb2DHYbG5M3EAkmOlPk8wVkm6I9QC5lxTrQiJUdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915357; c=relaxed/simple;
	bh=JMs3GtAM/AP4Nk43zqLEi3kmlubpg35ct1yoyWyMJXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4zBHbbgdUskCkC/REv9tgxab5jj8R2ypXRxv43GeC4/KF2917dzDeISySQwA/BTj5SeXKorOMPP/eMoN2sy+gEKwK2NBCaYKpeyFox48qwiTf55I1aJsz2AIzvsBe9rGvGG7rGQQ/coJA1XE+3HR6t5AYvSbSjdZN9tH3G2S8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0KycE56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0KycE56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9FC4CEC6;
	Mon, 14 Oct 2024 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728915357;
	bh=JMs3GtAM/AP4Nk43zqLEi3kmlubpg35ct1yoyWyMJXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0KycE56otn3C3jY/iBFiLf55OqtAYwT3cUTbVoioqB0WAAfbVC2kRidZ4Z//cBr/
	 EYC2NeAoNz4JiLct3w4hmbk4qULdVftBHA6l4lE1x+yu/mgfoJXD2x8s9qr4D05REn
	 /h4yqng4duYLzj+n9/eNx13vQQ9ZvjhEYkJNkHtv1KuvNBBqriq9naTYX8gsydoZUD
	 i9oJX+1bThUXv0XrS7/9K5TZa5/XRw8TWhNT6uIlksjAjA4rXwidKlyRVqO1YEpOu8
	 GogfzPY4JS6enzBiSB0kj+mJjGMbZeY1V+uCdIcnWDAj+vGrxopVKAmgZcnhddTMXa
	 8XrktBNqMBMtw==
Date: Mon, 14 Oct 2024 15:15:52 +0100
From: Will Deacon <will@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, jonathan.cameron@huawei.com,
	mark.rutland@arm.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <20241014141551.GA17702@willie-the-truck>
References: <20241010025208.180458-1-dave@stgolabs.net>
 <670937ce7b7fd_9533f294b2@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670937ce7b7fd_9533f294b2@iweiny-mobl.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 11, 2024 at 09:35:58AM -0500, Ira Weiny wrote:
> Davidlohr Bueso wrote:
> > Update the CXL PMU driver to support the new events introduced
> > in the latest revision. These are:
> > 
> > - read/write accesses with TEE constraints.
> > - S2M indicating Modified state.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Just to be sure: Jonathan you are taking this through CPMU correct?

I was about to pick it up via the perf tree, so I'll hold fire until we
hear back from Jonathan.

Will
