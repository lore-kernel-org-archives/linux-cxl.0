Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DA3839A9;
	Mon, 24 Aug 2026 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612908; cv=none; b=HbhjshKK85xzIv0cEeHyYwhrI5Mgpp+LTJpQTqN90kPwM/ZwUaxJoZP8+Fh0n6XTJH3Y7Vd4HsrN600Csna6QGT5XUnZKrNwTCH0hVoM4lwOpncnOrcnWHXooo0s/+sUAUNiq1L1uwcstvKC9VnCqTiKVPhSGsRatXUP5FrCxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612908; c=relaxed/simple;
	bh=PYpyDAUN2pKVXsB3dJDVTvXJyMuAfaW9mgKSwmsCqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjERlKTSFeZRvS+WgRaM6ARA4eY+da0EzKSWxc7pyTVeCGXt0z71qtFDLgyqAXW8JqqT+QZPV45/gofROaRRjelklfWxutXlb9gTWfbj1E1bR2rzMcGa0EG5voIs/fhtF6+GZN9QeKmwWGIjZ4ynMm8fmETEpRT17aVY57B4zYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5mPVPeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5mPVPeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FAA1F000E9;
	Mon, 24 Aug 2026 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787612906;
	bh=GGwj2JS0jfdTEQ93X3pmVp1cA1NZUfQz8C0YQUMU7Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f5mPVPeUGOMyHoaKbxNToSCBwr3kHBJaLcQvG0DVu+6See2kmEYicvuYgsyaxJEVa
	 3/Q90fP3v4XOF3P5MUdixzRU6TPaI3w+99Z3/333FJBL+BjUmtUJuRKGuJW3NeV7rh
	 qzopLVzoTT6TCEX4Wysc1YfKwae2nep07sqPfP3cRZKjDGk5ZqO4wSDWuqZE0OqnVn
	 NgCRwGyLgbJNSHwDlCug7y//DF5cCqSAn7kyIV2kwdSUggLfQhPX/fUyB3WKUvt/Nj
	 4yzUBNoepq8FWBuPipJqN4AtaDI6deR6uopAeFbt44xLx8mFfLSgL3soq2yQJlYany
	 OfNvV+FFhIObQ==
Date: Tue, 25 Aug 2026 00:08:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] ACPI: extlog: Validate PCIe error section
 length before payload access
Message-ID: <20260825000814.33cbd963@jic23-huawei>
In-Reply-To: <20260824174936.939059-7-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> extlog_print_pcie() reads pcie_err->validation_bits and device_id and
> copies the 96-byte aer_info buffer without checking that
> gdata->error_data_length is big enough for a struct cper_sec_pcie. The
> cper_estatus_check() call added earlier keeps the read inside the estatus
> block, but a short section still gets stale adjacent bytes treated as PCIe
> error data.
> 
> Reject a section too small to hold the record before touching any field,
> and warn: a truncated section means firmware is emitting malformed records.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
