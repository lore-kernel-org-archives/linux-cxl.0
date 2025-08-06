Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFB220F3E
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467721; cv=none; b=dnkCZbCaNb3ua21D+i3cnz/v6olcouBrr52waeROSyYhT7w459j45Bzxgzyc4YCwOdo39hsXJ3C9RQCsO+V25pH535x0Drwijyj0CLml/jcZhvVPwYl2IlsKY/VUMG1N7i89rX4xX0dX2xFAs8zpUZyM5llTe189nGUfASDYuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467721; c=relaxed/simple;
	bh=iIOLEcJshtKlXseg9B0hu5VNrIlPeJfsqhTyd+ztscs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mL/sMBDyfqyC/z/FDcUQdz3O3+Gqfg6BT6o98l7vcayVA7GD4KqrZ8H2q73zWw79S9/OIsGSWzGPD8DnOrQITuLcHgXzHx1598ERM2A7U9H3v5FlXRNLldjQjg9jryVil6X6jBOk/xvkv2xHviprwRISupnZ8yVDcCNdbNml4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+WleBFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+WleBFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754467716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPtvIjzKcpv8YfEw3+TrvU4XWpxM4d3bHoKpLzFYhzw=;
	b=F+WleBFnTJ0v9F+P5fCobd5UvKmiYLQ7fo7quicBHVmurSi/Gx29e/Mmk09/JzQjya/Z/f
	+PmxfPU5qHrQ0uJY5/Gs82sDOlYCPs0rHRkopHriLCAEFGNX49mecTn4F0HRnBPMbgjdjz
	iC5azrHrXn71dB0SiKiIR7OxM3C4lHA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-IF-cHPSLNsC-XIosPZ0A0g-1; Wed,
 06 Aug 2025 04:08:33 -0400
X-MC-Unique: IF-cHPSLNsC-XIosPZ0A0g-1
X-Mimecast-MFC-AGG-ID: IF-cHPSLNsC-XIosPZ0A0g_1754467712
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAEEA1955E95;
	Wed,  6 Aug 2025 08:08:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 991C23000198;
	Wed,  6 Aug 2025 08:08:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BC62421E6A27; Wed, 06 Aug 2025 10:08:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
  <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
  <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 4/7] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20250721172228.2118-5-shiju.jose@huawei.com> (shiju jose's
	message of "Mon, 21 Jul 2025 18:22:25 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-5-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 10:08:27 +0200
Message-ID: <874iukq3d0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

shiju.jose--- via <qemu-devel@nongnu.org> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index f84088c0b9..118dec5362 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -261,6 +261,16 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#     See CXL r3.2 Table 8-59 Memory Module Event Record.
> +#
> +# @is-comp-id-pldm: Flag represents device specific component identifier
> +#     format is PLDM or not.
> +#
> +# @sub-type: Device event sub-type.
> +#     See CXL r3.2 Table 8-59 Memory Module Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-memory-module-event',

Again, partial copy of stuff the previous two patches added to related
commands.

> @@ -272,7 +282,9 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'uint8',
> +            'sub-type':'uint8'
>              }}
>  
>  ##

