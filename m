Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA11DF59
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187303; cv=none; b=ZDkJStebA149Ht5MyUvIq29szbpJPAN+HRxLO6M+kyX/Qt6kgFZSVK75QWnURicIEh61ykAMX1Y7rhP1o/86oZ8qCczr0/Hx5f3TVWhtIhzXgsOihWMcQv80KPHTVqCD4vVxbwJmlDv9vB9ytAdPB9p3ATVf2toho5aBwfKvIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187303; c=relaxed/simple;
	bh=9nL/rzPn8B0jff5BnDCsxJO32yRNGNu6ySvj/w1r4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPyo4Nqw0+/uVYwmoDbNYNSJcAHbZYhpoz52znpDK6xigI0sKkk0hBNJ9rTAYoYU5txoyCPzEIEHVmR1wEYvsOeMAOstytjhavI/Nt4Cg7g1gj/j2uldcFY01qj6XwJRoqC6gBSpDqQiRdUK45n38zCxf+h2MV1cxNp8SBlxVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8Xz2kkW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8Xz2kkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715187301; x=1746723301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9nL/rzPn8B0jff5BnDCsxJO32yRNGNu6ySvj/w1r4wU=;
  b=I8Xz2kkWDI2I2osyWy804EJxfnwzeJq+W/KMmthDzbTq0JWdz5H7xO/P
   hXi0Y1Y35p/TkUfoAGVqIeDz/X27draoMhfuTgfa5SB28bkE6B9FiV9M+
   teBf3Gf/Kjox7n74caNHgq8Q561ryq9+VR50/zWiuZ22/QzGG1AJiwkUD
   yrI4Sk9grTfQDCOTDzNkjGvDPocgkMuq7/AVEswsgk5n2C5fIUO5Z8pEf
   ZGLVl0AL/OoUfinoK6TVCOdzlViRDj/bp8033BcCv2GIFUoi9hcV2CfsP
   nMYYB1a2LiOQ9QDi/7s3zV4CZ27CkKAHB11dggnF4/egBemrpFb9pxQo4
   Q==;
X-CSE-ConnectionGUID: nhX4rikGQ7+wpT7e+PwDsg==
X-CSE-MsgGUID: Q23nor2IQUqFZlfSCG4zyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11003069"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11003069"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 09:55:01 -0700
X-CSE-ConnectionGUID: L7Z0cZRFRmiohvfp5VIhxQ==
X-CSE-MsgGUID: W7W1H182Q0+79L0F9mDpSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59816322"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.242.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 09:55:00 -0700
Date: Wed, 8 May 2024 09:54:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [PATCH v6 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <ZjuuFX81dlAaRn4c@aschofie-mobl2>
References: <cover.1714496730.git.alison.schofield@intel.com>
 <dd8d708b7a7ebfb64a27020a5eb338091336b34d.1714496730.git.alison.schofield@intel.com>
 <66352769c2394_1aefb29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66352769c2394_1aefb29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, May 03, 2024 at 11:05:29AM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may need to know which region, if any, maps the DPAs
> > (device physical addresses) reported in a cxl_general_media or
> > cxl_dram event. Since the mapping can change, the kernel provides
> > this information at the time the event occurs. This informs user
> > space that at event <timestamp> this <region> mapped this <DPA>
> > to this <HPA>.
> > 
> > Add the same region info that is included in the cxl_poison trace
> > event: the DPA->HPA translation, region name, and region uuid.
> > 
> > The new fields are inserted in the trace event and no existing
> > fields are modified. If the DPA is not mapped, user will see:
> > hpa=ULLONG_MAX, region="", and uuid=0
> > 
> > This work must be protected by dpa_rwsem & region_rwsem since
> > it is looking up region mappings.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> [..]
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 03fa6d50d46f..5342755777cc 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
> >  	u8 reserved[0x3d];
> >  } __packed;
> >  
> > +/*
> > + * General Media or DRAM Event Common Fields
> > + * - provides common access to phys_addr
> > + */
> > +struct cxl_event_common {
> > +	struct cxl_event_record_hdr hdr;
> > +	__le64 phys_addr;
> > +} __packed;
> > +
> >  union cxl_event {
> >  	struct cxl_event_generic generic;
> >  	struct cxl_event_gen_media gen_media;
> >  	struct cxl_event_dram dram;
> >  	struct cxl_event_mem_module mem_module;
> > +	struct cxl_event_common common;
> 
> I think we should rename this. As I was doing one last once-over my
> brain went "wait, there's no physical address in the Common Event
> Record".
> 
> So at a minimum call this "media_hdr" to match the style of
> cxl_event_record_hdr.
> 
> Now I say "minimum" because 'struct cxl_event_gen_media' and 'struct
> cxl_event_dram' should be including that struct in their definition to
> make it impossible that they have different definitions. I.e. I am not a
> fan of creating a new 'struct cxl_event_media_hdr' that is only consumed
> by 'union cxl_event'.
> 
> The "maximum" would be to combine these definitions into one common
> flexible format to maximize shared definitions, something like the
> below, but the thrash it would cause is probably on the same order as
> just adding a 'struct cxl_event_media_hdr media_hdr' member to existing
> 'struct cxl_event_gen_media' and 'struct cxl_event_dram', fixup all the
> users and call it a day,

I've added this to my queue to fixup. 
Thanks for the review.

-- Alison

> 
> struct cxl_event_media {
>         struct cxl_event_record_hdr hdr;
>         struct_group_tagged(cxl_event_media_hdr, media_hdr,
>                 __le64 phys_addr,
>                 u8 descriptor,
>                 u8 type,
>                 u8 transaction_type,
>                 u8 validity_flags[2],
>                 u8 channel,
>                 u8 rank,
>         };
>         union { 
>                 struct_group(general,
>                         u8 device[3],
>                         u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE],
>                         u8 gen_reserved[46],
>                 );
>                 struct_group(media,
>                         u8 nibble_mask[3],
>                         u8 bank_group,
>                         u8 bank,
>                         u8 row[3],
>                         u8 column[2],
>                         u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE],
>                         u8 dram_reserved[0x17],
>                 );
>         };
> } __packed;
