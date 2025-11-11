Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7549369991;
	Tue, 11 Nov 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877970; cv=none; b=hTUnuQHY4ELhHZ6p7IsWul2c5xwzRzPA87ba/gveFlGK78atthGtzt5Z1EbjnorQKQaOsOh5M0XDdA/MFsNUsCr50CxpyYZyS62rdebPt8y6nKlKQFPKPdnL8wscNO1b9cPLnm720y4VC1Rq5LhFhO35kxu1vh9pklDFi8n1tCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877970; c=relaxed/simple;
	bh=HIzM0iyT3dDoXIUZ+C66BgDp43e3Tu3Z+4PxsInPwrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGF9VxH+BezqFc1C07HdMRumMKjV2JFi0QB6/Sxbykf4ouvwIVUyaqV1OyukKanqRt+BLg+SKGlqO3XhQ2gKW9DTik0uYhV2He92//G482LUyhwvRRMVIu16rHH9fFPmFEaaR894g4wNxZsYxfHqXyNVo7UsTNsGWxZD90TEyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0wvRDQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0wvRDQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F763C4CEFB;
	Tue, 11 Nov 2025 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877970;
	bh=HIzM0iyT3dDoXIUZ+C66BgDp43e3Tu3Z+4PxsInPwrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0wvRDQJj5f5uCXvKhn5dc8STHHQH7StOpxysg6KHMApZLHAkXiz+g41StgoUiu7L
	 iQolui75WDT3w/Vw3J5DdZKOhVbnmOBk0bxL3q/UC3Z0g+ndM0Nmis6J9u9FuPnuh7
	 F4THWpnxR1SBp/EiAOQ75+46DxaWcoedbYxpN/R9UaSxfQkCAvB1iVJbBtrCvsK88/
	 12vqrMa03K5Pm5tNC5+SJ7DZ/Fb+X4hOKiDxqHWA6JVIBa/eT1HlSlIynLYo3zBENS
	 AG0SVd+au4GKdH+xm7vSx8XelnvDUyneSBfqVra5JRsx4+t/HBoqOxnbvrtdE/c/k1
	 aGNaw66gcx5Zw==
From: Mike Rapoport <rppt@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
Date: Tue, 11 Nov 2025 18:19:13 +0200
Message-ID: <176287786383.1435827.13312587708182229748.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111010010.7800-1-akinobu.mita@gmail.com>
References: <aQo1VjjQw1OZG8nY@kernel.org> <20251111010010.7800-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 11 Nov 2025 10:00:10 +0900, Akinobu Mita wrote:
> memblock_estimated_nr_free_pages() returns the difference between the total
> size of the "memory" memblock type and the "reserved" memblock type.
> 
> The "soft-reserved" memory regions are added to the "reserved" memblock
> type, but not to the "memory" memblock type. Therefore,
> memblock_estimated_nr_free_pages() may return a smaller value than
> expected, or if it underflows, an extremely large value.
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
      commit: c42af83c59b65d01c0f7a074e450bbbb43b22f0d

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

In the future please start a new thread when sending the next version of a
patch.

--
Sincerely yours,
Mike.

