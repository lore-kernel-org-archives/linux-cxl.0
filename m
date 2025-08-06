Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75D1D7E31
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467093; cv=none; b=sCahgVq7neiUdjAxZsQjHC9FsIgFinQBpx2vR16CSGb101Y5cgH6a+rDIDNiu8poj089Iq33NYw7k+XCYN2+WI1bL3lWRagX0N2wmtkyPd85qrJCKTQjMc5Fv+cEQplkX7lb+92D10PHhkaGbC78Oh155+xOtxpOoR+ZbPLF8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467093; c=relaxed/simple;
	bh=IsviSITewislYyrVR9l6MYaY7DPecNYxJYnoitC1EaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2jTGPFyo25alRgt/jBtFia6rP9VIwMNA3uDxVbC2GxABIz/G6ANH/o3XLtPdBumlohkOcEy0iPXNGppHxalHJCtPHwjY7fSVk83qvcvlqSKKEdHQTjaYIVDGEaGdAACspjRxNoXCsB/7Z5xG/nCo0yt8qwcfpNn1kNTd8RaiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6IA6TfF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6IA6TfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754467088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPmikXRTOFmMM79qW7tCghU8gonU2zNSDP0mrdBBWfE=;
	b=M6IA6TfFGxGEEqKAAUjiSs5df+ignsq4j0tfe5Fnqf4F1GJmrkf3VCM/1tAA+AQllRdeOq
	i7GufG0f1gO77Iv51vqz+/Ewn6aMl3q3c38OLG0LPDIyf3/u5jwpQm0SliLa4leHztHm5w
	1p0/frygjIGY+r/aCYDCK+F3rI5SX8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-dykqIJ3NOkuXZ0H0bWQAvQ-1; Wed,
 06 Aug 2025 03:58:05 -0400
X-MC-Unique: dykqIJ3NOkuXZ0H0bWQAvQ-1
X-Mimecast-MFC-AGG-ID: dykqIJ3NOkuXZ0H0bWQAvQ_1754467084
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE0361800296;
	Wed,  6 Aug 2025 07:58:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87F531956086;
	Wed,  6 Aug 2025 07:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C59B721E6A27; Wed, 06 Aug 2025 09:57:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
  <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
  <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
In-Reply-To: <20250721172228.2118-3-shiju.jose@huawei.com> (shiju jose's
	message of "Mon, 21 Jul 2025 18:22:23 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-3-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 09:57:59 +0200
Message-ID: <87ms8cq3ug.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

shiju.jose--- via <qemu-devel@nongnu.org> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 4. Support for component ID in the PLDM format.
>
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c1fe8319c8..e8060d16f7 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -82,6 +82,19 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @is-comp-id-pldm: Flag represents device specific component identifier
> +#     format is PLDM or not.

Awkward phrasing.  Before I can suggest a better one, I have a question.
The type is uint8, which isn't a flag.  What are the possible values?

> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.

The line break will not make it into generated HTML (it's all one
wrapped paragraph).

We commonly wrap like this:

   # @cme-ev-flags: Advanced programmable corrected memory error
   #     threshold event flags.  See CXL r3.2 Table 8-57 General Media
   #     Event Record.

If you want a line break in generated documentation, you need to start a
new paragraph like this:

   # @cme-ev-flags: Advanced programmable corrected memory error
   #     threshold event flags.
   #
   #     See CXL r3.2 Table 8-57 General Media Event Record.

Same below.

> +#
> +# @cme-count: Corrected memory error count at event.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @sub-type: Memory event sub-type.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> @@ -91,7 +104,10 @@
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            '*is-comp-id-pldm':'uint8',
> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
> +            'sub-type':'uint8' } }
>  
>  ##
>  # @cxl-inject-dram-event:

