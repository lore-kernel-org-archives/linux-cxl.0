Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88732ED34;
	Mon, 24 Aug 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608650; cv=none; b=NuXi/E6wW4tWmBW44TkB4VqiucelWkSqOtZDSCkwK2Yugh0oCo8iA+T7t4TA34IVIAg2fTWJN7S5WHORVke84udaKk86upfmyujBJk2mfX6PbId4/Zs3aY6G8bGnD/koRhmTRChqY4nJQlMm2eVMgHN940nRWnF4+kXfC1WtI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608650; c=relaxed/simple;
	bh=MzmOvpz+U+9t1SxHAtgipGhgzy0JiVCd4fKdVLz2tNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOfCpGsyP4rdmPyZ9YpF7wl5Cf0a137OdljY9gDXHrcnDnymKRH7BT7RFTbTlC15bKI3fWIn2XUS0k5TfRtVxX6EoTzjU65tyIcL7PvQ8kTJBeOX4C2rGRN4Wnzf5sAEskYqmbTKwc2fK6ZV3BBfhQKDRqRwYHWAo7rBWlGb2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smk3eS/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smk3eS/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5B81F000E9;
	Mon, 24 Aug 2026 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608649;
	bh=5mbymy+AQXtUUJmvEUwvTk7uwYJj2fB3OetWpSercIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Smk3eS/jAlx3rxH5GRJqGErheW2+ABxVqiDFSv1sOj3krTb7f4zmxss6J/slFkG6p
	 jlsXBNEgitXppRduldzwXfKo+5v0QXWRg3QxsL9F9lAKQjBeySlGBkgPR+ReGNmKUF
	 b97+8HimWGy4Sm9JOrISuVtH1ZKjnHAd6NockfMteJKzABuomyxbcrEsSm5KaaeCfP
	 ClOxHPMuYEZUICyXUz43XoZ6l25cu2L+fsqFBbg+v5rgcCTz3LFfn6ag+b9wQ2kpl5
	 VVA+IOmElz2rhjrRY2ZJxJd13q6jKxLzeMRsgjot+c+P2RC/CXT+ZttC8YE7tFvare
	 SFnEp2w1fGSHA==
Date: Mon, 24 Aug 2026 22:57:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/13] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Message-ID: <20260824225720.60a4fdcf@jic23-huawei>
In-Reply-To: <20260824174936.939059-2-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:24 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cper_estatus_check() sizes each section with acpi_hest_get_record_size(),
> which adds the firmware-controlled u32 error_data_length to the header size
> as a signed int (see <acpi/ghes.h>). A value in the top sizeof(*gdata)
> bytes of the u32 range wraps the sum small rather than large, so it slips
> past the "record_size > data_len" check: against the 72-byte v300 header,
> 0xffffffb9 sizes the record at 1 and acpi_hest_get_next() walks it a byte
> at a time, off the end. 0xffffffb8 sizes it at 0 and loops forever.
> 
> Sum in u64 so the check sees the real size, and reject a size the int
> helpers cannot carry, since the walk advances by their return value.
> 
> This is the per-section upper bound the later "len < sizeof(*foo)" guards
> rely on; they are lower bounds only.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
> Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I know I'm late to the discussion but maybe it would just be simpler to
use check_add_overflow()?

> ---
> v4:
> - Do the arithmetic in u64 at the choke point instead of bounding the u32
>   error_data_length against data_len, so the check no longer depends on the
>   signed helpers in <acpi/ghes.h> behaving (Tony Luck). Bounding the u32
>   still left a window when data_length itself was within a header of
>   U32_MAX, and it did not stop acpi_hest_get_next() advancing by a wrapped
>   int. The v3 "< 0" arm was dead either way, since data_len is unsigned and
>   promoted the int back (Tony Luck, Shuai Xue).
> - Dropped Alison's and Shuai's Reviewed-by; the check was reworked after
>   they reviewed it.
> ---
>  drivers/firmware/efi/cper.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..ec092729cacc 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>  {
>  	struct acpi_hest_generic_data *gdata;
> -	unsigned int data_len, record_size;
> +	unsigned int data_len;
>  	int rc;
>  
>  	rc = cper_estatus_check_header(estatus);
> @@ -762,11 +762,21 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>  	data_len = estatus->data_length;
>  
>  	apei_estatus_for_each_section(estatus, gdata) {
> +		u64 record_size;
> +
>  		if (acpi_hest_get_size(gdata) > data_len)
>  			return -EINVAL;
>  
> -		record_size = acpi_hest_get_record_size(gdata);
> -		if (record_size > data_len)
> +		/*
> +		 * acpi_hest_get_record_size() sums these as a signed int (see
> +		 * <acpi/ghes.h>), which wraps small for a huge
> +		 * error_data_length and slips past the check below. Sum in u64,
> +		 * and reject what those helpers cannot carry, since the walk
> +		 * advances by their return value.
> +		 */
> +		record_size = (u64)acpi_hest_get_size(gdata) +
> +			      gdata->error_data_length;

I'm late to the game obviously and what you have works but could this have
used some explicit overflow checking?  Something like

		if (check_add_overflow(acpi_hest_get_size(gdata),
				       gdata->error_data_length, &record_size))
			return -EINVAL;

		if (record_size > data_len)
			return -EINVAL;

That uses the compiler __builtin_add_overflow() which checks if the infinite
precision result of the sum of the parameters would have wrapped when written
to the output one.

I think you could then drop the earlier check as well as
record_size is at least as big as acpi_hest_get_size() and we know there
was no wrap around.

	
> +		if (record_size > data_len || record_size > INT_MAX)
>  			return -EINVAL;
>  
>  		data_len -= record_size;

