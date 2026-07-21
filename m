Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38516403AEA;
	Tue, 21 Jul 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654343; cv=none; b=Oto/PGs5Jw8Qg97dyb0MU9IcSukjdjhk1K9bb88ySp4DF9vDYY6EgEiU8tYTOr50KElnOnXMkTjWiIqFeNcCL4P0sqvcrZSi4LoLMh5nEMAjq8V25Jb7xtxbUGBOSBkmorXs+TUC+AUINWmUn8EeSOADs0d1npii3IA1qAuDheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654343; c=relaxed/simple;
	bh=Vi8SRRmyuNg8Cx6Jp7BsFckp7lvfXrOyXhQP2iPvHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU1wtky19Dy3O9bwdXtP7xbmSut7BHN2MfsKWtyPU7ywqu/VFwbMXlnobZRbwts2D87h+9Z6lh8aACjEaGI2MkQo7qbV1UU5rTMsRB6bYkPg8s7kw5ZhyEumLp1YNcfnd4igc38ZPQvhycC4RT+i7Ox7KIV1c2ETRjJO5d+QNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3J0SdG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3J0SdG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4931F00A3F;
	Tue, 21 Jul 2026 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654340;
	bh=G1xIDTvgZ4xzm/y4PId7m0JZQk33VonJiCwyHQfI7w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3J0SdG01kE6rdr1FSu1R3zVfFWQbw9lRLTQmNudH5bgjiecaV1WU3e9cbI4PODgS
	 JcLXBvcvUyvB3yAhtqo+NMtwWwPzRPyXmK1U7ci2hsczYXIu4q27naG31eVrKgNDRF
	 hWec1Gj65tCJhT52Ls0zJbj/0dkIPJJYez8BEz1JSt7zORXlLOyVdFBsfRc+n9h7VV
	 lxDcsuVVJ5m4i5x0rUf+DbxnOToPhxJbtZmh7UEBwhew0pb2twuYLkcBELI6+aVRh/
	 9ErKfk5dYyOkutA8RIta4NSi4Ddu12+E92rzib/ScfS6tLJQEEZsYl+sRZWBsfO+e+
	 2OeMOHuTUBRPg==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	jic23@kernel.org,
	Richard Cheng <icheng@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ryan.roberts@arm.com,
	ardb@kernel.org,
	kevin.brodsky@arm.com,
	anshuman.khandual@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com
Subject: Re: [PATCH v2] arm64/mm: Check the requested PFN range during memory removal
Date: Tue, 21 Jul 2026 18:18:39 +0100
Message-ID: <178464727167.1304664.6289495269821621329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721100026.10408-1-icheng@nvidia.com>
References: <20260721100026.10408-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 18:00:26 +0800, Richard Cheng wrote:
> prevent_memory_remove_notifier() advances pfn while scanning the requested
> range for early memory. When the loop completes, pfn is at or beyond
> end_pfn. Passing it to can_unmap_without_split() therefore checks a range
> after the one being offlined.
> 
> Consequently, a valid request can be rejected based on the following
> range, while a request that would split a leaf mapping can be accepted if
> the shifted range can be unmapped without a split. This was observed with
> CXL DAX memory, where the final memory block was incorrectly allowed to
> be offlined.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Check the requested PFN range during memory removal
      https://git.kernel.org/arm64/c/285f90a4d1141

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
