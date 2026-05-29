Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D93C1985;
	Fri, 29 May 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071689; cv=none; b=TJ6Smv4jaghvDwETG8pFiIC6uR+dJ/JZYVIat85xP5HK3dHL6W0ZPMDpYoup2N3oL9YgGewrretAQpYaGfO27YBP8O4l/+bab6WBBUcox+G7rq0Nh+DDRSqfP25R2D9bRQC+GZb+l0053YfiE/F3V9IQBzMcY+RJA1y7g9a93mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071689; c=relaxed/simple;
	bh=ZhwZZh2c+ydcgPmEcqMNksds1l0+8qeg8YfVh0k7VDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz49J4u0R1F7lBZy7xV+fpnN52474Is/9Xnapbh2vBEL3ukfgy1i0agCQ0WXu/XWPJfAmyTNgpDsZR3J/0eInXAHXxskqLSUHbjUz/n4o/4hkKvjQ5z3iSfVCZrxkBpzpOyagT3cWPaDm+AWbQrf8/lUdSr6I6/XzIdA9ZwEF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhtkOfg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhtkOfg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B72D1F00893;
	Fri, 29 May 2026 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071688;
	bh=sETUeraPm3lDWt83CkBlDnReof1JzvEfPtq12I0od7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UhtkOfg5tpU58A1puKZrFMJv4+ZSY+eHsk+EjpC/uqcWBXgkP8itWmK0dw0GnzJBx
	 v39RsyJx6rpSPrPEqDUrnbFCdXnf7nsoynP6VjDU0VDApCY4+N+cb03Di9yd91jFWD
	 n0LbFYZc8LZCA9ejD4EqmuVDmZTw9bAR2jSr/cZIxUOZo+iR/2vi/KlLQuTWt4DILU
	 wpiss1Sz6+OBpgYvYpF7U47lZb2JhC4gjIkVys1sKHhI/N3hi+LRqtlsFP5gZTKPpx
	 OumseINICIYyrn4mJ+bECl0Av1JejR9IwFfjvfDzXb9/D9D24Y40MRhZT03818uWla
	 NUrG5X2QKk7fg==
Date: Fri, 29 May 2026 17:21:13 +0100
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
Subject: Re: [PATCH v5 07/10] ACPI: APEI: introduce GHES helper
Message-ID: <20260529172113.74c4ca05@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-7-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-7-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:47 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Add a dedicated GHES_CPER_HELPERS Kconfig entry so the shared helper code
> can be built even when ACPI_APEI_GHES is disabled. Update the build glue
> and headers to depend on the new symbol.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
I guess it doesn't matter too much as in practice all exiting CXL systems
are ACPI based, but is this new symbol sufficient for the
CONFIG_CXL_RAS dependency?

Rest of this looks fine to me.
