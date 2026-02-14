Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3A271464;
	Sat, 14 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771056387; cv=none; b=c7htij6U4JO244HO4anqH/rRAYW4QIlsD38OVi+sQc4GhcL/GfpHg8qDRnCrMnXljDAL6ty+Yra4HGgjfXMqRj0jH4uDRkAVzPewHO18MUoJpSzeraUjFsxsrU5amLs1i6SoxadHinyaa563mHNlu4yP8mpk7eeHGgC/J6FU5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771056387; c=relaxed/simple;
	bh=fdgtcRtwikKxnqnTtahBc6VNdcurB3e7aq8Qt62VdnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjnMS47Bz4Sjepdimc0itRFtlpJ7AD0IdAXEMSyeyKKFQZerYG7tegSzM1Vs78oie0fUWhuBqzgKC4r5q62r9NwJW0j027adEpsFdGaiqpFu/1ONmudnX2IUIRuSjOeYkK8D80gywg8vH89HKNgf7ypWExDiVFUd7paOdyfFdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiqnQ0Yw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiqnQ0Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3D1C19421;
	Sat, 14 Feb 2026 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771056387;
	bh=fdgtcRtwikKxnqnTtahBc6VNdcurB3e7aq8Qt62VdnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiqnQ0YwbFCmi/UgGdKaC5NuHtK4q4fmvHnp6zwfakKnIrTXKPn2h1x6z8dFWKyLb
	 PEt7yimS//1tDzC6x3kpVkTQfk/yUAh8L92tzn3AbRDRcCfsuPqw5acK7RMu+cj5Eo
	 Dy8FlD5IDH7FUXYEoV2dghFKJxwfHIEHU5weAfcxKLOw9xm1CB3GfFeYRiaKP8ggkU
	 arF2YL7/7hqPfLy2pQu6c8uxy31g2LOFrLEgheR/Lev9YbysToxBPv8oytFYEajUYG
	 S9k6Mqamqns9rBP2+cewdf54gI006+24Zef53jzpiTixwES9gzV11Oj+vtFXbSWK8c
	 qGnfjy+qqYDOA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Cui Chao <cuichao1753@phytium.com.cn>
Cc: Mike Rapoport <rppt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/1] Identify the accurate NUMA ID of CFMW
Date: Sat, 14 Feb 2026 10:06:07 +0200
Message-ID: <177105633005.4117909.8876622423781862717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
References: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 13 Feb 2026 14:03:46 +0800, Cui Chao wrote:
> Changes in v4:
> - Condensed the impact description in changelog.
> - Added Gregory's Reviewed-by tag.
> - Added Dan's Reviewed-by tag.
> - Added Cc: <stable@vger.kernel.org> tag
> 
> Cui Chao (1):
>   mm: numa_memblks: Identify the accurate NUMA ID of CFMW
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
      commit: f043a93fff9e3e3e648b6525483f59104b0819fa

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.

