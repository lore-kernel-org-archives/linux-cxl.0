Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE7336EDA
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015676; cv=none; b=NDsfoXlI0Yfxj53JlW4MArMkkQJrB8vS4mIuIjsyIubSTQu5u4DxpVC0AwUAAkdystDhGDrimr7m8MGm9rwrLgxMHFsLtVdr+BctX7LyY4toJJK+JcNziO3+eycS1iVtFj5S9+m4J4lSXxKzwcb7Mw2ZNBsjflaGS6B2Z8PhyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015676; c=relaxed/simple;
	bh=Nfn2hGeOEFy8r5bnOzcrLcOWlsUAAE8KB8Y+srEx3bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MUtZvxc/WfeTZGKdkTNayPhzWv94AeYSc2AlzNbY3LldaKcvzlDld+QxJ3I1EEIH7rH7uFhlkgZ+Y6DjVx/Qen4Ei3QQErdtvbnEZ8bPX2au8XQMJkSAW1pYOM1tgV/9x7rdOb3y4aFUyWDFvJtkUG+SiOcVdraFZWJqEj+pUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J119VtMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J119VtMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789015674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U2A3OgVMxcHHdCjgS4ebzHoZ9OS3sHLFyVUP0LuvR4M=;
	b=J119VtMkSIBSEezkYKkQm30O7PWF/13ecjQDZI/fYLXv5XizFZFE8oV5257V0pSaaCMZ9H
	Ga9Liu4lwvUG8Q7czaTVIyg0tE0Qo9zp7f5DDQYpX+nDbBjdlDSW6qcmUikjJhj+DWbD8E
	HUQ2vXYNIbF23ngDhM+B2WbFSM1mDGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-NhxSHBubOFWgm1Jd3D1Ezg-1; Thu,
 10 Sep 2026 00:47:50 -0400
X-MC-Unique: NhxSHBubOFWgm1Jd3D1Ezg-1
X-Mimecast-MFC-AGG-ID: NhxSHBubOFWgm1Jd3D1Ezg_1789015668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C53291956095;
	Thu, 10 Sep 2026 04:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FA40195608B;
	Thu, 10 Sep 2026 04:47:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id ECD3221E6A04; Thu, 10 Sep 2026 06:47:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
  Alex Williamson
 <alex@shazbot.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Lukas Straub <lukasstraub2@web.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Hanna
 Reitz <hreitz@redhat.com>,  linux-cxl@vger.kernel.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 05/10] qapi: convert simple enum intros for cypto.json
In-Reply-To: <20260909041640.69080-6-jsnow@redhat.com> (John Snow's message of
	"Wed, 9 Sep 2026 00:16:35 -0400")
References: <20260909041640.69080-1-jsnow@redhat.com>
	<20260909041640.69080-6-jsnow@redhat.com>
Date: Thu, 10 Sep 2026 06:47:43 +0200
Message-ID: <87jyothfv4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: xSLfZ6amQ04O62YpvDZOlWrXeW9bQPqbjyTHokToWRc_1789015668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/crypto.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 5e395bc10c7..f85d1cebed3 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -10,10 +10,10 @@
>  
>  ##
>  # @QCryptoTLSCredsEndpoint:
> -#
> -# The type of network endpoint that will be using the credentials.
> -# Most types of credential require different setup / structures
> -# depending on whether they will be used in a server versus a client.
> +#     The type of network endpoint that will be using the credentials.
> +#     Most types of credential require different setup / structures
> +#     depending on whether they will be used in a server versus a
> +#     client.
>  #
>  # @client: the network endpoint is acting as the client
>  #
> @@ -126,11 +126,11 @@
>  
>  ##
>  # @QCryptoIVGenAlgo:
> -#
> -# The supported algorithms for generating initialization vectors for
> -# full disk encryption.  The 'plain' generator should not be used for
> -# disks with sector numbers larger than 2^32, except where
> -# compatibility with pre-existing Linux dm-crypt volumes is required.
> +#     The supported algorithms for generating initialization vectors
> +#     for full disk encryption.  The 'plain' generator should not be
> +#     used for disks with sector numbers larger than 2^32, except
> +#     where compatibility with pre-existing Linux dm-crypt volumes is
> +#     required.

'plain' should be @plain, and this part of the text should probably go
below the member descriptions.  I spotted related issues in review of
your "[PATCH 12/12] qapi: convert simple command intros for
block-core.json" and "[PATCH 5/5] qapi: convert simple event intros for
block-core.json".  Same reaction: leave for later, note future work:

1. Add missing markup to argument / member / feature references.

2. Review and improve doc comments where the intro refers to arguments /
members / features.

>  #
>  # @plain: 64-bit sector number truncated to 32-bits
>  #

