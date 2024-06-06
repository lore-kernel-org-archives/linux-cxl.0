Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7A13AD25;
	Thu,  6 Jun 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670574; cv=none; b=Aew80mSO3Lw3+zT8V8Tr/BKGzDzd+aXtaE/j3AJzSGT29RxRe+Wp6UD6vAwYBGm6zgzPFHtM/IzBns9Gi/28gxDQaLJTER1PSWRSA8tAIf6rdNE/Ma/z2/eoGcSxPDcwEB5iTzb9EuBdX7+SXLWAMR/q6trKCD1JwgC2rxWjnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670574; c=relaxed/simple;
	bh=gcyhBTjSNVb7wu268JcVK1apAHBGJ38qvCp2uwXmZ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+29GgC9XcWNag/5DIPudznSQmKKZAeMJtOcQt6x6LalCvOcizpKHFJwbuQTg/ZbAJQp61RHUegmauNffBI0Gsqr6Bu+bWYXceVFBUG2+3pibSCZj8YzC/F4DW41xBFdhGUzUZq2w6v0gVfvJsLrsVCqXDEYHy3jPsvw39eTxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krpwgOhL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krpwgOhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717670572; x=1749206572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcyhBTjSNVb7wu268JcVK1apAHBGJ38qvCp2uwXmZ1s=;
  b=krpwgOhLBnipgo5Fnn0y3On4QczWGAiM4fJTUM26P0ut5d49w2q3xQTt
   cfnjpGjsAMWaaqQBMULY2FW1HtgOCT13ZTi50JO338mjMPRPYgO34k5lY
   aW7dLPRaZac/+kBPtT6aAf0ClgUMn8kxkpRm5AZivfzGM0uHA7KCDi2Sx
   DUwAA3ZMKDUMLj4xsfGKBnCjoWDQ4epDjFyi8Fqp2JBGLz7lJSfVPtXK4
   7uKujRZ4kMPRWPcEOuq8MZJBq2HAFCQF43nznDBn7yTYybjVQ8CrTK6/s
   LijaXkN0ew0zvFmgoLniQ4sNpN0a//Y4Oi62y2T5/VvDP23kuuPt7RgJ6
   g==;
X-CSE-ConnectionGUID: HPmJ5SygRcq098tuSA5/Hg==
X-CSE-MsgGUID: jUgR1S1ARtGQpDcTtzCKNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24962861"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="24962861"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:42:51 -0700
X-CSE-ConnectionGUID: E4XLhoBnRnGlO87Bzez5OQ==
X-CSE-MsgGUID: DGZC0NvkQUyZvd7qqdLNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37989265"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.29])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:42:48 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v6] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Thu, 06 Jun 2024 12:42:44 +0200
Message-ID: <4881660.OV4Wx5bFTl@fdefranc-mobl3>
In-Reply-To: <20240605123000.00001e8f@Huawei.com>
References:
 <20240602191238.27712-1-fabio.m.de.francesco@linux.intel.com>
 <20240605123000.00001e8f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, June 5, 2024 1:30:00=E2=80=AFPM GMT+2 Jonathan Cameron wrote:
> On Sun,  2 Jun 2024 21:12:25 +0200
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
>=20
> > cxl_event_common was an unfortunate naming choice and caused confusion=
=20
with
> > the existing Common Event Record. Furthermore, its fields didn't map all
> > the common information between DRAM and General Media Events.
> >=20
> > Remove cxl_event_common and introduce cxl_event_media_hdr to record com=
mon
> > information between DRAM and General Media events.
> >=20
> > cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> > cxl_event_dram, leverages the commonalities between the two events to
> > simplify their respective handling.
> >=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >=20
> > - Changes for v6 -
> >=20
> > 	- Add "Reviewed-by" tags
> Hi Fabio,

Hi Jonathan,
=20
> Adding tags doesn't need a new version. b4 or however Dave is picking the=
se
> up will gather them up from the v5 posting.

I just read  what you replied in the v5 thread and know that now it makes m=
ore=20
sense.

> My one nervousness about this is the impression it perhaps gives that the=
=20
contents
> of validity flags has the same meaning in both records.
>=20
> Maybe a comment to that effect next to it's definition makes sense?

Yes, sure.=20
I'll add it.

