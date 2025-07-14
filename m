Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18769276046;
	Mon, 14 Jul 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531132; cv=none; b=HWSTMa1ULiOKuS4iSNuNFXZ1jRhmHrwmjslC6dszu9EyBEUuF5YHmljkCVchL1XYXohSwe0B7rNyxejI63Y0xD+VPp7lQfrXVJ01hREQ7xKvzVT+5WLrBJlrB46AO1MS447qzq7+zxo+BVCMbPEHrI/gfNZ1/J8k9QBH41BwSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531132; c=relaxed/simple;
	bh=oBg6Mjl7+5+LrdabQMCjV01g6q043iKAFYk/beoPt/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlObOqWl4gX/TFwNA+pXQd3E6G3esI6VtHAzAPBiO3CYH1cjHlWZTmeDegSsG8hmljFfiZveOk2jwDlhX8GnbCspRJtxFU1DSTgYPSqejEiuHzEoIF2/xCspPBnbAiSmLr9UBgQrn1HuIVODKjSgwE+BeLGuNvgDM5SD/vfVz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFZN978B; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFZN978B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752531131; x=1784067131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBg6Mjl7+5+LrdabQMCjV01g6q043iKAFYk/beoPt/I=;
  b=BFZN978B3cSCwYC3cKZ3fpjptdvvtejqcXokeubAeqFB6LRN4Hv43SUj
   XD/m4tjl9JOV6GdH+x2yOwdh6VLQqQ2W2RpnsNvW8TuUVtQHx3+DlqQMJ
   yPiVM6Z2MVBm/qpoDpb8G3/IX1yn4XyOejUzRrOOdMb3a76tuzFGlwzv2
   Ha0jOljyItRmcvi39aZjyfyTlaecgrPgnYpQNRH23zW7WW1hvAL5NTZJb
   4iuMp47qU39ECzz/WjvCYTSwwwhYmjvA/xvxoT1Eg9/cbkCsmoJkfP4n5
   eEBF0gDuSeOBI/tgSALFe9QzOwl8O0e7lcELYJxdGxSV3rIQpqz1+8nkd
   Q==;
X-CSE-ConnectionGUID: Ksm1uEaUQ1WTTah3Jnu1aw==
X-CSE-MsgGUID: SbqJv1rmQgSA+MRqiFsiog==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="64994575"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="64994575"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:12:10 -0700
X-CSE-ConnectionGUID: b+gOMCFATeG+4My4q2NicA==
X-CSE-MsgGUID: TWJd13AeQc6l8WxIPrMKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157551732"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.95])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:12:04 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Shiju Jose <shiju.jose@huawei.com>
Subject:
 Re: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem locking
Date: Tue, 15 Jul 2025 00:12:00 +0200
Message-ID: <3761719.vuYhMxLoTh@fdefranc-mobl3>
In-Reply-To: <20250711234932.671292-9-dan.j.williams@intel.com>
References:
 <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, July 12, 2025 1:49:32=E2=80=AFAM Central European Summer Time =
