Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6A2C69C;
	Fri, 17 May 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940533; cv=none; b=lG/3f37AsMJQUbl5o+PeDa6Dot/uQ42K3/bFH6XQ2ANwF37/ska9BC8/ZZzCVu2lUC6Lfq+4zpHbEaTIS/BqAJX6xNMlERsdJKmuqjboESwJzMOCVgQhvhpCVcCqO0DusI2Ho+INV2yQH517mrzF9N2ubnFvgLdPDibZiAFU/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940533; c=relaxed/simple;
	bh=pfuCaal2BbH2H2hAduZ+yPJwkOr35rv6GubynynOKNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEGrk6DO/HtLyDuShdqmfBFNiURuHSKqzF4MyrChUlKEU0l5TnveN0n4FMyml+C2zprg6Up1awkwy6wqWThRYmrHAxWLtYglRPwzyx5qE79jrXxsQnEDFpMRpEHfJB02DEipCu+if5xc25adIoqG1/krImFL33v4klERyM7AggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pbev1wbq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pbev1wbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715940533; x=1747476533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfuCaal2BbH2H2hAduZ+yPJwkOr35rv6GubynynOKNs=;
  b=Pbev1wbqIcHUvtorJeWO6z2sOdpx59AE68pxNIgljVF2amXVEfNBGdqn
   WFqYMmnzA4fcyYWW+feuV2EwcqV4D8UqlAqGZ1oScQeBdbQKx3iYEKTCi
   TgwULxDjEXuzEl1WvY+E4QUtnpcvtO11vXjwL2Gt+kg0VGWfiiQbpcKZb
   J4FqASJe+37Vyb92OMZT4IvVjz5QKF3xU67KKO5ifHVa429vAnQBuQUaI
   S6u2CoBCy+rbUlEYIB7/qbyIw1ebYjzZ7a3bbqaS1Bw6PqxsdxGBiwkht
   RZQaHgDUoEf99E+RguMyFbpC6pP2fOl8Dq+a2oDUQBZGpCBrPv2mdSUFb
   w==;
X-CSE-ConnectionGUID: BTgj9ey/Tmu/6pWl9wgTTQ==
X-CSE-MsgGUID: c1HcfxBySPGO0vwKF/dEpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11950421"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11950421"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 03:08:52 -0700
X-CSE-ConnectionGUID: 0KBlDWPsRzq3yu15syg1rw==
X-CSE-MsgGUID: 43lF/XZvQ8yTvCWhav0Ytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31571973"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.21])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 03:08:49 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Fri, 17 May 2024 12:08:45 +0200
Message-ID: <6226704.vuYhMxLoTh@fdefranc-mobl3>
In-Reply-To: <20240516173319.00007429@Huawei.com>
References:
 <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
 <20240516173319.00007429@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Jonathan,

Thanks for your comments.

On Thursday, May 16, 2024 6:33:19=E2=80=AFPM GMT+2 Jonathan Cameron wrote:
> On Thu, 16 May 2024 12:19:53 +0200
>=20
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
> > cxl_event_common was a poor naming choice and caused confusion with the
> > existing Common Event Record.
> >=20
> > Use cxl_event_media as a common structure to record information about D=
RAM
> > and General Media events because it simplifies handling the two events.
> >=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and
> > cxl_dram events") Signed-off-by: Fabio M. De Francesco
> > <fabio.m.de.francesco@linux.intel.com> ---
>=20
> Packing question inline.
>
> > [...]
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
>=20
> Does the struct that is created end up __packed?

No, I should have noticed it.

> Also, why is tagged useful here?

It is not useful. I'll rework it not tagged.

Again thanks,

=46abio

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


