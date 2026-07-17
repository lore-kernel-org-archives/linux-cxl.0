Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA39348C46
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325581; cv=none; b=oEvLC9dcDQ+wQeKtXpej0XIH/tn+5NHYy5kIblW/iH+iltWdtVPXQ83KSMufZ77VIoh7y2AJjDl//34u1SfU+eUu6ceHAab4hh5VyWsIbE90m0cHrO+Jqkd5fGPIA5vKsFcB56qeJ2RUCs7uB8CGttmG3TpffsZFFSy/YQLhN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325581; c=relaxed/simple;
	bh=Tu+GjLkUE+rvLPXBedTckqAXHQ4gN0mzJDRV8VjvA/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eXOvNO/mAh23t5bvBSW7Tbbn/643thd8kw3NJroMdo6qFpRj3Ve+3WHeqCsurKPmk5vPXrYpjqbma8mi24IHzR0bpbPuBiAuTtnILOKO/xw7rrx7DLzq5LBK113JViYeSpqcwg2ikfljgrILYBaybu6SDNqe+IttNGNVqRSPpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr4mXoN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr4mXoN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D911F000E9;
	Fri, 17 Jul 2026 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784325580;
	bh=lK+rDofT0+PNd15RHcPu+I5aiv0z7Cz3IaF1B0roOgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dr4mXoN8wt0OmQqsqcVjqwL2yXgq91N+ftkBflqIM4pvczLgobp5yldZJc97aJ9GU
	 20aNRue+3BMTLNCO538YoLUyhccDrPfmcEedBtLZxetc4UbZ+j38kUtujJCsZns3CH
	 YkWobpHE+hh2GxP8yn+Arzht8MBRCAe+EYl3Flq159zXLy6Yw9J7HujQ1R0nhQqgMX
	 eN+RVsfosNiFQKUPtC0frJ5JClRBrpwlbNd91A4eRpyYh0DipkThzk0QR7kHgf8GHI
	 epZW+0ZdU1mYV+lfZOC9pCMWrGkoSsTRnSy4R+KjYacpt0cZewCr/w35KdsNMHZnRu
	 hIaplQttN2iEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:59:39 +0000
Message-Id: <20260717215940.33D911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `target_list` union is not endian-safe, causing corrupted targ=
et mapping on big-endian architectures.
--

--- Patch [1]: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave way=
s that overflow targets ---
commit 4abc7b385aec9c1d79e37f3577a9009b393c2333
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Reject switch decoder interleave ways that overflow targets

This patch validates switch decoder enumeration to ensure the interleave
ways encoding fits the available targets. It prevents overrunning the
target arrays during enumeration and handles uncommitted decoders by ignori=
ng
stale interleave ways.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofi=
eld@intel.com?part=3D1

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,

[ ... ]

> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
> +		}
> +
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;

[Severity: High]
This is a pre-existing issue, but does this union overlay create an implicit
memory dependency on the CPU's byte order?

In init_hdm_decoder(), the target mapping extracts bytes via the target_id
array based on memory layout:

    target_list.value =3D (hi << 32) + lo;
    for (i =3D 0; i < cxld->interleave_ways; i++)
        cxld->target_map[i] =3D target_list.target_id[i];

On big-endian architectures, byte 0 of the 64-bit integer corresponds to the
most significant byte (target 7) instead of the least significant byte
(target 0).

Does this completely reverse the target mapping, potentially routing memory
transactions to the wrong CXL targets and leading to memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784322343.gi=
t.alison.schofield@intel.com?part=3D1
