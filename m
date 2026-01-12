Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148913570AE
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219965; cv=none; b=MotDqYeozmqaYP70GpgTS5Jqp4fYkT7+i+oq554TJvhN9Fm0i4WqbDCP+2KUbHJJyhUGShdikV2rj9OCfiENGalUCutZPeu91ABm3BjTxU1y7ZwHn3HnQ6Y/bWDk7aJ/o/5CWiXjSSf2pGmed95Dsy1F3+edlDnHPQyfyI+VNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219965; c=relaxed/simple;
	bh=3XdhG1Loto45yAFU7LjgXG/nX1n8HSv3NwTxgYJHqxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYZOAHEOvHYoSs7JOOGqK8vdaI7TTDjHHytBSDRhcB0wTQ9CQb6ZljRvjP9TcIPEhlIQDulxPl8HCN20Qm/Xu62GcIl25TtzdhnuUiQAuY2EIvBd4JYfLAD6KbvlCw59AVjoT1B+R4nERrAS2iu5ks1K6DJRtOzmY2IdH/gFMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O90TRLsh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O90TRLsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768219962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyKAAVbRiwpUoBFdn3/clJG0F+n4W2Li7tTGkoyMxfw=;
	b=O90TRLshvBELTqi14tdksYMBrmO9CoYm7AAsnqWDWeeByKQQyRorn9AqoYaaRMEKNdLFkW
	gYq+3X0Ktkzud/FXGNgZGWL9v2b44JtYKIXpTQ0hc8X5C5DT+vMn4fZHCfi1vkKy4vqr05
	vGKdxRXrzytvOTAmUCQSMrk7/YPa2q0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502---VYPIF4Md-iIJkCiAEzoQ-1; Mon,
 12 Jan 2026 07:12:39 -0500
X-MC-Unique: --VYPIF4Md-iIJkCiAEzoQ-1
X-Mimecast-MFC-AGG-ID: --VYPIF4Md-iIJkCiAEzoQ_1768219958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C49ED1954B0B;
	Mon, 12 Jan 2026 12:12:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C96DE19560BA;
	Mon, 12 Jan 2026 12:12:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7803021E6683; Mon, 12 Jan 2026 13:12:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 1/5] qapi: cxl: Refactor CXL event injection for
 common commands arguments
In-Reply-To: <20260102151512.460766-2-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 2 Jan 2026 15:15:08 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-2-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:12:34 +0100
Message-ID: <87pl7ff2rx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> Refactor CXL event injection to use struct for common command
> arguments.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I verified this does not change the external interface by comparing
generated qapi-introspect.c before and after.

> ---
>  qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index eeddb58d1d..d5b86159f1 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -31,11 +31,10 @@
>   }
>  
>  ##
> -# @cxl-inject-general-media-event:
> +# @CXLCommonEventBase:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> -# specified via the log parameter.
> +# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> +# Table 8-42 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
> @@ -44,6 +43,16 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# Since: 8.1
> +##
> +{ 'struct': 'CXLCommonEventBase',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +
> +##
> +# @CXLGeneralMediaEvent:
> +#
> +# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,26 +83,29 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLGeneralMediaEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>  
>  ##
> -# @cxl-inject-dram-event:
> -#
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> -# This event type is reported via one of the event logs specified via
> -# the log parameter.
> +# @cxl-inject-general-media-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# logs specified via the log parameter.
>  #
> -# @log: Event log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': 'CXLGeneralMediaEvent' }
> +
> +##
> +# @CXLDRAMEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> @@ -133,9 +145,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLDRAMEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> @@ -143,18 +155,21 @@
>             }}
>  
>  ##
> -# @cxl-inject-memory-module-event:
> +# @cxl-inject-dram-event:
>  #
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> -# at the time of the event.
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': 'CXLDRAMEvent' }
> +
> +##
> +# @CXLMemModuleEvent:
>  #
> -# @log: Event Log to add the event to
> -#
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
>  #
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
> @@ -185,9 +200,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> -            'type': 'uint8', 'health-status': 'uint8',
> +{ 'struct': 'CXLMemModuleEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
> @@ -195,6 +210,18 @@
>              'corrected-persistent-error-count': 'uint32'
>              }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.3)
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.

I believe this should be

   # Inject an event record for a Memory Module Event (CXL r3.0
   # 8.2.9.2.1.3).  This event includes a copy of the Device Health info
   # at the time of the event.

> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': 'CXLMemModuleEvent' }
> +
>  ##
>  # @cxl-inject-poison:
>  #

