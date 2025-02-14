Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6B266EE1;
	Fri, 14 Feb 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550909; cv=none; b=PJF60wZpoGgHUryD0lacEvo2cxyi7isNt1eMtQNmSknxTZbfBtHQpjUOnn+LlCAa7hfh/TZ2kGvmstu19+n4zy0V9zqO9XLKUI3mWrwt3opOleMIyGkmCwupKUR/melADq1S0Z+ygiwxvuOaTtSwvVFgDTjl1kg6yEZNsqV2+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550909; c=relaxed/simple;
	bh=W8zq/v5vPvhVYcs9auKXlmzYWh04rjm5apQKr28YEzk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmfC/a0gkqW2GlzFxmhwdx7R2INAkwKi982B6oJHx++DyZhCCw6uUgjxVE0r9UK0m0tyAgnhFl6ASNmiU6t1tNA15ucdTtn+JvXtA9jc8VKzf5lAqjODb6FWQ6IvaWTggcJUh+Qgycbw1zDj536TejWPOuWpxw6p5ZS6rLrxl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvcz82wrgz6M4f8;
	Sat, 15 Feb 2025 00:32:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D970814038F;
	Sat, 15 Feb 2025 00:35:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:35:04 +0100
Date: Fri, 14 Feb 2025 16:35:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 15/18] cxl/region: Add a dev_warn() on registration
 failure
Message-ID: <20250214163502.0000575f@huawei.com>
In-Reply-To: <20250211095349.981096-16-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-16-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:45 +0100
Robert Richter <rrichter@amd.com> wrote:

> Esp. in complex system configurations with multiple endpoints and
> interleaving setups it is hard to detect region setup failures as its
> registration may silently fail. Add messages to show registration
> failures.
>=20
> Example log message:
>=20
>   cxl region5: region sort successful
>   cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: n=
one nr_eps: 1 nr_targets: 1
>   cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: =
1 ig: 256
>   cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next:=
 mem0 nr_eps: 1 nr_targets: 1
>   cxl region5: pci0000:e0:port1 iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
>   cxl endpoint5: failed to attach decoder5.0 to region5: -6
>   cxl_port endpoint5: probe: 0
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
I'm in general fine with this, but we have previously been reluctant in
some cases to go above dev_dbg.  Hence would like input from more
people on this one.

=46rom me though
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ebcfbfe9eafc..3031d4773274 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2147,6 +2147,12 @@ static int attach_target(struct cxl_region *cxlr,
>  	rc =3D cxl_region_attach(cxlr, cxled, pos);
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
> +
> +	if (rc)
> +		dev_warn(cxled->cxld.dev.parent,
> +			"failed to attach %s to %s: %d\n",
> +			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> +
>  	return rc;
>  }
> =20

