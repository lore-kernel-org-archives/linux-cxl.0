Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CC38E5CB;
	Tue,  3 Feb 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128636; cv=pass; b=SMcU3IwPmWK2lRVF+BDJzcT1ihGo3MeKsXskgaNGLwVMpsMBBXqhqpNt+Cz5hO0VdCRdiEszTdfojvQjNRWTpdCFbQxCxnlD5t85tww81qy8jiJdl1VuNadCI52yF1LTePwWTI5BvY3Cin/jCfDQXbR2vCC9czwQbTIs7+skAKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128636; c=relaxed/simple;
	bh=wvkrZIgXGoSl/zKcvpbuPOlsKpHUxf1VXqJTMoQDJJQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=A1edGLrWbb8zqMuAKIBSATl6PZwAs6ObJLljTlEf2Fbl6PhSz//dCwmAO28x1eA81eGn6CCqgsKkqSLxmf++NpO2TQ+8Pt2fmp2B6uhk9FpSXyV0d7fpcrlHjC0NAalHoJHlh4tkgLKJgOKmX0tZUxDdwg95XN1GpOxJL20Wpjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CXbKGW8B; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CXbKGW8B"
ARC-Seal: i=1; a=rsa-sha256; t=1770128619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aJiJ1YOxSocrD7K5XhotZabc3EEfcudFTLLH8PkvUA38NMQJAgDFLFW7iyg+kzxhroPehVqiP0pdjPZAUBx8Ks1YI2JM8Tq5icqVrzm5r34Ds24gW9F6oXbv8rJJJZwodXoFMkJ2Zs49WfWv4RqjpwPX9ruCYn1TI8RNpufXgQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770128619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xJbJfSAfgc8tdOJIaDn21wthOF6/Fyv3TK3bifzkQSM=; 
	b=aVtFhh4pF4vnQ+tfU+ApARiPHuu7/rH/B8gdKHu++tNAjwY7VDymAUpty7ZIS4yFAjchsa/7cGqN5g99c+LA48lBLo7OQ9/r0e9W6eO91rB8GBV0xjQUObTIBDQzRz/j2/M1pUETm8jeUVrEXRdTDhnCfddL7j+CAF5rq8B5kWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770128619;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xJbJfSAfgc8tdOJIaDn21wthOF6/Fyv3TK3bifzkQSM=;
	b=CXbKGW8BYlDLm95IjLCU3/sDRdK56KCArs7/kymJbGjmmNj/OuwsCgDWai98exGV
	OU6D4K+DCnkCOXAEK8fDtDARLeIgLNE1eEJ28BcbfgutOLsQD4s6DhqT4E96euKdrR4
	0SSxxv7CH1wKhr3ETYN1ciOJre0KXyXk/1DoWY2Y=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770128618286653.5565535544064; Tue, 3 Feb 2026 06:23:38 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 06:23:38 -0800 (PST)
Date: Tue, 03 Feb 2026 22:23:38 +0800
From: Li Ming <ming.li@zohomail.com>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>
Cc: "dave" <dave@stgolabs.net>, "dave.jiang" <dave.jiang@intel.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"dan.j.williams" <dan.j.williams@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c23e33320.c78951ef7300.3027465952765956716@zohomail.com>
In-Reply-To: <20260202153924.00002396@huawei.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
	<20260201093002.1281858-3-ming.li@zohomail.com> <20260202153924.00002396@huawei.com>
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
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
Feedback-ID: rr0801122c4edc738e26565353fd5228af00008fbb5b760634f91d945a8f89be2fb5cd4f0a08a1a28e99c9c991da9bcd26:zu08011227875f40eeb898f4c1665609690000424f3dda523e7a5bdc5f171218593f8b9e2066469863c9cf51:rf080112320902cc147cd1caf34454c09c0000817064c62cecee544a40aa7e83f52dd71e188633557c86907b0a8c5d527ae90bed91c805:ZohoMail




