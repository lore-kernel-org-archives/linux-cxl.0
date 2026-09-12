Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685501BD9C9
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198500; cv=none; b=nbaaeyFU30rNfwJEP0Exfh+Axa2bYuYQZLlKM5vFyb1G2M2q7CyMyxUrgECuZFczPIJHgJcU/cwU0+Sore38bG9pgIPRI1YYIGu1GnyC5wJvvJCO+AH9FkLn3awkSv2PAG3NJuIV5TyzBbiwvNU7EcVQ2vQHkiOIRakDtXEpslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198500; c=relaxed/simple;
	bh=abPPugs5aMc/zOVJAcamxs19r8NB9n/v4Tmh/RACMKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlHw+dq3KqbK7Rox5t49MzPfcbX2fDdPVeORT4KrD4GA5vuwJofh8jCBunkvNS/R1UFh71OU35GrdmEsuCksuXGC19S2plfzH5C4jhOPQNcxlNUn3E7gM4LYLDTkfNRhS/8gL6wbW1+BP66iU+0LSdVNKgR8+7qUX7RpfMVFR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlRBaCvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlRBaCvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789198498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv+ECiz5HJpXtukGfXlAJAjlWLeksgEIipoaYnmmfuE=;
	b=GlRBaCvPkoPECp1F852YwtoqET/G/qzPZzgNVkYBMvQmeITdTpMEchW2hHXU0kNKpNRkYD
	tmXIUl0ILoqR62jIuwIRTJdgAkyQsgnVmuglzWercBeDlEGCnV5N3LhxvHLMhcO4eMJE6y
	j6QxNQV1ftoDGsSpcvsU68Hq6Aa1ypQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-YOjhYsEqNsCQDcoLWpjB2w-1; Sat,
 12 Sep 2026 03:34:54 -0400
X-MC-Unique: YOjhYsEqNsCQDcoLWpjB2w-1
X-Mimecast-MFC-AGG-ID: YOjhYsEqNsCQDcoLWpjB2w_1789198493
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C516F180AE8F;
	Sat, 12 Sep 2026 07:34:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1915D18004D4;
	Sat, 12 Sep 2026 07:34:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id ACEA621E6A04; Sat, 12 Sep 2026 09:34:49 +0200 (CEST)
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
Subject: Re: [PATCH 3/6] qapi: convert remaining simple intros for machine.json
In-Reply-To: <20260911172200.227914-4-jsnow@redhat.com> (John Snow's message
	of "Fri, 11 Sep 2026 13:21:57 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
	<20260911172200.227914-4-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:34:49 +0200
Message-ID: <87h5ju3oti.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 4IkGdXk3FqytCDfryIVVmeF-l2czstc_KfcVipf1zPg_1789198493
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
>  qapi/machine.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0516112f8e8..13875fc4642 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -449,8 +449,7 @@
>  
>  ##
>  # @NumaOptions:
> -#
> -# A discriminated record of NUMA options.  (for OptsVisitor)
> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>  #
>  # @type: NUMA option type
>  #

Trivial conflict with my "[PATCH 1/2] qapi/machine: Drop misleading (for
OptsVisitor) doc".  I'll take care of it.

