Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39ED8287E;
	Wed, 16 Sep 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789526444; cv=none; b=aVVXVwgUZjLS9WDqGrlwLinS/3qQBh6qHHdjCvGbiOLiANRiRBApvZ1bU7NL0ufTsKCK6DO7u62ONdZuvmbXQ6MnW0npYA/jeEOBhFD3Ng3p26hetLGfuVIn7Bn0h4vmweaCQ1K0IwuYIx6RDDCRgNPTxq9N50x6HDLSzOcgGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789526444; c=relaxed/simple;
	bh=CzpJotlXGbUgYWGTDvWoZnOLDxvSFAjUQOBRP8RgLzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kA/G1G2pJWpZBiDbVBT/oK+G/lJNhaVfyp0KftnRygtuRXBW6ptPZaByQBCdtlTAlm84YHw2zVOKwD14ouTkdJTbGNRLRkq149+1RQKn0gZSx9WApjLJlhQ94fyayS5knWJmZP+y/QB7gLsy6V7THjYz1ElBQlvBrwfh+CqQBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkNMqNHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkNMqNHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA521F000FF;
	Wed, 16 Sep 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789526440;
	bh=0rEKOzg+vSg0ZBlgxzOkjCWSeaE4jz6DX+ZJtW3dWTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nkNMqNHLJpBmV22YNi8g56DLim4WkefnMlMoAkSTGgPXb9p/o0Amnnf/hnpiAQnLo
	 kw2rLSt5RAGSQcSZsZT8DqSrePw8yqsGqz8fDYn8poI2b2fN46oFsBsDbD0iDQkopw
	 abkXpF96UIffSPlMrxV+Kbx4ZqylonLCZHsxA+0T9Xu84ngcnJgSK7/xMkyW8FX9Tm
	 njZ6ioaCjrXg4+hGBk7u/HFqHMcxfhAEtxmRJ5RWMcCQBP6WGwI07yf4oiixLahwj5
	 FhAdgmGO8UUvDoRFWlmbas3/mYWaxFpPXoaWuZ1vagIC6ol4V4EHPtTc8HdA4BvL1X
	 zSrIwLaSuzf0A==
Date: Wed, 16 Sep 2026 03:40:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v7 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Message-ID: <20260916034038.3a7e65d1@jic23-hlaptop>
In-Reply-To: <20260902053839.25595-6-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
	<20260902053839.25595-6-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 13:38:37 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> cxl_get_poison_by_memdev() queries Get Poison List per partition but
> never checks the result inside the loop, so a later partition's success
> overwrites an earlier partition's failure and the whole scan reports
> success while that partition's poison went unlisted. Before the loop
> conversion the PMEM query returned early on error. Stop the loop on any
> error not already tolerated as a RAM -EFAULT.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Given Alison's comments, lets get this in. Can revist later in the
world where we all have lots of spare time.

Jonathan
