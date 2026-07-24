Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCC3C2BB9
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880289; cv=none; b=oxr7pkOXaeCjVpmmbSUm6AFhS03ksePmmK+F1gMp2w/cHsdWiv4DyFoPyWAUlP/EHyq28xBjZUUk3C5D2fQZ/hmzoFcDJ4Aj/9vlrZaAtgdhIBVnQ9iGYHB1BYXLovbBPH8Du7Eou3DBojZSSm2wnDhhD6X0vNYbEExBFmuvED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880289; c=relaxed/simple;
	bh=G1NNR208d5RHpjW5S00KOtiHySiyn2YfPUhemZZW3rA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwbGNc+f63X8SRN2nuti98ICfLAp8fEUstpJbKfCgGtAvSOWBElOBtNZGd84c1pRJ40n8wXnNrlv4KWbDPrUATP1qkty5K8bPUpvBRMolcgadY+9DCcoVI/ppu8uI4np10sU6NIX5PxXhXaXHGSzQ4CqbIdXeMCyjOaa6lJbt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRU3/QTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRU3/QTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784880283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVKEwiRe4suQZ48gcSUJ/fLMBLeVgURcgJ8pJ/tcVok=;
	b=eRU3/QTO/6INT9wMsprhQ6xXarWO7cVYsS2vwPpZFXkP/ctKhx2FG+ujqfhZsglwgd/b7x
	OUeu6eNQ07Yxg+qwzYfX6i5XWOxx1glW8Eyvy/v8z8GrGto/DIsn7WrlJPyXPBgHSVIYAL
	4ZrLlgLnF+Cki9smKFHXxDkhW1hGZa4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-2Ff3ybS5MdyVE0iWcp73ug-1; Fri,
 24 Jul 2026 04:04:40 -0400
X-MC-Unique: 2Ff3ybS5MdyVE0iWcp73ug-1
X-Mimecast-MFC-AGG-ID: 2Ff3ybS5MdyVE0iWcp73ug_1784880277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 205961801332;
	Fri, 24 Jul 2026 08:04:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A73B11800240;
	Fri, 24 Jul 2026 08:04:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4CCD621E6920; Fri, 24 Jul 2026 10:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
  qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
  linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
In-Reply-To: <87ik65g8xm.fsf@pond.sub.org> (Markus Armbruster's message of
	"Thu, 23 Jul 2026 14:57:41 +0200")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<87ik65g8xm.fsf@pond.sub.org>
Date: Fri, 24 Jul 2026 10:04:31 +0200
Message-ID: <87h5lobypc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -k0vZHT7mUQLvbJpVKgE0DkN9cg_4LAugQSvx3hDoTs_1784880277
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Markus Armbruster <armbru@redhat.com> writes:

[...]

> Converting single first paragraps is mechanical.  For it to be correct,
> this single paragraph must actually be the overview, and not some other
> crap.  I expect it to be almost always overview.  Not sure how to best
> look for the exceptions.

The separation truly matters only when the inliner inlines the doc
comment.  It potentially matters when it would inline it if the type was
used differently.

If I remember correctly, the inliner inlines doc of struct / union base
type, union branch type, command / event argument type.

Argument can only be struct or union.  Base and branch can only be
struct.

We talked about maybe inlining return types some day.  This would be
struct, union, or array of struct or union.

So, for anything other than struct and union, the inliner doesn't get
involved, and separating the overview cleanly is just a matter of
writing style.  I'm not sure we care.  Even if we elect to care,
cleaning it up is hardly this series' business.  In short, your
mechanical conversion of single first paragraphs to overview syntax
should be fine even where a paragraph's contents isn't clearly overview.

Structs and unions, however, could use an eye-over.

[...]

