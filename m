Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E5328B6;
	Wed, 27 Nov 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722047; cv=none; b=AaVK3G7UKU3jbP0CH9szHqnJa39CwqmiDGY1pBnuMwaZxnGb8NoeTcSTP/zw8VNAmKtFwISL8A84C+iWWGwJnSx7lwdGbveokoF5ic7opeP8eIB64RdxjPTGSK3QDjFDYFeqBqAAeYSej8QIN8YjjK9b7g/upkbBURdIq7ixMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722047; c=relaxed/simple;
	bh=ncPIlJNbTVF+RdXN6fFSuK1Ao3lo5VBICNQCSgrJ9K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw3unOgRch5E5M4UsTzy+zXvOjR5/oWLOqc3JgQMABIE3uKD9IAuluMd5k4p4+VnTbpJml/yG01GoI0yQYxDK8GJTwb1eET/iw2lYDFEK13aJl23YTuYIr3TTXVuNG483hrd3q6JT9Z4qgGUsr+737rtrI1fd1r30JMPR1i5QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CD0C4CECC;
	Wed, 27 Nov 2024 15:40:45 +0000 (UTC)
Date: Wed, 27 Nov 2024 10:41:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Message-ID: <20241127104132.6c1729e1@gandalf.local.home>
In-Reply-To: <a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 10:12:12 +0000
Shiju Jose <shiju.jose@huawei.com> wrote:

> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:__data_loc char[] memdev;	offset:8;	size:4;	signed:0;
> 	field:__data_loc char[] host;	offset:12;	size:4;	signed:0;
> 	field:int log;	offset:16;	size:4;	signed:1;

> 	field:uuid_t hdr_uuid;	offset:20;	size:16;	signed:0;

New type for me ;-)

> 	field:u64 serial;	offset:40;	size:8;	signed:0;
> 	field:u32 hdr_flags;	offset:48;	size:4;	signed:0;
> 	field:u16 hdr_handle;	offset:52;	size:2;	signed:0;
> 	field:u16 hdr_related_handle;	offset:54;	size:2;	signed:0;
> 	field:u64 hdr_timestamp;	offset:56;	size:8;	signed:0;
> 	field:u8 hdr_length;	offset:64;	size:1;	signed:0;
> 	field:u8 hdr_maint_op_class;	offset:65;	size:1;	signed:0;
> 	field:u8 hdr_maint_op_sub_class;	offset:66;	size:1;	signed:0;
> 	field:u64 dpa;	offset:72;	size:8;	signed:0;
> 	field:u8 descriptor;	offset:80;	size:1;	signed:0;
> 	field:u8 type;	offset:81;	size:1;	signed:0;
> 	field:u8 transaction_type;	offset:82;	size:1;	signed:0;
> 	field:u8 channel;	offset:83;	size:1;	signed:0;
> 	field:u32 device;	offset:84;	size:4;	signed:0;
> 	field:u8 comp_id[16];	offset:88;	size:16;	signed:0;
> 	field:u64 hpa;	offset:104;	size:8;	signed:0;
> 	field:uuid_t region_uuid;	offset:112;	size:16;	signed:0;
> 	field:u16 validity_flags;	offset:128;	size:2;	signed:0;
> 	field:u8 rank;	offset:130;	size:1;	signed:0;
> 	field:u8 dpa_flags;	offset:131;	size:1;	signed:0;
> 	field:__data_loc char[] region_name;	offset:132;	size:4;	signed:0;
> 	field:u8 sub_type;	offset:136;	size:1;	signed:0;
> 	field:u8 cme_threshold_ev_flags;	offset:137;	size:1;	signed:0;
> 	field:u32 cme_count;	offset:140;	size:4;	signed:0;
> 
> print fmt: "memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb len=%d flags='%s' handle=%x related_handle=%x maint_op_class=%u maint_op_sub_class=%u : dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u device=%x validity_flags='%s' comp_id=%shpa=%llx region=%s region_uuid=%pUb sub_type=%u cme_threshold_ev_flags=%u cme_count=%u", __get_str(memdev), __get_str(host), REC->serial, __print_symbolic(REC->log, { CXL_EVENT_TYPE_INFO, "Informational" }, { CXL_EVENT_TYPE_WARN, "Warning" }, { CXL_EVENT_TYPE_FAIL, "Failure" }, { CXL_EVENT_TYPE_FATAL, "Fatal" }), REC->hdr_timestamp,


> &REC->hdr_uuid,

libtraceevent doesn't know about taking an address with '&'.

If I remove it (and the other one below for region_uuid), it parses fine.

I'll have to add this to the library, as it should be able to handle this.
I bet I also have to add "%pUb" as well.

Thanks,

-- Steve



> REC->hdr_length, __print_flags(REC->hdr_flags, " | ", { ((((1UL))) << (2)), "PERMANENT_CONDITION" }, { ((((1UL))) << (3)), "MAINTENANCE_NEEDED" }, { ((((1UL))) << (4)), "PERFORMANCE_DEGRADED" }, { ((((1UL))) << (5)), "HARDWARE_REPLACEMENT_NEEDED" }, { ((((1UL))) << (6)), "MAINT_OP_SUB_CLASS_VALID" } ), REC->hdr_handle, REC->hdr_related_handle, REC->hdr_maint_op_class, REC->hdr_maint_op_sub_class, REC->dpa, __print_flags(REC->dpa_flags, "|", { ((((1UL))) << (0)), "VOLATILE" }, { ((((1UL))) << (1)), "NOT_REPAIRABLE" } ), __print_flags(REC->descriptor, "|", { ((((1UL))) << (0)), "UNCORRECTABLE_EVENT" }, { ((((1UL))) << (1)), "THRESHOLD_EVENT" }, { ((((1UL))) << (2)), "POISON_LIST_OVERFLOW" } ), __print_symbolic(REC->type, { 0x00, "ECC Error" }, { 0x01, "Invalid Address" }, { 0x02, "Data Path Error" }, { 0x03, "TE State Violation" }, { 0x04, "Scrub Media ECC Error" }, { 0x05, "Adv Prog CME Counter Expiration" }, { 0x06, "CKID Violation" } ), __print_symbolic(REC->transaction_type, { 0x00, "Unknown" }, { 0x01, "Host Read" }, { 0x02, "Host Write" }, { 0x03, "Host Scan Media" }, { 0x04, "Host Inject Poison" }, { 0x05, "Internal Media Scrub" }, { 0x06, "Internal Media Management" }, { 0x07, "Internal Media Error Check Scrub" }, { 0x08, "Media Initialization" } ), REC->channel, REC->rank, REC->device, __print_flags(REC->validity_flags, "|", { ((((1UL))) << (0)), "CHANNEL" }, { ((((1UL))) << (1)), "RANK" }, { ((((1UL))) << (2)), "DEVICE" }, { ((((1UL))) << (3)), "COMPONENT" }, { ((((1UL))) << (4)), "COMPONENT PLDM FORMAT" } ), __print_hex(REC->comp_id, 0x10), REC->hpa, __get_str(region_name), &REC->region_uuid, REC->sub_type, REC->cme_threshold_ev_flags, REC->cme_count