Dan Williams wrote:
> Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
> The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> representing the state of the conditional lock.
>=20
> The goal of this conversion is to complete the removal of all explicit
> unlock calls in the subsystem. I.e. the methods to acquire a lock are
> solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
> unlock is implicit / scope-based. In order to make sure all lock sites are
> converted, the existing rwsem's are consolidated and renamed in 'struct
> cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
> between old-world (explicit unlock allowed), and new world (explicit unlo=
ck
> deleted).
>=20
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/cdat.c   |   6 +-
>  drivers/cxl/core/core.h   |  17 ++-
>  drivers/cxl/core/edac.c   |  44 +++---
>  drivers/cxl/core/hdm.c    |  41 +++---
>  drivers/cxl/core/mbox.c   |   6 +-
>  drivers/cxl/core/memdev.c |  50 +++----
>  drivers/cxl/core/port.c   |  18 +--
>  drivers/cxl/core/region.c | 295 ++++++++++++++++----------------------
>  drivers/cxl/cxl.h         |  13 +-
>  include/linux/rwsem.h     |   1 +
>  10 files changed, 212 insertions(+), 279 deletions(-)
>=20
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 0ccef2f2a26a..c0af645425f4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -336,7 +336,7 @@ static int match_cxlrd_hb(struct device *dev, void *d=
ata)
>  	cxlrd =3D to_cxl_root_decoder(dev);
>  	cxlsd =3D &cxlrd->cxlsd;
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	for (int i =3D 0; i < cxlsd->nr_targets; i++) {
>  		if (host_bridge =3D=3D cxlsd->target[i]->dport_dev)
>  			return 1;
> @@ -987,7 +987,7 @@ void cxl_region_shared_upstream_bandwidth_update(stru=
ct cxl_region *cxlr)
>  	bool is_root;
>  	int rc;
> =20
> -	lockdep_assert_held(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> =20
>  	struct xarray *usp_xa __free(free_perf_xa) =3D
>  		kzalloc(sizeof(*usp_xa), GFP_KERNEL);
> @@ -1057,7 +1057,7 @@ void cxl_region_perf_data_calculate(struct cxl_regi=
on *cxlr,
>  {
>  	struct cxl_dpa_perf *perf;
> =20
> -	lockdep_assert_held(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> =20
>  	perf =3D cxled_get_dpa_perf(cxled);
>  	if (IS_ERR(perf))
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 2be37084409f..f796731deedf 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -5,6 +5,7 @@
>  #define __CXL_CORE_H__
> =20
>  #include <cxl/mailbox.h>
> +#include <linux/rwsem.h>
> =20
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -107,8 +108,20 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_siz=
e_t rcrb);
>  #define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
>  #define PCI_CAP_EXP_SIZEOF		0x3c
> =20
> -extern struct rw_semaphore cxl_dpa_rwsem;
> -extern struct rw_semaphore cxl_region_rwsem;
> +struct cxl_rwsem {
> +	/*
> +	 * All changes to HPA (interleave configuration) occur with this
> +	 * lock held for write.
> +	 */
> +	struct rw_semaphore region;
> +	/*
> +	 * All changes to a device DPA space occur with this lock held
> +	 * for write.
> +	 */
> +	struct rw_semaphore dpa;
> +};
> +
> +extern struct cxl_rwsem cxl_rwsem;
> =20
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d62..f1ebdbe222c8 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -115,10 +115,9 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_sc=
rub_context *cxl_ps_ctx,
>  						flags, min_cycle);
>  	}
> =20
> -	struct rw_semaphore *region_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_region_rwsem);
> -	if (!region_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return ret;
> =20
>  	cxlr =3D cxl_ps_ctx->cxlr;
>  	p =3D &cxlr->params;
> @@ -154,10 +153,9 @@ static int cxl_scrub_set_attrbs_region(struct device=
 *dev,
>  	struct cxl_region *cxlr;
>  	int ret, i;
> =20
> -	struct rw_semaphore *region_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_region_rwsem);
> -	if (!region_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return ret;
> =20
>  	cxlr =3D cxl_ps_ctx->cxlr;
>  	p =3D &cxlr->params;
> @@ -1332,16 +1330,15 @@ cxl_mem_perform_sparing(struct device *dev,
>  	struct cxl_memdev_sparing_in_payload sparing_pi;
>  	struct cxl_event_dram *rec =3D NULL;
>  	u16 validity_flags =3D 0;
> +	int ret;
> =20
> -	struct rw_semaphore *region_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_region_rwsem);
> -	if (!region_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return ret;
> =20
> -	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
> -	if (!dpa_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return ret;
> =20
>  	if (!cxl_sparing_ctx->cap_safe_when_in_use) {
>  		/* Memory to repair must be offline */
> @@ -1779,16 +1776,15 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_con=
text *cxl_ppr_ctx)
>  	struct cxl_memdev_ppr_maintenance_attrbs maintenance_attrbs;
>  	struct cxl_memdev *cxlmd =3D cxl_ppr_ctx->cxlmd;
>  	struct cxl_mem_repair_attrbs attrbs =3D { 0 };
> +	int ret;
> =20
> -	struct rw_semaphore *region_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_region_rwsem);
> -	if (!region_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return ret;
> =20
> -	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =3D
> -		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
> -	if (!dpa_lock)
> -		return -EINTR;
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((ret =3D ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return ret;
> =20
>  	if (!cxl_ppr_ctx->media_accessible || !cxl_ppr_ctx->data_retained) {
>  		/* Memory to repair must be offline */
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9cb34e30248..865a71bce251 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,7 +16,10 @@
>   * for enumerating these registers and capabilities.
>   */
> =20
> -DECLARE_RWSEM(cxl_dpa_rwsem);
> +struct cxl_rwsem cxl_rwsem =3D {
> +	.region =3D __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa =3D __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> =20
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cx=
ld,
>  			   int *target_map)
> @@ -214,7 +217,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_=
dev_state *cxlds)
>  {
>  	struct resource *p1, *p2;
> =20
> -	guard(rwsem_read)(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>  	for (p1 =3D cxlds->dpa_res.child; p1; p1 =3D p1->sibling) {
>  		__cxl_dpa_debug(file, p1, 0);
>  		for (p2 =3D p1->child; p2; p2 =3D p2->sibling)
> @@ -266,7 +269,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_dec=
oder *cxled)
>  	struct resource *res =3D cxled->dpa_res;
>  	resource_size_t skip_start;
> =20
> -	lockdep_assert_held_write(&cxl_dpa_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
> =20
>  	/* save @skip_start, before @res is released */
>  	skip_start =3D res->start - cxled->skip;
> @@ -281,7 +284,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_dec=
oder *cxled)
> =20
>  static void cxl_dpa_release(void *cxled)
>  {
> -	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	__cxl_dpa_release(cxled);
>  }
> =20
> @@ -293,7 +296,7 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_=
decoder *cxled)
>  {
>  	struct cxl_port *port =3D cxled_to_port(cxled);
> =20
> -	lockdep_assert_held_write(&cxl_dpa_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
>  	__cxl_dpa_release(cxled);
>  }
> @@ -361,7 +364,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_deco=
der *cxled,
>  	struct resource *res;
>  	int rc;
> =20
> -	lockdep_assert_held_write(&cxl_dpa_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
> =20
>  	if (!len) {
>  		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
> @@ -470,7 +473,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const =
struct cxl_dpa_info *info)
>  {
>  	struct device *dev =3D cxlds->dev;
> =20
> -	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> =20
>  	if (cxlds->nr_partitions)
>  		return -EBUSY;
> @@ -516,9 +519,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder =
*cxled,
>  	struct cxl_port *port =3D cxled_to_port(cxled);
>  	int rc;
> =20
> -	down_write(&cxl_dpa_rwsem);
> -	rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> -	up_write(&cxl_dpa_rwsem);
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> +		rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> =20
>  	if (rc)
>  		return rc;
> @@ -529,7 +531,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
> =20
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  {
> -	guard(rwsem_read)(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
>  		return resource_size(cxled->dpa_res);
> =20
> @@ -540,7 +542,7 @@ resource_size_t cxl_dpa_resource_start(struct cxl_end=
point_decoder *cxled)
>  {
>  	resource_size_t base =3D -1;
> =20
> -	lockdep_assert_held(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
>  		base =3D cxled->dpa_res->start;
> =20
> @@ -552,7 +554,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port =3D cxled_to_port(cxled);
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
> -	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	if (!cxled->dpa_res)
>  		return 0;
>  	if (cxled->cxld.region) {
> @@ -582,7 +584,7 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxl=
ed,
>  	struct device *dev =3D &cxled->cxld.dev;
>  	int part;
> =20
> -	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>  		return -EBUSY;
> =20
> @@ -614,7 +616,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decode=
r *cxled, u64 size)
>  	struct resource *p, *last;
>  	int part;
> =20
> -	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder attached to %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> @@ -842,9 +844,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxl=
d)
>  		}
>  	}
> =20
> -	down_read(&cxl_dpa_rwsem);
> -	setup_hw_decoder(cxld, hdm);
> -	up_read(&cxl_dpa_rwsem);
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		setup_hw_decoder(cxld, hdm);
> =20
>  	port->commit_end++;
>  	rc =3D cxld_await_commit(hdm, cxld->id);
> @@ -882,7 +883,7 @@ void cxl_port_commit_reap(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	/*
>  	 * Once the highest committed decoder is disabled, free any other
> @@ -1030,7 +1031,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
>  		else
>  			cxld->target_type =3D CXL_DECODER_DEVMEM;
> =20
> -		guard(rwsem_write)(&cxl_region_rwsem);
> +		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id !=3D cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed out of order\n",
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 81b21effe8cf..92cd3cbdd8ec 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -909,8 +909,8 @@ void cxl_event_trace_record(const struct cxl_memdev *=
cxlmd,
>  		 * translations. Take topology mutation locks and lookup
>  		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
>  		 */
> -		guard(rwsem_read)(&cxl_region_rwsem);
> -		guard(rwsem_read)(&cxl_dpa_rwsem);
> +		guard(rwsem_read)(&cxl_rwsem.region);
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
> =20
>  		dpa =3D le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
>  		cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
> @@ -1265,7 +1265,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 =
cmd)
>  	/* synchronize with cxl_mem_probe() and decoder write operations */
>  	guard(device)(&cxlmd->dev);
>  	endpoint =3D cxlmd->endpoint;
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	/*
>  	 * Require an endpoint to be safe otherwise the driver can not
>  	 * be sure that the device is unmapped.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..f5fbd34310fd 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -232,15 +232,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlm=
d)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
> -	}
> =20
>  	if (cxl_num_decoders_committed(port) =3D=3D 0) {
>  		/* No regions mapped to this memdev */
> @@ -249,8 +247,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  		/* Regions mapped, collect poison by endpoint */
>  		rc =3D  cxl_get_poison_by_endpoint(port);
>  	}
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
> =20
>  	return rc;
>  }
> @@ -292,19 +288,17 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64=
 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
> -	}
> =20
>  	rc =3D cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	inject.address =3D cpu_to_le64(dpa);
>  	mbox_cmd =3D (struct cxl_mbox_cmd) {
> @@ -314,7 +308,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 d=
pa)
>  	};
>  	rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -327,11 +321,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 =
dpa)
>  		.length =3D cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> -out:
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
> =20
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
> =20
> @@ -347,19 +338,17 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 =
dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc) {
> -		up_read(&cxl_region_rwsem);
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
> -	}
> =20
>  	rc =3D cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	/*
>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> @@ -378,7 +367,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dp=
a)
> =20
>  	rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> @@ -391,11 +380,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 d=
pa)
>  		.length =3D cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
> -out:
> -	up_read(&cxl_dpa_rwsem);
> -	up_read(&cxl_region_rwsem);
> =20
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
> =20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 087a20a9ee1c..bacf1380dc4d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -30,18 +30,12 @@
>   * instantiated by the core.
>   */
> =20
> -/*
> - * All changes to the interleave configuration occur with this lock held
> - * for write.
> - */
> -DECLARE_RWSEM(cxl_region_rwsem);
> -
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
> =20
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
> -	lockdep_assert_held(&cxl_region_rwsem);
> +	lockdep_assert_held(&cxl_rwsem.region);
> =20
>  	return port->commit_end + 1;
>  }
> @@ -176,7 +170,7 @@ static ssize_t target_list_show(struct device *dev,
>  	ssize_t offset;
>  	int rc;
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	rc =3D emit_target_list(cxlsd, buf);
>  	if (rc < 0)
>  		return rc;
> @@ -196,7 +190,7 @@ static ssize_t mode_show(struct device *dev, struct d=
evice_attribute *attr,
>  	struct cxl_endpoint_decoder *cxled =3D to_cxl_endpoint_decoder(dev);
>  	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> -	/* without @cxl_dpa_rwsem, make sure @part is not reloaded */
> +	/* without @cxl_rwsem.dpa, make sure @part is not reloaded */
>  	int part =3D READ_ONCE(cxled->part);
>  	const char *desc;
> =20
> @@ -235,7 +229,7 @@ static ssize_t dpa_resource_show(struct device *dev, =
struct device_attribute *at
>  {
>  	struct cxl_endpoint_decoder *cxled =3D to_cxl_endpoint_decoder(dev);
> =20
> -	guard(rwsem_read)(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>  	return sysfs_emit(buf, "%#llx\n", (u64)cxl_dpa_resource_start(cxled));
>  }
>  static DEVICE_ATTR_RO(dpa_resource);
> @@ -560,7 +554,7 @@ static ssize_t decoders_committed_show(struct device =
*dev,
>  {
>  	struct cxl_port *port =3D to_cxl_port(dev);
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
>  }
> =20
> @@ -1722,7 +1716,7 @@ static int decoder_populate_targets(struct cxl_swit=
ch_decoder *cxlsd,
>  	if (xa_empty(&port->dports))
>  		return -EINVAL;
> =20
> -	guard(rwsem_write)(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.region);
>  	for (i =3D 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport =3D find_dport(port, target_map[i]);
> =20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4314aaed8ad8..ad60c93be803 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -141,16 +141,12 @@ static ssize_t uuid_show(struct device *dev, struct=
 device_attribute *attr,
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	ssize_t rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
>  	if (cxlr->mode !=3D CXL_PARTMODE_PMEM)
> -		rc =3D sysfs_emit(buf, "\n");
> -	else
> -		rc =3D sysfs_emit(buf, "%pUb\n", &p->uuid);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "\n");
> +	return sysfs_emit(buf, "%pUb\n", &p->uuid);
>  }
> =20
>  static int is_dup(struct device *match, void *data)
> @@ -162,7 +158,7 @@ static int is_dup(struct device *match, void *data)
>  	if (!is_cxl_region(match))
>  		return 0;
> =20
> -	lockdep_assert_held(&cxl_region_rwsem);
> +	lockdep_assert_held(&cxl_rwsem.region);
>  	cxlr =3D to_cxl_region(match);
>  	p =3D &cxlr->params;
> =20
> @@ -192,27 +188,22 @@ static ssize_t uuid_store(struct device *dev, struc=
t device_attribute *attr,
>  	if (uuid_is_null(&temp))
>  		return -EINVAL;
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &region_rwsem)))
>  		return rc;
> =20
>  	if (uuid_equal(&p->uuid, &temp))
> -		goto out;
> +		return len;
> =20
> -	rc =3D -EBUSY;
>  	if (p->state >=3D CXL_CONFIG_ACTIVE)
> -		goto out;
> +		return -EBUSY;
> =20
>  	rc =3D bus_for_each_dev(&cxl_bus_type, NULL, &temp, is_dup);
>  	if (rc < 0)
> -		goto out;
> +		return rc;
> =20
>  	uuid_copy(&p->uuid, &temp);
> -out:
> -	up_write(&cxl_region_rwsem);
> =20
> -	if (rc)
> -		return rc;
>  	return len;
>  }
>  static DEVICE_ATTR_RW(uuid);
> @@ -354,20 +345,17 @@ static int queue_reset(struct cxl_region *cxlr)
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int rc;
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
> =20
>  	/* Already in the requested state? */
>  	if (p->state < CXL_CONFIG_COMMIT)
> -		goto out;
> +		return 0;
> =20
>  	p->state =3D CXL_CONFIG_RESET_PENDING;
> =20
> -out:
> -	up_write(&cxl_region_rwsem);
> -
> -	return rc;
> +	return 0;
>  }
> =20
>  static int __commit(struct cxl_region *cxlr)
> @@ -375,19 +363,17 @@ static int __commit(struct cxl_region *cxlr)
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int rc;
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
> =20
>  	/* Already in the requested state? */
>  	if (p->state >=3D CXL_CONFIG_COMMIT)
> -		goto out;
> +		return 0;
> =20
>  	/* Not ready to commit? */
> -	if (p->state < CXL_CONFIG_ACTIVE) {
> -		rc =3D -ENXIO;
> -		goto out;
> -	}
> +	if (p->state < CXL_CONFIG_ACTIVE)
> +		return -ENXIO;
> =20
>  	/*
>  	 * Invalidate caches before region setup to drop any speculative
> @@ -395,16 +381,15 @@ static int __commit(struct cxl_region *cxlr)
>  	 */
>  	rc =3D cxl_region_invalidate_memregion(cxlr);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	rc =3D cxl_region_decode_commit(cxlr);
> -	if (rc =3D=3D 0)
> -		p->state =3D CXL_CONFIG_COMMIT;
> +	if (rc)
> +		return rc;
> =20
> -out:
> -	up_write(&cxl_region_rwsem);
> +	p->state =3D CXL_CONFIG_COMMIT;
> =20
> -	return rc;
> +	return 0;
>  }
> =20
>  static ssize_t commit_store(struct device *dev, struct device_attribute =
*attr,
> @@ -437,10 +422,10 @@ static ssize_t commit_store(struct device *dev, str=
uct device_attribute *attr,
>  	device_release_driver(&cxlr->dev);
> =20
>  	/*
> -	 * With the reset pending take cxl_region_rwsem unconditionally
> +	 * With the reset pending take cxl_rwsem.region unconditionally
>  	 * to ensure the reset gets handled before returning.
>  	 */
> -	guard(rwsem_write)(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.region);
> =20
>  	/*
>  	 * Revalidate that the reset is still pending in case another
> @@ -461,13 +446,10 @@ static ssize_t commit_show(struct device *dev, stru=
ct device_attribute *attr,
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	ssize_t rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> -	rc =3D sysfs_emit(buf, "%d\n", p->state >=3D CXL_CONFIG_COMMIT);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +	return sysfs_emit(buf, "%d\n", p->state >=3D CXL_CONFIG_COMMIT);
>  }
>  static DEVICE_ATTR_RW(commit);
> =20
> @@ -491,15 +473,12 @@ static ssize_t interleave_ways_show(struct device *=
dev,
>  {
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
>  	struct cxl_region_params *p =3D &cxlr->params;
> -	ssize_t rc;
> +	int rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> -	rc =3D sysfs_emit(buf, "%d\n", p->interleave_ways);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +	return sysfs_emit(buf, "%d\n", p->interleave_ways);
>  }
> =20
>  static const struct attribute_group *get_cxl_region_target_group(void);
> @@ -534,23 +513,21 @@ static ssize_t interleave_ways_store(struct device =
*dev,
>  		return -EINVAL;
>  	}
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
> -	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc =3D -EBUSY;
> -		goto out;
> -	}
> +
> +	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> =20
>  	save =3D p->interleave_ways;
>  	p->interleave_ways =3D val;
>  	rc =3D sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group(=
));
> -	if (rc)
> +	if (rc) {
>  		p->interleave_ways =3D save;
> -out:
> -	up_write(&cxl_region_rwsem);
> -	if (rc)
>  		return rc;
> +	}
> +
>  	return len;
>  }
>  static DEVICE_ATTR_RW(interleave_ways);
> @@ -561,15 +538,12 @@ static ssize_t interleave_granularity_show(struct d=
evice *dev,
>  {
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
>  	struct cxl_region_params *p =3D &cxlr->params;
> -	ssize_t rc;
> +	int rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> -	rc =3D sysfs_emit(buf, "%d\n", p->interleave_granularity);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
>  }
> =20
>  static ssize_t interleave_granularity_store(struct device *dev,
> @@ -602,19 +576,15 @@ static ssize_t interleave_granularity_store(struct =
device *dev,
>  	if (cxld->interleave_ways > 1 && val !=3D cxld->interleave_granularity)
>  		return -EINVAL;
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
> -	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc =3D -EBUSY;
> -		goto out;
> -	}
> +
> +	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> =20
>  	p->interleave_granularity =3D val;
> -out:
> -	up_write(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +
>  	return len;
>  }
>  static DEVICE_ATTR_RW(interleave_granularity);
> @@ -625,17 +595,15 @@ static ssize_t resource_show(struct device *dev, st=
ruct device_attribute *attr,
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	u64 resource =3D -1ULL;
> -	ssize_t rc;
> +	int rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> +
>  	if (p->res)
>  		resource =3D p->res->start;
> -	rc =3D sysfs_emit(buf, "%#llx\n", resource);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +	return sysfs_emit(buf, "%#llx\n", resource);
>  }
>  static DEVICE_ATTR_RO(resource);
> =20
> @@ -663,7 +631,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resourc=
e_size_t size)
>  	struct resource *res;
>  	u64 remainder =3D 0;
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	/* Nothing to do... */
>  	if (p->res && resource_size(p->res) =3D=3D size)
> @@ -705,7 +673,7 @@ static void cxl_region_iomem_release(struct cxl_regio=
n *cxlr)
>  	struct cxl_region_params *p =3D &cxlr->params;
> =20
>  	if (device_is_registered(&cxlr->dev))
> -		lockdep_assert_held_write(&cxl_region_rwsem);
> +		lockdep_assert_held_write(&cxl_rwsem.region);
>  	if (p->res) {
>  		/*
>  		 * Autodiscovered regions may not have been able to insert their
> @@ -722,7 +690,7 @@ static int free_hpa(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p =3D &cxlr->params;
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	if (!p->res)
>  		return 0;
> @@ -746,15 +714,14 @@ static ssize_t size_store(struct device *dev, struc=
t device_attribute *attr,
>  	if (rc)
>  		return rc;
> =20
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
> =20
>  	if (val)
>  		rc =3D alloc_hpa(cxlr, val);
>  	else
>  		rc =3D free_hpa(cxlr);
> -	up_write(&cxl_region_rwsem);
> =20
>  	if (rc)
>  		return rc;
> @@ -770,15 +737,12 @@ static ssize_t size_show(struct device *dev, struct=
 device_attribute *attr,
>  	u64 size =3D 0;
>  	ssize_t rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
>  	if (p->res)
>  		size =3D resource_size(p->res);
> -	rc =3D sysfs_emit(buf, "%#llx\n", size);
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +	return sysfs_emit(buf, "%#llx\n", size);
>  }
>  static DEVICE_ATTR_RW(size);
> =20
> @@ -804,26 +768,20 @@ static size_t show_targetN(struct cxl_region *cxlr,=
 char *buf, int pos)
>  	struct cxl_endpoint_decoder *cxled;
>  	int rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> =20
>  	if (pos >=3D p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc =3D -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
> =20
>  	cxled =3D p->targets[pos];
>  	if (!cxled)
> -		rc =3D sysfs_emit(buf, "\n");
> -	else
> -		rc =3D sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "\n");
> +	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
> =20
>  static int check_commit_order(struct device *dev, void *data)
> @@ -938,7 +896,7 @@ cxl_port_pick_region_decoder(struct cxl_port *port,
>  	/*
>  	 * This decoder is pinned registered as long as the endpoint decoder is
>  	 * registered, and endpoint decoder unregistration holds the
> -	 * cxl_region_rwsem over unregister events, so no need to hold on to
> +	 * cxl_rwsem.region over unregister events, so no need to hold on to
>  	 * this extra reference.
>  	 */
>  	put_device(dev);
> @@ -1129,7 +1087,7 @@ static int cxl_port_attach_region(struct cxl_port *=
port,
>  	unsigned long index;
>  	int rc =3D -EBUSY;
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	cxl_rr =3D cxl_rr_load(port, cxlr);
>  	if (cxl_rr) {
> @@ -1239,7 +1197,7 @@ static void cxl_port_detach_region(struct cxl_port =
*port,
>  	struct cxl_region_ref *cxl_rr;
>  	struct cxl_ep *ep =3D NULL;
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	cxl_rr =3D cxl_rr_load(port, cxlr);
>  	if (!cxl_rr)
> @@ -2142,7 +2100,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  {
>  	struct cxl_region_params *p;
> =20
> -	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	if (!cxled) {
>  		p =3D &cxlr->params;
> @@ -2215,18 +2173,18 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	struct cxl_region *detach;
> =20
>  	/* when the decoder is being destroyed lock unconditionally */
> -	if (mode =3D=3D DETACH_INVALIDATE)
> -		down_write(&cxl_region_rwsem);
> -	else {
> -		int rc =3D down_write_killable(&cxl_region_rwsem);
> +	if (mode =3D=3D DETACH_INVALIDATE) {
> +		guard(rwsem_write)(&cxl_rwsem.region);
> +		detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
> +	} else {
> +		int rc;
> =20
> -		if (rc)
> +		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +		if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  			return rc;
> +		detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
>  	}
> =20
> -	detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
> -	up_write(&cxl_region_rwsem);
> -
>  	if (detach) {
>  		device_release_driver(&detach->dev);
>  		put_device(&detach->dev);
> @@ -2234,29 +2192,35 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	return 0;
>  }
> =20
> +static int __attach_target(struct cxl_region *cxlr,
> +			   struct cxl_endpoint_decoder *cxled, int pos,
> +			   unsigned int state)
> +{
> +	int rc;
> +
> +	if (state =3D=3D TASK_INTERRUPTIBLE) {
> +		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +		if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +			return rc;
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
> +		return cxl_region_attach(cxlr, cxled, pos);
> +	}
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	return cxl_region_attach(cxlr, cxled, pos);
> +}
> +
>  static int attach_target(struct cxl_region *cxlr,
>  			 struct cxl_endpoint_decoder *cxled, int pos,
>  			 unsigned int state)
>  {
> -	int rc =3D 0;
> -
> -	if (state =3D=3D TASK_INTERRUPTIBLE)
> -		rc =3D down_write_killable(&cxl_region_rwsem);
> -	else
> -		down_write(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	down_read(&cxl_dpa_rwsem);
> -	rc =3D cxl_region_attach(cxlr, cxled, pos);
> -	up_read(&cxl_dpa_rwsem);
> -	up_write(&cxl_region_rwsem);
> +	int rc =3D __attach_target(cxlr, cxled, pos, state);
> =20
> -	if (rc)
> -		dev_warn(cxled->cxld.dev.parent,
> -			"failed to attach %s to %s: %d\n",
> -			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> +	if (rc =3D=3D 0)
> +		return 0;
> =20
> +	dev_warn(cxled->cxld.dev.parent, "failed to attach %s to %s: %d\n",
> +		 dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
>  	return rc;
>  }
> =20
> @@ -2516,7 +2480,7 @@ static int cxl_region_perf_attrs_callback(struct no=
tifier_block *nb,
>  		return NOTIFY_DONE;
> =20
>  	/*
> -	 * No need to hold cxl_region_rwsem; region parameters are stable
> +	 * No need to hold cxl_rwsem.region; region parameters are stable
>  	 * within the cxl_region driver.
>  	 */
>  	region_nid =3D phys_to_target_node(cxlr->params.res->start);
> @@ -2539,7 +2503,7 @@ static int cxl_region_calculate_adistance(struct no=
tifier_block *nb,
>  	int region_nid;
> =20
>  	/*
> -	 * No need to hold cxl_region_rwsem; region parameters are stable
> +	 * No need to hold cxl_rwsem.region; region parameters are stable
>  	 * within the cxl_region driver.
>  	 */
>  	region_nid =3D phys_to_target_node(cxlr->params.res->start);
> @@ -2688,17 +2652,13 @@ static ssize_t region_show(struct device *dev, st=
ruct device_attribute *attr,
>  	struct cxl_decoder *cxld =3D to_cxl_decoder(dev);
>  	ssize_t rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> =20
>  	if (cxld->region)
> -		rc =3D sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
> -	else
> -		rc =3D sysfs_emit(buf, "\n");
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
> +	return sysfs_emit(buf, "\n");
>  }
>  DEVICE_ATTR_RO(region);
> =20
> @@ -3037,7 +2997,7 @@ static int cxl_pmem_region_alloc(struct cxl_region =
*cxlr)
>  	struct device *dev;
>  	int i;
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	if (p->state !=3D CXL_CONFIG_COMMIT)
>  		return -ENXIO;
> =20
> @@ -3049,7 +3009,7 @@ static int cxl_pmem_region_alloc(struct cxl_region =
*cxlr)
>  	cxlr_pmem->hpa_range.start =3D p->res->start;
>  	cxlr_pmem->hpa_range.end =3D p->res->end;
> =20
> -	/* Snapshot the region configuration underneath the cxl_region_rwsem */
> +	/* Snapshot the region configuration underneath the cxl_rwsem.region */
>  	cxlr_pmem->nr_mappings =3D p->nr_targets;
>  	for (i =3D 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> @@ -3126,7 +3086,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(=
struct cxl_region *cxlr)
>  	struct cxl_dax_region *cxlr_dax;
>  	struct device *dev;
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	if (p->state !=3D CXL_CONFIG_COMMIT)
>  		return ERR_PTR(-ENXIO);
> =20
> @@ -3326,7 +3286,7 @@ static int match_region_by_range(struct device *dev=
, const void *data)
>  	cxlr =3D to_cxl_region(dev);
>  	p =3D &cxlr->params;
> =20
> -	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_rwsem.region);
>  	if (p->res && p->res->start =3D=3D r->start && p->res->end =3D=3D r->en=
d)
>  		return 1;
> =20
> @@ -3386,7 +3346,7 @@ static int __construct_region(struct cxl_region *cx=
lr,
>  	struct resource *res;
>  	int rc;
> =20
> -	guard(rwsem_write)(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.region);
>  	p =3D &cxlr->params;
>  	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> @@ -3522,10 +3482,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder=
 *cxled)
> =20
>  	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> =20
> -	down_read(&cxl_region_rwsem);
> -	p =3D &cxlr->params;
> -	attach =3D p->state =3D=3D CXL_CONFIG_COMMIT;
> -	up_read(&cxl_region_rwsem);
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		p =3D &cxlr->params;
> +		attach =3D p->state =3D=3D CXL_CONFIG_COMMIT;
> +	}
> =20
>  	if (attach) {
>  		/*
> @@ -3550,7 +3510,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *e=
ndpoint, u64 spa)
>  	if (!endpoint)
>  		return ~0ULL;
> =20
> -	guard(rwsem_write)(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_rwsem.region);
> =20
>  	xa_for_each(&endpoint->regions, index, iter) {
>  		struct cxl_region_params *p =3D &iter->region->params;
> @@ -3592,30 +3552,23 @@ static int cxl_region_can_probe(struct cxl_region=
 *cxlr)
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int rc;
> =20
> -	rc =3D down_read_interruptible(&cxl_region_rwsem);
> -	if (rc) {
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &rwsem))) {
>  		dev_dbg(&cxlr->dev, "probe interrupted\n");
>  		return rc;
>  	}
> =20
>  	if (p->state < CXL_CONFIG_COMMIT) {
>  		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
> -		rc =3D -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
> =20
>  	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
>  		dev_err(&cxlr->dev,
>  			"failed to activate, re-commit region and retry\n");
> -		rc =3D -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
> =20
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	if (rc)
> -		return rc;
>  	return 0;
>  }
> =20
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..50799a681231 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -469,7 +469,7 @@ enum cxl_config_state {
>   * @nr_targets: number of targets
>   * @cache_size: extended linear cache size if exists, otherwise zero.
>   *
> - * State transitions are protected by the cxl_region_rwsem
> + * State transitions are protected by cxl_rwsem.region
>   */
>  struct cxl_region_params {
>  	enum cxl_config_state state;
> @@ -912,15 +912,4 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_=
port *port);
>  #endif
> =20
>  u16 cxl_gpf_get_dvsec(struct device *dev);
> -
> -static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_sem=
aphore *rwsem)
> -{
> -	if (down_read_interruptible(rwsem))
> -		return NULL;
> -
> -	return rwsem;
> -}
> -
> -DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_=
T))
> -
>  #endif /* __CXL_H__ */
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index c810deb88d13..cbafdc12e743 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -244,6 +244,7 @@ DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interr=
uptible(_T), _RET =3D=3D 0)
> =20
>  DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_writ=
e(_T))
>  DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
> +DEFINE_GUARD_COND(rwsem_write, _kill, down_write_killable(_T), _RET =3D=
=3D 0)
> =20
>  /*
>   * downgrade write lock to read lock
> --=20
> 2.50.0
>=20
>=20
>=20




