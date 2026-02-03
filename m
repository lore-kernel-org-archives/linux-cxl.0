Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7367350A27;
	Tue,  3 Feb 2026 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132079; cv=pass; b=TIRLUVm8cUzEIDg6WNuQ213a778eSd4HRM7Elyc7Yu6gpdl+8mUfne/RMfvHPbqDwMZv3KeqpL7ki4egQxy+UAn9YrerNRlx6KNYb8v3R1QdyUmUOuSvIHlsp+T0cy+PsVXO0UbYMDFXp/Gd+KvfWlkcCRBS2l+MuZdCsx0jJGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132079; c=relaxed/simple;
	bh=i7OqAFJpVxFPbnaek5PwOrMWib1pTp5ZrdqsjDLc+Qk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=s62l9oUf9FO6J3WAsNroT5AOD4MsmHxozh1+QsduP+c4hYoXV81pRxbexYVkt/R6LHHum0e03zMUNf1JNatzBznkK9e1L+g+NKN8B1yiKGfWYGOgXgSA5gXd8yEH5ChxHyVMh007wS6v3bVolXothqwML5ypvt6lOvH2UpuQUpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XWaSSrr4; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XWaSSrr4"
ARC-Seal: i=1; a=rsa-sha256; t=1770132070; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PsjZldpyXB/q8kxAJ1g/s570yNqpW1/zYJX4ozOKVm8ff8x5CJZRJkyJ1D0FJE//6xpCMcNRWY9vi8dGGNvkbiCBk3ayOz5+aRBHLJ0JhEAM1GIp497j6p1gD9vHyRToJMq1GkssCKJvXpSoFF3nyJAATtcYPCnqgzHXCxAwr2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770132070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E4PsahzFJRpcGL+SAkHtCPr85fq01m8YWGN/XMcCc0k=; 
	b=jypZXkb9TNYZO3AhYU0vZPRn3jzVwrHs0OpCHKcfHWrmMgU3sHgoia62iEUQyK+PXD030+dDpyw9kOBp6O6D6siUzIGwEQ7BdekUCLqd5Bztd6QeLNotYba6y7370Ko1Aww/4yE3bChIGCaROiHYDmgfAeTtmt236vwdPq9s9Y0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770132070;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=E4PsahzFJRpcGL+SAkHtCPr85fq01m8YWGN/XMcCc0k=;
	b=XWaSSrr4igEmDRh0AAcrX2yQAjwvYZamvRYEI17NX/OWjdxcmPCgZmKuLs/R/tnx
	cWBVy/ARcbGHt6uYSLlkuZLfizX5yKmoLjK+wMrrJT5cxK4LwBfY7/2z0Dvq0woQAGQ
	ZuE0ILLZGiTkWS6uDsFHHEAsgTbltaGTrzovFOc4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770132069831336.08706930507117; Tue, 3 Feb 2026 07:21:09 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 07:21:09 -0800 (PST)
Date: Tue, 03 Feb 2026 23:21:09 +0800
From: Li Ming <ming.li@zohomail.com>
To: "danjwilliams" <dan.j.williams@intel.com>
Cc: "dave" <dave@stgolabs.net>,
	"jonathan.cameron" <jonathan.cameron@huawei.com>,
	"dave.jiang" <dave.jiang@intel.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c2417ddbc.de6bcafb8090.2871009931423392945@zohomail.com>
In-Reply-To: <69813c31200a6_55fa1005a@dwillia2-mobl4.notmuch>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com> <69813c31200a6_55fa1005a@dwillia2-mobl4.notmuch>
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
Feedback-ID: rr0801122cad0a9ce0e5f8736db455d3290000c69b4d6a8ee53e35faabb8ae18db9a97af73e3e86c9583f092944498d3f2:zu0801122758dc921acd59f84b4db9baee0000d7514067e19a5534e50476058e60600218fafcb8a92f072654:rf08011232e18812d6975bfcc11f9bce9000004b5ea3cda32e29fe89ebe57b52fa6ac1a456683bf51580409d3c14e1c962da8076abc3e4:ZohoMail




From:  <dan.j.williams@intel.com>
To: "Li Ming"<ming.li@zohomail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Cc: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Li Ming"<ming.li@zohomail.com>
Date: Tue, 03 Feb 2026 08:07:13 +0800
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport adding

 > Li Ming wrote:
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
 > > completed.
 > 
 > Are you seeing this case fail permanently? The expectation is that the
 > one that loses the race iterates up the topology and retries.
 > 
 > So yes, you can lose this race once, but not twice is the expectation.
 > 
Hi Dan,

My understanding is that would not trigger enumeration retry, because enumerating ports flow retries the enumeration only when find_or_add_dport() returns a -EAGAIN. but the port's driver checking in cxl_port_add_dport() returns a -ENXIO, so it makes devm_cxl_enumerate_ports() failure directly.

Ming

