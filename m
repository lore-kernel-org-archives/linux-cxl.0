Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBA43B6CB
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183411; cv=none; b=OgLp7gxATpziKO9d8uIpGdjHBYS76B9IwR9FIZIhlFp1H4dAuQSl1U2AbDdnT5UcQJv8s295CA6tv6Kx9IUUSeL2GDlxfvWtGLhU4nQ/E6hldEcglXV9HkiudAJOW2wRd5ghWpXGr7aOdVc6PhL0YzBgUVvEsjprQxUkG2cnePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183411; c=relaxed/simple;
	bh=Wn3aDeNrh/1IIcV//UAZjbYsqKYg/qFaAeUZ+mhvKfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gvLtXBV7Bnn4jxfGBnYcAQ64RP4xy3TMS87yfQD1Da8n7mSnZ1/b2Z6CBnJciPa8yWEg9pbgiNp1K2Dw7h5cTj4ZnvqxNvzS3341COs+mMklmfW3zVxWtkj+lNxra5HLptafvs+8ElnfZ/SpoTCwz7iVr/uvYEM1p92wx0SvHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/cOKIsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/cOKIsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788183408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCs2Aq9tg9fBZkM3AoyGj6bTEL9C6nYwd+ohMUtyCFo=;
	b=S/cOKIsQyBPjTreFRUtvXBruon3uyEWOcV6Q/U+iP2eSFdfX7R96mOqfVbelexo46SIx4z
	gGvZs4HL+Fc5HnRJICzfMUNAnbuVAIhWeC0ByjGiYjcWN22sUIkhojKAesUirJtr8Qe5w1
	BJ6euHJIFqSypbIc2mspEusBS+J9d6U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-p2frzGdJOeKlgdYB206L-A-1; Mon,
 31 Aug 2026 09:36:43 -0400
X-MC-Unique: p2frzGdJOeKlgdYB206L-A-1
X-Mimecast-MFC-AGG-ID: p2frzGdJOeKlgdYB206L-A_1788183399
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A94183F9DB;
	Mon, 31 Aug 2026 13:36:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A0FA3000223;
	Mon, 31 Aug 2026 13:36:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 24F5821E6837; Mon, 31 Aug 2026 15:36:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
  linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
  qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>,
  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
In-Reply-To: <20260826193840.2152000-43-jsnow@redhat.com> (John Snow's message
	of "Wed, 26 Aug 2026 15:38:39 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
	<20260826193840.2152000-43-jsnow@redhat.com>
Date: Mon, 31 Aug 2026 15:36:34 +0200
Message-ID: <87pkyye7j1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: _nDzJBPrtHMt4Jz64DidhFC9bPpRvsMgvKHf9kzs8As_1788183399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 208 ++++++++++++++++------------------------------
>  1 file changed, 73 insertions(+), 135 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 2d63c1bac3b..3a5c6df9cff 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json

[...]

> @@ -469,8 +453,7 @@
>  
>  ##
>  # @NumaOptions:
> -#
> -# A discriminated record of NUMA options.  (for OptsVisitor)
> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>  #
>  # @type: NUMA option type
>  #

The parenthesis is questionable.  As long as it's there, this isn't
"very trivial".

> @@ -488,8 +471,7 @@
>  
>  ##
>  # @NumaNodeOptions:
> -#
> -# Create a guest NUMA node.  (for OptsVisitor)
> +#     Create a guest NUMA node.  (for OptsVisitor)
>  #
>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>  #

Likewise.


[...]

> @@ -1156,10 +1125,9 @@
>  
>  ##
>  # @BALLOON_CHANGE:
> -#
> -# Emitted when the guest changes the actual BALLOON level.  This value
> -# is equivalent to the @actual field return by the `query-balloon`
> -# command
> +#     Emitted when the guest changes the actual BALLOON level.  This
> +#     value is equivalent to the @actual field return by the
> +#     `query-balloon` command
>  #
>  # @actual: the logical size of the VM in bytes.  Formula used:
>  #     logical_vm_size = vm_ram_size - balloon_size

Two sentences, i.e. not "very trivial".

[...]

