Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27D3A784E;
	Tue,  3 Feb 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128241; cv=pass; b=LYaZBIUoDbYgHZCcdkqc4ZfSckt/1ZmdYZOe57LKnsvdTX8mEXRx4ty+yaygU9n5JcUH+/JmV8WaIsXg7giUSRdeC4ri3Kg23rRVHz79bvCk+sK239xVB+Sy0TExZClmSt/86rdQuKfSr9cdwCCw1YlIo+IBpoPeOsQpvm8EO2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128241; c=relaxed/simple;
	bh=bXLPOV0fSnDUf9brwCKKCL5ARd4uF3dT49m1RcBbBxk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sfElpidgF9SO3BCwCDcboJT52toLBQfSKyvADCjgWplaPn9f/CrUWeEMwIoGMAVeNladuCpgmVv4OoonCQdytUFv2o21r+TTDqwO4kcQTsCSBt6GLEPZ5ja0dmkbXP4rnMXEn0Qv4CsmbkXO4MHmEel1CRtTYq/CuIY9t64u6jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Lx87f4B4; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Lx87f4B4"
ARC-Seal: i=1; a=rsa-sha256; t=1770128105; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JbtdkOwY/ak1/ORF/C/zpHV0e8YSXVAey56hbInF+4U+PykrG5mKlpSkoXpefg/E9KiGSeGRNAtroEAubijTrTwzI7ZXLr4IZoX42o6RLzzd3sS4wvVFPNENSq+g857JTiBjGKZqoV/S5AfnEWxYHGhHzLjE7b8ms3NfE33RdH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770128105; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8NS/EN06yl9lW7f2UEWT2XTxQNCTe4hJh78q7ioi4S4=; 
	b=WhzxShJqTmqoiCa1bvbnozz97RtEjqv8pruDVwFAIG4yKSf64i7igwp9sPfW7pFdA1LdVtOiNjLEaRPy2kb73bFzHcZKXb4KNs4PwbQhcV+RLmLmTnQSdzkpf3iOfQJ8MMBEuXueHZhnVyV4NTmwTffVZ76CIwu47tkLbW4igys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770128105;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=8NS/EN06yl9lW7f2UEWT2XTxQNCTe4hJh78q7ioi4S4=;
	b=Lx87f4B4zzxDdoKjk6d8ciEVU1vofgs7nE0lvXdC6EOPQ5lQTGGcdZ14Mj9HKx6c
	G75N04QZCIenB+3RsCHazuH2wwJzWvq16+TBE4IQqDgOSgPUhc5B14C1c0pZPM4Pugg
	cIb24gejGv9MoGJUtaTrAxNLTkwFUWYgRP86w3y4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770128103434286.315767033842; Tue, 3 Feb 2026 06:15:03 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 06:15:03 -0800 (PST)
Date: Tue, 03 Feb 2026 22:15:03 +0800
From: Li Ming <ming.li@zohomail.com>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>
Cc: "dave" <dave@stgolabs.net>, "dave.jiang" <dave.jiang@intel.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"dan.j.williams" <dan.j.williams@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c23db57fd.ece515507178.5495973139177331106@zohomail.com>
In-Reply-To: <20260202144103.000016cb@huawei.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
	<20260201093002.1281858-2-ming.li@zohomail.com> <20260202144103.000016cb@huawei.com>
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122cfa02f362062f21d4ed0b57390000cdbea1993dd94d7d5f49044c8ebb51e50ac2564025ce983a1d74b236f9c6:zu080112273b64f5feda0d02db74db1a060000ebc62b8771cfeb26ffff0ecdb2cf451e75a0daa7e57ff9f316:rf0801123230820a2204f9f625d78eb9070000e0fb45e8ff257e425b8e65aaff8fd018c777ce69a873a4c2bb19361e5fc63e98dfe3617f:ZohoMail




From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Li Ming"<ming.li@zohomail.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 02 Feb 2026 22:41:03 +0800
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default

 > On Sun,  1 Feb 2026 17:30:01 +0800
 > Li Ming <ming.li@zohomail.com> wrote:
 > 
 > > CXL testing environment can trigger following trace
 > > 
 > >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
 > >  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
 > >  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
 > >  Call Trace:
 > >   <TASK>
 > >   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
 > >   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
 > >   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
 > >   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
 > >   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
 > >   platform_probe+0x9d/0x130
 > >   really_probe+0x1c8/0x960
 > >   __driver_probe_device+0x187/0x3e0
 > >   driver_probe_device+0x45/0x120
 > >   __device_attach_driver+0x15d/0x280
 > > 
 > > commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
 > > initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
 > > However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
 > > valid endpoint.
 > > 
 > > Across the CXL core, endpoint availability is generally determined by
 > > checking whether it is NULL. Align with this convention by initializing
 > > cxlmd->endpoint to NULL by default.
 > 
 > I had a look at whether it made sense to use use IS_ERR_OR_NULL() to check
 > for validity of the endpoint, but it would be somewhat fiddly and I think
 > you are correct that convention here seems to be NULL means not set.
 > We don't need the error code.  One comment inline.
 > 
 > Either way nice catch
 > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Thanks for the review.

 > 
 > 
 > > 
 > > Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
 > > Signed-off-by: Li Ming <ming.li@zohomail.com>
 > > ---
 > >  drivers/cxl/core/memdev.c | 2 +-
 > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > > 
 > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
 > > index af3d0cc65138..41a507b5daa4 100644
 > > --- a/drivers/cxl/core/memdev.c
 > > +++ b/drivers/cxl/core/memdev.c
 > > @@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 > >      cxlmd->id = rc;
 > >      cxlmd->depth = -1;
 > >      cxlmd->attach = attach;
 > > -    cxlmd->endpoint = ERR_PTR(-ENXIO);
 > > +    cxlmd->endpoint = NULL;
 > cxlmd has just been allocated with kzalloc so I'd argue we don't need this to be explicitly
 > set at all.  Seems like a natural and safe default.
Yes, I forgot it. Thanks for pointing it out.

Ming
 > 
 > >  
 > >      dev = &cxlmd->dev;
 > >      device_initialize(dev);
 > 
 > 

