Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D521C9E5;
	Wed,  4 Feb 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213119; cv=pass; b=LZvew9EmtNzhpebLd75M2fTpAh3Yg2HPEHp33obkNszx/9ILFHRUnRNy1fem2hbqKid5349pwM3LeOWn+0hOGtr4mG5I1erZnMDzUVXOo8wmaBsh8TA/bKPsQ5BoSHpalhD/Fu+SYbxq+rkusjpBvXUQyZDQZaCRRvqZjpzHoiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213119; c=relaxed/simple;
	bh=oW7YgnqH5bc0kQnIlJf1I9LKECI2nGaiCVSTn9VxlCI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZC74jUl7+tB1P2eeyDZmWNuAfKmPhTOLSdD/Gp0ZQQE9qtXn59YIADtAjhq37L7s6NxA3n2ZZ2Iima6F/F7L6sKVBGV+Hc6njZItVyAc1nH4MMcSO68H5XaHMkVzmhxTcQK/6V4yoCDtWYPOFWTQKm10wKX5QrDOiAMl8QR4UtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=OuyXsaY1; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="OuyXsaY1"
ARC-Seal: i=1; a=rsa-sha256; t=1770213107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cGa5k+DsU9vB3yINrlNr9SO5P62rRTFh2sAdL2lWDajwdy9aRVWVD+PE/eV3InkziiML1D4UEG3GMXdmfmCzLCgrKfo0uZh/hyXijCKtNe/8FO8eO15bxD55V+ry3FUL+is2h0iE6dsmTsyYjbvdb4n/t/vjxgsYqg1poAiEY0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770213107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MPo46pestrSYRl8dlLDYJDkvTMU/uEw1wcFsmxwjTPs=; 
	b=JRU+w0vcow40fNQycFIh2U8PmyfJvV/qgIIne0HwG10yaa/vPdQEgJTQ0kX66MLtXSziwSjYGAT3pG71lPcH4OF+E/VAozfiM6HQEdptiNmESBwEz8HtXGXjpIE5EtnDm5gvYRrfB+L6tXMvhKmwxhBXIMS0eruhFkwQZ35CsMw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770213107;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=MPo46pestrSYRl8dlLDYJDkvTMU/uEw1wcFsmxwjTPs=;
	b=OuyXsaY1gv0pV1Jg28hAL7AoLTypUx1o5Qiw9UlIsD04jb8suG0yWa7ei7JKyZ5v
	drvC+vy73+tbUGBDvNYtLViEGtJ6+sJkEDE+4xmBt8XYIzMC/keW17w0TezDL/B/PvY
	1rvMYcUubLc9bCT3OhlJwAUzvvRNDvLVjeHGohmc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770213105712922.7227964136649; Wed, 4 Feb 2026 05:51:45 -0800 (PST)
Received: from  [188.253.115.14] by mail.zoho.com
	with HTTP;Wed, 4 Feb 2026 05:51:45 -0800 (PST)
Date: Wed, 04 Feb 2026 21:51:45 +0800
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
Message-ID: <19c28ec5fd8.12b828a5223352.8051295068527742835@zohomail.com>
In-Reply-To: <698275bca732a_55fa10097@dwillia2-mobl4.notmuch>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com>
 <69813c31200a6_55fa1005a@dwillia2-mobl4.notmuch>
 <19c2417ddbc.de6bcafb8090.2871009931423392945@zohomail.com> <698275bca732a_55fa10097@dwillia2-mobl4.notmuch>
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
Feedback-ID: rr0801122ce0bb481f6c260535daff565b000087f63ad44949cf5ef3e3efaed70da7601ec93efc42dcf47467dc90529d09:zu08011227db7771761783ba3575d686850000dd052947752efc7d95fe433529252584eb5e00004d31fec0cf:rf0801123259428a12b3a5ca535c74af9f0000ba54206b719b91b579454cb9ce4f751d5a7c28b24202a7bbd541d735979cb71b9aea3c6e:ZohoMail




From:  <dan.j.williams@intel.com>
To: "Li Ming"<ming.li@zohomail.com>, "danjwilliams"<dan.j.williams@intel.com>
Cc: "dave"<dave@stgolabs.net>, "jonathan.cameron"<jonathan.cameron@huawei.com>, "dave.jiang"<dave.jiang@intel.com>, "alison.schofield"<alison.schofield@intel.com>, "vishal.l.verma"<vishal.l.verma@intel.com>, "ira.weiny"<ira.weiny@intel.com>, "linux-cxl"<linux-cxl@vger.kernel.org>, "linux-kernel"<linux-kernel@vger.kernel.org>
Date: Wed, 04 Feb 2026 06:25:00 +0800
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport adding

 > Li Ming wrote:
 > [..]
 > >  > > 
 > >  > > To fix this race, require that dport addition holds the parent port lock
 > >  > > of the target port. The CXL subsystem already requires holding the
 > >  > > parent port lock while attaching a new port. Therefore, successfully
 > >  > > acquiring the parent port lock ganrantees that port attaching has
 > >  > > completed.
 > >  > 
 > >  > Are you seeing this case fail permanently? The expectation is that the
 > >  > one that loses the race iterates up the topology and retries.
 > >  > 
 > >  > So yes, you can lose this race once, but not twice is the expectation.
 > >  > 
 > > Hi Dan,
 > > 
 > > My understanding is that would not trigger enumeration retry, because
 > > enumerating ports flow retries the enumeration only when
 > > find_or_add_dport() returns a -EAGAIN. but the port's driver checking
 > > in cxl_port_add_dport() returns a -ENXIO, so it makes
 > > devm_cxl_enumerate_ports() failure directly.
 > 
 > Ah, true, my mental model was still stuck in the old top-down dport
 > enumeration scheme.
 > 
 > So, yes, we do need to make sure that switch port creation does not race
 > port lookup. However, I think the scoped_guard() tends to make code less
 > readable and in this case hides the opportunity for more comments to
 > explain what is happening.
 > 
 > I also think, per that observation from Jonathan, that we can save the
 > cxl_bus_resan() violence by taking the CXL platform device lock.
 > 
 > So, please move the locking internal to find_or_add_dport(), so that
 > plain guard() can be used. Add comments for the fact that
 > devm_cxl_create_port() and the CXL platform init path need to be flushed
 > by taking the device lock. And explain why the device to lock is
 > different dependening on whether the parent_port is the cxl_root or a
 > descendant port.
 > 
 > 
Got it, will do that in V2, also remove PATCH #1 as you mentioned.

Ming
