Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB97219E8F
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488606; cv=none; b=NjKkgBuEc2IVdChThpSH5wUTl1AhsgPkgMQxzP2YlxL2GTnlC4/LEZl7upEyAhHYrgWVA8g/yoeDzyfdPEt3J4UyKoO02mOYplunvH89EsRZ7Aeksjj4BsTxGQ3cl1idANbVoEiqExd/I+q8PAXSgVRo+VeCAUqYg6zEregzrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488606; c=relaxed/simple;
	bh=h3LVrJcHKUK9EtRaCPRj6IfvWwti1Z2xkhx/iMjMIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk6IDLM13ARzgMTHCP1n7ZEcH5PWJELkXiu7xqVO2dn78La/l+K6pbrV6zlzwxhkYAtWNI0wlKQF6262P4PyLYy3cwIDCq5YsYjlhNlwXqzGm4qVNsdFEeDP/BJyTc9lLb+ELDO6y6WKQxm4QQPPFK6qkHlaxtOVtv0FDK48qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b27eMFiV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b27eMFiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749488604; x=1781024604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3LVrJcHKUK9EtRaCPRj6IfvWwti1Z2xkhx/iMjMIwE=;
  b=b27eMFiVjllajI0uGY1OSqz2K51kofA7Pr1fP2W20rbnbovRE0F2bx8K
   QYIDxIaK8yezwasmPIXb9HlQahwu6lftAFwDjGIzacYsFT7mgluPMabGI
   150JcNlt644gK2sD887H1E9xK5TS348cO7o5vZaZnk28BHTXS3PPTSuIP
   ZvWPnqlZ3MVshWzMLG8WobBylbuD6n/cS4aUToYSTeOcd2LH4uelBQM+E
   +jIR0RFW8byoYa+TUF+TbgJ/2KFsGjCQANWAq8Ydv3yvXgogjV85kvjAN
   5qZrMFLLoXoDrgnDDqocJFmJZ63gbmdcbRRw1ZVr6uiGbc9V7BiY38Pjm
   g==;
X-CSE-ConnectionGUID: goVC1nnkSe6aRnARXNLKgw==
X-CSE-MsgGUID: RyT5eoiaQ7utKn7ad003oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51667260"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51667260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:03:23 -0700
X-CSE-ConnectionGUID: 9dU72jiHQYS5DofEyaOYhQ==
X-CSE-MsgGUID: QZnJ503JQASyGqbV1tvNeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146563632"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:03:20 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Date: Mon, 09 Jun 2025 19:03:15 +0200
Message-ID: <2529357.LH7GnMWURc@fdefranc-mobl3>
In-Reply-To: <20250605001148.1698633-1-dave.jiang@intel.com>
References: <20250605001148.1698633-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Dave,

On Thursday, June 5, 2025 2:11:47=E2=80=AFAM Central European Summer Time D=
ave Jiang wrote:
> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support. Add a callback
> in the cxl_root_decoder to retrieve the extended linear cache size from
> ACPI via the cxl_acpi driver.
>=20
> In order to deal with cxl_test, a device parameter had to be introduced
> to the hmat_get_extended_linear_cache_size() call in order to help with
> the mock wrapped function from ACPI. Even though the 'struct device' is
> not used by the actual hmat_get_extended_linear_cache_size() function.
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c      |  4 +++-
>  drivers/cxl/acpi.c            | 15 ++++++++++++++-
>  drivers/cxl/core/Makefile     |  1 -
>  drivers/cxl/core/acpi.c       | 11 -----------
>  drivers/cxl/core/core.h       |  2 --
>  drivers/cxl/core/port.c       |  5 ++++-
>  drivers/cxl/core/region.c     |  6 +++++-
>  drivers/cxl/cxl.h             | 12 +++++++++++-
>  include/linux/acpi.h          |  6 ++++--
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 20 ++++++++++++++++++++
>  tools/testing/cxl/test/mock.c | 23 +++++++++++++++++++++++
>  tools/testing/cxl/test/mock.h |  4 ++++
>  13 files changed, 89 insertions(+), 22 deletions(-)
>  delete mode 100644 drivers/cxl/core/acpi.c
>=20
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9d9052258e92..bc8441dc7fe2 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -110,6 +110,7 @@ static struct memory_target *find_mem_target(unsigned=
 int mem_pxm)
> =20
>  /**
>   * hmat_get_extended_linear_cache_size - Retrieve the extended linear ca=
che size
> + * @dev: device for debug output

Isn't dev used to find a port check if it is a mock one?
BTW, should the test part go to a separate patch?=20

>   * @backing_res: resource from the backing media
>   * @nid: node id for the memory region
>   * @cache_size: (Output) size of extended linear cache.
> @@ -117,7 +118,8 @@ static struct memory_target *find_mem_target(unsigned=
 int mem_pxm)
>   * Return: 0 on success. Errno on failure.
>   *
>   */
> -int hmat_get_extended_linear_cache_size(struct resource *backing_res, in=
t nid,
> +int hmat_get_extended_linear_cache_size(struct device *dev,
> +					struct resource *backing_res, int nid,
>  					resource_size_t *cache_size)
>  {
>  	unsigned int pxm =3D node_to_pxm(nid);
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..7076d471ada5 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -337,6 +337,19 @@ static int add_or_reset_cxl_resource(struct resource=
 *parent, struct resource *r
>  	return rc;
>  }
> =20
> +static int cxl_acpi_get_extended_linear_cache_size(struct cxl_root_decod=
er *cxlrd,
> +						   struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *size)
> +{
> +	return hmat_get_extended_linear_cache_size(&cxlrd->cxlsd.cxld.dev,
> +						   backing_res, nid, size);
> +}
> +
> +static const struct cxl_rcd_ops acpi_rcd_ops =3D {

What does _rcd_ stand for?

> +	.get_extended_linear_cache_size =3D cxl_acpi_get_extended_linear_cache_=
size,
> +};
> +

[skip]

>  };
> =20
> +static int mock_hmat_get_extended_linear_cache_size(struct device *dev,
> +						    struct resource *backing_res,
> +						    int nid, resource_size_t *size)
> +{
> +	struct cxl_decoder *cxld;
> +	struct cxl_port *port;
> +
> +	if (!is_root_decoder(dev))
> +		return -EINVAL;

Is there any real chance that dev is not a root decoder? Is that check nece=
ssary?

Thanks,

=46abio


Thanks,

=46abio



