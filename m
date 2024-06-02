Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3618175A5;
	Sun,  2 Jun 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717355519; cv=none; b=URv3GDWbjy+GA3yO4AXyogg/0tivRl6DVKIrlwKznt/3vC6OvjXp8xGjxnZFlWqCU23di5speJ7v+avffYS3UONOkM7KixhJWEHI/+HWYP5RewW3XOyNsMSZ84Xpl4NQBzqep5tm5z8ERcUxhznlTwfbafw8cg2XFw4m4sHQIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717355519; c=relaxed/simple;
	bh=Xa0XG5Hy1WzV3Z+VyKKvpftB2k1RsyX1IiSLdj/6Iio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKYTk0L8XUyfVq85C9J3F302yLRTamlrHLXwFjr0sOPhlm8hByHRBqv4OtsdH0zBVw05mhszy9c45yYZKi2EByzgURn2Ak2QTAjKIx/QwsgNMByCmRk2I76ly9yTQoryq/QgX11bEcT85tQ+l7QWmT2p0h8y/geD1Z7RdZHnS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaxL/Iqi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaxL/Iqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717355518; x=1748891518;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Xa0XG5Hy1WzV3Z+VyKKvpftB2k1RsyX1IiSLdj/6Iio=;
  b=YaxL/IqihqYh5eSz3TH3paooCyhHeETtbXFTr7iCk9tMoUUTZRxsaWSd
   H4r4rU502YsVUsdvyegvWatG1x3+9TExNre7eQywdiYJsuKuOFlGRSrmh
   SiVpAdR0XXVl/XNht1JVhuE5DkikS56yWWeZRG+DoRJySOfPuXp6mroES
   357yvVxSsQ666EWB7X0WY1dc+Tmnj/VDNaZjo1l+xo7R1HDaA6pSwBekV
   mbYRoHVf3kfNEsu/TW4L70mnh/Drxi4tERUxho7VrFK5laXlUvw/JBQQo
   59wp3BU5TfUh0nXuDmPobg5et+OYNUx6TX+/i/FTft3JQdSXEkeFOAUDW
   Q==;
X-CSE-ConnectionGUID: nFnaTtENT3KpF3xYzyxNJQ==
X-CSE-MsgGUID: Rg1vahJmRu6KBFWOPmEwrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14008730"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="14008730"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 12:11:58 -0700
X-CSE-ConnectionGUID: iXjj2wB/QrOdLOc5crDHTg==
X-CSE-MsgGUID: VfDK+9lySASwqBlm6CxFOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="36674224"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.16])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 12:11:54 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5] cxl/events: Use a common struct for DRAM and General Media
 events
Date: Sun, 02 Jun 2024 21:09:50 +0200
Message-ID: <4887657.OV4Wx5bFTl@fdefranc-mobl3>
In-Reply-To: <20240602183136.25768-1-fabio.m.de.francesco@linux.intel.com>
References: <20240602183136.25768-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, June 2, 2024 8:31:29=E2=80=AFPM GMT+2 Fabio M. De Francesco wrot=
e:
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

Please discard this v5 because the Reviewed-by tags are missing.

=46abio

> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.co=
m>
> ---
>=20
> - Changes for v5 -
>=20
> 	- Rebase on v6.10-rc1
>=20
> - Changes for v4 -
>=20
>         - Initialise cxl_test_dram and cxl_test_gen_media without=20
>           unnecessary extra de-references (Dan)
>         - Add a comment for media_hdr in union cxl_event (Alison)
>=20
> - Changes for v3 -
>=20
>         - Rework the layout of cxl_event_dram and cxl_event_gen_media to
>           make a simpler change (Dan)
>         - Remove a "Fixes" tag (Dan)
>         - Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
>         - Rewrite end extend the commit message
>=20
> - Link to v4 -
>=20
> https://lore.kernel.org/linux-cxl/20240521140750.26035-1-fabio.m.de.franc=
esco@linux.intel.com/
>=20
>  drivers/cxl/core/mbox.c      |  2 +-
>  drivers/cxl/core/trace.h     | 32 ++++++++++-----------
>  include/linux/cxl-event.h    | 41 ++++++++++-----------------
>  tools/testing/cxl/test/mem.c | 54 +++++++++++++++++++-----------------
>  4 files changed, 61 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..a08f050cc1ca 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,7 +875,7 @@ void cxl_event_trace_record(const struct cxl_memdev=20
*cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
> =20
> -		dpa =3D le64_to_cpu(evt->common.phys_addr) &=20
CXL_DPA_MASK;
> +		dpa =3D le64_to_cpu(evt->media_hdr.phys_addr) &=20
CXL_DPA_MASK;
>  		cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index ee5cd4eb2f16..6d8b71d8f6c4 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -340,23 +340,23 @@ TRACE_EVENT(cxl_general_media,
>  	),
> =20
>  	TP_fast_assign(
> -		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->media_hdr.hdr);
>  		__entry->hdr_uuid =3D CXL_EVENT_GEN_MEDIA_UUID;
> =20
>  		/* General Media */
> -		__entry->dpa =3D le64_to_cpu(rec->phys_addr);
> +		__entry->dpa =3D le64_to_cpu(rec->media_hdr.phys_addr);
>  		__entry->dpa_flags =3D __entry->dpa & CXL_DPA_FLAGS_MASK;
>  		/* Mask after flags have been parsed */
>  		__entry->dpa &=3D CXL_DPA_MASK;
> -		__entry->descriptor =3D rec->descriptor;
> -		__entry->type =3D rec->type;
> -		__entry->transaction_type =3D rec->transaction_type;
> -		__entry->channel =3D rec->channel;
> -		__entry->rank =3D rec->rank;
> +		__entry->descriptor =3D rec->media_hdr.descriptor;
> +		__entry->type =3D rec->media_hdr.type;
> +		__entry->transaction_type =3D rec-
>media_hdr.transaction_type;
> +		__entry->channel =3D rec->media_hdr.channel;
> +		__entry->rank =3D rec->media_hdr.rank;
>  		__entry->device =3D get_unaligned_le24(rec->device);
>  		memcpy(__entry->comp_id, &rec->component_id,
>  			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> -		__entry->validity_flags =3D get_unaligned_le16(&rec-
>validity_flags);
> +		__entry->validity_flags =3D get_unaligned_le16(&rec-
>media_hdr.validity_flags);
>  		__entry->hpa =3D hpa;
>  		if (cxlr) {
>  			__assign_str(region_name);
> @@ -440,19 +440,19 @@ TRACE_EVENT(cxl_dram,
>  	),
> =20
>  	TP_fast_assign(
> -		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->media_hdr.hdr);
>  		__entry->hdr_uuid =3D CXL_EVENT_DRAM_UUID;
> =20
>  		/* DRAM */
> -		__entry->dpa =3D le64_to_cpu(rec->phys_addr);
> +		__entry->dpa =3D le64_to_cpu(rec->media_hdr.phys_addr);
>  		__entry->dpa_flags =3D __entry->dpa & CXL_DPA_FLAGS_MASK;
>  		__entry->dpa &=3D CXL_DPA_MASK;
> -		__entry->descriptor =3D rec->descriptor;
> -		__entry->type =3D rec->type;
> -		__entry->transaction_type =3D rec->transaction_type;
> -		__entry->validity_flags =3D get_unaligned_le16(rec-
>validity_flags);
> -		__entry->channel =3D rec->channel;
> -		__entry->rank =3D rec->rank;
> +		__entry->descriptor =3D rec->media_hdr.descriptor;
> +		__entry->type =3D rec->media_hdr.type;
> +		__entry->transaction_type =3D rec-
>media_hdr.transaction_type;
> +		__entry->validity_flags =3D get_unaligned_le16(rec-
>media_hdr.validity_flags);
> +		__entry->channel =3D rec->media_hdr.channel;
> +		__entry->rank =3D rec->media_hdr.rank;
>  		__entry->nibble_mask =3D get_unaligned_le24(rec-
>nibble_mask);
>  		__entry->bank_group =3D rec->bank_group;
>  		__entry->bank =3D rec->bank;
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..1119d0bbb091 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -21,6 +21,17 @@ struct cxl_event_record_hdr {
>  	u8 reserved[15];
>  } __packed;
> =20
> +struct cxl_event_media_hdr {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +} __packed;
> +
>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
>  struct cxl_event_generic {
>  	struct cxl_event_record_hdr hdr;
> @@ -33,14 +44,7 @@ struct cxl_event_generic {
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
>  struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> +	struct cxl_event_media_hdr media_hdr;
>  	u8 device[3];
>  	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
>  	u8 reserved[46];
> @@ -52,14 +56,7 @@ struct cxl_event_gen_media {
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
>  struct cxl_event_dram {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> +	struct cxl_event_media_hdr media_hdr;
>  	u8 nibble_mask[3];
>  	u8 bank_group;
>  	u8 bank;
> @@ -95,21 +92,13 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
> =20
> -/*
> - * General Media or DRAM Event Common Fields
> - * - provides common access to phys_addr
> - */
> -struct cxl_event_common {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -} __packed;
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	/* dram & gen_media event header */
> +	struct cxl_event_media_hdr media_hdr;
>  } __packed;
> =20
>  /*
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..142333e63cdf 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -384,19 +384,21 @@ struct cxl_test_gen_media {
>  struct cxl_test_gen_media gen_media =3D {
>  	.id =3D CXL_EVENT_GEN_MEDIA_UUID,
>  	.rec =3D {
> -		.hdr =3D {
> -			.length =3D sizeof(struct cxl_test_gen_media),
> -			.flags[0] =3D CXL_EVENT_RECORD_FLAG_PERMANENT,
> -			/* .handle =3D Set dynamically */
> -			.related_handle =3D cpu_to_le16(0),
> +		.media_hdr =3D {
> +			.hdr =3D {
> +				.length =3D sizeof(struct=20
cxl_test_gen_media),
> +				.flags[0] =3D=20
CXL_EVENT_RECORD_FLAG_PERMANENT,
> +				/* .handle =3D Set dynamically */
> +				.related_handle =3D cpu_to_le16(0),
> +			},
> +			.phys_addr =3D cpu_to_le64(0x2000),
> +			.descriptor =3D=20
CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +			.type =3D=20
CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +			.transaction_type =3D=20
CXL_GMER_TRANS_HOST_WRITE,
> +			/* .validity_flags =3D <set below> */
> +			.channel =3D 1,
> +			.rank =3D 30,
>  		},
> -		.phys_addr =3D cpu_to_le64(0x2000),
> -		.descriptor =3D CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> -		.type =3D CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> -		.transaction_type =3D CXL_GMER_TRANS_HOST_WRITE,
> -		/* .validity_flags =3D <set below> */
> -		.channel =3D 1,
> -		.rank =3D 30
>  	},
>  };
> =20
> @@ -408,18 +410,20 @@ struct cxl_test_dram {
>  struct cxl_test_dram dram =3D {
>  	.id =3D CXL_EVENT_DRAM_UUID,
>  	.rec =3D {
> -		.hdr =3D {
> -			.length =3D sizeof(struct cxl_test_dram),
> -			.flags[0] =3D=20
CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> -			/* .handle =3D Set dynamically */
> -			.related_handle =3D cpu_to_le16(0),
> +		.media_hdr =3D {
> +			.hdr =3D {
> +				.length =3D sizeof(struct=20
cxl_test_dram),
> +				.flags[0] =3D=20
CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> +				/* .handle =3D Set dynamically */
> +				.related_handle =3D cpu_to_le16(0),
> +			},
> +			.phys_addr =3D cpu_to_le64(0x8000),
> +			.descriptor =3D=20
CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> +			.type =3D CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> +			.transaction_type =3D=20
CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> +			/* .validity_flags =3D <set below> */
> +			.channel =3D 1,
>  		},
> -		.phys_addr =3D cpu_to_le64(0x8000),
> -		.descriptor =3D CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> -		.type =3D CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> -		.transaction_type =3D=20
CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> -		/* .validity_flags =3D <set below> */
> -		.channel =3D 1,
>  		.bank_group =3D 5,
>  		.bank =3D 2,
>  		.column =3D {0xDE, 0xAD},
> @@ -473,11 +477,11 @@ static int mock_set_timestamp(struct cxl_dev_state=
=20
*cxlds,
>  static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>  {
>  	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> -			   &gen_media.rec.validity_flags);
> +			   &gen_media.rec.media_hdr.validity_flags);
> =20
>  	put_unaligned_le16(CXL_DER_VALID_CHANNEL |=20
CXL_DER_VALID_BANK_GROUP |
>  			   CXL_DER_VALID_BANK |=20
CXL_DER_VALID_COLUMN,
> -			   &dram.rec.validity_flags);
> +			   &dram.rec.media_hdr.validity_flags);
> =20
>  	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
>  	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
>=20




