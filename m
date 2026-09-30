Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39E4FD7BD
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782864; cv=none; b=aPBvPceQ3N8aGL7xSj6HAr5GTngPfbvH7bWqro6UG3RChwi1CZCudavVxinysXFFIF44m7UYFaEOqfDDjS5lsnB6DLEPHbxMj6fx7UOugTgyRHSKPtKFtTsR7bzTIbm1MqbllYZ/j8DZrTMGBOtXZN5J7+Vz2uWxFc2328t0yMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782864; c=relaxed/simple;
	bh=1ZKkO48P+hf4qihwXdaf3xc+tKNuGsLDkI7PQ+Ai2G0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABTkfUPgTCVO6r45Pfkob6gvIsEvMKR/wjErL5qjyV5QJPqAg9lR+xmwY6BYVHONUfF3BvljRN1LzJ19U45uZiYf3lpCcEDUZAH9im8Mlm7e4p6cCHX0vHbicQ57Pm2S1ujgtoPmQPmkkHFkEZk3qxiLGFVQM8Yk9fy363Pq6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFCwBG0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFCwBG0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6971F000FF;
	Wed, 30 Sep 2026 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782859;
	bh=M4xXfvHfO4k8pHtWPyF8ZqnciH4BthvChoxEsslzado=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFCwBG0spUX2Gzpxf3MkXM9soR/6P1CiMNehQ928PKkP2pnDuXv2Xh0PkbCK9qaAD
	 gc6MFMpdQF96NLjrUbc8IL6hIHZU4MG+BhRH3ZCutMG9Ng9EMCQOaPYHo5VJdHGAy5
	 5YLQQMnDhxYWQNIzKRbqQUJBKgzb6J+XOPk7f4Fo7FKLRW5rX9Zv/FQbsrxfagJfgD
	 VLJGPZb1OOj6Tn8gg2jlTJv85LBoipLYq8ryP0AmSif+Z7hazW+Ez/m8hs+OgvC77H
	 NebOHSflkiPO4aRPfScep/HGoseqt0mWVJZJAaKmVAS6qW5hFLN4KMx0twL/zB4eaz
	 aXDbm5HUlyXNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] cxl/core: Hold the dport host lock across dport
 lookup and use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260930152311.4164036-3-dave.jiang@intel.com>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:40:58 +0000
Message-Id: <20260930154059.2F6971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: dead output parameter in cxl_pci_find_port() and cxl_mem_find_=
port()
--

commit 58eb742e11e94e0c9aa8769fb391c94f00a507ed
Author: Dave Jiang <dave.jiang@intel.com>
cxl/core: Hold the dport host lock across dport lookup and use

This commit addresses a use-after-free risk during dport lookup. It introdu=
ces
helpers to look up the dport with the host lock held, and updates existing
callers to pass NULL instead of fetching the dport from the port lookup
functions.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f4653..f08de094f4125 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -747,6 +759,10 @@ DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_regio=
n *, if (!IS_ERR_OR_NULL(_T)
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> +struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
> +				     struct cxl_port *port);
> +struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
> +				     struct cxl_port *port);
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,

[Severity: Low]
Since this patch updates all callers to pass NULL for the dport argument,
the dport parameter is now completely unused in both cxl_pci_find_port()
and cxl_mem_find_port() defined in drivers/cxl/core/port.c.

Should the struct cxl_dport **dport parameter be removed entirely from these
function signatures and internal helpers like find_cxl_port_by_dport() to
avoid leaving dead output parameters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930152311.4164=
036-1-dave.jiang@intel.com?part=3D2
