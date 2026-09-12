Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A463542F8
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198479; cv=none; b=YkT/ELmQwgMFBpu4qTe+XB1b6bJINBJ1Ahcgo+0sov3hJBmgCwpS/d+j7SgrVbBzMyyEbh2IKwG7CX0OXPiPVKMbOa4vLXtdOrhDXZIxOYik56Q6sPjVQEOYs93nWMNVlKfl7H3yfTeokzmhNoYsF82gsXi/6m3HvzqkUXenPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198479; c=relaxed/simple;
	bh=WCgcBw4m53eGTf5CXLnAduLsSp75x84fAi3IqRj8gko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LjYFr3ezyas7yNluKWWAB8LhLwIriaLeubgYOfd5vCak+MW90/MJJ4tYb5qMNIu4+gBlEd2bCmzkrHp6dUuVw7/Tehkx6YqtpoFbpTGxkfokY/wQOxWzghLmNIwl57kBVyMc4Mr3ZRGODYRfMMGY9LXicXrft9CepXpMj85XAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGChywuG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGChywuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789198476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=milOYn+egTVPgep39dcg4cxxAUlOsDpdyziKQ5Gn3pM=;
	b=hGChywuGR1MLkL52bV/pipT9nuDGk9KAg5vSxTMc44C0J7oGJVvG1RELJ7yhsSoE3+JwTN
	bPcMsRHn1UXuXZw2roIjU1jinnOGVD3A2PPolWXt+6yv2F/S0Yz33Hj/LbyLuAVPnn9muy
	1CM6p5r+6VNlFAQde4yTH+0aMY6vHuA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-RRoGBTgoMR2QI0_6mjf2yA-1; Sat,
 12 Sep 2026 03:34:32 -0400
X-MC-Unique: RRoGBTgoMR2QI0_6mjf2yA-1
X-Mimecast-MFC-AGG-ID: RRoGBTgoMR2QI0_6mjf2yA_1789198470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C4AF18005AA;
	Sat, 12 Sep 2026 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21DD41800446;
	Sat, 12 Sep 2026 07:34:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AD1CE21E6A04; Sat, 12 Sep 2026 09:34:26 +0200 (CEST)
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
Subject: Re: [PATCH 1/6] qapi: convert remaining simple intros for
 block-export.json
In-Reply-To: <20260911172200.227914-2-jsnow@redhat.com> (John Snow's message
	of "Fri, 11 Sep 2026 13:21:55 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
	<20260911172200.227914-2-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:34:26 +0200
Message-ID: <87ik4a3ou5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: uo6oCTqfhozxppv7noGZU1lmVdQCAfOJEX5T-ntQL7A_1789198470
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-export.json | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 2893c6456d5..e9f7e72c8ee 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -37,10 +37,9 @@
>  
>  ##
>  # @NbdServerOptions:
> -#
> -# Keep this type consistent with the `NbdServerOptionsLegacy` type.
> -# The only intended difference is using `SocketAddress` instead of
> -# `SocketAddressLegacy`.
> +#     Keep this type consistent with the `NbdServerOptionsLegacy`
> +#     type.  The only intended difference is using `SocketAddress`
> +#     instead of `SocketAddressLegacy`.

"Keep this consistent" is for developers, and should not go into user
reference documentation.

Let's leave this for another day, just take note of future work:

6. Move comments for developers out of doc comments

>  #
>  # @addr: Address on which to listen (since 4.2).
>  ##
> @@ -50,10 +49,9 @@
>  
>  ##
>  # @NbdServerOptionsLegacy:
> -#
> -# Keep this type consistent with the `NbdServerOptions` type.  The
> -# only intended difference is using `SocketAddressLegacy` instead of
> -# `SocketAddress`.
> +#     Keep this type consistent with the `NbdServerOptions` type.  The
> +#     only intended difference is using `SocketAddressLegacy` instead
> +#     of `SocketAddress`.

Likewise.

>  #
>  # @addr: Address on which to listen (since 1.3).
>  ##
> @@ -339,9 +337,8 @@
>  
>  ##
>  # @BlockExportOptions:
> -#
> -# Describes a block export, i.e. how single node should be exported on
> -# an external interface.
> +#     Describes a block export, i.e. how single node should be
> +#     exported on an external interface.
>  #
>  # @type: Block export type
>  #

