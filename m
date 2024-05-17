Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF850255;
	Fri, 17 May 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951778; cv=none; b=Gvp+OplCc9EEKixuf75cK3T7lCLYJIPEJoEs29XbJoIu6rkAmYG9X5p2A6y7e25G9KLXD7ujWN05jfLTlQ6L/G/hSs5NRZRrq5z78nIFAtfnFOT2a4V1getc+ghMH6jPC4RXq6zOeBrq5c5rwbaiJ33c5BGlKiKtgEHNf014x68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951778; c=relaxed/simple;
	bh=oLw1U/bIncficobO2SIQU+Ct9tJgm5fGqsxduffjJ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHMGXysjeGq6j4T9sCEGAsK+MLzJf+jAKH1Tzzvn0ze32dZxznNP/M2IrP3HHYTOLw/IW3IANskR6OrUuVpW62k8Ox1GQrwhtms/Vphz6/spShx8bCZ5x09TmYepHATRq2P15PGzYznoJDZO0+PEMsFnSMemvxFlwTOqLEiN+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z50XfUii; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z50XfUii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715951776; x=1747487776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLw1U/bIncficobO2SIQU+Ct9tJgm5fGqsxduffjJ3E=;
  b=Z50XfUii+PU5EAAQfBpMCYhT74qxRHGOLq4OhpdFYqbVw7zgu2fUCDvz
   faJuX8YHDMEpJ5GH3nosWgTTPkyUn9dgHOAYv8NnNOnAqqe9UOVmf+oza
   qLbRCQFin4Smfvkcjg6psYTOOP7WGx84WZWHP3hLdNCmaz7+VBGxu/zaX
   vwGkZoSMgdpXugcTO6tMfzi/04qmig5PwevmXiqkU+zC6Lq3LjXnN1UOF
   IlGsmU9banVhRjOrJ4OygVXmLutooiQMZ28S95bNP3OcdWf8CveMSF3sl
   oRnNi06tmPlykjP55wClMa/zSYlVCV05tcmyLUu4R0zKSPq1AHhk2YckC
   A==;
X-CSE-ConnectionGUID: NnFLlKM0QCS8m03NtA/O8g==
X-CSE-MsgGUID: h3sMD/ZlR0Kv614QLk7FhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11968770"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11968770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:16:15 -0700
X-CSE-ConnectionGUID: THVLFMVEQ++8soNt9bp++Q==
X-CSE-MsgGUID: qVMG0JPBSfKXyIyzr1ohhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31803043"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.21])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:16:12 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Fri, 17 May 2024 15:16:09 +0200
Message-ID: <13630976.tdPhlSkOF2@fdefranc-mobl3>
In-Reply-To: <6646a835ac144_2c26294da@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
 <6646a835ac144_2c26294da@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, May 17, 2024 2:43:33=E2=80=AFAM GMT+2 Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > cxl_event_common was a poor naming choice and caused confusion with the
> > existing Common Event Record.
>=20
> I would say "unfortunate" rather than "poor".
>

Agreed.
=20
> > Use cxl_event_media as a common structure to record information about D=
RAM
> > and General Media events because it simplifies handling the two events.
> >=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and
> > cxl_dram events")
> What is the fix? There is no user visible behavior changes that results f=
rom
> this cleanup, right?

Right.
=20
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.m.de.francesco@linux.intel.com>
> > ---
> >=20
> > Changes for v2:
> > 	- Extend the commit message (Alison);
> > 	- Add a "Fixes" tag (Alison, thanks).
> > =09
> >  drivers/cxl/core/mbox.c      |  6 ++--
> >  drivers/cxl/core/trace.h     |  4 +--
> >  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
> >  tools/testing/cxl/test/mem.c |  4 +--
> >  4 files changed, 36 insertions(+), 48 deletions(-)
>=20
> Oh, nice, net reduction in code I was not expecting.
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
>=20
> I was hoping at the end of this to get rid of the word "common" to avoid =
any
> more "common event record confusion".

Right, still an unfortunate naming choice.=20

> > [...]
>=20
> Oh nice you went for the full 'struct_group_tagged' proposal. However, gi=
ven
> that Jonathan is already asking questions about "__packed", lets do the
> simpler change, something like this, what do you think?=20

I think that these simpler changes are better.=20

> This also preserves
> type-safety.
>=20
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..f48b59943977 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -33,14 +33,16 @@ struct cxl_event_generic {
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE 0x10
>  struct cxl_event_gen_media {
> -       struct cxl_event_record_hdr hdr;
> -       __le64 phys_addr;
> -       u8 descriptor;
> -       u8 type;
> -       u8 transaction_type;
> -       u8 validity_flags[2];
> -       u8 channel;
> -       u8 rank;
> +       struct cxl_event_media_hdr {
> +               struct cxl_event_record_hdr hdr;
> +               __le64 phys_addr;
> +               u8 descriptor;
> +               u8 type;
> +               u8 transaction_type;
> +               u8 validity_flags[2];
> +               u8 channel;
> +               u8 rank;
> +       } hdr;
>         u8 device[3];
>         u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
>         u8 reserved[46];
> @@ -52,14 +54,7 @@ struct cxl_event_gen_media {
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE     0x20
>  struct cxl_event_dram {
> -       struct cxl_event_record_hdr hdr;
> -       __le64 phys_addr;
> -       u8 descriptor;
> -       u8 type;
> -       u8 transaction_type;
> -       u8 validity_flags[2];
> -       u8 channel;
> -       u8 rank;
> +       struct cxl_event_media_hdr hdr;
>         u8 nibble_mask[3];
>         u8 bank_group;
>         u8 bank;
> @@ -109,7 +104,7 @@ union cxl_event {
>         struct cxl_event_gen_media gen_media;
>         struct cxl_event_dram dram;
>         struct cxl_event_mem_module mem_module;
> -       struct cxl_event_common common;
> +       struct cxl_event_media_hdr media_hdr;
>  } __packed;
>=20
>  /*

I'll make v3 according to the suggestion showed above.

Thanks,

=46abio