From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Li Ming"<ming.li@zohomail.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 02 Feb 2026 23:39:24 +0800
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport adding

 > On Sun,  1 Feb 2026 17:30:02 +0800
 > Li Ming <ming.li@zohomail.com> wrote:
 > 
 > > When CXL subsystem adds a cxl port to a hierarchy, there is a small
 > > window where the new port becomes visible before it is bound to a
 > > driver. This happens because device_add() adds a device to bus device
 > > list before bus_probe_device() binds it to a driver.
 > > So if two cxl memdevs are trying to add a dport to a same port via
 > > devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
 > > and attempt to add a dport, but fails because the port has not yet been
 > > attached to cxl port driver.
 > > the sequence is like:
 > > 
 > > CPU 0                    CPU 1
 > > devm_cxl_enumerate_ports()
 > >   # port not found, add it
 > >   add_port_attach_ep()
 > >     # hold the parent port lock
 > >     # to add the new port
 > >     devm_cxl_create_port()
 > >       device_add()
 > >     # Add dev to bus devs list
 > >     bus_add_device()
 > >                     devm_cxl_enumerate_ports()
 > >                     # found the port
 > 
 > Indenting not consistent here as this call is in devm_cxl_enumerate_ports()
Thanks for that, will fix it in next version.

 > 
 > >                     find_cxl_port_by_uport()
 > >                     # hold port lock to add a dport
 > >                     device_lock(the port)
 > >                     find_or_add_dport()
 > >                       cxl_port_add_dport()
 > >                         return -ENXIO because port->dev.driver is NULL
 > >                     device_unlock(the port)
 > >     bus_probe_device()
 > >       # hold the port lock
 > >       # for attaching
 > >       device_lock(the port)
 > >         attaching the new port
 > >       device_unlock(the port)
 > > 
 > > To fix this race, require that dport addition holds the parent port lock
 > > of the target port. The CXL subsystem already requires holding the
 > > parent port lock while attaching a new port. Therefore, successfully
 > > acquiring the parent port lock ganrantees that port attaching has
 > 
 > Spell check. Guarantees
Got it.

 > 
 > > completed.
 > > 
 > > Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
 > > Signed-off-by: Li Ming <ming.li@zohomail.com>
 > 
 > Analysis looks reasonable to me, but I'm not hugely confident on this
 > one so would like others to take a close look as well.
 > Question inline.
 > 
 > 
 > > ---
 > >  drivers/cxl/core/port.c | 6 +++++-
 > >  1 file changed, 5 insertions(+), 1 deletion(-)
 > > 
 > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
 > > index 54f72452fb06..fef2fe913e1f 100644
 > > --- a/drivers/cxl/core/port.c
 > > +++ b/drivers/cxl/core/port.c
 > > @@ -1817,8 +1817,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 > >              /*
 > >               * RP port enumerated by cxl_acpi without dport will
 > >               * have the dport added here.
 > > +             *
 > > +             * Hold the parent port lock here to in case that the
 > > +             * port can be observed but has not been attached yet.
 > >               */
 > > -            scoped_guard(device, &port->dev) {
 > > +            scoped_guard(device, &parent_port_of(port)->dev) {
 > I'm nervous about whether this is the right lock. For unregister_port()
 > (which is easier to track down that the add path locking) the lock
 > taken depends on where the port is that is being unregistered.
 > Specifically root ports are unregistered under parent->uport_dev, not
 > parent->dev.
You are right.
When cxl acpi driver attempts to add a cxl host bridge port, it will hold cxl_root->uport_dev.
Otherwide, hold parent_port->dev lock for the new port addition.
So I think it is possible that memdev can observe a cxl host bridge port but it has not been attach yet.
Maybe I should hold the lock of the new port's host.
Let's see if other reviewers have more comments on that.

Ming
 > 
 > > +                guard(device)(&port->dev);
 > >                  dport = find_or_add_dport(port, dport_dev);
 > >                  if (IS_ERR(dport)) {
 > >                      if (PTR_ERR(dport) == -EAGAIN)
 > 
 > 

