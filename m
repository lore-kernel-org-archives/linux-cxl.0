Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370E477295
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389152; cv=none; b=p2h+VlhWLFbPcYuz+zTup1RlpfdwnScjaYG1fTcRzpfrkdlLmG6TNb0i7ELuyarPnrTRQL++9W0mbxr8TfbvSahnYUW75crTUFwlqdTUkAYXAYlNGV72EX6xQcaRhPh9UN8rlwW9VAzIuQc6rFV886biidLpRsxr9O7Tq/XiEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389152; c=relaxed/simple;
	bh=NFpjw25Y/P6YQ94yhokdCvoY44JFO9SFUyQ4XZ7/8r0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ai2A1mebxQYlmi1WZWOE4xMDVNfuLkh6U2xDKiga1k6g3jBHCq3uyLRncskBuMCzIPNMFWKMFCzrSgVE0Cj2VX2cYkpPVp/u2t7XpKXrxzuatZuDdrJiRbFhc06oWpf6geHVm3K1mx6ayDkbxrUmSTO9OSbqkifBIcTX3t+76GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3/nCrOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3/nCrOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0251F0089E;
	Mon, 14 Sep 2026 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789389143;
	bh=arX8gXhYYZiyv6rsC87oXWfF6DhG/c7iPUt6LcQJefQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3/nCrOy9gVDRmK9wxqSH7LN9qUBlAy0d6gy7YTgF6PSHu9lbD25mVOcxg/fiGuYz
	 ewwFyu0ybSy9BjHzfiCSEK7PHyJS0uruFvIlVxD5n/47rKNBD0s9B9FGDII/AFs3x+
	 y6AUrUau32Zd4KljCS+l+Au1rMGVtxVbqAgn0gCLxW6nOhOnRL6NHtIbyqzdky3xBL
	 xtd/BXj2LmdOItzaYsmkSKqbu7NtA0P0DZehAC++4sAFfiSGBhdeW2y8asR8lx4VuX
	 /g3RBx2PG1vyQeFESLwqBU0rYi2ZOvxvd7uKa7KaVUwaGcTSF2j2+iBrNOn2nbW587
	 dN9ON/kLi06OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260914121843.718493-1-kanie@linux.alibaba.com>
References: <20260914121843.718493-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:32:22 +0000
Message-Id: <20260914123223.0C0251F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignoring the return value of devm_add_action_or_reset() leads to a=
 use-after-free of the debugfs directory dentry on the error path.
--

commit acaad538920d3905d33312c0501a79695900337c
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/core: Fix dport use-after-free via the einj_inject debugfs file

This commit fixes a use-after-free when accessing the per-dport einj_inject
debugfs file after unbinding the dport host. It registers a devm action to
remove the debugfs directory when the dport host is released.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db0..82513b46f6347 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
[ ... ]
> @@ -832,6 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_d=
port *dport)
> =20
>  	dir =3D cxl_debugfs_create_dir(dev_name(dport->dport_dev));
> =20
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
> +

[Severity: High]
If devm_add_action_or_reset() fails, will this lead to a use-after-free of
the dir dentry?

When devm_add_action_or_reset() fails to allocate memory for the devres
node, it immediately executes the registered action before returning an
error. In this case, remove_debugfs() would be called, which runs
debugfs_remove_recursive(dir) and drops the reference to the dentry,
potentially freeing it.

Since cxl_debugfs_create_dport_dir() ignores the return value of
devm_add_action_or_reset(), it proceeds to call debugfs_create_file(),
passing the freed dir pointer as the parent directory.

Should this check the return value and return early if the devm action
fails to register?

>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914121843.7184=
93-1-kanie@linux.alibaba.com?part=3D1
