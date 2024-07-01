Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56384D12
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826946; cv=none; b=PkJAxqDH5QbIvE+cCjKDnD7F4V9CXkr3raWm4nAPROu5A8mAORyug25vc4Az3AEY6g0523u0DaeZ2e9DBfNz5Ppcnb/616t/bzylW1pqztnejY7n7Rmfm0G16oWeSrrhtAzwAnbuJBqa7vP2x9xvn9+A0XEPykc2ZBuzrAZa3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826946; c=relaxed/simple;
	bh=e2zM2QpYmdq4o2U1VvxR4ZpbhZ9v3nHwxRqhYdFvvFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnYkTAjUNbdGahSIgPyF4ut1LohSTvRdYLUdg+QDCVb/P5imyxgxLYR004qwf0JDHAx5mVFaDtgoRJ/XQYRJcQAVTuDgU5IjejmiVtuYKsRwNZFCdJLODKaRsKhMsDre2karLK4f3XNaBP3fB8IKc/Dlyk2K8S2n80viTj9ACIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuShXmiJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuShXmiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719826945; x=1751362945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2zM2QpYmdq4o2U1VvxR4ZpbhZ9v3nHwxRqhYdFvvFI=;
  b=YuShXmiJROmx3GZfA9MO5Wc/CYQ0DszNiwSiXRlF5OW6arII1qSqdqow
   xKnuAxOyw4zp/a/nsLAv2kux5VMbomAMEZbZT3beyXz0c2geeQiwTIPHD
   /hRN8vskglQtkxcvuGIzkJ1+nP/jgv7SznIF0PtbM2AuT/8/WTAxCLzpn
   t9K+wcOVjR7wW2HMXCkD8cABwg5lFw43NrGOEoVMHWqb02AtdIPex2ZHV
   PIkJ1ZGqCY81+WGBbUA5A4EqAKWPHH5jlkd0v698LjAaM9EkhqZnDZbUh
   8DOIzD3NLHkc69wajQrVpQN2cWjhFvrpajmxNCxq5pPPRriYwKYEd8YGg
   A==;
X-CSE-ConnectionGUID: xdH8fdR+SEyvKxYVqBxBig==
X-CSE-MsgGUID: 24THU6PTR7OPQIWcWpm1LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17081422"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="17081422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:42:24 -0700
X-CSE-ConnectionGUID: 1mExbMcDT/m3lqhjrcbiPA==
X-CSE-MsgGUID: 1ntBeWfMRYey0+v158BQIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45363618"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:42:21 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org,
 Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Subject:
 Re: [PATCH v3 2/4] cxl: Restore XOR'd position bits during address
 translation
Date: Mon, 01 Jul 2024 11:42:18 +0200
Message-ID: <9723852.eNJFYEL58v@fdefranc-mobl3>
In-Reply-To: <3568032.dWV9SEqChM@fdefranc-mobl3>
References:
 <cover.1719275633.git.alison.schofield@intel.com>
 <e36eabffe2c2e1a7611cf8ba9ba8bee435bceb1c.1719275633.git.alison.schofield@intel.com>
 <3568032.dWV9SEqChM@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, July 1, 2024 11:28:24=E2=80=AFAM GMT+2 Fabio M. De Francesco wro=
