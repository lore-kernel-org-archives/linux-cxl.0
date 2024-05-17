Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05224F1E4;
	Fri, 17 May 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951231; cv=none; b=LgfnG3sRFA6m+l795XzNl16Djq7nGnbl+K0ekzwHHxFeNqmsnVMe2l3wpPSVwZQWqWR5bssZTYxT62IpFjIub/GjCNeLQmf1sxe7mgByswCQlg9qMUanbjOCasCcKzs2xHkRJRhazFRZOe2q2Wo7zMiBouuuhD5LDyWARzlSjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951231; c=relaxed/simple;
	bh=E8NIBmhuXkQWY9tdw0NTb9s7Ylgh7bn9fuNNOGVJNic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSQ/xjI/yZETQFG1N8V8r24v/ADgHFDpir9zWIyeaz7jrOxjVeYPod2OqegwuK1z0togVsimBbzEJeZUtF+UUNYgUMrhld8ww8E+BKh0Czd6Lyuq/jCRkv6fyno/MJX9R509UTPPM9oxRszGzsq2juYNVJOn+V49WhEEwoc2f5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlU2OuBo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlU2OuBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715951230; x=1747487230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8NIBmhuXkQWY9tdw0NTb9s7Ylgh7bn9fuNNOGVJNic=;
  b=KlU2OuBouO9TmBila2MRLVTaNBVPuDvos4Mp5tvCUGkEGB0Qi2+wfoQx
   Zx0aFmYmUZrhE8a08MzNsdo44p0SeutP8sqNmb3cfKlCZdWKbvjvj33z5
   QMfjCwuNtOOZomrIlhgLUH9cvGgqJ5q3toNQbG0pSGkQm4w+Ag/onvKbP
   X+6aiOaFeBi2ZEXk6ip49FcfLyykrR9+Suwzvr2gsUUrXrvg3RjffC08y
   s2YZDZBbcI+4hHE8TodaAR8wqqr6FV75l2QU/Pup9T5wJpdVH8a2P39dc
   Q0JsA8lWUpEpb+adg8389IIrsf+ZEKns89iGjVh2ovg78dm1xIr9tpzU5
   Q==;
X-CSE-ConnectionGUID: 5S/0eS+VRjOBj7mNU0lCLQ==
X-CSE-MsgGUID: Yp+zmC1uRUqbpl0Fl4hsig==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23527149"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="23527149"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:07:09 -0700
X-CSE-ConnectionGUID: xtTZ3099SYu2icluC7wbcg==
X-CSE-MsgGUID: X+CWfPMdS3S1PjrlrEneAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="32333302"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.21])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:07:06 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] cxl/events: Use a common struct for DRAM and General Media events
Date: Fri, 17 May 2024 15:07:02 +0200
Message-ID: <5789047.t9SDvczpPo@fdefranc-mobl3>
In-Reply-To: <66467b8b47170_8c79294b3@iweiny-mobl.notmuch>
References:
 <20240515190512.3480817-1-fabio.m.de.francesco@linux.intel.com>
 <66467b8b47170_8c79294b3@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, May 16, 2024 11:32:59=E2=80=AFPM GMT+2 Ira Weiny wrote:
> Fabio M. De Francesco wrote:
> > Use cxl_event_media as a common structure to record information about D=
RAM
> > and General Media events because it simplifies handling the two events.
> >=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.m.de.francesco@linux.intel.com>
> > ---
> >=20
> >  drivers/cxl/core/mbox.c      |  6 ++--
> >  drivers/cxl/core/trace.h     |  4 +--
> >  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
> >  tools/testing/cxl/test/mem.c |  4 +--
> >  4 files changed, 36 insertions(+), 48 deletions(-)
>=20
> Other than saving 12 lines of code what are we saving with this change?
>
> The addition of media_common implies an additional event type which is not
> in the specification.  (perhaps confusing future contributors?)  And the
> code is more complex to follow.  The decode of the phys_addr field is not
> simplified (which IIRC was the point of this idea.)
>
> I'm probably being dense but I just don't see the need for the
> struct_group complexity here.
>=20
> Ira

Ira,

I think you are right, there is no need for struct_group here and this code=
 is=20
unnecessarily complex.

Anyway, for the next version, I'll use the simpler solution showed by Dan i=
n=20
his comment on v2.

Thanks,

