Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4050AC39
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544723; cv=none; b=ujbaVcB5/YAFyMtvpIn+qMDETEDQ7UHHoRxNcmc2EYn86COqhG2493gj7TpPdDEemxzHmAQ7RJIJU5lh37/dau/roHm8DvzuhDUMK1WkV8keP9/lW3Bvc7llOqRWfJ0qBgy6047aKfOYbwROjY8+0t5Rs+CAP2WR1QBZqSvum88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544723; c=relaxed/simple;
	bh=eZLIFKKKFFu55fwbBPg2fA0Rdgb7G826EISqX8f676I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulLj4+cbpb9jqITl6o3XOQiPCUliPqEJxHZwyJueqGUEI9iXJBPCjW66Y1ulIVGVNC3dFFk9zwIjjjfiuDcE4Oos7+QiE+IM2wZ6KIkogLDa7Wox9PpVrG2JVTkzKXnUIJfXpDYrORgogBjU+nYQF7B5Zjx7R/g23wj2rrlnxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/6N6wrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/6N6wrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84881F00A3D;
	Fri,  4 Sep 2026 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544721;
	bh=TGDRLf22auJVRwV/c+dEHK/45yJPnyHHXHgdCj+655s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/6N6wrZobJ25vCd/2uj4rEJScP/Ybo3RMeSU9XGPbj6EBbphv/WXXE6xWunL3IQ3
	 eOUwOs5bAMAdiwu2blhR/49+Lz7DDnHVUwalGfBkkAViTV9oYF+Nnp6gPlAkC/xGvT
	 LbvLmwZTkIZS9F++SmIYzYC+5CTH91auIZrMiQqmniuqgTRp2LKdDS+SH73d56MrCD
	 dW1PEGMTp6qmIPCm3jjWezN/V59i9xY3jNyrMMEpduDFyGxj9Jpih+kUMXu08LputU
	 l73NQxI4OPprCJW5OjY2d7xKtTe2YL3B3TTTeReGWlMH56L0HWf2Z48NvAtf8yM2t+
	 jRtck9J4O/Bzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-6-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:58:40 +0000
Message-Id: <20260904175840.E84881F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch truncates Flit mode TLP logs by strictly copying only =
16 bytes of the prefix log and deliberately leaving `flit` and `header_len`=
 as zero.
--

commit a79ba2cb1ba02ad8827d582fce99b0fe70c8796e
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Avoid populating software AER metadata from raw hardware buff=
er

This commit fixes an issue in extlog_print_pcie() where casting the hardware
aer_info buffer directly to struct aer_capability_regs could fill software-=
only
metadata fields (header_len and flit) with raw firmware bytes. It introduce=
s a
safer local copy mechanism to populate only the hardware-backed fields while
keeping the rest zeroed.

Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.=
kernel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 2451362e696dc..1b61788abd5a6 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -149,7 +149,21 @@ static void extlog_print_pcie(struct cper_sec_pcie *=
pcie_err,
>  		return;
> =20
>  	aer_severity =3D cper_severity_to_aer(severity);
> -	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	/*
> +	 * struct pcie_tlp_log is larger than the hardware layout, so aer_info
> +	 * only maps onto the struct up to the four Header Log DWORDs. Copy that
> +	 * much, then place the TLP Prefix Log from where the hardware keeps it.
> +	 * Everything else stays zero: nothing reads root_command, root_status =
or
> +	 * the error source IDs, and header_len and flit are software-only.
> +	 */
> +	memcpy(&aer_regs, pcie_err->aer_info,
> +	       offsetof(struct aer_capability_regs, header_log) +
> +	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
> +	memcpy(aer_regs.header_log.prefix,
> +	       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
> +	       sizeof(aer_regs.header_log.prefix));

[Severity: Medium]
Does this strict 16-byte copy truncate the TLP Prefix Log in Flit mode?

By hardcoding sizeof(aer_regs.header_log.prefix) (16 bytes) and deliberately
leaving the software metadata fields 'flit' and 'header_len' as zero, this
appears to drop up to 24 bytes (6 DWORDs) of the Flit mode extended TLP hea=
der
from the hardware buffer.

If a PCIe error occurs in Flit mode, the error would be printed as if it we=
re a
non-Flit mode error, leading to incomplete diagnostic information in dmesg.

Should this logic account for Flit mode to ensure the entire extended header
data is accurately copied?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D5
