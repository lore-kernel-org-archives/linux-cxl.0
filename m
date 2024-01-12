Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC06EB64
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo94vohA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705073534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4ZOZf0uCeLvPi5YNdo8XiIRLjLbs13iXLaYF+Bpw/I=;
	b=eo94vohAVxKG/u20JCBu1uGA3h3qprlB4TgsGUcDwG9KZK+nhZwOY63SObJ6sPU3yFZOKd
	WPtHPBFwU0otyMHQDuXNvz57pOrnEyJp7i3P3cFt2JfYoL4FifYkn9crM9JktBR0gg8b+H
	e1KcP9o8dOToAq1PhxIP1GrtDP/DGU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-PCU9tSVEMjmaqDy0MPl_Ww-1; Fri, 12 Jan 2024 10:32:10 -0500
X-MC-Unique: PCU9tSVEMjmaqDy0MPl_Ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA6A685A58C;
	Fri, 12 Jan 2024 15:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 151A6492BF0;
	Fri, 12 Jan 2024 15:32:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C99E921E680D; Fri, 12 Jan 2024 16:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  "Hao Xiang"
 <hao.xiang@bytedance.com>,  "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>,  "Ben Widawsky" <ben.widawsky@intel.com>,
  "Gregory Price" <gourry.memverge@gmail.com>,  "Fan Ni"
 <fan.ni@samsung.com>,  "Ira Weiny" <ira.weiny@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  David Hildenbrand
 <david@redhat.com>,
  Igor Mammedov <imammedo@redhat.com>,  Eric Blake <eblake@redhat.com>,
  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
  qemu-devel@nongnu.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
  linux-cxl@vger.kernel.org
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Sun, 31 Dec 2023 23:53:15 -0800")
References: <20240101075315.43167-1-horenchuang@bytedance.com>
	<20240101075315.43167-2-horenchuang@bytedance.com>
Date: Fri, 12 Jan 2024 16:32:06 +0100
Message-ID: <87h6jilg95.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

QAPI schema sanity review only.

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
>
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> 	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \
>
> In v1, we plan to move most of the implementations to util and break down
> this patch into different smaller patches.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/common.json b/qapi/common.json
> index 6fed9cde1a..591fd73291 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -167,6 +167,25 @@
>  { 'enum': 'HostMemPolicy',
>    'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>  
> +##
> +# @HostMemType:
> +#
> +# Automatically find a backend memory type on host.

Types don't do, they are.  Suggest something like

   # Host memory types

> +# Can be further extened to support other types such as cxlpmem, hbm.

Doc comments are reference documentation for users of QMP.  This
sentence doesn't fit there.

> +#
> +# @none: do nothing (default).

Again, types don't do, they are.

(default) makes no sense here.  Types don't have defaults, optional
arguments do.  In this case, @host-mem-type below.

What kind of memory does this setting request?

> +#
> +# @cxlram: a CXL RAM backend on host.

Suggest to spell it cxl-ram.

> +#
> +# Note: HostMemType and HostMemPolicy/host-nodes cannot be set at the same
> +# time. HostMemType is used to automatically bind with one kind of
> +# host memory types.

I feel this note doesn't belong here.  Add it to the users of
HostMemType and HostMemPolicy instead.

> +#
> +# Since: 8.3
> +##
> +{ 'enum': 'HostMemType',
> +  'data': [ 'none', 'cxlram' ] }
> +

I guess you're adding this to common.json and not qom.json so it's next
to HostMemPolicy.  Okay.

>  ##
>  # @NetFilterDirection:
>  #
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 95516ba325..fa3bc29708 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -626,6 +626,7 @@
>              '*host-nodes': ['uint16'],
>              '*merge': 'bool',
>              '*policy': 'HostMemPolicy',
> +            '*host-mem-type': 'HostMemType',
>              '*prealloc': 'bool',
>              '*prealloc-threads': 'uint32',
>              '*prealloc-context': 'str',

Missing: doc comment update.

[...]

