Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713722E737C;
	Fri, 29 May 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069977; cv=none; b=bbE/BApURqDAwP+69V8obm8y0QDTkU6Kebeiwf7vZxkYHxzLTK1VLrKZ1isstTQI0K9VmwbtrqeIrWffiwaWJTX9rkGd95fWQRa3YvCCPa5ChTwdFG92e195dZBxH44FuJJc8m1O6bP/SHAa8zd9fUOX7r7qKVygpEHZjA5RqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069977; c=relaxed/simple;
	bh=P/V8Y9uIXI4AWqNgG7UMS/Pgmk+Co5kVOuPDYeh7Kp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXvYNvRHxej1UzlhUIOxzwZmfdkZfTw54C07pRxixCKeoFKGczBs1X5+5KwrwVHT0Ch286vkfO+kK7ecpD0vaBtn23SDXxIbkO8w4YAM151weSTnUGEdTOE2n1CTl/ceCSB78tr9TEWXh8c5TRY9t260kYF/mN00zb9MzEJxFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsdxII/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsdxII/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA2F1F00893;
	Fri, 29 May 2026 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069976;
	bh=N/B1s9KhnGd01rwpg2fz4lH2p0wkLzGPo4AluzrGq1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WsdxII/q2zvqNxWCu9klfz79GluHKPdSHwdkuHSAv0hUH4JarglftSySE6k5cbyMM
	 BqPCmcNHtOf0Wbcf7WePutZtO5a3J27pzUo5lCjR6amgAmK2Kljw3ZHzDQvSgXj8oy
	 6eoAd3FAA1d/M9VDgPQry4cccHA8vF4X3FaJc6MsUTbiZYc8vX7j9bHVydxWHppBd5
	 aYajVapdVuY45Wy5vVkNOKKB4VCBIAFFKgwjooxm/W77u10KqU70XA9JlBi683UXIf
	 H35ULHRV7vYplnGUjdbmo3QWilV11HQT9eMNN/riJBVQW5i1u74hYUX7pkoN2Ot93+
	 tADG9vjqdg4cQ==
Date: Fri, 29 May 2026 16:52:39 +0100
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
Subject: Re: [PATCH v5 01/10] ACPI: APEI: GHES: share macros via a private
 header
Message-ID: <20260529165239.25753125@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-1-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-1-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:41 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Carve the CPER helper macros out of ghes.c and place them in a private
> header so they can be shared with upcoming helper files. This is a
> mechanical include change with no functional differences.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
I'm not sure there is a 'right' way to handle the use of ACPI deifned stuff
outside of ACPI, but this seems reasonable to me.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
