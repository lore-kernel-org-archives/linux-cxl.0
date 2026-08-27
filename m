Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED63F2118
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821850; cv=none; b=sd6T8f0kj1AdufVg57K5ELSxlc3tte3/FnRhLWM8kL0j5RU8oREP5g7bg/2OaC/GET1kpXAdf+XulsWfROrnqFAXYmfwu63viBBlad5KJdzouOCptBdyaxfOMsJD7QLEM359XC6ChlQfDyhXDkkPNS/d8AxHR4BDwM3xDzTJOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821850; c=relaxed/simple;
	bh=vwuUHj96KHqE5ijYrASNifndHHwz2LIx2+F19r3Hmq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C0Tvqo1LsQ/IGFgILuEVIwYbSmQ6bwhXP7zXkCN4CWE0vtAe8UhtEJlgDA7j65Y9akUzP4S2d8HrodWNwbsRQS8a3ibdPimwC2o/2ULuiospJnoFRkYw82U7U/4N4ZAIu37So+5o/tpffm9BpbqlAvNjvi2zc5GnSO6qHCBFhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWyFj8tQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWyFj8tQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821847;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=EDuF+iQrFQ3v8cejBaPxhDBh3hQD9PNSHjqcUgHUNgo=;
	b=HWyFj8tQc7Ao6Z9kKMuFFg6NqgyT9onwikNkdKrfqf4XwCv4MppOhtEJ2EnGCHaFN1Al9f
	x9dI22MS6UUwp+NYY7H0Pypcav0SIuSWuOy023OU/ge6U2MTrhRGjwT+Obv06BS6bsKSWu
	U1Kh7hI6Hg757O5jOfODUbLwcFkDkAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-pvNHjy4-NZCv5SMnHhGB6A-1; Thu,
 27 Aug 2026 05:10:42 -0400
X-MC-Unique: pvNHjy4-NZCv5SMnHhGB6A-1
X-Mimecast-MFC-AGG-ID: pvNHjy4-NZCv5SMnHhGB6A_1787821839
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1E901955F6D;
	Thu, 27 Aug 2026 09:10:37 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A43C1800346;
	Thu, 27 Aug 2026 09:10:26 +0000 (UTC)
Date: Thu, 27 Aug 2026 10:10:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
	linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
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
Message-ID: <ao_-_38raHK0rWkX@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-2-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260826193840.2152000-2-jsnow@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: EbRRcKuBOpuS5nIydkG1_6u0oSlkCEpvnQ6uaCLw7_Q_1787821839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/error.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/qapi/error.json b/qapi/error.json
> index 54cb02fb880..a53b13e55c9 100644
> --- a/qapi/error.json
> +++ b/qapi/error.json
> @@ -9,8 +9,7 @@
>  
>  ##
>  # @QapiErrorClass:
> -#
> -# QEMU error classes
> +#     QEMU error classes

Where is this need for indent coming from ?  From the POV of someone
writing comments, the need to indent the introductory text like this
feels very counter-intuitive, an exception from any other inline
docs syntax I've typically used. Is there any way we can avoid this ?

>  #
>  # @GenericError: this is used for errors that don't require a specific
>  #     error class.  This should be the default case for most errors
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

