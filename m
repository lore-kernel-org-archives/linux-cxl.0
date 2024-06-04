Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD1142E9C
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492709; cv=none; b=ineqteFVLCPj54KH6HDbI9FkEA4tYbmXhm88gWeajsYBbdjJYrI5nanu8MkPO0HAVEuiajIWtB1rbHb7wqVX34Bui3uaX7QZgBNZtVufEtkvl/m2ryo5PH2SV1BISM/+DlJejUKXR7V74GslfxPRfoPz5wcm6zR47TuVDRIpHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492709; c=relaxed/simple;
	bh=rXF08ziuRzVySAh1ZPW1e1gAzCY852KJ29VoUEXTkU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NZJ7QZuP8hvDSZob4v3jcFEBmWKZW99UURoJPUfeKHF8/0DTQaFYu8+m2TEkOnkh8kBNSuJr1iks0aBu3gYOyLhPd/YvqaFaNoWcB7OnEQrPK+Th79pLPEvrlvuKQevLxF7iv2F4d+5PxGK2gjRUXhGtFXQGNNli2hpYcS7GIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLlXCkco; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLlXCkco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717492707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJxLCaBaIuRGcA0TH+Rg+hOm7JhuMGzVkNLWQKfNTtc=;
	b=FLlXCkcoFzmomHUf8zPy8igUY1HvnMBMqXKQjfRYpewpUtpi8b6+yV71hfPyfyUybELOwU
	zcnAR7obp3rHXeRxVFqzwNMiVt/EcQDlLDL2PsQoiL69lnJfCpYad8hKxGxJuiERz0C3Gl
	Dna7WyRy4bNQ/QZgwAXt924hBs7wyK4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-fZA_7lFZOYKinfcPFuq64Q-1; Tue,
 04 Jun 2024 05:18:21 -0400
X-MC-Unique: fZA_7lFZOYKinfcPFuq64Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6074E3C025CE;
	Tue,  4 Jun 2024 09:18:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5591A4D6D;
	Tue,  4 Jun 2024 09:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 61B0321E668A; Tue,  4 Jun 2024 11:18:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: fan <nifan.cxl@gmail.com>,  <qemu-devel@nongnu.org>,
  <linux-cxl@vger.kernel.org>,  <gregory.price@memverge.com>,
  <ira.weiny@intel.com>,  <dan.j.williams@intel.com>,
  <a.manzanares@samsung.com>,  <dave@stgolabs.net>,
  <nmtadam.samsung@gmail.com>,  <jim.harris@samsung.com>,
  <Jorgen.Hansen@wdc.com>,  <wj28.lee@gmail.com>,  Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240501155812.00002ec3@Huawei.com> (Jonathan Cameron's message
	of "Wed, 1 May 2024 15:58:12 +0100")
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org> <ZjEnwPeoivsW8y5Z@debian>
	<20240501155812.00002ec3@Huawei.com>
Date: Tue, 04 Jun 2024 11:18:18 +0200
Message-ID: <87cyox9icl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

I finally got around to read this slowly.  Thank you, Fan and Jonathan!

I'm getting some "incomplete" vibes: "if we ever implement", "patches
for this on list", "we aren't emulating this yet at all", and ...

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

[...]

> Only thing I'd add is that for now (because we don't need it for testing
> the kernel flows) is that this does not provide any way for external
> agents (e.g. our 'fabric manager' to find out what the state is - i.e.
> if the extents have been accepted by the host etc). That stuff is all
> defined by the spec, but not yet in the QMP interface.  At somepoint
> we may want to add that as a state query type interface.

... this, too.

In review of v5, I asked whether this interface needs to be stable.

"Not stable" doesn't mean we change an interface without thought.  It
merely means we can change it much, much faster, and with much less
overhead.

I understand you want it chiefly for CXL development.  Development aids
commonly don't need to be stable.

If you're aiming for stable, you need to convince us the interface can
support the foreseeable purposes without incompatible changes.  In
particular, I'd like to see how you intend to support "finding out what
the state is".  I suspect that's related to my question in review of v8:
how to detect completion, and maybe track progress.

There's infrastructure for background jobs: job.json.  We might be
better off using it, unless completion is trivial and progress tracking
unnecessary.

[...]

