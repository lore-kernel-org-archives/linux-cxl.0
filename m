Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606A15CD4D
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964201; cv=none; b=AzsIjfg+6vXs0VJDmucTTLvreZKxEOscSaiFSB4pkYkpjqFa7pd21actUzcr4wwEq8ErNW58u6eYjk7CBQc/cKgTS12LkDZ9exF/WGTXdahdEX4ZHB9wutfVB8xz7d19Mbj0E/vw4icAIJnorWFxPhZ0bmnUV+1NBFZeVkF+obA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964201; c=relaxed/simple;
	bh=V68WcJj7Caakbd89IVaeHcyHHZxQegLEiYbWeUrkLdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UC6EuQt6SxwRD9xyjlENphBgmLNtyZTLnxGPYk31iiAlyoaLscnVXZ1bIUueT5jHX2Q2BZNfVcgHVUD50JZ31RuNxYFIV+SScmErXvGKNQOHseLkIRViR/6yUXQw4VY30YK9Qx/wVhrflMzJcaW38uSUr74XkzXtbEkCGya/wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7TmWENe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7TmWENe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713964199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=702f7RWc9UdE6UuFLqM4KgRdi7amap9QXG2xh3eTZx4=;
	b=L7TmWENebcEAyxjzPAF1JTm+WAyLO575n1Nhc02Pa8l4TCdJOXnBCYcb4sAwWHMEKqyPhT
	jYG1DqD2OSGBfHZJ5yYByA8SDuwqS6+D4u0duQuQgqirOiFiCxs4RnIuvVgjKOoPnGLNIC
	EfsfqjJO2zoOIu1tycX4TnpuNn6B5Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-DhYI6sFIPfu_WHX7Gnv1Ag-1; Wed, 24 Apr 2024 09:09:54 -0400
X-MC-Unique: DhYI6sFIPfu_WHX7Gnv1Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 882D418065AA;
	Wed, 24 Apr 2024 13:09:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A82C13FA4;
	Wed, 24 Apr 2024 13:09:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 174DD21E66C8; Wed, 24 Apr 2024 15:09:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
  linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
  ira.weiny@intel.com,  dan.j.williams@intel.com,
  a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
  jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240304194331.1586191-10-nifan.cxl@gmail.com> (nifan cxl's
	message of "Mon, 4 Mar 2024 11:34:04 -0800")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
Date: Wed, 24 Apr 2024 15:09:52 +0200
Message-ID: <87a5livrdr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

nifan.cxl@gmail.com writes:

> From: Fan Ni <fan.ni@samsung.com>
>
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.

Will fabric manager emulation obsolete these commands?

> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
>
> 1. Add dynamic capacity extents:
>
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
>
> { "execute": "qmp_capabilities" }
>
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 0,
>           "len": 134217728
>       },
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> 2. Release dynamic capacity extents:
>
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) look like below:
>
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..2645004666 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -19,13 +19,16 @@
>  #
>  # @fatal: Fatal Event Log
>  #
> +# @dyncap: Dynamic Capacity Event Log
> +#
>  # Since: 8.1
>  ##
>  { 'enum': 'CxlEventLog',
>    'data': ['informational',
>             'warning',
>             'failure',
> -           'fatal']
> +           'fatal',
> +           'dyncap']

We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.

>   }
>  
>  ##
> @@ -361,3 +364,59 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDCExtentRecord:

Such traffic jams of capital letters are hard to read.

What does DC mean?

> +#
> +# Record of a single extent to add/release
> +#
> +# @offset: offset to the start of the region where the extent to be operated

Blank line here, please

> +# @len: length of the extent
> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'CXLDCExtentRecord',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The device will

I think we're missing an article here.  Is it "a flow" or "the flow"?

> +# have to acknowledged the acceptance of the extents before they are usable.

to acknowledge

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
> +# @path: CXL DCD canonical QOM path

What is a CXL DCD?  Is it a device?

I'd prefer @qom-path, unless you can make a consistency argument for
@path.

> +# @region-id: id of the region where the extent to add

What's a region, and how do they get their IDs?

> +# @extents: Extents to add

Blank lines between argument descriptions, please.

> +#
> +# Since : 9.0

9.1

> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will

Article again.

The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.

> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.

Is "and can be re-added" relevant here?

> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to release
> +# @extents: Extents to release
> +#
> +# Since : 9.0

9.1

> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}

