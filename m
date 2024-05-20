Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178913398E;
	Mon, 20 May 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227726; cv=none; b=RgfhEVfn4lBdOJU3EaLKZ/w7tiEe/8vEJpsxaIGZe3tS6+cQFmQQjy1O3C9+LswWsNR3SFhT73UKyacOzWX9I5+gCiPhVqoe2+gFzFYVqo87HpHIJv5r0t51Pw4/hvAE95b9TTYOeXpZTkhGPtzhmJ6EX6+ClvAlxzg6LlMdaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227726; c=relaxed/simple;
	bh=dzIx0OC26E5dApNJ0s1+EMiQ0pn0lx5sKEcZY24+oKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2BJ3tJ5Q1ar+TJydTeTqwQkqOIvFiSlRQXndXbOcLCbd1aNoKLcLkD2Py8E1AoP9Sf0IJeQ02foa/UHOdVoZrRMNRBfdbdKcKGhmFbCvCl6cfoLhtCvz238rXHHgaZD4/lg40DjN7JqXcf4a7e9q21dd3QEgXWYpbwhVTdqgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rr02vDPC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rr02vDPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716227725; x=1747763725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzIx0OC26E5dApNJ0s1+EMiQ0pn0lx5sKEcZY24+oKQ=;
  b=Rr02vDPCHwjl/qjEEWe/wJWnkeDsB+LSYkN2eDOdIb7Ov4ikw7/MG3c9
   pXBFMg7GW1Jwh5Mg4zDkDSElyJ6xDVEFk4VD0wVoOolEAHO1kE5VFrmrz
   ckRRyioNV+f9FBTe3As3yOR7uQWUCfmxmzkP51GurRjjYcQVdqUtU9v+t
   Yfh9ggn6EjML/To5aU/cOTGU1JBmfW0WqM7yb1E4fuBOvEd0BWSb9H3LZ
   s2xkEawCsNNz39IbpBAZPmtmgk0mG9H3gBg7kj+W9Iq1zC3WzQj5Hb9gX
   yLKjqaUZHw4gNa/jpZp2kGn5j24T9MSaCaB9nampkZSnANpkjelIT5WPl
   w==;
X-CSE-ConnectionGUID: 6lJuRs9DQdmh7gpLHwN0MA==
X-CSE-MsgGUID: kplNK1YNSs+S3+3f1hLQpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12248092"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12248092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:55:23 -0700
X-CSE-ConnectionGUID: p7ex7YgvS66k9CZqocFvxA==
X-CSE-MsgGUID: VrcCacuEQV63JrUoa4EFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32605467"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.122])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:55:21 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject:
 Re: [PATCH v3] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Mon, 20 May 2024 19:55:17 +0200
Message-ID: <4446774.UPlyArG6xL@fdefranc-mobl3>
In-Reply-To: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
References: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, May 18, 2024 1:26:21=E2=80=AFPM GMT+2 Fabio M. De Francesco wr=
ote:
> cxl_event_common was an unfortunate naming choice and caused confusion wi=
th
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
>=20
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
>=20
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.co=
m>
> ---
>=20
> [...]
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	struct cxl_event_media_hdr media_hdr;
>  } __packed;

Today I was thinking about a comment from Ira. He didn't like the addition =
of=20
an event that is not in the specs.[0] (Notice that the other issues have be=
en=20
already addressed).=20

I dislike the addition of an artificial event for the very same reasons Ira=
=20
expressed.

This additional event could be easily removed by something simple like the=
=20
following diff.

=46abio

[0] https://lore.kernel.org/linux-cxl/66467b8b47170_8c79294b3@iweiny-mobl.n=
otmuch/

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a08f050cc1ca..05de8836adea 100644
=2D-- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -875,7 +875,13 @@ void cxl_event_trace_record(const struct cxl_memdev=20
*cxlmd,
                guard(rwsem_read)(&cxl_region_rwsem);
                guard(rwsem_read)(&cxl_dpa_rwsem);
=20
=2D               dpa =3D le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_M=
ASK;
+               if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
+                       dpa =3D le64_to_cpu(evt->gen_media.media_hdr.phys_a=
ddr)
+                             & CXL_DPA_MASK;
+               else if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
+                       dpa =3D le64_to_cpu(evt->dram.media_hdr.phys_addr)
+                             & CXL_DPA_MASK;
+
                cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
                if (cxlr)
                        hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 6562663a036d..f0a5be131e6a 100644
=2D-- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -97,7 +97,6 @@ union cxl_event {
        struct cxl_event_gen_media gen_media;
        struct cxl_event_dram dram;
        struct cxl_event_mem_module mem_module;
=2D       struct cxl_event_media_hdr media_hdr;
 } __packed;
=20
 /*



