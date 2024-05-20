Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F82BB02;
	Mon, 20 May 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245840; cv=none; b=oXKzWladLpHNCTPhWqwOIhvPedbysNrg5d798qpcWaSxsAdjckqHmaWgDs9qj9onz6DyFuTsTeffJ15lchlDsHu2h22ub0rESqX/+cNR4xo08pKNxGMo1wKS75e76lOqK2OPxs3aghHtIrXz1+cWwrLBJajyjGrko9kAQSDR3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245840; c=relaxed/simple;
	bh=hw1CkrVZiWcYewlm4mKxXcEMU+gmLH6V9X14+HZy/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIbMalKxrNZLZR9b0OoQmZ4iCbQVbBU4vUlvEGe6E6iC3SeDnvIWHKutcLG4IYIjR7UdpBA6wtP0aS8Kky+XHnDxcOzDgFYAAQrzbDXpVPg+9uG/ue7cpx1HNLw3dySB0O2POTkaVyqsBF2ZqRA91GJ1ltH948XE26yQvgn+FJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SURuoBz5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SURuoBz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245838; x=1747781838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hw1CkrVZiWcYewlm4mKxXcEMU+gmLH6V9X14+HZy/Tg=;
  b=SURuoBz5saHrNkfILzMv6936FV93p16kgZJ1aYrceRlsJKeEc+aHyVPN
   uo1UwSrIBOeBxV1rJz43zbuRwPY/9SXQ/CKdv2Uua2xfSNvyyTa0v/G0j
   8RwvxBLG3qoNza3bh2pDzyoNgE2MOspneaCnireo73udrPWEiexgT+18t
   sjLdjRs5ObqPx3ISfBsEqIYIea+BLhD5qH6OSpbjwYq+y2eTzq//dxisN
   2pqw90ItSGxLHxHhRTYXKPe7mlC2e78D3dfMfLV3MrLOtJONHJxRQhCss
   hHuJa1m5QFw/Z7D2KrnEpzMp0/vH/OTItgCM0E9JiIIo2p3UPMshaNQ/i
   g==;
X-CSE-ConnectionGUID: Vv4Z91c/SaScjW2E4+bx8Q==
X-CSE-MsgGUID: KrvQ03twSrifqtNvsjHi6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29915599"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="29915599"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:57:18 -0700
X-CSE-ConnectionGUID: RX5/4wY5Qdi779Niwq4Gcg==
X-CSE-MsgGUID: j89SCt2zSkyfPCdlGd4z1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37461387"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.132])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:57:14 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Tue, 21 May 2024 00:57:10 +0200
Message-ID: <2114228.Jadu78ljVU@fdefranc-mobl3>
In-Reply-To: <4446774.UPlyArG6xL@fdefranc-mobl3>
References:
 <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
 <4446774.UPlyArG6xL@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, May 20, 2024 7:55:17=E2=80=AFPM GMT+2 Fabio M. De Francesco wrot=
e:
> On Saturday, May 18, 2024 1:26:21=E2=80=AFPM GMT+2 Fabio M. De Francesco =
wrote:
> [...]
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a08f050cc1ca..05de8836adea 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,7 +875,13 @@ void cxl_event_trace_record(const struct cxl_memdev=
=20
> *cxlmd,
>                 guard(rwsem_read)(&cxl_region_rwsem);
>                 guard(rwsem_read)(&cxl_dpa_rwsem);
> =20
> -               dpa =3D le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_M=
ASK;
> +               if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
> +                       dpa =3D le64_to_cpu(evt-
>gen_media.media_hdr.phys_addr)
> +                             & CXL_DPA_MASK;
> +               else if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
> +                       dpa =3D le64_to_cpu(evt->dram.media_hdr.phys_addr)
> +                             & CXL_DPA_MASK;
> +
>                 cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
>                 if (cxlr)
>                         hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6562663a036d..f0a5be131e6a 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -97,7 +97,6 @@ union cxl_event {
>         struct cxl_event_gen_media gen_media;
>         struct cxl_event_dram dram;
>         struct cxl_event_mem_module mem_module;
> -       struct cxl_event_media_hdr media_hdr;
>  } __packed;
> =20
>  /*
>=20

I suspect that I didn't clarify that the diff above is proposing an additio=
nal=20
little change to this patch (for v4) and that I wanted to collect comments=
=20
before applying and respinning.

To be clearer, that diff is meant only to show that cxl_event_media_hdr can=
 be=20
removed from union cxl_event at no cost while still be used for the common=
=20
fields in the definitions of cxl_event_dram and cxl_event_gen_media.

=46abio





