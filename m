Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9536A374;
	Wed, 16 Sep 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525160; cv=none; b=ZiDkj2EkkiszAicxMdV5DrNcy0XIEs19V4vsk3f2wi1h9aLi7Oorr63Md+MRWeAAzZoutFISUjZSed/uGo7H3SAGsJan92kTSCgHd3Ia+z1gqa134dUQpU7pXwz+I9fSPJLnLw5p5jjL9r2CFwJFzUkVzfvSPTCJa99wma0JLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525160; c=relaxed/simple;
	bh=XCFcmVW77M2bJxgvtYNfGK1iEpuFeAQMZ2Sde3qLbYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ziacd5Y4JOBZ1DN9KqXAdIUp5b8lgrJuUH40Lof/GnrR2cXx6YL2LmY7NwR+L7mXcwMoMyZZ6O+5fTgiw3wKIBj+6E4OJCqdytyTC25NGXyWFyRnPJjcfAG9btvanpy6x6VKjbduvsnHHDuQ/kxhoiDCLvv8wvp4gxkOyijHPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyXh07tf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyXh07tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525B51F000FF;
	Wed, 16 Sep 2026 02:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789525157;
	bh=dDUcURMBHAMH1IhaS6HFHMjQAJF2An/QFLOBs2F5dqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QyXh07tfacpxaLmNiFdQ1hgXdJu0iwv3QMsVa24BQKXT2JMN7gsV+SF9ejbNZ9w3n
	 gHFasFAbqNtkVSwTUmnUCaJLt+TmGDBkrnJSFNoLaGY2DOIP/SlzXhFicqw6+i9rTc
	 jF1JePFN5CkydYxqTD82fqSQFkzJu9Svb5sgLv/cHn2Al+eBvTHhUzG0l4OCiAgbGl
	 7r2BANMcl+Gne9DMz/jfwY6Zm+NnWeMiUgZXFozkmCpC/DK+te93v3bxJkXrLlOHgG
	 tlJuk9nimIm6zs4o6QzCuV6bBucmUrCw413u7akGt22aQddzLEdXkvhvPVt4W0nhXe
	 n+SGup6Brxxfw==
Date: Wed, 16 Sep 2026 03:19:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v7 2/7] cxl/region: Scan all partitions for unmapped
 poison
Message-ID: <20260916031912.408f98dd@jic23-hlaptop>
In-Reply-To: <20260902053839.25595-3-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
	<20260902053839.25595-3-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 13:38:34 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
> from ctx->part onward. A fully-mapped partition has no unmapped tail,
> it's a normal per-partition state, but the loop treated it with break,
> aborting the whole sweep and silently skipping unmapped poison in all
> later partition. Use continue so a fully-mapped partition is skipped and
> later partitions are still scanned.
> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
