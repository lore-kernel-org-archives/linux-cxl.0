Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132E527583
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764270; cv=none; b=jAw/LN4crPkzpdTPwAMNJ9BKXRgrMg+RTW4BC8vVI784U8oKmdgFvSgw5jJSS/bm4TDfKljz2KxVAP63QqaozXh6B7l7h5d9B/4jkB203LBEpm2crap2oESlT1YeIsNoLWLQSdwPWu6AURDsKxU0kB2b+UUzk3fL452drmFdzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764270; c=relaxed/simple;
	bh=+B6n666XBduE7vqgaGNpWw2W2lNsq4O6v+RSXQrJwc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWPkO9cWUlaOrHAfPwe6V1dd8jEtCrUFIsvYZcujVkRJNQbiB77L74jqtn0Lvt7SmtK40wp6yNlpX3XEJXdZWhSy+i894Anip88846LKBApR7jyXufzUZ/ffIesniEpPWTlhYglEsNNFRYmtKfSWl+vPBrgeUpKXdQyfpmoHj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA6YGKkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA6YGKkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4D1F000FF;
	Fri, 18 Sep 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789764269;
	bh=P76JVcPl/cDCJsny+lRMgleuSkOL64xlP6lJ7ED0XgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZA6YGKkDKCphSEMsH2UxY7Tcj/k0h1yNeBKuKxo/aV00VLYH7jsvDumpXWRg9KRHV
	 a9z4hpOj++tqTZOV5o/sZnNQ1mvCDsrEhih21bzZxzmQ5moAEp3mQU1e6t+oocI/h6
	 TcVGPTjvNCvtxFX7J9uisY8gVGhzadQDPXwT3Jukrto02c51d0Si7W4RV/ZNgs8FIq
	 cSTGSM2GU4xAkhOJn3pCPDEzQYphtBkmJLcuJmKfWploLK0u9GVLDWRRpPTeTg2YQz
	 tQixgzzE/QN0O7j2ZU79y7lFOCk4o5hx5UjQYq1d8H4RGScUxdu1QsxIjbbRXF2RA3
	 xbpfyf9ERFmiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260918203049.7273-3-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-3-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:44:28 +0000
Message-Id: <20260918204428.E2C4D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/mem: cxl_configure_dcd() incorrectly treats Total Capacity as =
static capacity boundary
--

commit 72ce11842054ad85a9e98674e8c97e80cf0a2d21
Author: Ira Weiny <iweiny@kernel.org>

cxl/mem: Read dynamic capacity configuration from the device

This commit implements the Dynamic Capacity (DC) mailbox commands to read=20
and store CXL DCD configuration information. It validates the first=20
partition and ensures there are no gaps or overlaps before configuring it.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..15df8db314d90 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,54 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, =
struct cxl_dpa_info *info)

[ ... ]

> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info =
*info)
> +{
> +	struct cxl_dc_partition_info dc_info =3D { };
> +	struct device *dev =3D mds->cxlds.dev;
> +	u64 total;
> +	int rc;
> +
> +	if (!mds->cxlds.media_ready)
> +		return 0;
> +
> +	rc =3D cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n=
",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}

[Severity: High]
Does info->size here represent the total capacity (volatile + persistent +
dynamic) rather than just the static capacity?

Since cxl_mem_dpa_fetch() initializes info->size to mds->total_bytes=20
(which is the total capacity), comparing the dynamic partition's base=20
against this will evaluate to true for spec-compliant devices,=20
unconditionally rejecting them as overlaps.

> +
> +	/* A gap between static capacity and the DC partition is not supported =
*/
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending =
at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}

[Severity: High]
If info->size includes dynamic capacity, would enforcing that the DCD=20
partition starts exactly at info->size be physically impossible without=20
overlapping the unprovisioned space at the end of the DPA?

> +
> +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> +		dev_err(dev,
> +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> +			dc_info.size, info->size);
> +		return -EINVAL;
> +	}
> +
> +	info->size =3D total;

[Severity: High]
Could this lead to double-counting the dynamic capacity?

Since info->size already includes the dynamic capacity per the CXL spec,=20
adding dc_info.size here would inflate the value.=20

If a non-compliant device bypassed the overlap checks, this inflated size=20
could also cause the strict contiguity check in cxl_dpa_setup() to fail=20
later during device probe:

drivers/cxl/core/hdm.c:cxl_dpa_setup() {
    ...
    /* Require ordered + contiguous partitions */
    if (i) {
        const struct cxl_dpa_part_info *prev =3D &info->part[i - 1];

        if (prev->range.end + 1 !=3D part->range.start)
            return -EINVAL;
    }
    ...
}

> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918203049.7273=
-1-anisa.su@samsung.com?part=3D2
