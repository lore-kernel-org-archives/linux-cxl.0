Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE173E3141;
	Fri, 29 May 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070101; cv=none; b=QGjnyeSrmBDvm7PYrmKY1YoH57lpI73vXYZpPJYxEUCZkoWzhD+Ql+EGtfdJ5FFwlKus0at/Uf+m6YRNk0F8l0wHJymRJ/QLaBRvfTMsi57KdgLmP6g703inZ7h/8oAHMgUA4gqLulKqDomnDqd+ES3prFhQTEuJ4gpgV3m2jFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070101; c=relaxed/simple;
	bh=vQIrYU3rMA01nDDihAQO5sYcRfLRGlj6m+UnK28/h60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyrotUe1CnSw7HoghtwOTUBsLNFP7SqD/mLItyASzV8UzzhXOPZHCtdNginuQBRYeNvSF14MsINkV6c19H+uko9rADtiYeUlOzCblzyUbw9My7iMD61z6eGqlDcV0z+I3U4S75YLyQMY+cx6u4YiUIX+Rx+oAE+RoGYJfPG/YZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THR4yJ+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THR4yJ+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415981F00893;
	Fri, 29 May 2026 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070099;
	bh=sVe55kbXzOg+Z8nDDwZg/tyzZkOiB0dMGcWUzNM9AVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=THR4yJ+SIEv4gOdeg1a71O5x2FJCph4oUeQBkYsREFY0TNOYpRjK7cEml+jLO6wKO
	 1QtkI4HvQgFJlgQejqTrXQaR9BCrsdWs7+ecj3raEZ0NUbc2EiGFITOOeycUtPSc/Y
	 GR2eoyfmSaWialaDzC59KjPaWUgkERidsR5YnBZ43Dyt01hGCdwjfq7JGQO/wV7i82
	 IDBdGGC06mik3nVm7zUvNRoy42xiNa1BUgcSmMOqCiHc/qVM062PmWzHFrBOhLgQgE
	 8uXUMUKpH1Fwsqh4Mnl4L8aLQq7uDe7tIo3lulxgqqYSU5EmfaQ8UeXWI/aIRH4Zcx
	 AKhXEy8L+Gihg==
Date: Fri, 29 May 2026 16:54:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc
 helpers
Message-ID: <20260529165442.76449f9e@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-3-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-3-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:43 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Move the GHESv2 acknowledgment and error-source allocation helpers from
> ghes.c into ghes_cper.c. This is a mechanical refactor that keeps the
> logic unchanged while making the helpers reusable.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
