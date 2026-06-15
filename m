Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982E2F7F04
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544943; cv=none; b=BVV885EaNdRIf4saGkwc3PfzZRNk3pN54uGbvc5W/Xr3lbP8vTcYingYhktj0rXlsyc11Xsbj2j+uzXg8l0X9xNZfw3mE2xbhKpEDQPrUEHhV2IwNXcp7R4jedfmfvwkETaSaBx6cvOhaLKTXNdnh22Q9FH9QAIMB7XmcnNqRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544943; c=relaxed/simple;
	bh=v6F12hJfhTg5Q7BvV7xrI+Xq9HROc+1EPlTMaUlGG5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qResGQprfb28RAHEmLjhICEp8K7L1kTq95A5iDKCZEybilydYBrSssbtcNgHFeRg3wYquLZszOtY2EfHOFNyaF5IInATW8TFpm2fRJk0rYlftvkdXFWxBJhM7EB4ddmew/qzTMnR2cpJ/wsNJyzAKE5MwXnXIS+gOpr1jJYXE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O69RnwHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O69RnwHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE49D1F000E9;
	Mon, 15 Jun 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544942;
	bh=p7FyGrV4AjKGIemBHq/uzWlOJK/wdu/Aplpz39gdpoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O69RnwHb1o1rp5wqe5L2mAiXSK7Hnug5mk6uP2DeXEI/rbBg4+pGQrhSUsC6cS66+
	 zFMV09EBTyCKIKn/msUImPt8QiJuBYmjdfQ++4UTaq4xk4fWtIF7FI8CbEdTGfF3tl
	 lemnlt/G1Oj2s79GbHbrqr8A9PUAbRbOpjGbeL2chLr73fVa6z1HfzMs7WZX44ig0S
	 ePOPR2QhgZh6YFydxUJ8PwUkX5asFu66yuoOcXPiBGgzqkEvrtUh9LfJqShzdt51gG
	 DW+CGIppVTYeXXOQ0if+zDeDNnX4AJJifxr9FfB0+pZqR1JVaW+RhUQHxFp52oVjB9
	 RSPzyyVhUBJUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] cxl: Add BI register probing and port
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260615145529.13848-2-dave@stgolabs.net>
References: <20260615145529.13848-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:35:41 +0000
Message-Id: <20260615173541.BE49D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] devm mappings for dport BI registers leak on hotplug due to being =
called outside the dport devres group in cxl_port_add_dport.
--

commit a836080fdf13fa334055f7f13a95491b66ef793f
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Add BI register probing and port initialization

This commit adds register probing for BI Route Table and BI Decoder capabil=
ity
structures. It introduces helpers to map the BI Decoder of a downstream port
at dport-creation time and a port's own BI capability during port probe.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52fa..ca8d8c14b7876 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c

[ ... ]

> @@ -261,6 +321,17 @@ static struct cxl_dport *cxl_port_add_dport(struct c=
xl_port *port,
>  	/* This group was only needed for early exit above */
>  	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
> =20
> +	if (dev_is_pci(dport_dev)) {
> +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_map_bi(dport);

[Severity: High]
Does this leak devm mappings if the dport is hot-removed?

Looking at cxl_port_add_dport(), devm_cxl_add_dport_by_dev() creates a
devres group for the dport on the parent port's device. However,
cxl_dport_map_bi() is called after devm_cxl_add_dport_by_dev() returns,
meaning the devres group has already been closed.

Because cxl_dport_map_bi() calls devm_cxl_iomap_block() against the parent
port device, these devm allocations bypass the dport group and attach
directly to the parent port device.

If the dport is hot-removed, the dport devres group is released, but the BI
capability mappings appear to be left behind. If the dport is subsequently
re-added, won't devm_request_mem_region() fail with -EBUSY due to the
physical address region conflict, permanently breaking BI capabilities?

> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
>  	cxl_switch_parse_cdat(dport);
> =20
>  	/* New dport added, update the decoder targets */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615145529.1384=
8-1-dave@stgolabs.net?part=3D1
