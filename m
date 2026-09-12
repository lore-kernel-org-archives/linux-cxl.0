Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AD374E41
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196307; cv=none; b=pkASehGkyvhJ7nn9044NZ7S+doFGeZ5OptO/GMfC9sZ5BGDW/G47ehqTTbjAkiXk1JJrDev+wkbx4oll92TKYnx4KEfPX406NMRnud6IxqZgoaQcp5veopwOLHo7yT4W/fpctQIQuiOt+YYEP9jV386MC0neoWSNcL8T7/Ne7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196307; c=relaxed/simple;
	bh=mtEOS4yr/y3V6uBShRlxP5JEZhjrsJrP5RHDhlenikE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfBWTbx5CqHJzfxa6PyV18u8km5cXkiIh/oagYPcrXotHyRBw1pLj3Aa/74ykdAmXIKM6HCDOAgevhyhCZss7m58+sx+cFL66L54CRfNg5t48XY9qTAEv3qmphPbO26FqQGrC8Sd23KJ9KVPyF7xn0Dornyttd1T9+0z/qcLoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHKNsW11; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHKNsW11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789196304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lM0GoqUIpmQ4AYhx53gaB+m4sN2W+MFyviY6sYw4uW4=;
	b=hHKNsW115/GRQwkIM/N81ObKZiXTBsvdb8+bbZt1UusgGlTFn4HpA4J+5wwb25vEOPlf4W
	0Kk0/VsQkTUuQVkN48YzmCkcZnd7bE0SEChk+iBdM3lj201JIUlFnbI2og3gW7BHmyv72B
	FHiAQ69p6ndH5wXR/LPcqZidzq/3PAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-Orw_XzzyOV-piNqaeXar_g-1; Sat,
 12 Sep 2026 02:58:20 -0400
X-MC-Unique: Orw_XzzyOV-piNqaeXar_g-1
X-Mimecast-MFC-AGG-ID: Orw_XzzyOV-piNqaeXar_g_1789196299
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5342193EF71;
	Sat, 12 Sep 2026 06:58:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13D4C195608B;
	Sat, 12 Sep 2026 06:58:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 90E2921E6A04; Sat, 12 Sep 2026 08:58:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric
 Blake <eblake@redhat.com>,  Jonathan Cameron <jic23@kernel.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 5/6] qapi: convert intro sections with "TODO" markers
In-Reply-To: <20260911172200.227914-6-jsnow@redhat.com> (John Snow's message
	of "Fri, 11 Sep 2026 13:21:59 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
	<20260911172200.227914-6-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 08:58:14 +0200
Message-ID: <877bkr3qih.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: JMliCEC-joWNSx7Z60wmkTHEnbXfL3Kh2N25q6zsUWs_1789196299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> This patch converts intro sections that are immediately followed by a
> "TODO:" that was formerly used to demarcate the stub member insertion
> point.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json   |  7 ++-----
>  qapi/migration.json | 10 ++--------
>  qapi/net.json       |  9 +++------
>  qapi/yank.json      |  5 +----
>  4 files changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 13875fc4642..108033b6d64 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1216,11 +1216,8 @@
>  
>  ##
>  # @query-memory-size-summary:
> -#
> -# Return the amount of initially allocated and present hotpluggable
> -# (if enabled) memory in bytes.
> -#
> -# TODO: This line is a hack to separate the example from the body
> +#     Return the amount of initially allocated and present
> +#     hotpluggable (if enabled) memory in bytes.
>  #
>  # .. qmp-example::
>  #

I see output change from

    Command query-memory-size-summary (Since: 2.11)

       Return the amount of initially allocated and present hotpluggable
       (if enabled) memory in bytes.

       Return:
          "MemoryInfo"

       Example::

          -> { "execute": "query-memory-size-summary" }
          <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }

to

    Command query-memory-size-summary (Since: 2.11)

       Return the amount of initially allocated and present hotpluggable
       (if enabled) memory in bytes.

       Example::

          -> { "execute": "query-memory-size-summary" }
          <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }

       Return:
          "MemoryInfo"

Similar for the other hunks.  Surprising.  What's going on?

[...]

