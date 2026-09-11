Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A34469840
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117331; cv=none; b=XFDDWRQ/+Y08Lp7wwzQzdOAQyBCUB59919dsgKWE1T9UAMFBOSQ5cNBQWxfYEXU4liyhYWw/mMKPs0Hd8sS2lnZvziyjBbfT6CeYaUy6HhB4caaF4eE5BtZ/JbdAMoBlo9J11prYBkMM5LGoxiaDJZvTeMMKQ9z2DLLqCo6Hwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117331; c=relaxed/simple;
	bh=Ps9Er26VgZGpjiljwJL/VLvwr70ac/HilgVuzwnOhpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2AfX9ddYj2p0dZP9SRnCuNlxUogi93BeQFFygm2cNCMkPSL8yHhihsc4JanqcDl9LyjWz3EoNXwbNhc6ixX5P1cp4wHxvGWUToQa4+b5Pig0LXhSGHcXjdTzh9cXxS3RZHNzRCEh08uUiPhHW7ZsdhsB3io0wGflxCy3U15oMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDkmHH9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDkmHH9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MJBu7fue3ktY+Ym4o58URFtWuH4NUmP3N+rZtbuGq4=;
	b=GDkmHH9f2Zf2G/AJk1gPA+Rj7UyZBO1Cve70OjPdTbNfL515Ut2E9yJZeZIWMT/AVF2VyP
	crIhglFTWaAPo/csYewLdcICNhXbY8ArK/JrCaNChAin5KbiDHJY0lt1QVdbbpINg0Sbwj
	cRUvO30K/dPjqpBOWUsxYich8qhMaHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-3r8QaFn9NM-2495BwnmkiA-1; Fri,
 11 Sep 2026 05:01:59 -0400
X-MC-Unique: 3r8QaFn9NM-2495BwnmkiA-1
X-Mimecast-MFC-AGG-ID: 3r8QaFn9NM-2495BwnmkiA_1789117318
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35E721800613;
	Fri, 11 Sep 2026 09:01:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7BE11955D89;
	Fri, 11 Sep 2026 09:01:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5A60021E6A04; Fri, 11 Sep 2026 11:01:55 +0200 (CEST)
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
Subject: Re: [PATCH 03/10] qapi: convert simple data struct intros for
 acpi.json
In-Reply-To: <20260910203856.99003-4-jsnow@redhat.com> (John Snow's message of
	"Thu, 10 Sep 2026 16:38:49 -0400")
References: <20260910203856.99003-1-jsnow@redhat.com>
	<20260910203856.99003-4-jsnow@redhat.com>
Date: Fri, 11 Sep 2026 11:01:55 +0200
Message-ID: <87zexo88l8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: gnJn-PZPgbgs7gIBWIbw7BuDZede6_DDhA6mmvN2WZI_1789117318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/acpi.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/acpi.json b/qapi/acpi.json
> index d2c59df30b2..291a04a7ea4 100644
> --- a/qapi/acpi.json
> +++ b/qapi/acpi.json
> @@ -81,10 +81,9 @@
>  
>  ##
>  # @ACPIOSTInfo:
> -#
> -# OSPM Status Indication for a device.  For description of possible
> -# values of @source and @status fields see "_OST (OSPM Status
> -# Indication)" chapter of ACPI5.0 spec.
> +#     OSPM Status Indication for a device.  For description
> +#     of possible values of @source and @status fields see "_OST (OSPM
> +#     Status Indication)" chapter of ACPI5.0 spec.
>  #
>  # @device: device ID associated with slot
>  #

Another instance of "text that refers to arguments should probably go
below the argument descriptions", and again leaving for later.

