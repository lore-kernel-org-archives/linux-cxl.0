Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F521CC71
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220448; cv=none; b=UUTK/7MTeIALYD4GMbD4Lu1vtNYejVoCAiTZtYuVDjAa4vgi4nseG0maM4YxDX0NTlE1x2q9TfmC5lFyzPUWmO9MBkp08HB6tHWcZi1DhY21FZumVUmH74k6LxCtH6uoPtwKyURq0Ta7R81nfCnjDYFMvYSBB4gILTUtfR3oscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220448; c=relaxed/simple;
	bh=jpiJuYBPdzDipKcPTpK1BCHRS6NWv1O1waj048XPNmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBhCMS2k7pmFdW5g96l+mMIPQv+WBKsk0rEX4mNG+FDsqcQlHE6kt2dzl2h2MoqJrCAq2oBJvYMrnBAKx8Fg8qcLIre730yzIFk2016JU37SXrilNJCADJPMU8AkaEKtg/NM74Ea0amToiokLzApN5eWC0BuQT4UWTAEn9LfGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fl8GUDZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl8GUDZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUz/fFHY0vYh37y5tGfe1IC3pqzk5q52FSH7N7Cq9EM=;
	b=Fl8GUDZUTebGAcCVM5udILjgUEpUK3K2neW5yNGYMWkzI5VYG5QJINg5EoD/RVrTzGbArv
	2GolXLHod6/dSliaTKoW2AmOSmMBt+r1TuA6hokK1j0JKgPzwfOaQDmMyXCWn4uMtKcSSB
	ElC/G1pJWuZXybDqPTUNY481UUz+8Ao=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-61EgSCWVMZ6O_vBcm6LroQ-1; Mon,
 12 Jan 2026 07:20:41 -0500
X-MC-Unique: 61EgSCWVMZ6O_vBcm6LroQ-1
X-Mimecast-MFC-AGG-ID: 61EgSCWVMZ6O_vBcm6LroQ_1768220440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02CDD195605A;
	Mon, 12 Jan 2026 12:20:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92B4D18001D5;
	Mon, 12 Jan 2026 12:20:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 304CF21E6742; Mon, 12 Jan 2026 13:20:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20260102151512.460766-6-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 2 Jan 2026 15:15:12 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-6-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:20:37 +0100
Message-ID: <877btnf2ei.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

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
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 12 +++++++++++-
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 3e4bad4ad0..752d46cda2 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -242,6 +242,14 @@
   ##
   # @CXLMemModuleEvent:
   #
   # Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
   #
   # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
   #     Event Record for bit definitions for bit definiions.
   #
   [...]
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-type: Device event sub-type.
> +#
>  # Since: 8.1

You're not updating the reference to the CXL spec from 3.0 to 3.2.
Intentional?  You do in PATCH 2.

>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -251,7 +259,9 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            'sub-type':'uint8'
>              }}
>  
>  ##

[...]

