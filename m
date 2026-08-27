Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78511405C2F
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837994; cv=none; b=dqXbnLIZEIEo3HXqEpEic2DKzl3JpkRtnr+V7X+qDVb5e8NxsMab4E/023ydxS8eEa45jdY1JeOeKhJMGX6JuHwlz+kzM2uGwy6Y9tiaZs4jM/BXLSc0zppFWZF4c7tP0JOtjeiSaftT+g7/kUnYhmcWQKHfwz/+CHrVEKU7Gaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837994; c=relaxed/simple;
	bh=oy47AfehaWefzayjCfUfA2SsBZ4BUEQvy7XOKI6kiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OaxmDKdHY4ejL8BZFu6BQDAvjtwgiCRiKAxLAqQ/INvaddvp42Mipvg01OSyNjBzrsirggfg3Rj6m+oo1bhC8VgoQvLy5qEh2baOn/ez+WTDtzMdZDBCdp3jOvrR2plOuwL9NYyhxsUXHhG/TP70eiOCpO1/rUlZ68yuZWPJls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgQ4JNsy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgQ4JNsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787837987;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qH3mShZB+XOmnEkPOPaAr/PtkuZBNwHw182S/VQMPXc=;
	b=UgQ4JNsyW4w0NJ3ZwsveLHJF6DwNjIrUedN2N0NnF0+mjzTOY2hh1RLzxia3NIpjE4dPdc
	iqslzDuYFur6nPnuda7FgVJsgbs7Qb+TGgPNnuUX3CSNo8R6CUyg3wYiFvjfuMzGXtknaJ
	HVRqk8X3+F2WvPAM3/N0Pr5sM2gOmys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-EVneE2scN0KFRW4rq_rn7A-1; Thu,
 27 Aug 2026 09:39:44 -0400
X-MC-Unique: EVneE2scN0KFRW4rq_rn7A-1
X-Mimecast-MFC-AGG-ID: EVneE2scN0KFRW4rq_rn7A_1787837977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BE93195DE19;
	Thu, 27 Aug 2026 13:39:36 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67DC418005AD;
	Thu, 27 Aug 2026 13:39:26 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:39:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
	Alex Williamson <alex@shazbot.org>, linux-cxl@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
Message-ID: <apA-CzGqrlFNfjp5@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-2-jsnow@redhat.com>
 <ao_-_38raHK0rWkX@redhat.com>
 <87jypb90c0.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87jypb90c0.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: lCLNZ7vZoxoTEZFGr9XUR9abdQr9IoMr9w9pQlSO45Y_1787837977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 03:09:35PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  qapi/error.json | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/qapi/error.json b/qapi/error.json
> >> index 54cb02fb880..a53b13e55c9 100644
> >> --- a/qapi/error.json
> >> +++ b/qapi/error.json
> >> @@ -9,8 +9,7 @@
> >>  
> >>  ##
> >>  # @QapiErrorClass:
> >> -#
> >> -# QEMU error classes
> >> +#     QEMU error classes
> >
> > Where is this need for indent coming from ?  From the POV of someone
> > writing comments, the need to indent the introductory text like this
> > feels very counter-intuitive, an exception from any other inline
> > docs syntax I've typically used. Is there any way we can avoid this ?
> 
> The cover letter explains the need:

Yes, I just didn't see the connection from that, to the use
of indent.

> 
>     This is being done primarily for the benefit of the forthcoming
>     "inliner", a feature for the rendered HTML QMP documentation that
>     seeks to "inline" QMP command argument documentation into the argument
>     list for each command.
> 
>     There are two main motives here:
> 
>     (1) We want the split between the "introduction" and "details"
>         sections to be mechanically obvious, so that auto-generated or
>         inlined documentation has a well-defined, obvious spot to go.
> 
>     (2) We do not want to inline irrelevant, introductory text describing
>         structures to be copied into command documentation.

So IIUC, you're saying that we are going to rely on indentation
to distinguish introduction from details ?


> Note that the inliner elided Netdev's Intro "Captures the configuration
> of a network device."
> 
> However, when Intro and Details bleed together, the inliner elides more
> than it should.  I consider that a fairly serious issue.
> 
> I'm afraid forgetting to mark the end of Intro with "Details:" would be
> a common mistake, easy to miss in review.  So I explored possible
> alternatives:
> 
>     Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
>     Date: Wed, 15 Apr 2026 11:43:45 +0200
>     Message-ID: <87zf341ru6.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87zf341ru6.fsf@pond.sub.org/
> 
> John is working towards "3. Make the end of intro syntactically obvious"
> always, specifically "3c. Indent intro like descriptions and tagged
> sections" with the ultimate goal to reject unindented Intro.  That way,
> we cannot write an Intro with an unclear end.  John, correct me if I'm
> accidentally misrepresenting your work.
> 
> Questions?  Better ideas?

As an author, how substantive is "Intro" expected to be? I guess on
QAPI docs I've written I've not ever been aware of there even being
a distinct concept of Intro vs Details to think about. It is all just
some lines of prose to me.

My only alternative idea to indentation would be to declare that the
"Intro" is always the 1st paragraph of text and anything beyond that
is the "Details". That might match up with the way that contributors
naturally write text where the 1st paragraph conveys the key idea,
such that they dno't need to think about Intro vs Details as a
concept.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

