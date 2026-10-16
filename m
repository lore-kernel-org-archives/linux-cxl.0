Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942544722B
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176323; cv=none; b=BIft6dvB34sQh0/5Cee1jBEbuKUK9hSmwLDpwGSZiwvQzYZeFrh4+rNPKrHCpiaxvT30KJbM5tT3ECo4mWo/3z66LN0IvVCfOJ4LE5fROfeV82hQOCVbe07H6zGs+DG/wwd2OYc7oJfTQj1yZJ/obG9kWyaamMzwO9YPR4bbCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176323; c=relaxed/simple;
	bh=AGTU9vLrr6a7l11XeCNxz+dhbs/CwhBFZIh/RTE2rRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPr0chxxeEVGjm/c07FayK62HcMlVvG+ChssWt8PZB2tdaPO2fawaksUAZX2botp6DjKqf44Qso0hV+BtvepmA4i/pN58WIXBy/iahRw9CpMbulkgt5vERLbVksObtcgxtAU+oS8srDs4oKdAFtJAYP22K/mjM/TXGLrfoJoJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkLHlBwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkLHlBwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD21F000C4;
	Fri, 16 Oct 2026 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792176321;
	bh=EOs4AOFeKBgoU5IFm8gYoayfSFDPSXajedHLYdknfkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OkLHlBwb+vGCTK0qCbQtbJzWt/jDhTvIPk2WGs5P89XxJzQFDvPpd8ldTrGyZWVLo
	 iJlKi32UntjOWbp7K59wZZ/PLjdbVSyKqWOsNro0OLRMgfgzKdhzKjNdvPwWsiP3wA
	 z+Js770nlZRO5J+iR4tpW13jQkW5oiZHVhND9aqyHUr/08iNRxWEp95SBEhC/UiUr/
	 ojs0UF/MZBrVZKutdQeXBkmq/b+oeBp6SsYClcAazbx/IhydPmBR9hB0pxES3UMyPx
	 jMBa84hvoQFV7iTO+rAgFO7jF/tXR2Gyvr8FM8nEiOEMU8v7+DVk+2CY5dAzhn9lQw
	 1SrcQTqZLR5/A==
Date: Fri, 16 Oct 2026 19:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 5/7] cxl/region: Factor out
 cxl_port_calc_interleave()
Message-ID: <20261016194516.6eefbf23@jic23-hlaptop>
In-Reply-To: <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
	<bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 21:26:01 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() calculates the interleave ways and
> granularity of a port's decoder from the parent interleave and the number
> of targets below the port, then validates the result. That calculation and
> its checks are open coded between the target search and the decoder setup.
> 
> Move the calculation and its checks to a new helper,
> cxl_port_calc_interleave(), so that the interleave for the port's decoder
> is calculated and validated in one place.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
