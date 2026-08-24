Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3433331EBB;
	Mon, 24 Aug 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610180; cv=none; b=thxUXQGJXz+biatK0WhUAL5wqrEt3G80f4KlaFKv7zNoOWdIUZ9J4+wtfMh7SssRsICnag2C+GjbevHTxDKc6tPvZMlF4exVCwGGOMzSIlQ5u23negbqCmmtSmhbX97T/4E86F21iV/m/z7ObpXymnb+WI5zAYwZ5SE0wQCjabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610180; c=relaxed/simple;
	bh=LXwTLpDAQHCPcPoIwMgEtMxNEZBYBXUflkeJE1yaBms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIKVixxVEVVe6Y+V4nfFplkI0rhIaQs9ONZTdtjv3kw9uJ4SvdpkU56GYy5hK7qVcS8mQHpdv33p646TqT6RWbRF28elqS63SPBKVoHjcJDcN1h4NMfW4856QcO5XZvRSNp18E/Ph2XhlWW9AN5iTfwTIcc/jv2hrEImOXRYqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7sHsjSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7sHsjSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D61F000E9;
	Mon, 24 Aug 2026 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787610178;
	bh=TKqVgqauEruTPN1rpen48G1YgM9WzoBZfpr2ypzAplU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U7sHsjSuYFRsSHEe7tzYY0kqzg0ybfF0B/AEPqhoqFTvJ8jFVXyBCr6Wd/MuSGj4v
	 SLNCcLd03EBiN1G8xj5pbLcDqbFsVmdDLAGDmdwGQbvBDuF/vEb9+V3Jf5bzmfvTVT
	 M/w0JxLaudBKDsVWqwCFC/JqT7+eVdLtT0Ifmwe2s1aQ0Aa47Gn68Rr4Xbf2M61zl0
	 +1oPY2MxlGN0kCn6snYBYNrFJ6ZZp49hauK0XiJEDvpWUQX8mxybo3yQyacSR7rPjM
	 ek5h8D5VpiyvGUkRR3/2RzGdo680LQrU3877C7diIo2WI67iV45nkzY/cw+a3xWP/w
	 7uWk3lt6LAALQ==
Date: Mon, 24 Aug 2026 23:22:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] efi/cper: Reject an error status block length
 that wraps a u32
Message-ID: <20260824232239.44c76252@jic23-huawei>
In-Reply-To: <20260824174936.939059-3-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cper_estatus_len() sums the firmware-controlled data_length (or
> raw_data_offset plus raw_data_length) into a u32. A data_length of
> 0xffffffec wraps that sum to 0, and a length that reads back short defeats
> every bound built on it: bert_print_all() passes its "remain <
> estatus_len" check, then advances "estatus += estatus_len" by zero and
> loops forever. GHES survives only because __ghes_check_estatus() rejects a
> length below sizeof(*estatus) first.
> 
> Reject a length that cannot be expressed in a u32 in
> cper_estatus_check_header(), which both of today's callers reach: GHES via
> __ghes_check_estatus() and BERT via cper_estatus_check(). extlog reaches
> neither yet; a later patch routes it through cper_estatus_check(), whose
> ELOG_ENTRY_LEN bound needs this to hold.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
> Fixes: 06d65deade9a ("ACPI, APEI, UEFI Common Platform Error Record (CPER) header")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems fine to me and to use the overflow.h stuff here we'd have to invent some
local variables which rather outweighs their documentation benefit.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> v4:
> - New patch. sashiko-bot's review of v4 pointed out that the u32 sum in
>   cper_estatus_len() wraps, which bypasses the bounds added by the
>   surrounding patches.
> ---
>  drivers/firmware/efi/cper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index ec092729cacc..ea1c999089bc 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -745,6 +745,17 @@ int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus)
>  	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
>  		return -EINVAL;
>  
> +	/*
> +	 * cper_estatus_len() sums these into a u32, and a wrapped sum reads
> +	 * back smaller than the record. Reject a length that cannot be
> +	 * expressed so no caller is handed the short value.
> +	 */
> +	if ((u64)sizeof(*estatus) + estatus->data_length > U32_MAX)
> +		return -EINVAL;
> +	if (estatus->raw_data_length &&
> +	    (u64)estatus->raw_data_offset + estatus->raw_data_length > U32_MAX)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(cper_estatus_check_header);

