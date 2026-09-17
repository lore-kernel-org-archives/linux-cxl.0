Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C79375ADF
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614054; cv=none; b=ZtQOPG8A/YzjEa7xgMsr+YvYGEfALCNQBJ61DVPY1DQV7EvqM8xgMPTvJTVGhs2jRuEoscjhEy1ov8XmsDvUXOIcXHtXDWbBsKaEmqZz57bVa2u25ZV1Pg90kyJ6uDMaZ9sqViApdk6z9l3QiKlr4s9fpwTpJVBvoqOcjM3utWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614054; c=relaxed/simple;
	bh=1TTKy4xfHbApV7fwHj8OOLkx878qP/yI/CK4gLgT0iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtDeU8m4d5+u6vWrey8/0MyJ/+ChTw5RgBmTWX1nEuONDt1QMzK+QHc874fOYs78Py3pxQUji9w/XioD8WtFWzdj4rdTSB5gLCtXO+eJMaERrl+VEd/peK/e4LpnqH3+yhNHzG4XtZu60bUNh7CiiC2hQH9Rnjit+Jep64bnfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtcpWeRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtcpWeRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8711F000FF;
	Thu, 17 Sep 2026 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614050;
	bh=41cGHno223xNe4ntaCUhmmSzho+h49/OIC848+TKybQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NtcpWeRZupdddWDxo9AGT0lQNLXFC2o9tW93eK+P2ShJmCRRWk4egjDgPLkl9w5yf
	 SYb28sGVQLqUI9ziNzaTQHF3Pv5L7XflWF0fBgFrKDuQRWqJRea3TF9ne/mukGeXLo
	 iH21iidsu8H16upzclojMv2N3EO5KD2bFCH/YQ1fDXytM7h3kv58tB0dQuA5jLI/ZD
	 PTnO8m+yKIwH2A1wa4EtI17DEo/m/aNQHt52w7saHAmj6WSG3iqZCPa0aQRIM5lj/E
	 9SmzaPyEscQDiJUv4/oTvueAaQ/vcO0qhNsKUV0a/6jWFKM+FFZxKZY4oiwTaUI3mp
	 0Zr+vkH7sYheQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260917024632.1397380-1-kanie@linux.alibaba.com>
References: <20260917024632.1397380-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 03:00:49 +0000
Message-Id: <20260917030049.BD8711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/region: missing access attributes for SRAT nodes without HMAT
--

commit 2503e3249f202233ccb3653d33cc651692452053
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/region: Create node access attributes for CFMWS-only NUMA nodes

A NUMA node that only backs a CXL fixed memory window and is not
enumerated by SRAT has no memory_target in the HMAT code, so
hmat_callback() exits early at find_mem_target() and never creates
the node's accessN attributes. Create the attributes with
node_set_perf_attrs() when the node is not backed by a real SRAT pxm.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f54acbf68e844..5ef0ca0694ff1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2631,7 +2632,19 @@ static bool cxl_region_update_coordinates(struct c=
xl_region *cxlr, int nid)
> =20
>  	for (int i =3D 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			/*
> +			 * A CFMWS-only node (not backed by a real SRAT pxm)
> +			 * has no HMAT memory_target, so hmat_callback()
> +			 * never created the access attributes for it:
> +			 * create them here instead of only updating them.
> +			 * This is called at most once per node (see
> +			 * nodemask_region_seen), so the attributes are not
> +			 * created twice.
> +			 */
> +			if (!acpi_node_backed_by_real_pxm(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);

[Severity: Medium]
Will this silently drop access attributes for SRAT nodes that lack HMAT
entries?

If the system provides an ACPI SRAT table that enumerates a NUMA node,
acpi_node_backed_by_real_pxm() will return true. However, if there is no
corresponding HMAT table or entry, hmat_callback() exits early and never
calls node_set_perf_attrs() to create the node's access attributes.

When CXL regions later come online, cxl_region_update_coordinates() checks
acpi_node_backed_by_real_pxm(), which evaluates to true. It therefore calls
node_update_perf_attrs() instead of node_set_perf_attrs().=20

Because the attributes were never created, node_update_perf_attrs() finds
an empty node->access_list and silently returns, which drops CXL access
coordinate sysfs attributes and NUMA mempolicy updates. Using an ACPI
topology check to guess the initialization state of generic struct node
sysfs attributes leaves the underlying bug unresolved for standard SRAT
nodes lacking HMAT data.

>  			cset++;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917024632.1397=
380-1-kanie@linux.alibaba.com?part=3D1
