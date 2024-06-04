Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED514600E
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502081; cv=none; b=jHdeho2+TpLA3j9Y0+J8ThPYFGoc1xiDbLT7V9PRsxeCDr3Dmi+uwdUm35ZUgNeR/YBcn5yPiu2/GqaK9AAlXRiYJ+DKmoXXcNBoU2G/KiFOVTXlmStg4u2nY19ktda959a2CawmtzgsOsJRim3I2erJiNv8BFm3hIEsywwg0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502081; c=relaxed/simple;
	bh=lZ3VPEk9tpiY5PfM/6US4/ZK+WC6jwUkxnhb/p9uCvg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nilCvgoQearIW0IsoKN88fDypUMu4jjnNWQAM0xLW6mqc0l5rrBweDq/NNiDXnQfLiIV78khqwVR5+m3Bf8tG3rEEiC0FLuGjVgkZYMkZYs7IzhE9Jf1ac+n0bG+BnS+QcZ2C5yLkkDzWG7Zg0JegYDyu/zJjOfhIuE0BmekaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vtprb5h77z6K9MP;
	Tue,  4 Jun 2024 19:53:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AEFA91400DB;
	Tue,  4 Jun 2024 19:54:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 12:54:29 +0100
Date: Tue, 4 Jun 2024 12:54:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: fan <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240604125428.00003a1d@Huawei.com>
In-Reply-To: <87cyox9icl.fsf@pond.sub.org>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjEnwPeoivsW8y5Z@debian>
	<20240501155812.00002ec3@Huawei.com>
	<87cyox9icl.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 04 Jun 2024 11:18:18 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> I finally got around to read this slowly.  Thank you, Fan and Jonathan!
> 
> I'm getting some "incomplete" vibes: "if we ever implement", "patches
> for this on list", "we aren't emulating this yet at all", and ...

Absolutely.  There is a bunch of stuff that we reject today but
the interfaces allow you to specify it and align with the CXL specification
Fabric Management API definition which is the spec used to control this
stuff from a BMC etc.  If that doesn't work we have a hardware errata
problem, so hopefully that is fairly stable.

I think I can publicly confirm there are some related errata in flight,
seeing as we said we'd raise questions on some aspects in the kernel and
QEMU series preceding this one (so no IP secrecy issues). These are as a
result of this work from Fan, but we have carefully avoided implementing
anything that 'may' change.


> 
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
> [...]
> 
> > Only thing I'd add is that for now (because we don't need it for testing
> > the kernel flows) is that this does not provide any way for external
> > agents (e.g. our 'fabric manager' to find out what the state is - i.e.
> > if the extents have been accepted by the host etc). That stuff is all
> > defined by the spec, but not yet in the QMP interface.  At somepoint
> > we may want to add that as a state query type interface.  
> 
> ... this, too.
> 
> In review of v5, I asked whether this interface needs to be stable.
> 
> "Not stable" doesn't mean we change an interface without thought.  It
> merely means we can change it much, much faster, and with much less
> overhead.
> 
> I understand you want it chiefly for CXL development.  Development aids
> commonly don't need to be stable.

Ok. If it makes sense to make this unstable for now I'm fine with that.
I don't see why it would change beyond in backwards compatible fashion
with new optional fields to cover future specification updates allowing
for more information. However I've been wrong on such things before.

So I'm fine adding a patch on top of v8 marking them unstable for now.

> 
> If you're aiming for stable, you need to convince us the interface can
> support the foreseeable purposes without incompatible changes.  In
> particular, I'd like to see how you intend to support "finding out what
> the state is".  I suspect that's related to my question in review of v8:
> how to detect completion, and maybe track progress.

There is a need for completion information but given it's completely
asynchronous to the commands defined here (Can be out of order, lots of
ongoing capacity add / remove flows in flight etc) and for the hardware
definition the feedback occurs via an event record log I'm not expecting it
to affect the interfaces added so far.

> 
> There's infrastructure for background jobs: job.json.  We might be
> better off using it, unless completion is trivial and progress tracking
> unnecessary.

I'll take a look, but these are not conventional background commands
(We do have those as well, but that's a whole different set of future
problems!)

The actual command itself completes synchronously but not the flow
it kicked off which is not background as such because it may never
finish and involves lots of moving parts.  This is similar to any
form of error injection.  We inject the error synchronously and that
creates a bunch of records in various registers / firmware etc but
the actions the host OS takes are asynchronous and may only happen
when it decides to poll some register or a driver loads much later.

So I'm not sure if job.json approach fits.

> 
> [...]
> 
> 

