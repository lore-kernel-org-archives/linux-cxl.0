Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17761D5147
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772736; cv=none; b=AeeQjDrvVp/jB/vJmeuO1N7b4btQ/h0qiZthLoXVb4VcNqNWxKGJUAtzhq/trkAsL+8N4NAZQm3aLCf6e98uqYWHS6eCeyFCdjO6qI13afBA7W0FsWCVXiaY96C77133oGDjLwbQXBHyCgyUrRkdPx64z2c6sa+A0IiKEd0cQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772736; c=relaxed/simple;
	bh=DWXGV4gKNnefe7Z37+0J9UM+EPFPvAVYED14D8cKqUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxH5PdsjNvfLspA6YfM/FKyHCSn2EGj6NawDldAeaE/G2P2AQFUXtGmL3TddoN8I921lzuqKrlLOPAjIEet+txQW64b0Xx/j9Xg8I/TZwWps6gdxNzQvUCDRyXzMhGtYU4Ma1oz80hko/guyn1QNODW2IH6/05OW0LttKCPdSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrWAytgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrWAytgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D4DC4CEC7;
	Thu, 24 Oct 2024 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772735;
	bh=DWXGV4gKNnefe7Z37+0J9UM+EPFPvAVYED14D8cKqUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrWAytgEI7HJjWnnYxWwrt3m4TrVNMkNxyGUX4BIGTWZw8r5TI5CiN2r2HM0CKSJy
	 a7mgEDhfVqo5FJHOybCtIaQ9Hvv2gUQIIkMpF6P6yFxO8vQsiUHga6rL7qLjoQkD1L
	 PkIEAvcXixFyys6lhS33GVgbZwO6JvaVBncavPZYFXrA5tTgVDZRHyCSWVgTLRfKVY
	 4DRo/Jm+l6biB7b/nW347vQC+PsEfIygYIXrysPLK5+BOvfpn00axr1+R+zRqygnD6
	 5Yv9tfdPpHLpxGybOz8u9yk5gQHXoJnBQ0zvMIcyVSEMa6ssO0tFTYkeyxfWKvizlh
	 cXOAScRrFWcuQ==
From: Will Deacon <will@kernel.org>
To: jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] perf/cxlpmu: Support missing events in 3.1 spec
Date: Thu, 24 Oct 2024 13:25:27 +0100
Message-Id: <172976975631.3760779.1396610844480750567.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241010025208.180458-1-dave@stgolabs.net>
References: <20241010025208.180458-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 19:52:08 -0700, Davidlohr Bueso wrote:
> Update the CXL PMU driver to support the new events introduced
> in the latest revision. These are:
> 
> - read/write accesses with TEE constraints.
> - S2M indicating Modified state.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/cxlpmu: Support missing events in 3.1 spec
      https://git.kernel.org/will/c/48545b3eff6b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
