Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2B3236
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504141; cv=none; b=TnftQoavdattTELupqKHnt0VdrshpjlWAuFKeHqcsU57z6dDEo8UoHg+1Vy+vV1OMhhplWiCDNJ1tm+zm4fWeZm8GHz+LRuIAdbLb6J8IlfaU4SY/eqT7Q/RnaFF13GXBK+V4Yp2Q7B9NY9N/xmtej+eT1UaBrOdZxxnkuoEaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504141; c=relaxed/simple;
	bh=Zs2KBbYyC9T6QGVbBph93WydZMEkAGWxFBsrOnMNj28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTXhllVXTTt1smASF8XUahDiUlF3d9r/uIjUvCXYbSi4x3AeE0xs5Cz7qhm2Ie4daiwIz93iFdXCXwlbkEx5Cf8EZobVzU+Rjyyc4pjyG4QxcIaH5DrOrGYlAPzq6ZJ93Yq19hTY1cnDcERjvaKWyu0pzoVCPlB6BpBDFWNckDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7ZCcok5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7ZCcok5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717504139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xDFsrXwaNaInsZ8AxXaZ9DH8FqH1/zcsyoVrAYeJ0o=;
	b=a7ZCcok5qvs08BI/M8DGHSLmQt+/Ue1N3Edu05hJZOarlTmc8buFY8asvpMW0v7icrVAt9
	buGjlBLKzE6VTD0b66yiStT25r9FTh9tG0fsWdGvOIGHN73hzP+WdzZBBBbwYXhq3FyRII
	XGqXRGYx7XmWM46ZMvO+sOrKUZMmsus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-eD-6wDx8MLqxw7m7qm4rvA-1; Tue, 04 Jun 2024 08:28:57 -0400
X-MC-Unique: eD-6wDx8MLqxw7m7qm4rvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC137811E85;
	Tue,  4 Jun 2024 12:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B461492BD1;
	Tue,  4 Jun 2024 12:28:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8BF7A21E66E5; Tue,  4 Jun 2024 14:28:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>,  fan <nifan.cxl@gmail.com>,
  <qemu-devel@nongnu.org>,  <linux-cxl@vger.kernel.org>,
  <gregory.price@memverge.com>,  <ira.weiny@intel.com>,
  <dan.j.williams@intel.com>,  <a.manzanares@samsung.com>,
  <dave@stgolabs.net>,  <nmtadam.samsung@gmail.com>,
  <jim.harris@samsung.com>,  <Jorgen.Hansen@wdc.com>,
  <wj28.lee@gmail.com>,  Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240604125428.00003a1d@Huawei.com> (Jonathan Cameron's message
	of "Tue, 4 Jun 2024 12:54:28 +0100")
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org> <ZjEnwPeoivsW8y5Z@debian>
	<20240501155812.00002ec3@Huawei.com> <87cyox9icl.fsf@pond.sub.org>
	<20240604125428.00003a1d@Huawei.com>
Date: Tue, 04 Jun 2024 14:28:54 +0200
Message-ID: <87h6e87uyh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 04 Jun 2024 11:18:18 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I finally got around to read this slowly.  Thank you, Fan and Jonathan!
>> 
>> I'm getting some "incomplete" vibes: "if we ever implement", "patches
>> for this on list", "we aren't emulating this yet at all", and ...
>
> Absolutely.  There is a bunch of stuff that we reject today but
> the interfaces allow you to specify it and align with the CXL specification
> Fabric Management API definition which is the spec used to control this
> stuff from a BMC etc.  If that doesn't work we have a hardware errata
> problem, so hopefully that is fairly stable.
>
> I think I can publicly confirm there are some related errata in flight,
> seeing as we said we'd raise questions on some aspects in the kernel and
> QEMU series preceding this one (so no IP secrecy issues). These are as a
> result of this work from Fan, but we have carefully avoided implementing
> anything that 'may' change.
>
>
>> 
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>> 
>> [...]
>> 
>> > Only thing I'd add is that for now (because we don't need it for testing
>> > the kernel flows) is that this does not provide any way for external
>> > agents (e.g. our 'fabric manager' to find out what the state is - i.e.
>> > if the extents have been accepted by the host etc). That stuff is all
>> > defined by the spec, but not yet in the QMP interface.  At somepoint
>> > we may want to add that as a state query type interface.  
>> 
>> ... this, too.
>> 
>> In review of v5, I asked whether this interface needs to be stable.
>> 
>> "Not stable" doesn't mean we change an interface without thought.  It
>> merely means we can change it much, much faster, and with much less
>> overhead.
>> 
>> I understand you want it chiefly for CXL development.  Development aids
>> commonly don't need to be stable.
>
> Ok. If it makes sense to make this unstable for now I'm fine with that.
> I don't see why it would change beyond in backwards compatible fashion
> with new optional fields to cover future specification updates allowing
> for more information. However I've been wrong on such things before.
>
> So I'm fine adding a patch on top of v8 marking them unstable for now.

I'd squash it into v8, but follow-up patch works for me, too.

>> If you're aiming for stable, you need to convince us the interface can
>> support the foreseeable purposes without incompatible changes.  In
>> particular, I'd like to see how you intend to support "finding out what
>> the state is".  I suspect that's related to my question in review of v8:
>> how to detect completion, and maybe track progress.
>
> There is a need for completion information but given it's completely
> asynchronous to the commands defined here (Can be out of order, lots of
> ongoing capacity add / remove flows in flight etc) and for the hardware
> definition the feedback occurs via an event record log I'm not expecting it
> to affect the interfaces added so far.
>
>> 
>> There's infrastructure for background jobs: job.json.  We might be
>> better off using it, unless completion is trivial and progress tracking
>> unnecessary.
>
> I'll take a look, but these are not conventional background commands
> (We do have those as well, but that's a whole different set of future
> problems!)
>
> The actual command itself completes synchronously but not the flow
> it kicked off which is not background as such because it may never
> finish and involves lots of moving parts.  This is similar to any
> form of error injection.  We inject the error synchronously and that
> creates a bunch of records in various registers / firmware etc but
> the actions the host OS takes are asynchronous and may only happen
> when it decides to poll some register or a driver loads much later.
>
> So I'm not sure if job.json approach fits.

Neither am I, but I want you to be aware of it, so you can make an
informed decision :)

>> [...]

