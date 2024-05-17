Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72654273
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956838; cv=none; b=mkromwspH4cIWET9X8PtMe6YM0pS/5EQxWfo4B5pS20jiE9BE4xukOGM3V1UQJdUf6P+91q+E8YVk9pZY2112Yw+ToX7ayFIcu0m+qXSnuvXiL3CbzFsN9wDOcHpjAaxbFBTs+X7YicGtodwJiWoloLMV42RdqYHqbdudqo455o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956838; c=relaxed/simple;
	bh=44EfypqGTIRb7W/3B2tc5em9ODR9PGCZ3gBfB0/S26M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKZD/QvLuO9LQqJ4rN+4Ko/4Qu2JrMHB+K6NiTqIPrbYdi5+gDU3syso9J3jR/7+dFLEVGN5mKqSl7IoQQt1vMUFYHuZZmEVsWBAmFYDLBWjYqiR7aL+fUFBxI9jHqIn0/b1Y5mMmWXM6VudECanASMYVODEbSucRPiK7WoxTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgqKv3FNkz6D8W5;
	Fri, 17 May 2024 22:37:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 522FE140B39;
	Fri, 17 May 2024 22:40:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 15:40:32 +0100
Date: Fri, 17 May 2024 15:40:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 05/13] cxl: fix check about pmem resource
Message-ID: <20240517154031.00007e35@Huawei.com>
In-Reply-To: <20240516081202.27023-6-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
	<20240516081202.27023-6-alucerop@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 16 May 2024 09:11:54 +0100
<alucerop@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Current check is using resource_size which counts on a range bigger than
> 0. For a resource with start and end being 0, resource_size returns 1
> and implying a false positive. Use the end not being zero as the new chec=
k.
>=20
> Note: If I=B4m not missing anything here, this should be extended to the
> whole linux kernel where resource_size is being used in conditionals,
> and where the likely right fix is to modify resource_size itself
> checking for the range not being 0.

The start and end being 0 is a valid resource of length 1 so that
should not need fixing.

These should have been initialized with DEFINE_RES_MEM()
/ DEFINE_RES_NAMED()
That will happily set the .end to -1 resulting in a wrap around
so that you get all bits set.

Sometimes this gives slightly confusing range prints but otherwise
I think it is fine.

>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c    | 4 ++--
>  drivers/cxl/core/memdev.c | 8 ++++----
>  drivers/cxl/mem.c         | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 47d9faf5897f..c5f70741d70a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -432,12 +432,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *c=
xled,
>  	 * Only allow modes that are supported by the current partition
>  	 * configuration
>  	 */
> -	if (mode =3D=3D CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> +	if (mode =3D=3D CXL_DECODER_PMEM && !cxlds->pmem_res.end) {
>  		dev_dbg(dev, "no available pmem capacity\n");
>  		rc =3D -ENXIO;
>  		goto out;
>  	}
> -	if (mode =3D=3D CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> +	if (mode =3D=3D CXL_DECODER_RAM && !cxlds->ram_res.end) {
>  		dev_dbg(dev, "no available ram capacity\n");
>  		rc =3D -ENXIO;
>  		goto out;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0336b3f14f4a..b61d57d0d4f4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -197,14 +197,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memd=
ev *cxlmd)
>  	int rc =3D 0;
> =20
>  	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (resource_size(&cxlds->pmem_res)) {
> +	if (cxlds->pmem_res.end) {
>  		offset =3D cxlds->pmem_res.start;
>  		length =3D resource_size(&cxlds->pmem_res);
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc)
>  			return rc;
>  	}
> -	if (resource_size(&cxlds->ram_res)) {
> +	if (cxlds->ram_res.end) {
>  		offset =3D cxlds->ram_res.start;
>  		length =3D resource_size(&cxlds->ram_res);
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> @@ -266,7 +266,7 @@ static int __cxl_dpa_to_region(struct device *dev, vo=
id *arg)
>  		return 0;
> =20
>  	cxled =3D to_cxl_endpoint_decoder(dev);
> -	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +	if (!cxled->dpa_res || !cxled->dpa_res->end)
>  		return 0;
> =20
>  	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> @@ -302,7 +302,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev =
*cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
> =20
> -	if (!resource_size(&cxlds->dpa_res)) {
> +	if (!cxlds->dpa_res.end) {
>  		dev_dbg(cxlds->dev, "device has no dpa resource\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6dc2bf1e2b1a..a168343d2d4d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -174,7 +174,7 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
> =20
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxlds->pmem_res.end && IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc =3D devm_cxl_add_nvdimm(cxlmd);
>  		if (rc =3D=3D -ENODEV)
>  			dev_info(dev, "PMEM disabled by platform\n");

