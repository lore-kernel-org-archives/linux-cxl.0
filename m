Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E673A7852;
	Tue,  3 Feb 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129236; cv=pass; b=QjYe88zfSwpmhwFcyo24wyUsCLd5/CYEQ9dKnaQ/H0OCf0KuRBv7nlUH+P4ZnuYYNBBJnVbNGHcm+a2tsbBNSOmXtBNfkAQrv4KS0IvLOqvANXmaKEB7dPVcjFGbpGWOXD5JK1h3eDWQnyDjzdesaXhQD6qO/i3Sd65CV6Fzj40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129236; c=relaxed/simple;
	bh=MLusjmnUIYh0dtfH1QnrUlwZt6QfSn5Fp7qFJzPRPic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EnI4jlDnJmYAEULnET3cA8SjnouTS8/AXC8tlGamoEoDhFNWahFGDfDIFHIdkz3xCJIiGjOQyslWQY7Gpn8m2hMIWDJKdMjN6oZYpfI+EQYJ40vd95jFa/SrvFQxSe7wsAbJN6bnaNxoZdBDhB/emr9clEQRM3ttTu8wN22g62o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MUo7uxNE; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MUo7uxNE"
ARC-Seal: i=1; a=rsa-sha256; t=1770129221; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dMxxlo1zL6nsCqOOsaKUrIx1ykR/GRuXgv0mlPdMScCpfSfXzmW/bCfWhJwlb1sLXQEq5dfEhMT9vyvLYyqm4xeTAi3UZyeUPbnYxMrK4+78nMDHKwbhriJvk8wjRdUQYa6awRDLIVXxLlvsvszMLyEEQenrU+wFmEzqViR0KB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770129221; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZjZEbRmx5hifj4KyEfNAiYo+2YWYQUZGYjDQyJmIgok=; 
	b=kHApYBvMBoDEU27nb1hdE6qd017mUKFiAi4eLeXZURqV08QxEP075FLIkCBigXrFW5W0vAc2EWIByoxXhwXBvJE6iQG+DsWsnUHaBTj/XA/hB6kzwfXVQdq/QfDQyX1sVNpoTo/XMc/TomlRpWRO2HroFI59Z99+wuPOV+Y9sDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770129221;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ZjZEbRmx5hifj4KyEfNAiYo+2YWYQUZGYjDQyJmIgok=;
	b=MUo7uxNExRwakb/wz9tsC46fsAtdrlsaaxibk8TUO1Za49G5vCoJR0Gs/qkDeXWU
	ojNfsj04dbBM8ALAPQd6xlTf85JXUtVl+StPNocYw3CkIW+qzgoLfZyZpRMbM5ddWMe
	rVCZFT+ga7208Wna9cPpMEk8eak5fZFN9sSn2J5A=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770129220687164.524419824166; Tue, 3 Feb 2026 06:33:40 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 06:33:40 -0800 (PST)
Date: Tue, 03 Feb 2026 22:33:40 +0800
From: Li Ming <ming.li@zohomail.com>
To: "Gregory Price" <gourry@gourry.net>
Cc: "dave" <dave@stgolabs.net>,
	"jonathan.cameron" <jonathan.cameron@huawei.com>,
	"dave.jiang" <dave.jiang@intel.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"dan.j.williams" <dan.j.williams@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c23ec6444.fa7d548e7409.6321851600706723924@zohomail.com>
In-Reply-To: <aYDRcU0dZjwCRb4y@gourry-fedora-PF4VCD3F>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com> <aYDRcU0dZjwCRb4y@gourry-fedora-PF4VCD3F>
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
Feedback-ID: rr0801122c50131c502ea0f95d418cb2fb0000200f2c5cd2f72b7717e40fbbfb48d5f8753ad5885560f5c0b2023ca3e8f3:zu080112276f53bb7f1131ae2f1bc80eb200000e49a8d23354a74fbd8105b3b817c593df7d386533520f5f6d:rf08011232d61f9435a99a2a0a497a390b0000fac8396420972c00c4b60e6d47cc5d22b5d8953022653324849b4f252586c86d4792db43:ZohoMail




From: Gregory Price <gourry@gourry.net>
To: "Li Ming"<ming.li@zohomail.com>
Cc: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 03 Feb 2026 00:31:45 +0800
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport adding

 > On Sun, Feb 01, 2026 at 05:30:02PM +0800, Li Ming wrote:
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
 > > 
 > 
 > With just a a cursory look, I'm immediately concerned that you're fixing
 > a race condition with a lock inversion.
 > 
 > Can you guarantee the following is not happening
 > 
 >   Thread A         Thread B
 >   ----------------------------
 >   lock(parent)     lock(port)
 >   lock(port)       lock(parent)
 > 
 > ~Gregory
 > 
Hi Gregory,

I think no other scenario where driver needs to hold a child port lock together with its parent port lock than during a new port attaching or a port removal.
After re-reading a new port attaching and a port removal flows, I believe both operations acquire the parent port first before acquiring a child port lock. So I think the thread B case would not happen. If I miss something please correct me. Thanks

Ming
