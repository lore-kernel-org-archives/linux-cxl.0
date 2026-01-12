Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E461386C9
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220175; cv=none; b=JN3N7do4gXA1k8u3Ba13TOuKRmmkcYsyJu+boq/cTMFMZ2FxA5LsaTBfNBDyOBw/2flUdepgeLJe2IfItCtC3d10Gkn6YOUXcLUuAfoWew5gvgVnYiMHf563hRSxresEHt+4LGmV4rc93NXjLokXWe8GozdaeMhvV+mX9mqicUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220175; c=relaxed/simple;
	bh=TOdwZ49dn42rQCmA+edupiiwBY28ovB0Xh692zLIJ2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDbddJo71HlrzO1cXkq2wtbpUbI6XWy9JGd2EGNA+QeX63AY+ZrwsTTzuYZ+tpzNIUgwhfnwe3wD/bHYd8ry30dcTbmTx/Kzgmg8esTTOJUkhjKEB6CEFhtXNQO7x8A1QwFLZ/HV88YKxwEurErZTs9fQbKk4zhcbUWwz4ovhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhPc3CGR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhPc3CGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VDFbypgcE0ZzazQGWl9Vn6cHcUC5kVfBbUH42zkwYXA=;
	b=DhPc3CGRSG5+75K3XBL2bj9n9eRfYLTWYg0Sa5pHQbSkNR4335AvBCYWK6/tklzJXSZSak
	sBWIPBHIoqiNzVCDNQk7K9+22UGYAV8g0qorpjw3ymgYmoPJjxRytJHCxWdsa4fnCv40R0
	AWYIZkioWkUZ5Ce2QAoticrJtVbV4jU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-b8WR5gB_N9mgdW-AGxb17g-1; Mon,
 12 Jan 2026 07:16:10 -0500
X-MC-Unique: b8WR5gB_N9mgdW-AGxb17g-1
X-Mimecast-MFC-AGG-ID: b8WR5gB_N9mgdW-AGxb17g_1768220168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978FA1956046;
	Mon, 12 Jan 2026 12:16:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21F3418004D8;
	Mon, 12 Jan 2026 12:16:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B165421E6683; Mon, 12 Jan 2026 13:16:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 2/5] hw/cxl/events: Update for rev3.2 common
 event record format
In-Reply-To: <20260102151512.460766-3-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 2 Jan 2026 15:15:09 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-3-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:16:05 +0100
Message-ID: <87ldi3f2m2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 20 ++++++++---
>  include/hw/cxl/cxl_device.h |  7 +++-
>  include/hw/cxl/cxl_events.h | 15 ++++++--
>  hw/cxl/cxl-events.c         |  3 +-
>  hw/cxl/cxl-mailbox-utils.c  |  3 +-
>  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
>  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
>  7 files changed, 121 insertions(+), 21 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index d5b86159f1..b3c2ac9575 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -33,20 +33,32 @@
>  ##
>  # @CXLCommonEventBase:
>  #
> -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> -# Table 8-42 Common Event Record Format).
> +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
> +# Table 8-55 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
>  # @log: event log to add the event to
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to
> +#     initiate.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device
> +#     requests to initiate.
> +#
> +# @ld-id: LD ID of LD from where the event originated.

What's an LD?

> +#
> +# @head-id: ID of the device head from where the event originated.

Are these identifiers taken from the CXL spec?

> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLCommonEventBase',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +            '*ld-id':'uint16', '*head-id':'uint8' } }
>  
>  ##
>  # @CXLGeneralMediaEvent:

[...]

