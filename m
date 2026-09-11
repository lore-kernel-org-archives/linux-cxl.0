Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F382222A9
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117197; cv=none; b=QSmcWta4ywnOGfmOQkmKKwRvMTZRPNZifZV+a7irNs+DNUKkaoensnpAYqV0V99eqzF0iMm7BgoSCm3hDmzLunsaQDEqenTef/aXabIVcOKX151hR/TZuh78t/3fLFrPrsuJDJWod4Uul/D4DSWuoBYd7m51FedMqVhMPn9o8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117197; c=relaxed/simple;
	bh=fJyP0dF9mlUgC8WcKhxXVewGlBsXO8ZqkZPzH44Yu1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kq8DBCo39sUQPFeVOqGlLXIu0wZgjH93DFn/XBr7+yT7JOaqGKAYoUGU40etJyd8ma5Cpr9HNy9QUzPwxVugr6a1bfu/Ha65ZPvm95tdJN/sht3HSDH3KkJaUdt1jkeAko5TRDMtDnG0MWDLzLSk/OtwqvTZcxpHHQUmBfWYV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXk4gbtx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXk4gbtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIewDwVbSFkoIBxPtOaUyKrtR8TJ0pkLjaAft5la66M=;
	b=PXk4gbtxn8rULf7LBi+NT1XPO5C4riZ91AZmPtdnWWb44ldeiwqKuTNMsB8gxyxBQQ3wgM
	h2i06KLs6GIqJVThk96/objUgat1PzL0QMEvdpsabZH3qw/siXPGMIBesFN8dgB4KywyHJ
	h5e680BXGIB/3gVfQ3Ks21aZUsrMqQE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-aEgFXBqHNPqlxXGhazmlHg-1; Fri,
 11 Sep 2026 04:59:49 -0400
X-MC-Unique: aEgFXBqHNPqlxXGhazmlHg-1
X-Mimecast-MFC-AGG-ID: aEgFXBqHNPqlxXGhazmlHg_1789117188
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 393041800365;
	Fri, 11 Sep 2026 08:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 734C4180057F;
	Fri, 11 Sep 2026 08:59:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1FE4321E6A04; Fri, 11 Sep 2026 10:59:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
  Igor Mammedov <imammedo@redhat.com>,  linux-cxl@vger.kernel.org,  Zhao
 Liu <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Jonathan
 Cameron <jic23@kernel.org>,  qemu-block@nongnu.org,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/10] qapi: convert simple data struct intros for
 machine.json
In-Reply-To: <20260910203856.99003-9-jsnow@redhat.com> (John Snow's message of
	"Thu, 10 Sep 2026 16:38:54 -0400")
References: <20260910203856.99003-1-jsnow@redhat.com>
	<20260910203856.99003-9-jsnow@redhat.com>
Date: Fri, 11 Sep 2026 10:59:44 +0200
Message-ID: <871pb09n9b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: YB8RJK6zS5uHVm9BKcywc4gwswB5PXWs-pdWLhjPqJQ_1789117188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 942d35d7275..0516112f8e8 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -468,8 +468,7 @@
>  
>  ##
>  # @NumaNodeOptions:
> -#
> -# Create a guest NUMA node.  (for OptsVisitor)
> +#     Create a guest NUMA node.  (for OptsVisitor)
>  #
>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>  #

The (for OptsVisitor) part has become wrong.  I'll post a patch.

> @@ -596,11 +595,10 @@
>  
>  ##
>  # @NumaCpuOptions:
> -#
> -# Option "-numa cpu" overrides default cpu to node mapping.  It
> -# accepts the same set of cpu properties as returned by
> -# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
> -# node-id could be used to override default node mapping.
> +#     Option "-numa cpu" overrides default cpu to node mapping.  It
> +#     accepts the same set of cpu properties as returned by
> +#     `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`,
> +#     where node-id could be used to override default node mapping.
>  #
>  # Since: 2.10
>  ##

