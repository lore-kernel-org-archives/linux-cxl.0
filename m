Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4883FA5E7
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872857; cv=none; b=tRr3f3t30EH9kph7RQ7vv2YVZJFs3SAWWcRaaU4ayk4aQK8yrpTn/TFn1FaNf4bNX38VTWQnfxSr2eeV7P9lN4zlR40SenKAikVUhb1B5ZIW5ToHgW3ZUQY4xVP6946/t9q/gSiiRpczj35vKpjlj1C8ZRtuQd0Pbn+yin2hjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872857; c=relaxed/simple;
	bh=F9PuqLINOQFgmQyW7R6+BMZOP2DWjF8nm7Pit+6gdRE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RntpZcTYjYtggl03eBs9e7eFOM2rq+f8mJAiyTiSXiYkXHDBuLhiUQ2r9NwQJZf2t8vusspNkC/X/y0leDfemAMtpRH1tjEy1elqLWHqsSS/t4ILadEfbSK1KNudGGYUnm2Pf0M1p2HFgqLrCnBcc0u6mfRWdZrNB1jl4ubhflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ui66fJHL; arc=none smtp.client-ip=95.215.58.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ui66fJHL"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F9PuqLINOQFgmQyW7R6+BMZOP2DWjF8nm7Pit+6gdRE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791872853; v=1; x=1792477653;
 b=Ui66fJHLaO5KVxvN7O+TQbaU6xHnQtuqYnSNbUGyvD2CYeILnWMHIzUJJjq28KFzE2rNoPLj
 pSQO0TsWo9YzGiusTlGx0r/YSLZDl8o0M1/z/ObmIA5Xt0f/Qt09dmKTux22beuiESVg7yQImA2
 AkfGcavjD4zEBjftjy2POr5k=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6566544149091e28;
	Tue, 13 Oct 2026 06:27:33 +0000
X-Mizu-Trace-ID: 6566544149091e28
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v3 1/2] dax/bus: fix mapping attribute error reporting
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <as13np-95gSaBbQm@aschofie-mobl2.lan>
Date: Tue, 13 Oct 2026 14:27:15 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Dan Williams <djbw@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAB2A53F-1D2B-44FA-9D36-C393444C6DAA@linux.dev>
References: <20260924025035.1265035-1-songmuchun@bytedance.com>
 <20260924025035.1265035-2-songmuchun@bytedance.com>
 <as13np-95gSaBbQm@aschofie-mobl2.lan>
To: Alison Schofield <alison.schofield@intel.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 13, 2026, at 08:13, Alison Schofield =
<alison.schofield@intel.com> wrote:
>=20
> On Thu, Sep 24, 2026 at 10:50:34AM +0800, Muchun Song wrote:
>> After the DAX configuration locking was converted to rwsems, =
successful
>> lock acquisition leaves rc set to zero in mapping_store(). Two error
>> paths can return this stale value: an unbound region driver and a
>> misaligned range size. The sysfs write therefore reports success =
without
>> allocating the requested range.
>>=20
>> Return -ENXIO when the region driver is not bound and -EINVAL when =
the
>> range size is misaligned.
>=20
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Thanks.

>=20
> Will modify subject line upon applying like so:
> dax/bus: Return errors for invalid mapping requests

No problem.

Thanks,
Muchun=
