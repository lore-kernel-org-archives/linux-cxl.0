Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB87426EDD
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536891; cv=pass; b=D2GgkaMaYaIEdphQQq5ZHXJ7KUYlcIdSB1UDQIYxnTNnoEwFzAygTFN+3n6VoTEJgzJaoc0EWdMMMuWZhdPcbwKtLknTWeY1nXFEfEx/b7BGdTr6Hd2LnQB6VuQcpb+cYaEuEGrZ3D5c64X/nI13HUfASrEPnTfByxE6RMZiBmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536891; c=relaxed/simple;
	bh=Xyw8Ls+Zb5rNidkmQsSMgMydCM2c5uk0uSJw15v8QtY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S0icJtAwCtpmc1/vEAiWpReo1Rb+q4MmUrsVvr9JhBXGf1t5qcD3Zy6XwC2VZzy4K6YujCSRFyxaiIO2lVvwcRwRPRBOHNnKyZKQ23ecPZ6Mssr0VsNug+jwxRO8WtICfxaNDsYD9O7SVC+X2n+3SJJDrVfz8WBduL5Wv0zbDO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=azcDM8lK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="azcDM8lK"
ARC-Seal: i=1; a=rsa-sha256; t=1772536872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TBBbsm6t8bal9ztHEi9y5d5xJ7gsfB3BCAiG2PyIP/MpEB9/r5mI2JQq2JYVWS8zY5EPWU7OgVbS97aUQ5bTtf2gZqEMRyPPJigjkLZKWo9fVt0T7RJ6HLfkJQebxgDSfk/6LBzhE5tnWB9oJH+/wHHHBCZ7Pnafmv/5KW1uU3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772536872; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+j/lQM83KuzHRuyqQgcJYkdgnWoSLdDPQakjG6qrrKI=; 
	b=B5SP3fRpYS81erbZyNvYg+yWAUWqNjz9xN1kzpqAMYpjGL/6KcTxRY8IXyCWd0cfiXDs3bKk5QNkDsENVWfYqu/RSctQ2yJ/PG+NIiu68E9i2Dp61NbkYKnVoz4BV3nCVCxPuq99DerW1OIp2vAN3t8/CDDcTel8XAbD6a/9JEY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772536872;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+j/lQM83KuzHRuyqQgcJYkdgnWoSLdDPQakjG6qrrKI=;
	b=azcDM8lKFAm0GyJntg8/B5u96ORXVBsZ0MCwYVlCuuxfbya65Z5OOtajHLrXTB9x
	Dm3uaGxO+FzeHEfBfFWaMLMsDsjAed7j2UVKT6rzDi02e0Vi16afZM2a8UH3HurGCYN
	xqAyVukKMPtHJ76DK80VslU9PHVOse0/j/hMrh4E=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1772536870417664.2127773015691; Tue, 3 Mar 2026 03:21:10 -0800 (PST)
Received: from  [39.144.40.168] by mail.zoho.com
	with HTTP;Tue, 3 Mar 2026 03:21:10 -0800 (PST)
Date: Tue, 03 Mar 2026 19:21:10 +0800
From: Li Ming <ming.li@zohomail.com>
To: "danjwilliams" <dan.j.williams@intel.com>
Cc: "Alison Schofield" <alison.schofield@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"Dave Jiang" <dave.jiang@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>
Message-ID: <19cb36e3606.ed1be6dc75881.2832304784422670674@zohomail.com>
In-Reply-To: <69a6514597db6_6423c100e8@dwillia2-mobl4.notmuch>
References: <20260303001616.1821728-1-alison.schofield@intel.com> <69a6514597db6_6423c100e8@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v5] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
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
Feedback-ID: rr08011228211a93e31b1149cf32b3ecac0000b93f967724367e5c48c7779f69ad2917e707222ccff2740b0a36:zu080112277bb33b4e4ab11c1f936a1da1000041f7173ad9c380929d7a1a522346ea64145421de5e2273c64f:rf0801122d88f9f8775ca504f52c7770df000082e240119d0889ec97c5f505f8eed4deceec2e1fada7e86e31ed316b2be245:ZohoMail




From:  <dan.j.williams@intel.com>
To: "Alison Schofield"<alison.schofield@intel.com>, "Davidlohr Bueso"<dave@stgolabs.net>, "Jonathan Cameron"<jonathan.cameron@huawei.com>, "Dave Jiang"<dave.jiang@intel.com>, "Alison Schofield"<alison.schofield@intel.com>, "Vishal Verma"<vishal.l.verma@intel.com>, "Ira Weiny"<ira.weiny@intel.com>, "Dan Williams"<dan.j.williams@intel.com>
Cc: <linux-cxl@vger.kernel.org>, "Li Ming"<ming.li@zohomail.com>
Date: Tue, 03 Mar 2026 11:11:01 +0800
Subject: Re: [PATCH v5] cxl/port: Fix use after free of parent_port in cxl_detach_ep()

[...]
 > > @@ -1533,6 +1537,7 @@ static void cxl_detach_ep(void *data)
 > >          port = to_cxl_port(dev);
 > >  
 > >          parent_port = to_cxl_port(port->dev.parent);
 > > +        get_device(&parent_port->dev);
 > >          device_lock(&parent_port->dev);
 > >          device_lock(&port->dev);
 > >          ep = cxl_ep_load(port, cxlmd);
 > > @@ -1558,6 +1563,7 @@ static void cxl_detach_ep(void *data)
 > >              delete_switch_port(port);
 > >          }
 > >          device_unlock(&parent_port->dev);
 > > +        put_device(&parent_port->dev);
 > 
 > Wait, why is this needed? 
 > 
 >     struct device *dev __free(put_device) =
 >     bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_memdev)
 > 
 > This is the child port device reference prior to the device being
 > unregistered by delete_switch_port(). It is not released until after
 > that:
 > 
 >      device_unlock(&parent_port->dev);
 > 
 > So, if children are pinning parents and this child is released after it
 > is finished with its parent, why is an additional parent port pin
 > needed?
 > 
 > 

Oh, you are right. I missed this bus_find_device(). Thanks for pointing it out.


Ming