=46abio
=20
>=20
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2626f3fff201..ad4d7b0f7f4d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memd=
ev
> > *cxlmd,>=20
> >  		guard(rwsem_read)(&cxl_region_rwsem);
> >  		guard(rwsem_read)(&cxl_dpa_rwsem);
> >=20
> > -		dpa =3D le64_to_cpu(evt->common.phys_addr) &=20
CXL_DPA_MASK;
> > +		dpa =3D le64_to_cpu(evt->media_common.phys_addr) &=20
CXL_DPA_MASK;
> >=20
> >  		cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
> >  		if (cxlr)
> >  	=09
> >  			hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> >  	=09
> >  		if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
> >  	=09
> >  			trace_cxl_general_media(cxlmd, type, cxlr,=20
hpa,
> >=20
> > -						&evt-
>gen_media);
> > +						&evt-
>media_general);
> >=20
> >  		else if (event_type =3D=3D CXL_CPER_EVENT_DRAM)
> >=20
> > -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt-
>dram);
> > +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt-
>media_dram);
> >=20
> >  	}
> > =20
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> >=20
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 07a0394b1d99..2c7293761bb2 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
> >=20
> >  TRACE_EVENT(cxl_general_media,
> > =20
> >  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type=20
log,
> >=20
> > -		 struct cxl_region *cxlr, u64 hpa, struct=20
cxl_event_gen_media *rec),
> > +		 struct cxl_region *cxlr, u64 hpa, struct=20
cxl_event_media *rec),
> >=20
> >  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
> >=20
> > @@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
> >=20
> >  TRACE_EVENT(cxl_dram,
> > =20
> >  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type=20
log,
> >=20
> > -		 struct cxl_region *cxlr, u64 hpa, struct=20
cxl_event_dram *rec),
> > +		 struct cxl_region *cxlr, u64 hpa, struct=20
cxl_event_media *rec),
> >=20
> >  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
> >=20
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 60b25020281f..e417556cc120 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -32,41 +32,38 @@ struct cxl_event_generic {
> >=20
> >   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> >   */
> > =20
> >  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> >=20
> > -struct cxl_event_gen_media {
> > -	struct cxl_event_record_hdr hdr;
> > -	__le64 phys_addr;
> > -	u8 descriptor;
> > -	u8 type;
> > -	u8 transaction_type;
> > -	u8 validity_flags[2];
> > -	u8 channel;
> > -	u8 rank;
> > -	u8 device[3];
> > -	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> > -	u8 reserved[46];
> > -} __packed;
> > -
> >=20
> >  /*
> > =20
> >   * DRAM Event Record - DER
> >   * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
> >   */
> > =20
> >  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> >=20
> > -struct cxl_event_dram {
> > +struct cxl_event_media {
> >=20
> >  	struct cxl_event_record_hdr hdr;
> >=20
> > -	__le64 phys_addr;
> > -	u8 descriptor;
> > -	u8 type;
> > -	u8 transaction_type;
> > -	u8 validity_flags[2];
> > -	u8 channel;
> > -	u8 rank;
> > -	u8 nibble_mask[3];
> > -	u8 bank_group;
> > -	u8 bank;
> > -	u8 row[3];
> > -	u8 column[2];
> > -	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> > -	u8 reserved[0x17];
> > +	struct_group_tagged(cxl_event_media_hdr, media_hdr,
> > +		__le64 phys_addr;
> > +		u8 descriptor;
> > +		u8 type;
> > +		u8 transaction_type;
> > +		u8 validity_flags[2];
> > +		u8 channel;
> > +		u8 rank;
> > +	);
> > +	union {
> > +		struct_group(general,
> > +			u8 device[3];
> > +			u8=20
component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> > +			u8 gen_reserved[46];
> > +		);
> > +		struct_group(dram,
> > +			u8 nibble_mask[3];
> > +			u8 bank_group;
> > +			u8 bank;
> > +			u8 row[3];
> > +			u8 column[2];
> > +			u8=20
correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> > +			u8 dram_reserved[0x17];
> > +		);
> > +	};
> >=20
> >  } __packed;
> > =20
> >  /*
> >=20
> > @@ -95,21 +92,12 @@ struct cxl_event_mem_module {
> >=20
> >  	u8 reserved[0x3d];
> > =20
> >  } __packed;
> >=20
> > -/*
> > - * General Media or DRAM Event Common Fields
> > - * - provides common access to phys_addr
> > - */
> > -struct cxl_event_common {
> > -	struct cxl_event_record_hdr hdr;
> > -	__le64 phys_addr;
> > -} __packed;
> > -
> >=20
> >  union cxl_event {
> > =20
> >  	struct cxl_event_generic generic;
> >=20
> > -	struct cxl_event_gen_media gen_media;
> > -	struct cxl_event_dram dram;
> > +	struct cxl_event_media media_general;
> > +	struct cxl_event_media media_dram;
> >=20
> >  	struct cxl_event_mem_module mem_module;
> >=20
> > -	struct cxl_event_common common;
> > +	struct cxl_event_media media_common;
> >=20
> >  } __packed;
> > =20
> >  /*
> >=20
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 6584443144de..0a8fd145c391 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -378,7 +378,7 @@ struct cxl_event_record_raw hardware_replace =3D {
> >=20
> >  struct cxl_test_gen_media {
> > =20
> >  	uuid_t id;
> >=20
> > -	struct cxl_event_gen_media rec;
> > +	struct cxl_event_media rec;
> >=20
> >  } __packed;
> > =20
> >  struct cxl_test_gen_media gen_media =3D {
> >=20
> > @@ -402,7 +402,7 @@ struct cxl_test_gen_media gen_media =3D {
> >=20
> >  struct cxl_test_dram {
> > =20
> >  	uuid_t id;
> >=20
> > -	struct cxl_event_dram rec;
> > +	struct cxl_event_media rec;
> >=20
> >  } __packed;
> > =20
> >  struct cxl_test_dram dram =3D {




