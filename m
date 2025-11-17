Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF720322
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393725; cv=none; b=YbE98vF/L5PK9ANdVYQajSg0ap1KzxkzVboFxJuZ4Zx71jZ1kDZiRbVtmKwHsqiakZM6+/EbcOczdQOb5Zn2A87sl038GT8yYsr4P4LMcgTKDGaclY0nGaM/Ra5eCN4LFu9eRHo94m+A34ysA0bX+3Kfjk6a3YjYztztHnQFQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393725; c=relaxed/simple;
	bh=PGaSYbz1HP5FYhVvVbL/pe9UhNkk3S2Kiy6F5I7f8Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvUAQEzPiJ04GhNhIUHuHCFlzTTrEupVOp9VpNbFM9NgGjDhls9C/WdVO/H0cEYKCGUEkWoBvpJ6KiR8AY7TgzhdtzodEQz9PDeiVqhx5UOKaNf+Pj7B42MVSl5UOT0xbVdD51HFas/w38QV9n4BwQZz7JDtGKfHGP139WrsRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G57KgKsU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G57KgKsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763393724; x=1794929724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGaSYbz1HP5FYhVvVbL/pe9UhNkk3S2Kiy6F5I7f8Hc=;
  b=G57KgKsU9rRlw90f/YcYyqL/pTu0dsx1lFhrA8zAV4nyGjKUkBqhHs93
   fp6C+Vxg+pi3cGO2rsujbcOAiS8/KEauotAhJui4OQHAnrapxou5mt9Ih
   73wQlPVlsKuyC2uYXaaWWeMRLncgWZq3fOj1T/ytRvCOHeKx8EbC06PDg
   grWZ4GRm2RR1cOcsU6uEZPV97dB0PPC4o6Rf06QMz8HgUXWTvoEudsl0X
   j7RQuEx4Z8dn7EbF46FlNdCD49rspDOeAohk3H9R6aNNPTRaMZCi5GLxV
   ECpDfT0e2Se1bYiFFeMvsuQrlfvXmL9izY4cl9otvLXZVgLFRNPaV8Sop
   A==;
X-CSE-ConnectionGUID: 14Jeza15RLCl7gtBK8nNXw==
X-CSE-MsgGUID: uV3sU7OzQnq+weBNcdZ6sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65331355"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65331355"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:35:22 -0800
X-CSE-ConnectionGUID: AHeek6mQSxeuOO7K9HiRXQ==
X-CSE-MsgGUID: zwKyiJTfToeLqVflaHC31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="213878268"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:35:19 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject:
 Re: [PATCH v2 3/3] cxl/test: Add support for acpi extended linear cache
Date: Mon, 17 Nov 2025 16:35:17 +0100
Message-ID: <1943045.qM8IeB0Osv@fdefranc-mobl3>
In-Reply-To: <20251117144611.903692-4-dave.jiang@intel.com>
References:
 <20251117144611.903692-1-dave.jiang@intel.com>
 <20251117144611.903692-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 17, 2025 3:46:11=E2=80=AFPM Central European Standard T=
ime Dave Jiang wrote:
> Add the mock wrappers for hmat_get_extended_linear_cache_size() in order
> to emulate the ACPI helper function for the regions that are mock'd by
> cxl_test.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Changed to use mock_auto_region_size
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  tools/testing/cxl/Kbuild      |  1 +
>  tools/testing/cxl/test/cxl.c  | 21 +++++++++++++++++++++
>  tools/testing/cxl/test/mock.c | 20 ++++++++++++++++++++
>  tools/testing/cxl/test/mock.h |  3 +++
>  4 files changed, 45 insertions(+)
>=20
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 0d5ce4b74b9f..65e9ac227aee 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -11,6 +11,7 @@ ldflags-y +=3D --wrap=3Dcxl_rcd_component_reg_phys
>  ldflags-y +=3D --wrap=3Dcxl_endpoint_parse_cdat
>  ldflags-y +=3D --wrap=3Dcxl_dport_init_ras_reporting
>  ldflags-y +=3D --wrap=3Ddevm_cxl_endpoint_decoders_setup
> +ldflags-y +=3D --wrap=3Dhmat_get_extended_linear_cache_size
> =20
>  DRIVERS :=3D ../../../drivers
>  CXL_SRC :=3D $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2c3979c0b505..0c14e060a0cc 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -614,6 +614,25 @@ mock_acpi_evaluate_integer(acpi_handle handle, acpi_=
string pathname,
>  	return AE_OK;
>  }
> =20
> +static int
> +mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
> +					 int nid, resource_size_t *cache_size)
> +{
> +	struct acpi_cedt_cfmws *window =3D mock_cfmws[0];
> +	struct resource cfmws0_res =3D
> +		DEFINE_RES_MEM(window->base_hpa, window->window_size);
> +
> +	if (!extended_linear_cache ||
> +	    !resource_contains(&cfmws0_res, backing_res)) {
> +		return hmat_get_extended_linear_cache_size(backing_res,
> +							   nid, cache_size);
> +	}
> +
> +	*cache_size =3D mock_auto_region_size;
> +
> +	return 0;
> +}
> +
>  static struct pci_bus mock_pci_bus[NR_BRIDGES];
>  static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] =3D {
>  	[0] =3D {
> @@ -1142,6 +1161,8 @@ static struct cxl_mock_ops cxl_mock_ops =3D {
>  	.devm_cxl_port_enumerate_dports =3D mock_cxl_port_enumerate_dports,
>  	.cxl_endpoint_parse_cdat =3D mock_cxl_endpoint_parse_cdat,
>  	.devm_cxl_add_dport_by_dev =3D mock_cxl_add_dport_by_dev,
> +	.hmat_get_extended_linear_cache_size =3D
> +		mock_hmat_get_extended_linear_cache_size,
>  	.list =3D LIST_HEAD_INIT(cxl_mock_ops.list),
>  };
> =20
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 995269a75cbd..bff5853717f0 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -111,6 +111,26 @@ acpi_status __wrap_acpi_evaluate_integer(acpi_handle=
 handle,
>  }
>  EXPORT_SYMBOL(__wrap_acpi_evaluate_integer);
> =20
> +int __wrap_hmat_get_extended_linear_cache_size(struct resource *backing_=
res,
> +					       int nid,
> +					       resource_size_t *cache_size)
> +{
> +	int index, rc;
> +	struct cxl_mock_ops *ops =3D get_cxl_mock_ops(&index);
> +
> +	if (ops)
> +		rc =3D ops->hmat_get_extended_linear_cache_size(backing_res, nid,
> +							      cache_size);
> +	else
> +		rc =3D hmat_get_extended_linear_cache_size(backing_res, nid,
> +							 cache_size);
> +
> +	put_cxl_mock_ops(index);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(__wrap_hmat_get_extended_linear_cache_size);
> +
>  struct acpi_pci_root *__wrap_acpi_pci_find_root(acpi_handle handle)
>  {
>  	int index;
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 4ed932e76aae..bfd36cbdbae2 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -25,6 +25,9 @@ struct cxl_mock_ops {
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
>  	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(struct cxl_port *port,
>  						       struct device *dport_dev);
> +	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *cache_size);
>  };
> =20
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);
> --=20
> 2.51.1
>=20
>=20
>=20




