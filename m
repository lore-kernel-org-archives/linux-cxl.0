Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE23002A0;
	Tue,  3 Feb 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131064; cv=pass; b=Zg8f5fY8TXtJ+Qz7/5jKR/AuEHip0fpyPT8qw5D7QRBk47Hye6yMLQasnq6BujjynhCAxz/TIkev4IjH6su8/f+WRZisJBpyi8vohoEGZ1b2U+yv+kDBCx9MwovHxxV77REkoBlJFuWLLj2kBWnvnwHM9oFsHhSzF6CSf6naNNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131064; c=relaxed/simple;
	bh=Z376I/7Opuwud9VZ4QSGNwPblUSjU2c2h1IlZmo/OAI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oxasbNYLQqWudhQzhNevInmHKPZ7AZ2YwwL13Y//j/+PRhE88+2Q5Z+fU/ncheolww2xQPHglHQL6x6Cu9wGXv7bP4JSevr0QOPjp6MNbIgk3jUOpqP4lwYLibiGuYdqTVSYW95F8wd9N99KjZ7NmJJ7U4TgXkaZzakuhqKlB+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=DxkCVznc; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="DxkCVznc"
ARC-Seal: i=1; a=rsa-sha256; t=1770131049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KJDYs6hpoL4cNhaaJYPVDNlND+vv3U+7L6fYwV13r8hvS/ohlhCErDZwF/aWTcTTR8Z2USqI4y9dlZr36GDaKpioP+ljjWcI6mNmUydlRjtm6xvFunih0QtYv9cM97UEo31rX3OFzWWYC2P0KLQK95tqBko1rFo2Pxtz8UNUT7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770131049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AgFFziJnFM1eT0+YGCAoJN27NI3XPb49Vde9r3Pw1Nk=; 
	b=guh+rKR4X2pd7BSFv7xd8lO1F2Yqy1nJcBWVygRbT+kDLcuauGOtOTXqNwmDaYtVWbNhh2l8H2TInd5KrbSfFS7VUc/rZd+q56FcmTLpnPbqciKiRuT1lJVX+qRQgiaW8//ujj3Pk0Xhw9MSBnlKdAJYQbnIaIvYu8oqoezk7RM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770131049;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=AgFFziJnFM1eT0+YGCAoJN27NI3XPb49Vde9r3Pw1Nk=;
	b=DxkCVzncrx86bZ1dRjmMu52LQ1HAGdZQkREVL6P21vRqKSJBbitxTnh+ieQm/WDB
	rmy6PO/ByxehKEnvI+g9K9ZMbQ/t6uhhVW7REE4EncgJYlH3Xg3g9dUyluF2wKLTNWT
	PLN5/cdlWc8oV6QEStXTJcWx3I1B7fEa2tWd4CR0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770131048488205.72993411172627; Tue, 3 Feb 2026 07:04:08 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 07:04:08 -0800 (PST)
Date: Tue, 03 Feb 2026 23:04:08 +0800
From: Li Ming <ming.li@zohomail.com>
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: "dave" <dave@stgolabs.net>,
	"jonathan.cameron" <jonathan.cameron@huawei.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"dan.j.williams" <dan.j.williams@intel.com>
Message-ID: <19c2408481d.d3a542847734.6787260991561471110@zohomail.com>
In-Reply-To: <f7bae850-b9de-4d6c-bd8d-914cae90e7cc@intel.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com> <f7bae850-b9de-4d6c-bd8d-914cae90e7cc@intel.com>
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
Feedback-ID: rr0801122c29610a2530c411d8d95a40810000b81b89ae34f3fbb314e5e0ef7ed7f4aa3ed05c435099aef9e5155ca6d158:zu080112275efa8becdd75ca6f43cc6b2d0000d8dc5b44632524b92aeee3839bec70aad9f10c90b6ce2b7c5e:rf080112320fe3c6970703d9915f83ab440000465b8fd551fe3c0b1c1111f4574ae9c16f30280731662ce266d58c5a2195d095ad3868c9:ZohoMail




From: Dave Jiang <dave.jiang@intel.com>
To: "Li Ming"<ming.li@zohomail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Cc: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 03 Feb 2026 05:04:44 +0800
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default

 > 
 > 
 > On 2/1/26 2:30 AM, Li Ming wrote:
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
 > 
 > So I talked to Dan and the assigning of ERR_PTR(-ENXIO) is from a previous revision of implementation and isn't intended to be there. So removing the line entirely (which would mean endpoint == NULL from kzalloc) is probably the right change. However, I'm not able to reproduce the error. How is it triggered? Also, by setting it to NULL, are we covering up a different issue? Are you able to determine whether cxlmd->endpoint at that point is unexpected and perhaps triggered by a different bug?
 > 
 > DJ
Hi Dave,

As I implied in cover-letter, When I trigger issue #2, it always trigger this issue.
I have a simple script to run cxl test over and over again in a VM. I usually reproduce it in one hour with KASAN enabled. 
When I reproduced it, I dumpped out the value of cxlmd->endpoint, it is -ENXIO. That means it was not updated in cxl_port_add() yet at that time. I cannot reproduce this issue only with patch #2.

Ming

 > 
 > > 
 > > commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
 > > initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
 > > However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
 > > valid endpoint.
 > > 
 > > Across the CXL core, endpoint availability is generally determined by
 > > checking whether it is NULL. Align with this convention by initializing
 > > cxlmd->endpoint to NULL by default.
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
 > >  
 > >      dev = &cxlmd->dev;
 > >      device_initialize(dev);
 > 
 > 

