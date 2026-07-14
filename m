Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C3812FE
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999269; cv=none; b=BQV6ahLvN83lkk/qMzcJwhCMJPMHyrDpo8BrwhdegLZGau0r7wl8sf1foNu2clY+eglg2kh6Ip0hzTDOR3hdgEbCvOLUjptJPooHHNzYav7qsfmb9Ny2s8ADBCl0Bt75nCLC2iwJMMZU+u2VmPnajbmzeF0yz1OTh1H2pYEbA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999269; c=relaxed/simple;
	bh=pJivzLF/xKE6wu0oXcPSFFzh/zz2rrpto0/28g0X4WM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piNMwYQwyDUsnykpBnKvpS15/aoHLve42SXYpSxyfReIUw5kNj2d/W4tq/lq5cc9VCp3XPx3d0U+4kmhLygd7oBvnWbx4loe9KjZkwU4U4+MSaSUMEP+8p2IPXsRFaMHxFH9NoQLdBcNpjtHQcd2zkxOHMKW613rMuiswnXqNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtE5sgho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtE5sgho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003AC1F000E9;
	Tue, 14 Jul 2026 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999268;
	bh=+yyliz71akr58+TZQAR0AzDzhwayAhK65D/MZEruhQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FtE5sghoUmHMgNZETotJ2z5vZsEYrFuCcDbpiyUQe7LqhJ8rcNOXDknXawOpZMWHV
	 u/NGIHkNYcDB+DllWF9tdGTf5zP9hXjLeELSPI5eDv5CVgPcXBgHCmrtQWOf1el9el
	 8p6UMn89u41KRTpu8uplZ0EAI6SjtKOUs71IPO1YZR9o8Xc9EN+AGiBZDThv+j0ZOW
	 UCIfms0KWqIo93Oo446d2dD8SmmmYcRd471dVYD171/6b66BDTysl93GyGjzeGS34N
	 XhYBiwThUbpmVegcFUQH4498STxSM1pt+7V7ChOmuwk+vqxXCHt5sRGeEqiJh7fLh7
	 suShqcyZqvNWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/mbox: Serialize RAW Get/Set Feature commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714031010.14834-1-icheng@nvidia.com>
References: <20260714031010.14834-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:21:07 +0000
Message-Id: <20260714032108.003AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing lock acquisition in kernel-managed Feature paths defeats t=
he intended synchronization.
- [Low] The patch references an undeclared struct member `feat_mutex`, resu=
lting in an unconditional build failure.
--

--- Patch [1]: [PATCH] cxl/mbox: Serialize RAW Get/Set Feature commands ---
commit ffea860f8f4c719a69a797f95e4162563fecddae
Author: Richard Cheng <icheng@nvidia.com>

cxl/mbox: Serialize RAW Get/Set Feature commands

This commit modifies handle_mailbox_cmd_from_user() to acquire feat_mutex
around RAW Get and Set Feature mailbox commands. It aims to serialize these
userspace commands against kernel-managed Feature operations.

Link: https://lore.kernel.org/linux-cxl/20260709155841.1895915-1-dave.jiang=
@intel.com/

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 79543103ac298..b94b8514f6786 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -594,6 +594,8 @@ static int handle_mailbox_cmd_from_user(struct cxl_ma=
ilbox *cxl_mbox,
>  					u32 *retval)
>  {
>  	struct device *dev =3D cxl_mbox->host;
> +	bool is_feature_cmd =3D mbox_cmd->opcode =3D=3D CXL_MBOX_OP_GET_FEATURE=
 ||
> +			      mbox_cmd->opcode =3D=3D CXL_MBOX_OP_SET_FEATURE;
>  	int rc;
> =20
>  	dev_dbg(dev,
> @@ -603,7 +605,11 @@ static int handle_mailbox_cmd_from_user(struct cxl_m=
ailbox *cxl_mbox,
>  		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>  		mbox_cmd->opcode, mbox_cmd->size_in);
> =20
> +	if (is_feature_cmd)
> +		mutex_lock(&cxl_mbox->feat_mutex);

[Severity: Low]
Does this code compile? Looking at struct cxl_mailbox in
include/cxl/mailbox.h, it doesn't appear to have a feat_mutex member
declared:

include/cxl/mailbox.h:
struct cxl_mailbox {
	struct device *host;
	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
	size_t payload_size;
	struct mutex mbox_mutex;
	struct rcuwait mbox_wait;
	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
	enum cxl_features_capability feat_cap;
};

[Severity: High]
The commit message indicates this lock is meant to serialize RAW commands
against kernel-managed Feature helper loops like cxl_get_feature().

However, looking at cxl_get_feature() in drivers/cxl/core/features.c, it
loops over cxl_internal_send_cmd() without acquiring feat_mutex:

drivers/cxl/core/features.c:cxl_get_feature() {
	...
	do {
		...
		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
		...
	} while (data_rcvd_size < feat_out_size);
}

Does this missing lock acquisition in the kernel-managed paths defeat the
intended synchronization, allowing interleaved execution if userspace submi=
ts
RAW commands concurrently?

>  	rc =3D cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
> +	if (is_feature_cmd)
> +		mutex_unlock(&cxl_mbox->feat_mutex);
>  	if (rc)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714031010.1483=
4-1-icheng@nvidia.com?part=3D1