> I think the alternative of not including that or the remaining elements in
> your common structure would be worse.
>=20
> Jonathan
>=20

Thank you,

=46abio

>=20
> >=20
> > - Changes for v5 -
> >=20
> > 	- Rebase on v6.10-rc1
> >=20
> > - Changes for v4 -
> >=20
> >         - Initialise cxl_test_dram and cxl_test_gen_media without=20
> >           unnecessary extra de-references (Dan)
> >         - Add a comment for media_hdr in union cxl_event (Alison)
> >=20
> > - Changes for v3 -
> >=20
> >         - Rework the layout of cxl_event_dram and cxl_event_gen_media to
> >           make a simpler change (Dan)
> >         - Remove a "Fixes" tag (Dan)
> >         - Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
> >         - Rewrite end extend the commit message
> >=20
> > - Link to v4 -
> >=20
> > https://lore.kernel.org/linux-cxl/20240521140750.26035-1-fabio.m.de.fra=
ncesco@linux.intel.com/
> >=20
> >  drivers/cxl/core/mbox.c      |  2 +-
> >  drivers/cxl/core/trace.h     | 32 ++++++++++-----------
> >  include/linux/cxl-event.h    | 41 ++++++++++-----------------
> >  tools/testing/cxl/test/mem.c | 54 +++++++++++++++++++-----------------
> >  4 files changed, 61 insertions(+), 68 deletions(-)
>=20
>=20
>=20
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 60b25020281f..1119d0bbb091 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -21,6 +21,17 @@ struct cxl_event_record_hdr {
> >  	u8 reserved[15];
> >  } __packed;
> > =20
> > +struct cxl_event_media_hdr {
> > +	struct cxl_event_record_hdr hdr;
> > +	__le64 phys_addr;
> > +	u8 descriptor;
> > +	u8 type;
> > +	u8 transaction_type;
> > +	u8 validity_flags[2];
>=20
> Perhaps a comment to say that validity_flags meaning after bit 2
> varies across the different records?
>=20
> > +	u8 channel;
> > +	u8 rank;
> > +} __packed;
> > +
> >  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> >  struct cxl_event_generic {
> >  	struct cxl_event_record_hdr hdr;
> > @@ -33,14 +44,7 @@ struct cxl_event_generic {
> >   */
> >  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> >  struct cxl_event_gen_media {
> > -	struct cxl_event_record_hdr hdr;
> > -	__le64 phys_addr;
> > -	u8 descriptor;
> > -	u8 type;
> > -	u8 transaction_type;
> > -	u8 validity_flags[2];
> > -	u8 channel;
> > -	u8 rank;
> > +	struct cxl_event_media_hdr media_hdr;
> >  	u8 device[3];
> >  	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> >  	u8 reserved[46];
> > @@ -52,14 +56,7 @@ struct cxl_event_gen_media {
> >   */
> >  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> >  struct cxl_event_dram {
> > -	struct cxl_event_record_hdr hdr;
> > -	__le64 phys_addr;
> > -	u8 descriptor;
> > -	u8 type;
> > -	u8 transaction_type;
> > -	u8 validity_flags[2];
> > -	u8 channel;
> > -	u8 rank;
> > +	struct cxl_event_media_hdr media_hdr;
> >  	u8 nibble_mask[3];
> >  	u8 bank_group;
> >  	u8 bank;
> > @@ -95,21 +92,13 @@ struct cxl_event_mem_module {
> >  	u8 reserved[0x3d];
> >  } __packed;
> > =20
> > -/*
> > - * General Media or DRAM Event Common Fields
> > - * - provides common access to phys_addr
> > - */
> > -struct cxl_event_common {
> > -	struct cxl_event_record_hdr hdr;
> > -	__le64 phys_addr;
> > -} __packed;
> > -
> >  union cxl_event {
> >  	struct cxl_event_generic generic;
> >  	struct cxl_event_gen_media gen_media;
> >  	struct cxl_event_dram dram;
> >  	struct cxl_event_mem_module mem_module;
> > -	struct cxl_event_common common;
> > +	/* dram & gen_media event header */
> > +	struct cxl_event_media_hdr media_hdr;
> >  } __packed;
>=20
>=20
>=20
>=20
>=20