te:
> On Tuesday, June 25, 2024 2:55:53=E2=80=AFAM GMT+2 alison.schofield@intel=
=2Ecom wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >=20
>=20
> Hi Alison,
>=20
> Below I have two questions...=20
>=20
> > When a device reports a DPA in events like poison, general_media,
> > and dram, the driver translates that DPA back to an HPA. Presently,
> > the CXL driver translation only considers the Modulo position and
> > will report the wrong HPA for XOR configured root decoders.
> >=20
> > Add a helper function that restores the XOR'd bits during DPA->HPA
> > address translation. Plumb a root decoder callback to the new helper
> > when XOR interleave arithmetic is in use. For Modulo arithmetic, just
> > let the callback be NULL - as in no extra work required.
> >=20
> > Upon completion of a DPA->HPA translation a couple of checks are
> > performed on the result. One simply confirms that the calculated
> > HPA is within the address range of the region. That test is useful
> > for both Modulo and XOR interleave arithmetic decodes.
> >=20
> > A second check confirms that the HPA is within an expected chunk
> > based on the endpoints position in the region and the region
> > granularity. An XOR decode disrupts the Modulo pattern making the
> > chunk check useless.
> >=20
> > To align the checks with the proper decode, pull the region range
> > check inline and use the helper to do the chunk check for Modulo
> > decodes only.
> >=20
> > A cxl-test unit test of address translations is in upstream review.
>=20
> Would it be helpful to provide a link to the test?
>=20
> > Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
> > ---
> >  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
> >  drivers/cxl/core/port.c   |  5 +++-
> >  drivers/cxl/core/region.c | 22 ++++++++++--------
> >  drivers/cxl/cxl.h         |  6 ++++-
> >  4 files changed, 67 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 571069863c62..010741da0176 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct=20
> cxl_root_decoder *cxlrd, int pos)
> >  	return cxlrd->cxlsd.target[n];
> >  }
> > =20
> > +static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
> > +{
> > +	struct cxl_cxims_data *cximsd =3D cxlrd->platform_data;
> > +	int hbiw =3D cxlrd->cxlsd.nr_targets;
> > +	u64 val;
> > +	int pos;
> > +
> > +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > +	if (hbiw =3D=3D 1 || hbiw =3D=3D 3)
> > +		return hpa;
> > +
> > +	/*
> > +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> > +	 * the position bit to its value before the xormap was applied at
> > +	 * HPA->DPA translation.
> > +	 *
> > +	 * pos is the lowest set bit in an XORMAP
> > +	 * val is the XORALLBITS(HPA & XORMAP)
> > +	 *
> > +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> > +	 * as an operation that outputs a single bit by XORing all the
> > +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> > +	 * hweight64(). If the hamming weight is even the XOR of those
> > +	 * bits results in val=3D=3D0, if odd the XOR result is val=3D=3D1.
> > +	 */
> > +
> > +	for (int i =3D 0; i < cximsd->nr_maps; i++) {
> > +		if (!cximsd->xormaps[i])
> > +			continue;
> > +		pos =3D __ffs(cximsd->xormaps[i]);
> > +		val =3D (hweight64(hpa & cximsd->xormaps[i]) & 1);
> > +		hpa =3D (hpa & ~(1ULL << pos)) | (val << pos);
> > +	}
> > +
> > +	return hpa;
> > +}
> > +
> >  struct cxl_cxims_context {
> >  	struct device *dev;
> >  	struct cxl_root_decoder *cxlrd;
> > @@ -362,6 +399,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws=
=20
> *cfmws,
> >  	struct cxl_cxims_context cxims_ctx;
> >  	struct device *dev =3D ctx->dev;
> >  	cxl_calc_hb_fn cxl_calc_hb;
> > +	cxl_translate_fn translate;
> >  	struct cxl_decoder *cxld;
> >  	unsigned int ways, i, ig;
> >  	int rc;
> > @@ -389,13 +427,17 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfm=
ws=20
> *cfmws,
> >  	if (rc)
> >  		return rc;
> > =20
> > -	if (cfmws->interleave_arithmetic =3D=3D=20
> ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
> > +	if (cfmws->interleave_arithmetic =3D=3D=20
> ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> >  		cxl_calc_hb =3D cxl_hb_modulo;
> > -	else
> > +		translate =3D NULL;
> > +
> > +	} else {
> >  		cxl_calc_hb =3D cxl_hb_xor;
> > +		translate =3D cxl_xor_translate;
> > +	}
> > =20
> >  	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =3D
> > -		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> > +		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb,=20
> translate);
> >  	if (IS_ERR(cxlrd))
> >  		return PTR_ERR(cxlrd);
> > =20
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 887ed6e358fb..e5d5f7783857 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1808,6 +1808,7 @@ static int cxl_switch_decoder_init(struct cxl_por=
t=20
> *port,
> >   * @port: owning CXL root of this decoder
> >   * @nr_targets: static number of downstream targets
> >   * @calc_hb: which host bridge covers the n'th position by granularity
> > + * @translate: decoder specific address translation function
> >   *
> >   * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
> >   * 'CXL root' decoder is one that decodes from a top-level / static=20
> platform
> > @@ -1816,7 +1817,8 @@ static int cxl_switch_decoder_init(struct cxl_por=
t=20
> *port,
> >   */
> >  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> >  						unsigned=20
> int nr_targets,
> > -					=09
> cxl_calc_hb_fn calc_hb)
> > +					=09
> cxl_calc_hb_fn calc_hb,
> > +					=09
> cxl_translate_fn translate)
> >  {
> >  	struct cxl_root_decoder *cxlrd;
> >  	struct cxl_switch_decoder *cxlsd;
> > @@ -1839,6 +1841,7 @@ struct cxl_root_decoder=20
*cxl_root_decoder_alloc(struct=20
> cxl_port *port,
> >  	}
> > =20
> >  	cxlrd->calc_hb =3D calc_hb;
> > +	cxlrd->translate =3D translate;
> >  	mutex_init(&cxlrd->range_lock);
> > =20
> >  	cxld =3D &cxlsd->cxld;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 237c28d5f2cc..bdb06dbe98a8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2723,20 +2723,13 @@ struct cxl_region *cxl_dpa_to_region(const stru=
ct=20
> cxl_memdev *cxlmd, u64 dpa)
> >  	return ctx.cxlr;
> >  }
> > =20
> > -static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int=
=20
pos)
> > +static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int=
=20
pos)
> >  {
> >  	struct cxl_region_params *p =3D &cxlr->params;
> >  	int gran =3D p->interleave_granularity;
> >  	int ways =3D p->interleave_ways;
> >  	u64 offset;
> > =20
> > -	/* Is the hpa within this region at all */
> > -	if (hpa < p->res->start || hpa > p->res->end) {
> > -		dev_dbg(&cxlr->dev,
> > -			"Addr trans fail: hpa 0x%llx not in=20
> region\n", hpa);
> > -		return false;
> > -	}
> > -
> >  	/* Is the hpa in an expected chunk for its pos(-ition) */
> >  	offset =3D hpa - p->res->start;
> >  	offset =3D do_div(offset, gran * ways);
> > @@ -2752,6 +2745,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct=20
> cxl_region *cxlr, int pos)
> >  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev=20
*cxlmd,
> >  		   u64 dpa)
> >  {
> > +	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(cxlr-
> >dev.parent);
> >  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> >  	struct cxl_region_params *p =3D &cxlr->params;
> >  	struct cxl_endpoint_decoder *cxled =3D NULL;
> > @@ -2801,7 +2795,17 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, cons=
t=20
> struct cxl_memdev *cxlmd,
> >  	/* Apply the hpa_offset to the region base address */
> >  	hpa =3D hpa_offset + p->res->start;
> > =20
> > -	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> > +	/* Root decoder translation overrides typical modulo decode */
> > +	if (cxlrd->translate)
> > +		hpa =3D cxlrd->translate(cxlrd, hpa);
> > +
> > +	if (hpa < p->res->start || hpa > p->res->end) {
> > +		dev_dbg(&cxlr->dev,
> > +			"Addr trans fail: hpa 0x%llx not in=20
> region\n", hpa);
> > +		return ULLONG_MAX;
> > +	}
> > +
> > +	if (!cxlrd->translate && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
> >  		return ULLONG_MAX;
>=20
> I needed some time to understand this. It was not immediately clear why, =
for=20
> XOR translations, this chunk check is skipped.

Sorry, I wanted to say for "no translations" (i.e., for !cxlrd->translate) =
but=20
with copy-paste something went wrong.

=46abio

>=20
> Wouldn't it be helpful to add a comment to explain why that check is=20
skipped?
>=20
> Thanks,
>=20
> Fabio
>=20
> >=20
> >  	return hpa;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 603c0120cff8..3678235fc9ce 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -434,12 +434,14 @@ struct cxl_switch_decoder {
> >  struct cxl_root_decoder;
> >  typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder=20
*cxlrd,
> >  					    int pos);
> > +typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hp=
a);
> > =20
> >  /**
> >   * struct cxl_root_decoder - Static platform CXL address decoder
> >   * @res: host / parent resource for region allocations
> >   * @region_id: region id for next region provisioning event
> >   * @calc_hb: which host bridge covers the n'th position by granularity
> > + * @translate: decoder specific address translation function
> >   * @platform_data: platform specific configuration data
> >   * @range_lock: sync region autodiscovery by address range
> >   * @qos_class: QoS performance class cookie
> > @@ -449,6 +451,7 @@ struct cxl_root_decoder {
> >  	struct resource *res;
> >  	atomic_t region_id;
> >  	cxl_calc_hb_fn calc_hb;
> > +	cxl_translate_fn translate;
> >  	void *platform_data;
> >  	struct mutex range_lock;
> >  	int qos_class;
> > @@ -773,7 +776,8 @@ bool is_switch_decoder(struct device *dev);
> >  bool is_endpoint_decoder(struct device *dev);
> >  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> >  						unsigned=20
> int nr_targets,
> > -					=09
> cxl_calc_hb_fn calc_hb);
> > +					=09
> cxl_calc_hb_fn calc_hb,
> > +					=09
> cxl_translate_fn translate);
> >  struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int po=
s);
> >  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port=20
*port,
> >  						   =20
> unsigned int nr_targets);
> >=20
>=20
>=20




