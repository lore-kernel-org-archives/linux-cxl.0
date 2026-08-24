Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2F39446D;
	Mon, 24 Aug 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613283; cv=none; b=ZsUk/XfBHW+9Ar/Q0WIBmAs4azjuYd05RbUL1pm3HHCqQW/dygq98Ik8VsGKk2a7JuHoUxTRHW5FPXitygbmsdvmjADZuQL0xZJhbNftwozqikESiV7RU+CO3hULp8mHE+qrERy2iD7CFV2uiHFtJ3rC6ql+GSk6Psbzo2cmpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613283; c=relaxed/simple;
	bh=s/seawrg9V1dim3TtGAqG/cxLWd2DqAFAEFq5/I6eew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBwjsp67zcEITSwRvcyFxr0taBiC4Ha49MzM9EdpuM59RypWEVhH9ICfCDo6MoTlXwE7oCkryEAIa/gF/s1ROpsSUVlSYKrBhjwO7WR2AU0HglFCphHVJmK3PVU5RmNLYDEx1sFqNWZhuZKRhEra+4jG793ihEMDqwFbhUDFKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBGU7cSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBGU7cSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4581F000E9;
	Mon, 24 Aug 2026 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787613282;
	bh=hGjHpIlm5WKDXg4JBZ7h8JUL2M8SWiZvnFZa7lTZgsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JBGU7cShH9adw9UfvYncyJhRyUf8EIrmM3OxflZ5DZmVcTEbeNH9YhsUZ7zKZ43mV
	 XSPtnWt/M65m3eMlpW+KSIp0QdyFejVW1Xv7C7DbAWMyBAYBAp/kPkP9ZgAxQa+VrF
	 a6yLQpRccRBO9P5whQ/cF++WTmT2txt7IBV7PCVCtxuFL8iLp/VzO/cR+VG/IOnBiK
	 BXrEzHRJxcpTh/f2+5bm8IsLtRKrKwL5LRQiJJRELNVj5lPqb6wGqRHb9vVnWnM78d
	 XCHmTjSXGmS8NyI388NXO2F1A/cMmYH82LfyUUUXJYm5k4kk2cn7nylFdvbDlDx7J3
	 a7WcMWsCosesQ==
Date: Tue, 25 Aug 2026 00:14:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Message-ID: <20260825001435.046f007e@jic23-huawei>
In-Reply-To: <20260824174936.939059-10-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
> prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
> firmware controlled and never validated, so it can point the copy outside
> the section.
> 
> Extend cxl_cper_sec_prot_err_valid() to check that the section can hold
> the header, and that the header, DVSEC and RAS Capability block together
> fit the reported section length.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
