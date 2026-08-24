Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE9331EBB;
	Mon, 24 Aug 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610495; cv=none; b=VSBLCFF27fXWQBQmyyyn8WujPgtmCX3cFvxHJpA/NFKd/GUPeYtdpBPh+lawIk+moBIpcHL7fkzBzJXhCiVgo6ezgHPy7wQsoJuz2bqrWkQC7cqlgAQjK0I1V8QLlPchI0KNCcIJ/vMpEpHrEF384CPSdhY21Xc1sfVAnZDXoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610495; c=relaxed/simple;
	bh=AVKz6WFZbAejqTwiSO1qxeDBaTJQjSRLO2gUZJsPeVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT3arPIY216HSUIrZOYF3D1rw358Tg9X8lO2If0q14MPNIb61nloKar8YJGH6mJfbne+Co/MYzFjoakHK/JAdFR9MaevZmMIm6BtteevIvZkvDzfZt6HETdWarNp4xAh0sCYrZIg7MwegcH5ARSSA00/yHoXS48BTDl4L18xW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcmJ9Fpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcmJ9Fpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B31F000E9;
	Mon, 24 Aug 2026 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787610493;
	bh=cfXR6aFz7nH2DXlpI3BZpXD+7PBM4K7T2SerVviw33o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PcmJ9Fpb7XqzUcssT9yKfw333JhfQ3FdIvlTNe9TrC/54M0JY8bx6+VylSnHLqPkq
	 nB4l1g9iELzNTRPbCWs9qsvQFIMAeIucb8Pjx0jvft7X7hGa0Wyr/1kBEJr102yS6+
	 oKxTzH9SFk71A7X61l4wmpzYUkN5xiHMaXK8/u8S7vQhY9tqtgzKcYXodlhMbz0vUl
	 Zai1D6Xlw/0pxFL6R95BRXQhaQFDIF8N0RD2zU1CsZeUjl/X4YVdFVWoWpiRdi0snb
	 +mwHegS1jkfgdNTOr4Ij6RLwOTVzpBCjqaSvYR7D80DhXbADWBLnWYpMq1WIub0KbG
	 w2qVk30u3vXGw==
Date: Mon, 24 Aug 2026 23:28:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] ACPI: extlog: Validate elog record length
 before walking sections
Message-ID: <20260824232804.7071d9fc@jic23-huawei>
In-Reply-To: <20260824174936.939059-4-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
> record into elog_buf, then walks the sections using the firmware-controlled
> data_length. Nothing keeps data_length inside the buffer, so a malformed
> record walks the section pointer past elog_buf and reads adjacent memory.
> Unlike the GHES paths, extlog never calls cper_estatus_check().
> 
> Reject a record longer than ELOG_ENTRY_LEN and run cper_estatus_check()
> before walking the sections. The length test alone is not enough: a wrapped
> length reads back short and passes it, which cper_estatus_check() catches
> via the header check added earlier. Drop a malformed record with
> NOTIFY_DONE and without MCE_HANDLED_EXTLOG, since extlog did not consume
> it.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
> Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..9ad0052aa20c 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,6 +208,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  
>  	tmp = (struct acpi_hest_generic_status *)elog_buf;
>  
> +	/* Keep the firmware-controlled data_length inside elog_buf. */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))

Why this order?  To me checking if we are in crazy world (overflow) before
doing anything with the overflowed value makes more sense. So that would be swapping
the two conditions.

> +		return NOTIFY_DONE;
> +
>  	if (!ras_userspace_consumers()) {
>  		print_extlog_rcd(NULL, tmp, cpu);
>  		goto out;

